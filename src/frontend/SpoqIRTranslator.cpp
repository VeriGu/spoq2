#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "nodes.h"
#include "shortcuts.h"

#include <cassert>
#include <llvm-14/llvm/IR/BasicBlock.h>
#include <llvm-14/llvm/IR/CFG.h>
#include <llvm-14/llvm/IR/Constants.h>
#include <llvm-14/llvm/IR/InstrTypes.h>
#include <llvm-14/llvm/IR/Instruction.h>
#include <llvm-14/llvm/IR/Instructions.h>
#include <llvm-14/llvm/IR/Value.h>
#include <llvm-14/llvm/Support/Casting.h>
#include <llvm-14/llvm/Transforms/Utils/ValueMapper.h>
#include <memory>
#include <stdexcept>
#include <unordered_map>

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/Cloning.h"

namespace autov {

/**
 * @brief This look up table is incomplete and only contains the most common binary ops in llvm.
 * 
 */
const std::unordered_map<llvm::Instruction::BinaryOps, Expr::binops> SpoqIRModule::binops_lut = {
    {llvm::Instruction::BinaryOps::Add, Expr::binops::ADD},
    {llvm::Instruction::BinaryOps::Sub, Expr::binops::MINUS},
    {llvm::Instruction::BinaryOps::Mul, Expr::binops::MULT},
    {llvm::Instruction::BinaryOps::SDiv, Expr::binops::DIV},
    {llvm::Instruction::BinaryOps::SRem, Expr::binops::MOD},
};

const std::unordered_map<llvm::CmpInst::Predicate, Expr::binops> SpoqIRModule::cmpops_lut = {
    {llvm::CmpInst::Predicate::ICMP_EQ, Expr::binops::BEQ},
    {llvm::CmpInst::Predicate::ICMP_NE, Expr::binops::BNE},
    // Signed Numbers
    {llvm::CmpInst::Predicate::ICMP_SGT, Expr::binops::BGT},
    {llvm::CmpInst::Predicate::ICMP_SGE, Expr::binops::BGE},
    {llvm::CmpInst::Predicate::ICMP_SLT, Expr::binops::BLT}, 
    {llvm::CmpInst::Predicate::ICMP_SLE, Expr::binops::BLE},
    // Unsigned Numbers
    {llvm::CmpInst::Predicate::ICMP_UGT, Expr::binops::BGT},
    {llvm::CmpInst::Predicate::ICMP_UGE, Expr::binops::BGE},
    {llvm::CmpInst::Predicate::ICMP_ULT, Expr::binops::BLT},
    {llvm::CmpInst::Predicate::ICMP_ULE, Expr::binops::BLE}
};


void SpoqIRModule::dfs_llvm_ir_to_spoq_inst_vec(llvm::BasicBlock* block, spoq_inst_vec_t& vec) {
    for(auto &inst: *block) {
        if(auto br = llvm::dyn_cast<llvm::BranchInst>(&inst)) {
            if(br->isConditional()) {
                auto cond = br->getCondition();
                auto true_block = br->getSuccessor(0);
                auto false_block = br->getSuccessor(1);
                SpoqIfInst spoq_inst(cond);
                dfs_llvm_ir_to_spoq_inst_vec(true_block, spoq_inst.true_body);
                dfs_llvm_ir_to_spoq_inst_vec(false_block, spoq_inst.false_body);
                vec.push_back(std::make_unique<SpoqIfInst>(std::move(spoq_inst)));
            } else {
                dfs_llvm_ir_to_spoq_inst_vec(br->getSuccessor(0), vec);
            }
            return; // A br is the last instruction in a block (for a valid llvm module)
        }  
        // TODO : switch instruction
        else {
            vec.push_back(std::make_unique<SpoqLLVMInst>(&inst));
        }
    }
}

bool SpoqIRModule::llvm_ir_to_spoq_ir(SpoqFunction &spoq_func) {
    if(!spoq_func.cfg_converted) return false;
    dfs_llvm_ir_to_spoq_inst_vec(&spoq_func.llvm_func->getEntryBlock(), spoq_func.spoq_insts);
    return true;
}

// Spoq IR <----> Spoq Coq Low Spec

unique_ptr<SpecNode> SpoqIRContext::get_llvm_value_spec(llvm::Value* value) {
    if (value == nullptr) assert(false && "llvm value is nullptr");

    if (llvm::dyn_cast<llvm::Constant>(value)) {
        if(auto global = llvm::dyn_cast<llvm::GlobalVariable>(value)) {
            // TODO: support global variable
            llvm::errs() << "global: " << *global << "\n";
            assert(false);
        } else if(auto data = llvm::dyn_cast<llvm::ConstantData>(value)) {
            if (auto int_val = llvm::dyn_cast<llvm::ConstantInt>(data)) {
                if(int_val->getBitWidth() == 1) {
                    return std::make_unique<BoolConst>(!int_val->isZero());
                } else {
                    // FIXME: do we convert large integer here?
                    return std::make_unique<IntConst>(int_val->getSExtValue());
                }
            } else if(auto ptr_null = llvm::dyn_cast<llvm::ConstantPointerNull>(data)) {
                // TODO:
                llvm::errs() << "ptr_null: " << *value << "\n";
                return nullptr;
            }
            else {
                llvm::errs() << "unsupport llvm constant: " << *value << "\n";
                assert(false && "unsupport llvm constant");
            }
        } else {
            llvm::errs() << "unsupport llvm constant: " << *value << "\n";
            assert(false && "unsupport llvm constant");
        }
    } else if (llvm::dyn_cast<llvm::Argument>(value)) {
        if (type_map.find(value) == type_map.end()) {
            type_map[value] = this->get_llvm_value_type(value);
        }
        return std::make_unique<Symbol>(get_llvm_value_name(value),
                                        type_map[value]);
    } else if (llvm::dyn_cast<llvm::Instruction>(value)) {
        if (type_map.find(value) == type_map.end()) {
            type_map[value] = this->get_llvm_value_type(value);
        }
        return std::make_unique<Symbol>(get_llvm_value_name(value),
                                        type_map[value]);
    } else {
        llvm::errs() << "unsupport llvm value: " << *value << "\n";
        assert(false && "unsupport llvm value");
    }
}

shared_ptr<SpecType> SpoqIRContext::get_llvm_value_type(llvm::Value* value) {
    // TODO: pointer abstraction here
    if(value->getType() == nullptr) {
        llvm::errs() << "value type: " << *value << "\n";
        assert(false && "llvm value type is nullptr");
    }
    return SpoqIRModule::llvm_ir_type_to_spec_pure(value->getType());
}


shared_ptr<SpecType> SpoqIRModule::llvm_ir_type_to_spec_pure(llvm::Type* type) {
    if (type->isIntegerTy(1)) {
        return Bool::BOOL;
    } else if(type->isIntegerTy()) {
        return Int::INT;
    } else if (type->isPointerTy()) {
        return Struct::Ptr;
    } else if (type->isVoidTy()) {
        return make_shared<SpecType>("Void");
    } else if (type->isStructTy()) {
        // TODO: handle struct type
        throw std::invalid_argument("invalid types: " + type->getStructName().str());
        // return make_shared<TStruct>(type->getStructName().str());
    } else if (type->isArrayTy()) {
        return make_shared<Array>(llvm_ir_type_to_spec_pure(type->getArrayElementType()));
    } else {
        throw std::invalid_argument("invalid types: " + type->getStructName().str());
        return SpecType::UNKNOWN_TYPE;
    }
}


unique_ptr<SpecNode> construct_return_spec(Project* proj, SpoqIRContext& context) {
    if(context.pass_stack.size() == 0) {
        unique_ptr<std::vector<unique_ptr<SpecNode>>> tuple = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
        assert(context.return_list.size() <= 1 && "multiple return value not support yet");
        for (int i = 0; i < context.return_list.size(); i++) {
            tuple->push_back(context.get_llvm_value_spec(context.return_list[i]));
        }
        context.rettype = tuple->at(0)->type;
        context.return_list.clear();
        tuple->push_back(std::make_unique<Symbol>(context.abs_data_name, context.abs_data_type));
        return Shortcut::_Some_u(Shortcut::_Tuple_u(std::move(tuple)));
    } else {
        assert(false && "pass_stack.size() > 0, Not implemented yet");
        // TODO: This is not the final return. Construct a tuple with the return value and the pass_stack.
    }
}

unique_ptr<SpecNode> SpoqIRModule::spoq_inst_to_spec(Project* proj, spoq_inst_vec_t& vec, int num, SpoqIRContext& context) {
    if(num >= vec.size()) { 
        return construct_return_spec(proj, context);
    }

    if (auto spoq_inst = Shortcut::dyn_cast_u<SpoqLLVMInst>(vec[num])) {

        // Terminator
        if (auto ret = llvm::dyn_cast<llvm::ReturnInst>(spoq_inst->inst)) {
            assert(num == vec.size() - 1);
            if(auto rv = ret->getReturnValue()) context.return_list.push_back(rv);
            return spoq_inst_to_spec(proj, vec, num + 1, context);
        } 

        // Binary Operation
        if (auto bi = llvm::dyn_cast<llvm::BinaryOperator>(spoq_inst->inst)) {
            unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(bi->getOperand(0)));
            operands->push_back(context.get_llvm_value_spec(bi->getOperand(1)));
            if(binops_lut.find(bi->getOpcode()) == binops_lut.end()) {
                llvm::errs() << "Binary operation not supported: " << *bi << "\n";
                assert(false && "Binary operation not supported");
            }
            unique_ptr<Expr> expr = std::make_unique<Expr>(binops_lut.at(bi->getOpcode()), std::move(operands));
            unique_ptr<SpecNode> sym = context.get_llvm_value_spec(bi);
            auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);
            auto _let =  Shortcut::_Let_u(std::move(sym), std::move(expr), std::move(remain));
            return _let;
        } else if(auto cmp = llvm::dyn_cast<llvm::CmpInst>(spoq_inst->inst)) {
            unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(cmp->getOperand(0)));
            operands->push_back(context.get_llvm_value_spec(cmp->getOperand(1)));
            if(cmpops_lut.find(cmp->getPredicate()) == cmpops_lut.end()) {
                llvm::errs() << "Binary operation not supported: " << *cmp << "\n";
                assert(false && "Binary operation not supported");
            }
            unique_ptr<Expr> expr = std::make_unique<Expr>(cmpops_lut.at(cmp->getPredicate()), std::move(operands));
            unique_ptr<SpecNode> sym = context.get_llvm_value_spec(cmp);
            return Shortcut::_Let_u(context.get_llvm_value_spec(cmp), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        } 

