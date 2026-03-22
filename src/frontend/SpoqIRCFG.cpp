// ============================================================================
//
//  SpoqIRCFG.cpp — Control Flow Graph Structuring
//
// ============================================================================
//
// GOAL
// ----
// Spoq generates Coq code, which only supports structured control flow
// (if/else, while).  LLVM IR, on the other hand, uses an arbitrary
// control flow graph (CFG) with basic blocks connected by branch
// instructions — essentially goto's.  This file converts an arbitrary
// LLVM CFG into a tree-shaped CFG that maps directly to structured code.
//
//
// WHAT IS A "TREE-SHAPED CFG"?
// ----------------------------
// In a tree-shaped CFG, every basic block has at most ONE predecessor.
// This means there are no "join points" — places where two different
// paths merge back together.  A tree-shaped CFG can be directly printed
// as nested if/else without any goto's.
//
// Example — a normal CFG (diamond shape, NOT a tree):
//
//       entry
//      /     \
//    then    else        <-- conditional branch
//      \     /
//       join             <-- join point: 2 predecessors
//        |
//       ret
//
// The same logic as a tree-shaped CFG (join is duplicated):
//
//       entry
//      /     \
//    then    else
//     |       |
//    join   join'        <-- each path gets its own copy
//     |       |
//    ret     ret'
//
//
// THE FOUR PHASES
// ---------------
// The conversion happens in four phases, applied to each function:
//
//   Phase 1 — Eliminate select instructions
//     LLVM `select` is a ternary operator: %x = select i1 %c, %a, %b
//     (like C's  x = c ? a : b).  We convert each into an explicit
//     if/else diamond because the downstream code only handles branches.
//
//   Phase 2 — Normalize loops
//     LLVM loops can have multiple exits and complex structure.  We
//     normalize each loop so it has:
//       - A clean "preheader" block (the single entry into the loop)
//       - A single "postheader" block (where ALL exits merge)
//     The postheader uses a phi + compare chain to dispatch to the
//     correct original exit target (like a switch statement).
//     We then record preheader→postheader as a "jump" in the context,
//     so Phase 3 can treat the loop as a single edge and process
//     its body independently.
//
//   Phase 3 — DAG-to-tree (clone and split)
//     After Phase 2, loops are abstracted away.  What remains in each
//     "region" (the top-level function body, or a single loop body)
//     is a DAG — a graph with no cycles but possibly with join points.
//     We eliminate join points by CLONING: if a block has 2 predecessors,
//     we duplicate it so each predecessor gets its own copy.
//     Then we merge trivial straight-line chains (A→B where B has
//     one predecessor) back into single blocks.
//
//     WARNING: This cloning is exponential in the worst case.  A chain
//     of N diamonds (if/else that merge) produces 2^N copies.  Functions
//     with many sequential diamonds (e.g. from inlined allocators) will
//     hit the 5000-block safety limit and fail.
//
//   Phase 4 — Pass analysis (cross-loop value flow)
//     After the CFG is tree-shaped, we walk the function to find values
//     that are defined in one loop but used in another.  These must be
//     explicitly "passed" across loop boundaries when generating Coq.
//     The results are stored in context.pass_in / context.pass_out.
//
//
// KEY DATA STRUCTURES
// -------------------
//   SpoqLoopContext — tracks the loop structure:
//     - jump map:     preheader → postheader (one entry per loop)
//     - header_map:   block → which loop it belongs to
//     - pass_in/out:  which values cross each loop boundary
//     - step():       iterator that visits each region (top-level, then
//                     each loop body) so phases can process them one by one
//
//   SpoqFunction — per-function state:
//     - llvm_func:      pointer to the LLVM function
//     - loop_context:   the SpoqLoopContext for this function
//     - cfg_converted:  set to true when Phase 3 succeeds
//
// ============================================================================

#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "project.h"

