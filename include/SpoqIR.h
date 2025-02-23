#pragma once

#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <stdio.h>
#include <unordered_set>
#include <llvm/IR/Instructions.h>

namespace autov {
using std::shared_ptr;


class SpoqInst{ 
public:
    SpoqInst() {}
    virtual ~SpoqInst() = default;
    bool virtual is_spoq_control() { return false; }
};

typedef std::vector<unique_ptr<SpoqInst>> spoq_inst_vec_t;

class SpoqLLVMInst : public SpoqInst {
public:
    llvm::Instruction* inst = nullptr;
    bool virtual is_spoq_control() { return false; }
    SpoqLLVMInst(llvm::Instruction* inst) : inst(inst) {}
};


class SpoqIfInst : public SpoqInst {
public:
    shared_ptr<llvm::Value> cond;
    spoq_inst_vec_t true_body;
    spoq_inst_vec_t false_body;
    bool virtual is_spoq_control() override { return true; }
};

class SpoqContBreakInst : public SpoqInst {
public:
    shared_ptr<std::string> loop;
    shared_ptr<std::string> after;
    bool virtual is_spoq_control() override { return true; }
};

class SpoqLoopInst : public SpoqInst {
    spoq_inst_vec_t body;
};

class SpoqContinueInst: public SpoqContBreakInst { };

class SpoqBreakInst: public SpoqContBreakInst { };

}