        // function call
        if (auto call = llvm::dyn_cast<llvm::CallInst>(spoq_inst->inst)) {
            if (call->isInlineAsm()) {
                llvm::errs() << "call: " << *call << "\n";
                assert(false && "Not implemented yet: inline asm");
            }

            if (auto callee = call->getCalledFunction()) {
                auto args = std::make_unique<vector<unique_ptr<SpecNode>>>();
                for(int i = 0; i < call->arg_size(); i++) {
                    args->push_back(context.get_llvm_value_spec(call->getArgOperand(i)));
                }
                args->push_back(context.get_abs_data());

                if (callee->isIntrinsic()) {
                    if(callee->getIntrinsicID() == llvm::Intrinsic::dbg_value) {
                        return spoq_inst_to_spec(proj, vec, num + 1, context);
                    }
                    llvm::errs() << "Intrinsic function call: " << *call << "\n";
                    assert(false && "Not impl: intrinsic function call");
                } else {
                    unique_ptr<SpecNode> ret = nullptr;
                    if(call->getType()->isVoidTy()) {
                        ret = context.get_abs_data();
                    } else {
                        auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
                        children->push_back(context.get_llvm_value_spec(call));
                        children->push_back(context.get_abs_data());
                        ret = Shortcut::_Tuple_u(std::move(children));
                    }

                    auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);

                    // TODO: re-introduce post ensure here

                    auto callee_name = callee->getName().str() + "_spec";
                    return Shortcut::_When_u(std::move(ret), std::make_unique<Expr>(callee_name, std::move(args)), std::move(remain));
                }

            } else {
                llvm::errs() << "No inline asm && No called function found: " << *call << "\n";
                assert(false && "No inline asm && No called function found");
            }
        }

        // TODO: memory access support(load, store, getelementptr)

        // TODO: pointer conversion (ptr2int, int2ptr)
        // TODO: bitwise binary operations (shl, lshr, ashr, and, or, xor)
        // TODO: other conversion operations
        llvm::errs() << "Unsupported SpoqIR instruction [LLVM]: " << *spoq_inst->inst << "\n";
        assert(false && "Unsupported SpoqIR instruction [LLVM]");
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqIfInst>(vec[num])) {
        if (num == vec.size() - 1) {
            /// Final return.
            auto cond = context.get_llvm_value_spec(inst->cond);
            auto then_body = spoq_inst_to_spec(proj, inst->true_body, 0, context);
            auto else_body = spoq_inst_to_spec(proj, inst->false_body, 0, context);
            unique_ptr<If> if_inst = std::make_unique<If>(
                std::move(cond), std::move(then_body), std::move(else_body));
            return std::move(if_inst);
        } else {
            // TODO: This is not a final return. Modify the context to have correct return values.
            assert(false && "Not implemented yet - if-else but not final return");
            return nullptr;
        }
    } else {
        assert(false && "Unsupported SpoqIR instruction [LOOP]");
        // TODO: SpoqLoop, SpoqContinue, SpoqBreak
        return nullptr;
    }
}

}; // namespace autov