namespace autov {

// ============================================================================
// Phase 1: Eliminate select instructions
// ============================================================================
//
// Converts each LLVM `select` into an explicit if/else diamond:
//
//   Before:
//     [bb: ... %x = select i1 %c, %a, %b ... rest ...]
//
//   After:
//     [bb:           ... br i1 %c, true_bridge, false_bridge]
//     [true_bridge:  br true_bb]
//     [true_bb:      br suffix]
//     [false_bridge: br false_bb]
//     [false_bb:     br suffix]
//     [suffix:       %x = phi [%a, true_bb], [%b, false_bb] ... rest ...]
//
// Why the bridge blocks?  The phi at suffix needs to know which path was
// taken.  The bridge→bb→suffix pattern ensures each path has a unique
// block name for the phi's incoming-block list.
//
// This function processes one select at a time, then recurses to find the
// next one.  This is necessary because splitting a basic block invalidates
// all iterators over the function's block list.

bool SpoqIRModule::control_flow_elinminate_select(llvm::Function* func) {
    assert(func && "func is nullptr for control_flow_eliniminate_select");
    for (auto &bb: *func) {
        for(auto &inst: bb) {
            if (auto select = llvm::dyn_cast<llvm::SelectInst>(&inst)) {
                auto cond = select->getCondition();
                auto true_val = select->getTrueValue();
                auto false_val = select->getFalseValue();

                // Split: [bb: before select] [suffix: select..rest]
                auto suffix_bb = bb.splitBasicBlock(select);

                // Build the true arm:  true_bridge → true_bb → suffix
                auto true_bb = llvm::BasicBlock::Create(func->getContext(), "select.true.bb", func);
                auto true_bridge = llvm::BasicBlock::Create(func->getContext(), "select.true.bridge", func);
                llvm::BranchInst::Create(suffix_bb, true_bb);
                llvm::BranchInst::Create(true_bb, true_bridge);

                // Build the false arm:  false_bridge → false_bb → suffix
                auto false_bb = llvm::BasicBlock::Create(func->getContext(), "select.false.bb", func);
                auto false_bridge = llvm::BasicBlock::Create(func->getContext(), "select.false.bridge", func);
                llvm::BranchInst::Create(suffix_bb, false_bb);
                llvm::BranchInst::Create(false_bb, false_bridge);

                // Replace the unconditional br (added by splitBasicBlock)
                // with a conditional branch on the select's condition.
                auto term = bb.getTerminator();
                term->eraseFromParent();
                llvm::BranchInst::Create(true_bridge, false_bridge, cond, &bb);

                // Insert a phi at the merge point (suffix) to pick the
                // correct value depending on which arm was taken.
                auto new_phi = llvm::PHINode::Create(true_val->getType(), 2, "phi");
                new_phi->addIncoming(true_val, true_bb);
                new_phi->addIncoming(false_val, false_bb);
                suffix_bb->getInstList().push_front(new_phi);

                // Replace all uses of the original select with the phi.
                select->replaceAllUsesWith(new_phi);
                select->eraseFromParent();

                // Restart the scan (iterators are invalid after splitting).
                control_flow_elinminate_select(func);
                return true;
            }
        }
    }
    return false;
}

// ============================================================================
// Phase 3a: Duplicate successors of a cloned block
// ============================================================================
//
// When we clone a join-point block (in Phase 3b), the clone initially
// still points to the ORIGINAL successors.  Those successors now have
// an extra predecessor (the clone), which would create new join points.
//
// To prevent this, we also clone all successors reachable from the
// cloned block (within the current region).  This is done via BFS.
//
// After cloning, `remapInstructionsInBlocks` rewires all references
// inside the cloned blocks so they refer to other cloned blocks
// (not the originals).
//
// Example:
//   Original:    A → B → C → D
//   We cloned B to get B'.  B' still points to C.
//   So we also clone C → C', D → D'.
//   Now: B' → C' → D'  (fully independent copy)

bool SpoqIRModule::control_flow_duplicate(llvm::BasicBlock *bb,
                                          llvm::BasicBlock *ori,
                                          llvm::ValueToValueMapTy &value_map,
                                          SpoqLoopContext &context) {
    std::map<llvm::BasicBlock *, bool> is_cloned;
    llvm::SmallVector<llvm::BasicBlock *, 10> cloned_vec;

    // BFS from bb, cloning every reachable successor in the region.
    std::queue<llvm::BasicBlock *> q;
    q.push(bb);

    while (!q.empty()) {
        auto cur = q.front(); q.pop();
        auto last = cur->getTerminator();
        if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
            for (int i = 0; i < br->getNumSuccessors(); i++) {
                auto succ = br->getSuccessor(i);
                // Don't clone blocks outside our region (preheader,
                // postheader, loop header).
                if (!context.require_clone(succ)) continue;
                // Don't clone the same block twice.
                if (is_cloned.count(succ) > 0) continue;

                is_cloned[succ] = true;
                q.push(succ);
                auto cloned = llvm::CloneBasicBlock(succ, value_map, ".dup", succ->getParent());
                // Update phi nodes in loop/postheader to accept the clone.
                context.fix_headers(succ, cloned, value_map);
                cloned_vec.push_back(cloned);
                value_map[succ] = cloned;
            }
        }
    }

