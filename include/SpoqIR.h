#pragma once

#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <stdio.h>
#include <unordered_set>

#include "llvm/IR/Instructions.h"
#include "llvm/IR/BasicBlock.h"

namespace autov {
using std::shared_ptr;

class SpoqInst{ 
public:
    SpoqInst() {}
    virtual ~SpoqInst() = default;
    virtual bool is_spoq_control() { return false; }
    virtual llvm::Instruction* get_llvm_inst() { return nullptr; }
    virtual void print() { std::cout << "SpoqInst" << std::endl; }
};


class SpoqLLVMInst : public SpoqInst {
public:

    llvm::Instruction* inst = nullptr;
    bool virtual is_spoq_control() override{ return false; }
    SpoqLLVMInst(llvm::Instruction* inst) : inst(inst) {}
    llvm::Instruction* get_llvm_inst() override { return inst; }
    void print() override { llvm::errs() << "SpoqLLVMInst: " << *inst << "\n"; }
};

typedef std::vector<unique_ptr<SpoqInst>> spoq_inst_vec_t;


/// A phi at a CFG join, resolved to the edge the walk arrived on.
///
/// The walk reaches a join once per incoming path, and on any one path exactly
/// one of a phi's incoming values is live: the one belonging to the predecessor
/// it came from.  Holding that choice here reduces the phi to an ordinary
/// binding, `let <phi> := <incoming> in <rest>`.
class SpoqPhiInst : public SpoqInst {
public:
    llvm::PHINode* phi = nullptr;
    llvm::Value* incoming = nullptr;    ///< value for the edge we arrived on
    llvm::BasicBlock* from = nullptr;   ///< the predecessor that edge came from
    SpoqPhiInst(llvm::PHINode* phi, llvm::Value* incoming, llvm::BasicBlock* from)
        : phi(phi), incoming(incoming), from(from) {}
    bool virtual is_spoq_control() override { return false; }
    llvm::Instruction* get_llvm_inst() override { return phi; }
    void print() override {
        llvm::errs() << "SpoqPhiInst: " << *phi << "  <- " << *incoming << " from "
                     << from->getName() << "\n";
    }
};


/// Terminates one arm of a reconverging SpoqIfInst, yielding what the join
/// needs: whatever its phis take on this arm's edge, plus the state as the arm
/// left it.  The arm stops here rather than walking on into the join, so the
/// code after the join is emitted once instead of once per arm.
class SpoqJoinInst : public SpoqInst {
public:
    llvm::BasicBlock* join = nullptr;   ///< block the two arms reconverge at
    llvm::BasicBlock* from = nullptr;   ///< the edge this arm reaches it on
    std::vector<llvm::Value*> incoming; ///< value each of join's phis takes here
    SpoqJoinInst(llvm::BasicBlock* join, llvm::BasicBlock* from) : join(join), from(from) {}
    bool virtual is_spoq_control() override { return true; }
    void print() override {
        llvm::errs() << "SpoqJoinInst: -> " << join->getName() << " from " << from->getName()
                     << " carrying " << incoming.size() << " phi value(s)\n";
    }
};


class SpoqIfInst : public SpoqInst {
public:
    llvm::Value* cond;
    llvm::Instruction* branch = nullptr; ///< the conditional branch this If comes from
    spoq_inst_vec_t true_body;
    spoq_inst_vec_t false_body;

    /// The block both arms reconverge at, if they do.  Set means this If is not
    /// the last instruction in its vector: the arms stop at the join and the
    /// rest of the program follows the If once.  Null means each arm runs to its
    /// own return, and the If is terminal.
    llvm::BasicBlock* join = nullptr;

    SpoqIfInst(llvm::Value* cond) : cond(cond) {}
    bool virtual is_spoq_control() override { return true; }
    void print() override { 
        llvm::errs() << "SpoqIfInst: " << *cond << "\n"; 
        llvm::errs() << "[true]: " << *cond << "\n";
        for(auto &inst : true_body) inst->print();
        llvm::errs() << "[false]: " << *cond << "\n";
        for(auto &inst : false_body) inst->print();
        llvm::errs() << "End SpoqIfInst\n";
    }
};

/// A call to the loop starting at [preheader_block].
///
/// One per path that reaches the preheader, since the loop runs on each of
/// them, but a loop has a single body: llvm_ir_to_spoq_ir fills [body] for
/// whichever of them registered it with the loop context and leaves the others
/// empty.  So [body] is not the way to reach a loop's body -- ask the context,
/// via get_loop_inst_for_jump(preheader_block).
class SpoqLoopInst : public SpoqInst {
public:
    SpoqLoopInst(llvm::BasicBlock* source_block) : preheader_block(source_block) {}
    /// Populated for at most one of the instructions sharing a preheader.
    spoq_inst_vec_t body;
    llvm::BasicBlock* preheader_block;
    bool virtual is_spoq_control() override { return true; }
};

class SpoqContinueInst: public SpoqInst { 
public:
    SpoqContinueInst(llvm::BasicBlock* source_block) : latch_block(source_block) {}
    llvm::BasicBlock* latch_block;
    bool virtual is_spoq_control() override { return true; }
};

class SpoqBreakInst: public SpoqInst { 
public:
    SpoqBreakInst(llvm::BasicBlock* source_block) : exiting_block(source_block) {}
    llvm::BasicBlock* exiting_block;
    bool virtual is_spoq_control() override { return true; }
};
}