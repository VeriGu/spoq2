#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include <llvm-14/llvm/IR/BasicBlock.h>
#include <llvm-14/llvm/IR/CFG.h>
#include <llvm-14/llvm/IR/Instructions.h>
#include <llvm-14/llvm/IR/Value.h>
#include <llvm-14/llvm/Support/Casting.h>
#include <llvm-14/llvm/Transforms/Utils/BasicBlockUtils.h>
#include <llvm-14/llvm/Transforms/Utils/ValueMapper.h>
#include <stdexcept>


namespace autov {

void SpoqIRModule::control_flow_merge_bridge(llvm::BasicBlock* bb, std::set<llvm::BasicBlock*>& skip) {
    if(skip.find(bb) != skip.end()) return;
    auto last = bb->getTerminator();
    if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
        if(br->getNumSuccessors() == 1 && br->getSuccessor(0)->hasNPredecessors(1)) {
            auto succ = br->getSuccessor(0); // no self-loop with only one predecessor
            bb->getInstList().splice(bb->end(), succ->getInstList());
            for(auto pred: llvm::predecessors(succ)) {
                pred->replaceSuccessorsPhiUsesWith(succ, bb);
            }
            br->eraseFromParent();
            succ->eraseFromParent();
            control_flow_merge_bridge(bb, skip);
        } else {
            skip.insert(bb);
            for(int i = 0; i < br->getNumSuccessors(); i++) {
                control_flow_merge_bridge(br->getSuccessor(i), skip);
            }
        }
    } else if(auto sw = llvm::dyn_cast<llvm::SwitchInst>(last)) {
        skip.insert(bb);
        for(int i = 0; i < sw->getNumSuccessors(); i++) {
            control_flow_merge_bridge(sw->getSuccessor(i), skip);
        }
    }
}

bool SpoqIRModule::control_flow_clone_and_split(
    llvm::BasicBlock *bb, llvm::BasicBlock *ori, bool to_duplicate,
    llvm::ValueToValueMapTy &value_map) {
    if (to_duplicate) {
      std::map<llvm::BasicBlock *, bool> is_cloned;
      llvm::SmallVector<llvm::BasicBlock *, 10> cloned_vec;
      std::queue<llvm::BasicBlock *> q;
      q.push(bb);
      while (!q.empty()) {
          auto cur = q.front();
          q.pop();
          auto last = cur->getTerminator();
          if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
              for (int i = 0; i < br->getNumSuccessors(); i++) {
                  auto succ = br->getSuccessor(i);
                  if (is_cloned.count(succ) > 0)
                      continue;
                  is_cloned[succ] = true;
                  q.push(succ);
                  auto cloned = llvm::CloneBasicBlock(succ, value_map, ".dup",
                                                      succ->getParent());
                  cloned_vec.push_back(cloned);
                  value_map[succ] = cloned;
              }
          } else if (auto sw = llvm::dyn_cast<llvm::SwitchInst>(last)) {
              for (int i = 0; i < sw->getNumSuccessors(); i++) {
                  auto succ = sw->getSuccessor(i);
                  if (is_cloned.count(succ) > 0)
                      continue;
                  is_cloned[succ] = true;
                  q.push(succ);
                  auto cloned = llvm::CloneBasicBlock(succ, value_map, ".dup",
                                                      succ->getParent());
                  cloned_vec.push_back(cloned);
                  value_map[succ] = cloned;
              }
          }
      }
      cloned_vec.push_back(bb);
      llvm::remapInstructionsInBlocks(cloned_vec, value_map);
    } else {
        auto last = bb->getTerminator();
        if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
            for (int i = 0; i < br->getNumSuccessors(); i++) {
                auto succ = br->getSuccessor(i);
                if (llvm::pred_size(succ) >= 2) {
                    llvm::ValueToValueMapTy value_map_duplicate;
                    auto cloned = llvm::CloneBasicBlock(succ, value_map_duplicate, ".clone", bb->getParent());
                    value_map_duplicate[succ] = cloned;
                    control_flow_clone_and_split(cloned, succ, true, value_map_duplicate);
                    br->setSuccessor(i, cloned);
                    control_flow_clone_and_split(cloned, nullptr, false, value_map);
                }  else {
                    control_flow_clone_and_split(succ, nullptr, false, value_map);
                }
            }
        } else if(auto sw = llvm::dyn_cast<llvm::SwitchInst>(last)) {
            for (int i = 0; i < sw->getNumSuccessors(); i++) {
                auto succ = sw->getSuccessor(i);
                if (llvm::pred_size(succ) >= 2) {
                    auto cloned = llvm::CloneBasicBlock(succ, value_map, ".clone", bb->getParent());
                    llvm::ValueToValueMapTy value_map_duplicate;
                    value_map_duplicate[succ] = cloned;
                    control_flow_clone_and_split(cloned, succ, true, value_map_duplicate);
                    sw->setSuccessor(i, cloned);
                    control_flow_clone_and_split(cloned, nullptr, false, value_map);
                }  else {
                    control_flow_clone_and_split(succ, nullptr, false, value_map);
                }
            }
        }
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
                llvm::BranchInst::Create(suffix_bb, true_bb);
                auto false_bb = llvm::BasicBlock::Create(func->getContext(), "select.false.bb", func);
                llvm::BranchInst::Create(suffix_bb, false_bb);

                auto term = bb.getTerminator();
                term->eraseFromParent();

                llvm::BranchInst::Create(true_bb, false_bb, cond, &bb);

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

bool SpoqIRModule::control_flow_conversion_DAG(Project *proj, string fname,
                                               SpoqFunction &spoq_func) {
    llvm::ValueToValueMapTy value_map;
    control_flow_elinminate_select((spoq_func.llvm_func));
    control_flow_clone_and_split(&(spoq_func.llvm_func->getEntryBlock()), nullptr, false, value_map);

    std::vector<llvm::Instruction*> to_erase;
    for(auto &bb : *spoq_func.llvm_func) {
        for(auto &inst : bb) {
            if(auto phi = llvm::dyn_cast<llvm::PHINode>(&inst)) {
                if(bb.hasNPredecessors(1)) {
                    auto predecesor = bb.getUniquePredecessor();
                    auto block = phi->getIncomingValueForBlock(predecesor);
                    phi->replaceAllUsesWith(block);
                    to_erase.push_back(phi);
                } else {
                    // This should never happen.
                    llvm::errs() << "phi: " << *phi << "\n";
                    exit(0);
                }
            }
        }
    }
    for(auto inst : to_erase) {
        inst->eraseFromParent();
    }

    std::set<llvm::BasicBlock *> skip;
    control_flow_merge_bridge(&spoq_func.llvm_func->getEntryBlock(), skip);
    return true;
}

bool SpoqIRModule::control_flow_conversion_v2(Project *proj, string fname,
                                              SpoqFunction &spoq_func) {
    auto llvm_func = spoq_func.llvm_func;

    llvm::FunctionAnalysisManager FAM;
    llvm::LoopAnalysisManager LAM;
    llvm::PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    PB.registerLoopAnalyses(LAM);
    llvm::LoopInfo &LI = FAM.getResult<llvm::LoopAnalysis>(*llvm_func);
    if (!LI.empty()) {
        // TODO: eliminate loop.
        return false;
    } else {
        spoq_func.cfg_converted = control_flow_conversion_DAG(proj, fname, spoq_func);
        return spoq_func.cfg_converted;
    }
}

}; // namespace autov