    // Rewire all instructions in the cloned blocks to reference
    // other cloned blocks instead of originals.
    cloned_vec.push_back(bb);
    llvm::remapInstructionsInBlocks(cloned_vec, value_map);

    // If we cloned a nested loop (preheader+postheader), update
    // the jump map so it knows about the cloned loop too.
    context.update_jump(value_map);
    return true;
}

// ============================================================================
// Phase 3b: Clone-and-split — turn the DAG into a tree
// ============================================================================
//
// This is the core algorithm.  It walks the CFG within the current region
// (either the top-level function body or a single loop body) via DFS.
//
// At each block, it looks at each successor:
//   - If the successor has >= 2 predecessors (a "join point"), it clones
//     the successor and all its reachable subgraph, then redirects this
//     edge to the clone.  Now each predecessor has its own private copy.
//   - Then it recurses into the (possibly cloned) successor.
//
// After this pass, every block has at most one predecessor → tree-shaped.
//
// Example:
//   Before (diamond):       After (tree):
//       A                       A
//      / \                     / \
//     B   C                   B   C
//      \ /                    |   |
//       D  ←join point        D   D'  ←cloned
//
// EXPONENTIAL BLOWUP WARNING:
//   For a chain of N sequential diamonds, each clone duplicates
//   everything downstream.  This produces 2^N blocks.
//   A safety limit of 5000 blocks prevents runaway memory usage.

static int repeats = 0;
bool SpoqIRModule::control_flow_clone_and_split(llvm::BasicBlock *bb, SpoqLoopContext &context) {
    // LOG_DEBUG << "clone and split " << (bb->hasName() ? bb->getName().str() : "no name"); 
    // if (bb->getParent()->getBasicBlockList().size() > 200000) 
    //     throw std::runtime_error("block size too large in fn " + bb->getParent()->getName().str() + ": " + std::to_string(bb->getParent()->getBasicBlockList().size()));
    if (repeats > 10000000){
        throw std::runtime_error("block size too large in fn " + bb->getParent()->getName().str() + ".");
    }
    repeats++;
    if (bb == context.get_postheader()) return true;

    // If bb is a nested loop's preheader, skip over the entire loop
    // and continue from its postheader.
    if (auto target = context.require_jump(bb))  {
        return control_flow_clone_and_split(target, context);
    }

    auto last = bb->getTerminator();
    if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
        for (int i = 0; i < br->getNumSuccessors(); i++) {
            auto succ = br->getSuccessor(i);

            // JOIN POINT?  If succ has >= 2 predecessors, clone it.
            if (context.require_split(succ)) {
                // 1. Clone the successor block.
                llvm::ValueToValueMapTy value_map_duplicate;
                auto cloned = llvm::CloneBasicBlock(succ, value_map_duplicate, ".clone", bb->getParent());
                value_map_duplicate[succ] = cloned;
                context.fix_headers(succ, cloned, value_map_duplicate);

                // 2. Clone all blocks reachable from the clone (Phase 3a).
                control_flow_duplicate(cloned, succ, value_map_duplicate, context);

                // 3. Redirect this edge to the clone.
                br->setSuccessor(i, cloned);

                // 4. Rebuild the header_map since we changed the CFG.
                context.travel_all();
                succ = cloned;
            }

            // Recurse into the successor (now guaranteed to have 1 predecessor).
            if (bb == context.get_preheader() || context.require_clone(succ)) {
                bool ret = control_flow_clone_and_split(succ, context);
                if (!ret) return false;
            }
        }
    } else if (auto br = llvm::dyn_cast<llvm::CallBrInst>(last)) {
        llvm::errs() << "CallBrInst is not supported for control flow clone and split:";
        llvm::errs() << bb->getParent()->getName() << " " << *bb << "\n";
        return false;
    }
    return true;
}

