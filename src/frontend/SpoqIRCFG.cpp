#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "project.h"

namespace autov {

void SpoqIRModule::control_flow_merge_bridge(llvm::BasicBlock* bb, std::set<llvm::BasicBlock*>& skip, SpoqLoopContext& context) {
    if(skip.find(bb) != skip.end()) return;
    if(auto target = context.require_jump(bb)) {
        control_flow_merge_bridge(target, skip, context);
        return;
    }
    auto last = bb->getTerminator();
    if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
        if(br->getNumSuccessors() == 1 && br->getSuccessor(0)->hasNPredecessors(1)) {
            // no self-loop with only one predecessor
            auto succ = br->getSuccessor(0); 
            if (context.can_remove(succ)) {
                bb->getInstList().splice(bb->end(), succ->getInstList());
                for(auto pred: llvm::predecessors(succ)) {
                    pred->replaceSuccessorsPhiUsesWith(succ, bb);
                }
                br->eraseFromParent();
                succ->eraseFromParent();
                control_flow_merge_bridge(bb, skip, context);
                return;
            }
        } 
        skip.insert(bb);
        for(int i = 0; i < br->getNumSuccessors(); i++) {
            control_flow_merge_bridge(br->getSuccessor(i), skip, context);
        }
    } 
}

bool SpoqIRModule::control_flow_duplicate(llvm::BasicBlock *bb,
                                          llvm::BasicBlock *ori,
                                          llvm::ValueToValueMapTy &value_map,
                                          SpoqLoopContext &context) {
    std::map<llvm::BasicBlock *, bool> is_cloned;
    llvm::SmallVector<llvm::BasicBlock *, 10> cloned_vec;

    std::queue<llvm::BasicBlock *> q;
    q.push(bb);

    while (!q.empty()) {
        auto cur = q.front(); q.pop();
        auto last = cur->getTerminator();
        if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
            for (int i = 0; i < br->getNumSuccessors(); i++) {
                auto succ = br->getSuccessor(i);
                if (!context.require_clone(succ)) continue;
                if (is_cloned.count(succ) > 0)
                    continue;
                is_cloned[succ] = true;
                q.push(succ);
                auto cloned = llvm::CloneBasicBlock(succ, value_map, ".dup", succ->getParent());
                context.fix_headers(succ, cloned, value_map);
                cloned_vec.push_back(cloned);
                value_map[succ] = cloned;
            }
        }
    }

    cloned_vec.push_back(bb);
    llvm::remapInstructionsInBlocks(cloned_vec, value_map);
    context.update_jump(value_map);
    return true;
}

