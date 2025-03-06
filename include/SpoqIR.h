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


class SpoqIfInst : public SpoqInst {
public:
    llvm::Value* cond;
    spoq_inst_vec_t true_body;
    spoq_inst_vec_t false_body;
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

class SpoqLoopInst : public SpoqInst {
public:
    SpoqLoopInst(llvm::BasicBlock* source_block) : preheader_block(source_block) {}
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