// ============================================================================
// Phase 3c: Merge straight-line chains
// ============================================================================
//
// After cloning, the CFG has many trivial chains:
//   [A: ...insts... br B]  [B: ...insts... br C]
//   where B has exactly one predecessor (A).
//
// These are merged into a single block:
//   [A: ...A's insts... ...B's insts... br C]
//
// This reduces bloat from the cloning phase without changing semantics.
// Preheaders and postheaders are never merged (they are structurally
// significant boundaries tracked by SpoqLoopContext).

void SpoqIRModule::control_flow_merge_bridge(llvm::BasicBlock* bb, std::set<llvm::BasicBlock*>& skip, SpoqLoopContext& context) {
    if(skip.find(bb) != skip.end()) return;

    // Skip over nested loops.
    if(auto target = context.require_jump(bb)) {
        control_flow_merge_bridge(target, skip, context);
        return;
    }

    auto last = bb->getTerminator();
    if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
        // Can we merge?  Unconditional branch to a single-predecessor block.
        if(br->getNumSuccessors() == 1 && br->getSuccessor(0)->hasNPredecessors(1)) {
            auto succ = br->getSuccessor(0);
            if (context.can_remove(succ)) {
                // Splice succ's instructions into bb.
                bb->getInstList().splice(bb->end(), succ->getInstList());
                for(auto pred: llvm::predecessors(succ)) {
                    pred->replaceSuccessorsPhiUsesWith(succ, bb);
                }
                br->eraseFromParent();
                succ->eraseFromParent();
                // Try again — bb might now chain into another mergeable block.
                control_flow_merge_bridge(bb, skip, context);
                return;
            }
        }
        // Done merging this block; recurse into successors.
        skip.insert(bb);
        for(int i = 0; i < br->getNumSuccessors(); i++) {
            control_flow_merge_bridge(br->getSuccessor(i), skip, context);
        }
    }
}

// ============================================================================
// Phase 3: DAG-to-tree — orchestrator
// ============================================================================
//
// Runs Phase 3b (clone-and-split) and Phase 3c (merge) on each region.
//
// A "region" is either:
//   - The top-level function body (everything outside loops), or
//   - A single loop body (between preheader and postheader).
//
// SpoqLoopContext.step() iterates over regions:
//   step_count == -1  →  top-level (entry block, no postheader)
//   step_count >= 0   →  loop bodies (preheader to postheader)
//
// Between Phase 3b and 3c, trivial phi nodes are eliminated.
// After cloning, many phi nodes have only one incoming value
// (because their block now has only one predecessor).  These
// are replaced with their single value and removed.