bool SpoqIRModule::control_flow_clone_and_split(llvm::BasicBlock *bb, SpoqLoopContext &context) {
    if (bb == context.get_postheader()) return true;
    if (auto target = context.require_jump(bb))  {
        return control_flow_clone_and_split(target, context);
    }

    auto last = bb->getTerminator();
    if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
        for (int i = 0; i < br->getNumSuccessors(); i++) {
            auto succ = br->getSuccessor(i);
            if (context.require_split(succ)) {
                llvm::ValueToValueMapTy value_map_duplicate;
                auto cloned = llvm::CloneBasicBlock(succ, value_map_duplicate, ".clone", bb->getParent());
                value_map_duplicate[succ] = cloned;
                context.fix_headers(succ, cloned, value_map_duplicate);
                control_flow_duplicate(cloned, succ, value_map_duplicate, context);
                br->setSuccessor(i, cloned);
                context.travel_all();
                succ = cloned;
            }
            // TODO: fix me. Use other way to check for backward edge
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

bool SpoqIRModule::control_flow_elinminate_select(llvm::Function* func) {
    assert(func && "func is nullptr for control_flow_eliniminate_select");
    for (auto &bb: *func) {
        for(auto &inst: bb) {
            if (auto select = llvm::dyn_cast<llvm::SelectInst>(&inst)) {
                auto cond = select->getCondition();

                auto true_val = select->getTrueValue();
                auto false_val = select->getFalseValue();

                auto suffix_bb = bb.splitBasicBlock(select);

                auto true_bb = llvm::BasicBlock::Create(func->getContext(), "select.true.bb", func);
                auto true_bridge = llvm::BasicBlock::Create(func->getContext(), "select.true.bridge", func);
                llvm::BranchInst::Create(suffix_bb, true_bb);
                llvm::BranchInst::Create(true_bb, true_bridge);
                auto false_bb = llvm::BasicBlock::Create(func->getContext(), "select.false.bb", func);
                auto false_bridge = llvm::BasicBlock::Create(func->getContext(), "select.false.bridge", func);
                llvm::BranchInst::Create(suffix_bb, false_bb);
                llvm::BranchInst::Create(false_bb, false_bridge);

                auto term = bb.getTerminator();
                term->eraseFromParent();

                llvm::BranchInst::Create(true_bridge, false_bridge, cond, &bb);

                auto new_phi = llvm::PHINode::Create(true_val->getType(), 2, "phi");
                new_phi->addIncoming(true_val, true_bb);
                new_phi->addIncoming(false_val, false_bb);
                suffix_bb->getInstList().push_front(new_phi);

                select->replaceAllUsesWith(new_phi);
                select->eraseFromParent();
                control_flow_elinminate_select(func);
                return true;
            }
        }
    }
    return false;
}

bool SpoqIRModule::control_flow_conversion_DAG(string fname, SpoqFunction &spoq_func, SpoqLoopContext& context) {
    

    context.init(spoq_func.llvm_func);
    bool state = false;
    while (context.step()) {
        state = control_flow_clone_and_split(context.get_start(), context);
        if (!state) return false;

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
                        // llvm::errs() << "*func: " << *spoq_func.llvm_func << "\n";
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

    context.init(spoq_func.llvm_func);
    while(context.step()) {
        std::set<llvm::BasicBlock *> skip;
        control_flow_merge_bridge(context.get_start(), skip, context);
    }
    context.travel_all();
    return true;
}

void SpoqIRModule::pass_analysis(llvm::BasicBlock* block, std::vector<llvm::BasicBlock*>& stack,
        SpoqLoopContext& context) {

   if (auto target = context.require_jump_no_step(block)) {
       if (stack.size()) context.update_parent(block, *stack.rbegin());
        stack.push_back(block);
        assert(block->getUniqueSuccessor() && "preheader does not have a unique successor");
        pass_analysis(block->getUniqueSuccessor(), stack, context);
        stack.pop_back();
        pass_analysis(target, stack, context);
        return;
    }

    if (stack.size() && context.require_jump_no_step(*stack.rbegin()) == block) {
        return;
    }

    for (auto& inst: *block) {
        if (llvm::dyn_cast<llvm::PHINode>(&inst)) continue;
        for (auto& ops: inst.operands()) {
            if (auto op = llvm::dyn_cast<llvm::Instruction>(ops)) {
                auto op_header = context.real_header(op);
                context.recursive_update_pass(op_header, stack, op);
            }
            if (auto op = llvm::dyn_cast<llvm::Argument>(ops)) {
                context.recursive_update_pass(nullptr, stack, op);
            }
        }
    }

    for (auto succ: llvm::successors(block)) {
        if (stack.size() && context.is_backward(block, succ, *stack.rbegin())) continue;
        pass_analysis(succ, stack, context);
    }
}

bool SpoqIRModule::control_flow_conversion_v2(string fname,
                                              SpoqFunction &spoq_func) {
    auto llvm_func = spoq_func.llvm_func;

    llvm::FunctionAnalysisManager FAM;
    llvm::LoopAnalysisManager LAM;
    llvm::PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    PB.registerLoopAnalyses(LAM);
    control_flow_elinminate_select(llvm_func);
    llvm::LoopInfo &LI = FAM.getResult<llvm::LoopAnalysis>(*llvm_func);
    SpoqLoopContext& context = spoq_func.loop_context;
    if (!LI.empty()) {

        auto loops = LI.getLoopsInPreorder();
        // llvm::errs() << "function with loop: " << fname << " " << llvm_func->getBasicBlockList().size() << "\n";
        // Start from the outter loop first
        for(auto loop: loops) {

            auto preheader = loop->getLoopPreheader();
            llvm::BasicBlock* skip_preheader = nullptr;
            assert(preheader && "loop does not have a loop header");
            assert(preheader->getUniqueSuccessor() && "preheader does not have a unique successor");

            if (!preheader->phis().empty()) {
                // in case, two loops share preheaader / header
                auto last = preheader->getTerminator();
                auto real = preheader->splitBasicBlock(last, "realpreheader");
                loop->addBlockEntry(real);
                skip_preheader = preheader;
                preheader = real;
            }

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
                    // assert(llvm_func->getReturnType()->isVoidTy() && "infinite loop return non-void");
                    builder.CreateRetVoid();
                }

                exits.push_back(header);
            }
            llvm::BasicBlock* postheader = llvm::BasicBlock::Create(llvm_func->getContext(), "postheader", llvm_func);
            llvm::IRBuilder<> builder(postheader);

            std::vector<std::pair<llvm::ConstantInt*, llvm::BasicBlock*>> phi_map;
            std::map<llvm::Value*, llvm::BasicBlock*> pred_map;
            auto phi = builder.CreatePHI(llvm::Type::getInt32Ty(llvm_func->getContext()), 0);

            for(int e_id = 0; e_id < exits.size(); e_id++) {
                auto e = exits[e_id];
                auto last = e->getTerminator();
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
                    pred_map[v] = e; // unique v
                    phi->addIncoming(v, e);
                    br->setSuccessor(i, postheader);
                }
            }
            context.set_jump(preheader, postheader);

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
            builder.CreateBr(phi_map[0].second);
            phi_map[0].second->replacePhiUsesWith(pred_map[phi_map[0].first], postheader);

        }
        context.travel_all();
        spoq_func.cfg_converted = control_flow_conversion_DAG(fname, spoq_func, context);

        context.travel_all();
        std::vector<llvm::BasicBlock*> loop_stack;
        pass_analysis(&spoq_func.llvm_func->getEntryBlock(), loop_stack, context);
        // context.debug_jump();

        return spoq_func.cfg_converted;
    } else {
        spoq_func.cfg_converted = control_flow_conversion_DAG(fname, spoq_func, context);
        return spoq_func.cfg_converted;
    }
}

}; // namespace autov