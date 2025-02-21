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

typedef std::vector< shared_ptr<llvm::Instruction>> inst_vec_t;

class SpoqInst{ 
public:
    bool virtual spoq_only() { return false; }
    llvm::Instruction* inst = nullptr;
};

class SpoqIfInst : public SpoqInst {
public:
    shared_ptr<llvm::Value> cond;
    inst_vec_t true_body;
    inst_vec_t false_body;
    bool virtual spoq_only() override { return true; }
};

class SpoqContBreakInst : public SpoqInst {
public:
    shared_ptr<std::string> loop;
    shared_ptr<std::string> after;
    bool virtual spoq_only() override { return true; }
};

class SpoqLoopInst : public SpoqInst {
    inst_vec_t body;
};

class SpoqContinueInst: public SpoqContBreakInst { };

class SpoqBreakInst: public SpoqContBreakInst { };

}