bool SpoqIRModule::control_flow_conversion_DAG(string fname, SpoqFunction &spoq_func, SpoqLoopContext& context) {
    

    // --- Sub-pass 1: Clone-and-split + phi cleanup, per region ---
    context.init(spoq_func.llvm_func);
    bool state = false;
    while (context.step()) {
        repeats = 0;
        state = control_flow_clone_and_split(context.get_start(), context);
        if (!state) return false;

        // Eliminate trivial phi nodes: if a block now has only one
        // predecessor, its phi nodes each have exactly one incoming
        // value and can be replaced directly.
        std::vector<llvm::Instruction *> to_erase;
        for (auto &bb : *spoq_func.llvm_func) {
            for (auto &inst : bb) {
                if (!context.require_fix(&bb))
                    continue;
                if (auto phi = llvm::dyn_cast<llvm::PHINode>(&inst)) {
                    if (bb.hasNPredecessors(1)) {
                        auto predecesor = bb.getUniquePredecessor();
                        auto block = phi->getIncomingValueForBlock(predecesor);
                        phi->replaceAllUsesWith(block);
                        to_erase.push_back(phi);
                    } else {
                        context.debug_jump();
                        llvm::errs() << "phi: " << *phi << "\n";
                        llvm::errs() << "some PHI are not eliminated but required so" << "\n";
                        return false;
                        continue;
                    }
                }
            }
        }
        for (auto inst : to_erase) {
            inst->eraseFromParent();
        }
    }

    // --- Sub-pass 2: Merge straight-line chains, per region ---
    context.init(spoq_func.llvm_func);
    while(context.step()) {
        std::set<llvm::BasicBlock *> skip;
        control_flow_merge_bridge(context.get_start(), skip, context);
    }
    context.travel_all();
    return true;
}

// ============================================================================
// Phase 4: Pass analysis — find values that cross loop boundaries
// ============================================================================
//
// When generating Coq for a loop, we need to know which values are:
//   - Defined OUTSIDE the loop but used INSIDE  ("pass in")
//   - Defined INSIDE the loop but used OUTSIDE  ("pass out")
//
// These become explicit parameters/return values of the Coq while-loop.
//
// This function walks the tree-shaped CFG via DFS, maintaining a "loop
// stack" that tracks which loops we are currently inside.
//
// For each instruction operand, it finds where the operand was defined
// (which loop, or top-level), and if that differs from where it's used,
// records it as a pass_in or pass_out value via recursive_update_pass.
//
// Example:
//   %x = add ...           ; defined at top level
//   loop {
//     %y = mul %x, ...     ; uses %x → %x must be "passed in" to the loop
//     ...
//   }
//   %z = add %y, ...       ; uses %y → %y must be "passed out" of the loop

void SpoqIRModule::pass_analysis(llvm::BasicBlock* block, std::vector<llvm::BasicBlock*>& stack,
        SpoqLoopContext& context) {

    // Is this block a loop preheader?  If so, enter the loop.
   if (auto target = context.require_jump_no_step(block)) {
       // Record this loop's parent (for nested loops).
       if (stack.size()) context.update_parent(block, *stack.rbegin());

        // Push this loop onto the stack, process the loop body,
        // then pop and continue with the postheader.
        stack.push_back(block);
        assert(block->getUniqueSuccessor() && "preheader does not have a unique successor");
        pass_analysis(block->getUniqueSuccessor(), stack, context);
        stack.pop_back();
        pass_analysis(target, stack, context);
        return;
    }

    // If we've reached the postheader of the current innermost loop,
    // stop — our caller will handle what comes after the loop.
    if (stack.size() && context.require_jump_no_step(*stack.rbegin()) == block) {
        return;
    }

    // For each non-phi instruction, check if any operand crosses a loop
    // boundary (defined in a different loop than where it's used).
    for (auto& inst: *block) {
        if (llvm::dyn_cast<llvm::PHINode>(&inst)) continue;
        for (auto& ops: inst.operands()) {
            if (auto op = llvm::dyn_cast<llvm::Instruction>(ops)) {
                auto op_header = context.real_header(op);
                context.recursive_update_pass(op_header, stack, op);
            }
            if (auto op = llvm::dyn_cast<llvm::Argument>(ops)) {
                // Function arguments are defined at the top level (no loop).
                context.recursive_update_pass(nullptr, stack, op);
            }
        }
    }

    // Continue DFS into successors.
    // Skip backward edges (latch → loop header) to avoid infinite recursion.
    for (auto succ: llvm::successors(block)) {
        if (stack.size() && context.is_backward(block, succ, *stack.rbegin())) continue;
        pass_analysis(succ, stack, context);
    }
}

// ============================================================================
// Entry point: control_flow_conversion_v2
// ============================================================================
//
// Orchestrates all four phases to convert an LLVM function's CFG into
// a tree-shaped structured form for Coq generation.
//
//   Phase 1: select → branch diamonds
//   Phase 2: normalize loops (preheader/postheader)
//   Phase 3: clone join points → tree-shaped CFG
//   Phase 4: compute cross-loop value flow
//
// If the function has no loops, Phase 2 and Phase 4 are skipped.

bool SpoqIRModule::control_flow_conversion_v2(string fname,
                                              SpoqFunction &spoq_func) {
    auto llvm_func = spoq_func.llvm_func;

    // Set up LLVM's analysis infrastructure so we can query LoopInfo.
    llvm::FunctionAnalysisManager FAM;
    llvm::LoopAnalysisManager LAM;
    llvm::PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    PB.registerLoopAnalyses(LAM);

    // ── Phase 1: Eliminate select instructions ──
    control_flow_elinminate_select(llvm_func);

    // ── Phase 2: Normalize loops ──
    // Ask LLVM for loop info on the (post-Phase-1) CFG.
    llvm::LoopInfo &LI = FAM.getResult<llvm::LoopAnalysis>(*llvm_func);
    SpoqLoopContext& context = spoq_func.loop_context;

    if (!LI.empty()) {
        // Process loops outermost-first.
        auto loops = LI.getLoopsInPreorder();
        for(auto loop: loops) {

            // ── 2a: Clean up the preheader ──
            // The preheader is the single block that enters the loop.
            // If it has phi nodes (can happen when two loops share a
            // header), split it so we get a clean preheader with no phis.
            auto preheader = loop->getLoopPreheader();
            llvm::BasicBlock* skip_preheader = nullptr;
            if(!preheader) {
                throw std::runtime_error("loop does not have a loop header");
            } else if (!preheader->getUniqueSuccessor()){
                throw std::runtime_error("preheader does not have a unique successor");
            }
                // assert(preheader && "loop does not have a loop header");
                // assert(preheader->getUniqueSuccessor() && "preheader does not have a unique successor");

            if (!preheader->phis().empty()) {
                auto last = preheader->getTerminator();
                auto real = preheader->splitBasicBlock(last, "realpreheader");
                loop->addBlockEntry(real);
                skip_preheader = preheader;
                preheader = real;
            }

            // ── 2b: Handle infinite loops ──
            // If the loop has no exit (infinite loop), we insert a fake
            // exit edge so the rest of the pipeline can process it.
            //
            //   header:                    header:
            //     body instructions    →     br true, realloop, fakeexit
            //     br header                realloop:
            //                                body instructions
            //                                br header
            //                              fakeexit:
            //                                ret 0  (or ret void)
            llvm::SmallVector<llvm::BasicBlock*, 10> exits;
            loop->getExitingBlocks(exits);
            if (exits.size() == 0) {
                auto header = loop->getHeader();
                auto last = header->getTerminator();
                auto real = header->splitBasicBlock(last, "realloop");
                auto fake = llvm::BasicBlock::Create(llvm_func->getContext(), "fakeexit", llvm_func);
                loop->addBlockEntry(real);
                assert(!loop->contains(fake) && "Fake block is mistakenly in the loop");

                llvm::IRBuilder<> builder(header);
                builder.CreateCondBr(builder.getTrue(), real, fake);
                builder.SetInsertPoint(fake);
                if (!llvm_func->getReturnType()->isVoidTy()) {
                    LOG_ERROR << "infinite loop detected in " << fname << "\n";
                    if( !llvm_func->getReturnType()->isIntegerTy(64)) {
                        return false;
                    }
                    LOG_ERROR << "but we want " << fname << "\n";
                    builder.CreateRet(builder.getInt64(0));
                } else {
                    builder.CreateRetVoid();
                }
                exits.push_back(header);
            }

            // ── 2c: Create a unified postheader with exit dispatch ──
            // All loop exits are redirected to a single "postheader" block.
            // A phi node records which exit was taken (as an integer id).
            // Then a chain of icmp+br dispatches to the correct target.
            //
            //   BEFORE:                     AFTER:
            //   exit0 → target0             exit0 → postheader (id=0)
            //   exit1 → target1             exit1 → postheader (id=1)
            //   exit2 → target2             exit2 → postheader (id=2)
            //
            //                               postheader:
            //                                 %id = phi [0,exit0],[1,exit1],[2,exit2]
            //                                 %c1 = icmp eq %id, 2
            //                                 br %c1, target2, shadow1
            //                               shadow1:
            //                                 %c2 = icmp eq %id, 1
            //                                 br %c2, target1, shadow2
            //                               shadow2:
            //                                 br target0    (default)
            llvm::BasicBlock* postheader = llvm::BasicBlock::Create(llvm_func->getContext(), "postheader", llvm_func);
            llvm::IRBuilder<> builder(postheader);

            std::vector<std::pair<llvm::ConstantInt*, llvm::BasicBlock*>> phi_map;
            std::map<llvm::Value*, llvm::BasicBlock*> pred_map;
            auto phi = builder.CreatePHI(llvm::Type::getInt32Ty(llvm_func->getContext()), 0);

            for(int e_id = 0; e_id < exits.size(); e_id++) {
                auto e = exits[e_id];
                auto last = e->getTerminator();
                // If an exit ends with `ret`, split it so it ends with `br`
                // (the postheader expects branch predecessors).
                if (auto ret = llvm::dyn_cast<llvm::ReturnInst>(last)){
                    e->splitBasicBlock(last, "ret.shadow");
                }
                auto br = llvm::dyn_cast_or_null<llvm::BranchInst>(last);
                assert(br && "exit block does not have a branch terminator");
                bool set = false;
                for(int i = 0; i < br->getNumSuccessors(); i++) {
                    if (loop->contains(br->getSuccessor(i)) && skip_preheader != br->getSuccessor(i)) continue;
                    assert(!set && "a exit has multiple outgoing edges");
                    set = true;
                    auto v = llvm::ConstantInt::get(llvm_func->getContext(), llvm::APInt(32, e_id));
                    phi_map.push_back(std::make_pair(v, br->getSuccessor(i)));
                    pred_map[v] = e;
                    phi->addIncoming(v, e);
                    br->setSuccessor(i, postheader);
                }
            }

            // Register this loop in the context: preheader → postheader.
            // Phase 3 will treat this as a "jump" — skip from preheader
            // to postheader, processing the loop body separately.
            context.set_jump(preheader, postheader);

            // Build the dispatch chain (icmp + br for each exit).
            auto size = phi_map.size();
            assert(size > 0 && "a post header should have at least one outcoming edge");
            for(int i = 1; i < size; i++) {
                auto shadow_bb = llvm::BasicBlock::Create(builder.getContext(), "postprocess.shadow", llvm_func);
                phi_map[i].second->replacePhiUsesWith(pred_map[phi_map[i].first], postheader);
                auto cmp = builder.CreateICmpEQ(phi, phi_map[i].first);
                builder.CreateCondBr(cmp, phi_map[i].second, shadow_bb);
                postheader = shadow_bb;
                builder.SetInsertPoint(shadow_bb);
            }
            // Exit 0 is the default (no compare needed).
            builder.CreateBr(phi_map[0].second);
            phi_map[0].second->replacePhiUsesWith(pred_map[phi_map[0].first], postheader);
        }

        // Rebuild the mapping of "which block belongs to which loop".
        context.travel_all();

        // ── Phase 3: DAG-to-tree ──
        spoq_func.cfg_converted = control_flow_conversion_DAG(fname, spoq_func, context);

        // ── Phase 4: Pass analysis ──
        context.travel_all();
        std::vector<llvm::BasicBlock*> loop_stack;
        pass_analysis(&spoq_func.llvm_func->getEntryBlock(), loop_stack, context);

        return spoq_func.cfg_converted;
    } else {
        // No loops — skip Phase 2 and 4, just do Phase 3.
        spoq_func.cfg_converted = control_flow_conversion_DAG(fname, spoq_func, context);
        return spoq_func.cfg_converted;
    }
}

}; // namespace autov
