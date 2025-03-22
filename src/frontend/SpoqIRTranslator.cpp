#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "nodes.h"
#include "project.h"
#include "shortcuts.h"

#include <cassert>
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/Casting.h"
#include "llvm/Transforms/Utils/ValueMapper.h"
#include "llvm/IR/InlineAsm.h"
#include <memory>
#include <stdexcept>
#include <unordered_map>
#include <values.h>

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Transforms/Scalar/ConstantHoisting.h"
#include "llvm/Support/raw_ostream.h"

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
    {llvm::Instruction::BinaryOps::URem, Expr::binops::MOD},
    {llvm::Instruction::BinaryOps::Shl, Expr::binops::LSHIFT},
    {llvm::Instruction::BinaryOps::LShr, Expr::binops::RSHIFT}, // FIXME: we use RSHIFT(arithmetic) for both LShr
    {llvm::Instruction::BinaryOps::AShr, Expr::binops::RSHIFT},
    {llvm::Instruction::BinaryOps::And, Expr::binops::BITAND},
    {llvm::Instruction::BinaryOps::Or, Expr::binops::BITOR},
    // FIXME: {llvm::Instruction::BinaryOps::Xor, Expr::binops::BITOR},
};

const std::unordered_map<llvm::Instruction::BinaryOps, Expr::binops> SpoqIRModule::bool_binops_lut = {
    {llvm::Instruction::BinaryOps::And, Expr::binops::BAND},
    {llvm::Instruction::BinaryOps::Or, Expr::binops::BOR},
    {llvm::Instruction::BinaryOps::Xor, Expr::binops::NOT_EQUAL},
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


void SpoqIRModule::dfs_llvm_ir_to_spoq_inst_vec (llvm::BasicBlock* block, llvm::BasicBlock* parent, spoq_inst_vec_t& vec, SpoqLoopContext& context) { 

    if (context.is_backward(parent, block)) {
        vec.push_back(std::make_unique<SpoqContinueInst>(parent));
        return;
    }

    if (context.is_exiting(parent, block)) {
        vec.push_back(std::make_unique<SpoqBreakInst>(parent));
        return;
    }

    assert (block != context.get_postheader() && "Postheader should not be visited. All exits blcoked before.");

    // This block is a loop preheader. 
    // The preheader's all instructions excpet for the last unconditional branch are put in the current vec.
    // The postheader's all instructions except for PHIs should be put in the current vec
    if (auto target = context.require_jump(block)) {
        assert(!context.has_loop_inst_for_jump(block));

        for (auto &inst: *block) {
            if (inst.isTerminator()) continue;
            vec.push_back(std::make_unique<SpoqLLVMInst>(&inst));
        }

        
        auto v = std::make_unique<SpoqLoopInst>(block);
        context.set_loop_inst_for_jump(block, v->body);
        vec.push_back(std::move(v));

        dfs_llvm_ir_to_spoq_inst_vec(target, nullptr, vec, context);
        return;
    } 


    // Non preheader
    for(auto &inst: *block) {
        if(auto phi = llvm::dyn_cast<llvm::PHINode>(&inst)) {
            assert( (block == context.get_loopheader() || context.postheader_with_phi(block)) && "PHI node is not in the loop header or postheader");
            if (block == context.get_loopheader()) {
                context.add_header_phi(phi);
            }
            continue;
            // This phi nodes of postheader belongs to the loop we jump.
            // It will be processed when we process that loop.
        }
        
        if(auto br = llvm::dyn_cast<llvm::BranchInst>(&inst)) {
            if(br->isConditional()) {
                auto cond = br->getCondition();
                auto true_block = br->getSuccessor(0);
                auto false_block = br->getSuccessor(1);
                SpoqIfInst spoq_inst(cond);
                dfs_llvm_ir_to_spoq_inst_vec(true_block, block, spoq_inst.true_body, context);
                dfs_llvm_ir_to_spoq_inst_vec(false_block, block, spoq_inst.false_body, context);
                vec.push_back(std::make_unique<SpoqIfInst>(std::move(spoq_inst)));
            } else {
                dfs_llvm_ir_to_spoq_inst_vec(br->getSuccessor(0), block, vec, context);
            }
            return; // A br is the last instruction in a block (for a valid llvm module)
        }  
        else {
            // These functions are added before
            if (block == context.get_preheader()) continue;
            vec.push_back(std::make_unique<SpoqLLVMInst>(&inst));
        }
    }
}

bool SpoqIRModule::llvm_ir_to_spoq_ir(SpoqFunction &spoq_func) {
    if(!spoq_func.cfg_converted) return false;

    spoq_func.loop_context.init(spoq_func.llvm_func);
    while(spoq_func.loop_context.step()) {
        if ( !spoq_func.loop_context.context_in_loop() ) 
            dfs_llvm_ir_to_spoq_inst_vec(spoq_func.loop_context.get_start(), nullptr, spoq_func.spoq_insts, spoq_func.loop_context);
        else {
            dfs_llvm_ir_to_spoq_inst_vec(spoq_func.loop_context.get_start(), nullptr, spoq_func.loop_context.get_loop_inst_for_jump(), spoq_func.loop_context);
            // Update the postheader_phi 
            for (auto &inst: spoq_func.loop_context.get_postheader()->phis()) {
                spoq_func.loop_context.add_postheader_phi(&inst);
            }
        }
    }

    spoq_func.spoq_insts_converted = true;
    return true;
}

// Spoq IR <----> Spoq Coq Low Spec

unique_ptr<SpecNode> SpoqIRContext::get_llvm_value_spec(llvm::Value* value, llvm::Type* force_sym_type, bool abstraction) {
    if (value == nullptr) assert(false && "llvm value is nullptr");
    if (force_sym_type != nullptr) {
        type_map[value] = SpoqIRModule::llvm_ir_type_to_spec_pure(force_sym_type);
        return std::make_unique<Symbol>(get_llvm_value_name(value), type_map[value]);
    }

    if (llvm::dyn_cast<llvm::Constant>(value)) {
        if(auto global = llvm::dyn_cast<llvm::GlobalVariable>(value)) {
            auto name = global->getName().str();
            assert(name != "" && "global variable name is empty");
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::make_unique<StringConst>(name));
            vec->push_back(std::make_unique<IntConst>(0));
            return std::make_unique<Expr>("mkPtr", std::move(vec));
        } else if(auto data = llvm::dyn_cast<llvm::ConstantData>(value)) {
            if (auto int_val = llvm::dyn_cast<llvm::ConstantInt>(data)) {
                if(int_val->getBitWidth() == 1) {
                    return std::make_unique<BoolConst>(!int_val->isZero());
                } else {
                    // FIXME: do we convert large integer here?
                    return std::make_unique<IntConst>(int_val->getSExtValue(), int_val->isNegative());
                }
            } else if(auto ptr_null = llvm::dyn_cast<llvm::ConstantPointerNull>(data)) {
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::make_unique<StringConst>("null"));
                vec->push_back(std::make_unique<IntConst>(0));
                auto expr = std::make_unique<Expr>("mkPtr", std::move(vec));
                expr->type = Struct::Ptr;
                return expr;
            } else if (auto undef = llvm::dyn_cast<llvm::UndefValue>(data)) {
                if (data->getType()->isIntegerTy(1)) {
                    return std::make_unique<BoolConst>(true);
                } else if (data->getType()->isIntegerTy()) {
                    // TODO: should we emit a warning here?
                    return std::make_unique<IntConst>(0);
                } else if (data->getType()->isArrayTy()) {
                    // TODO: check array element is integer
                    return std::make_unique<Symbol>("undef_zmap", this->get_llvm_value_type(undef));
                } else if (data->getType()->isPointerTy()) {
                    auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    vec->push_back(std::make_unique<StringConst>("null"));
                    vec->push_back(std::make_unique<IntConst>(0));
                    auto expr = std::make_unique<Expr>("mkPtr", std::move(vec));
                    expr->type = Struct::Ptr;
                    return expr;
                }
            } 
        } else if (auto expr = llvm::dyn_cast<llvm::ConstantExpr>(value)) {
            if (expr->getOpcode() == llvm::AddrSpaceCastInst::CastOps::PtrToInt) {
              auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
              vec->push_back(this->get_llvm_value_spec(expr->getOperand(0)));
              return std::make_unique<Expr>(this->ptr2int_op_name, std::move(vec));
            } else if (expr->getOpcode() == llvm::AddrSpaceCastInst::CastOps::IntToPtr) {
              auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
              vec->push_back(this->get_llvm_value_spec(expr->getOperand(0)));
              return std::make_unique<Expr>(this->int2ptr_op_name, std::move(vec));
            }
            else if (expr->getOpcode() == llvm::Instruction::GetElementPtr) {
                auto res = SpoqIRModule::gep_inst_to_spec(expr, *this);
                return std::move(res.second);
            } else if (expr->getOpcode() == llvm::AddrSpaceCastInst::CastOps::BitCast) {
                if (expr->getOperand(0)->getType()->isPointerTy() && value->getType()->isPointerTy()) {
                    return this->get_llvm_value_spec(expr->getOperand(0));
                }
            }
        } 
        llvm::errs() << "unsupport llvm constant: " << *value << "\n";
        assert(false && "unsupport llvm constant");
    } else if (auto arg = llvm::dyn_cast<llvm::Argument>(value)) {
        if (type_map.find(value) == type_map.end()) {
            type_map[value] = this->get_llvm_value_type(value);
        }
        auto symbol = std::make_unique<Symbol>(get_llvm_value_name(value),
                                            type_map[value]);
        auto abs = arg_require_abstraction(arg->getParent(), arg->getArgNo());
        if (abstraction && abs != "") {
            assert(type_map[value]->name == "Z" && "only support Z type for abstraction");
            // std::cout << "abstraction: " << abs << std::endl;
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::move(symbol));
            auto expr = std::make_unique<Expr>("Z_to_" + abs, std::move(vec));
            expr->type = make_shared<SpecType>(abs);
            // std::cout << "abstraction: " << string(*expr) << std::endl;

            auto vec2 = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec2->push_back(std::move(expr));
            auto expr2 = std::make_unique<Expr>(abs + "_to_Z", std::move(vec2));
            expr2->type = Int::INT;
            return expr2;
        } else {
            return symbol;
        }
    } else if (auto inst = llvm::dyn_cast<llvm::Instruction>(value)) {
        if (type_map.find(value) == type_map.end()) {
            type_map[value] = this->get_llvm_value_type(value);
        }
        auto symbol = std::make_unique<Symbol>(get_llvm_value_name(value),
                                        type_map[value]);
        auto call = llvm::dyn_cast<llvm::CallInst>(value);
        if (call && abstraction) {
            auto abs = ret_require_abstraction(call->getCalledFunction(), 0);
            if (abs != "") {
                // std::cout << string(*symbol) << " " << string(*type_map[value]) << std::endl;
                assert(type_map[value]->name == "Z" &&
                       "only support Z type for abstraction");
                // std::cout << "abstraction: " << abs << std::endl;
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::move(symbol));
                auto expr =
                    std::make_unique<Expr>("Z_to_" + abs, std::move(vec));
                expr->type = make_shared<SpecType>(abs);
                // std::cout << "abstraction: " << string(*expr) << std::endl;

                auto vec2 = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec2->push_back(std::move(expr));
                auto expr2 =
                    std::make_unique<Expr>(abs + "_to_Z", std::move(vec2));
                expr2->type = Int::INT;
                return expr2;
            }
        }
        auto load = llvm::dyn_cast<llvm::LoadInst>(value);
        if (load && abstraction) {
            auto abs = symbol_require_abstraction(load->getParent()->getParent(), symbol->text);
            if (abs != "") {
                assert(type_map[value]->name == "Z" &&
                       "only support Z type for abstraction");
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::move(symbol));
                auto expr =
                    std::make_unique<Expr>("Z_to_" + abs, std::move(vec));
                expr->type = make_shared<SpecType>(abs);
                std::cout << "abstraction: " << string(*expr) << std::endl;

                auto vec2 = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec2->push_back(std::move(expr));
                auto expr2 =
                    std::make_unique<Expr>(abs + "_to_Z", std::move(vec2));
                expr2->type = Int::INT;
                return expr2;
            }
        }
        return symbol;
    } else {
        llvm::errs() << "unsupport llvm value: " << *value << " " << *(value->getType()) << "\n";
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
        assert(type->getStructName().str() != "" && "struct name is empty, fix me with a pass to assign name for each struct");
        return make_shared<SpecType>(type->getStructName().str());
    } else if (type->isArrayTy()) {
        auto elem_type = llvm_ir_type_to_spec_pure(type->getArrayElementType());
        assert(elem_type != SpecType::UNKNOWN_TYPE && "array element type is unknown");
        return make_shared<ZMap>(elem_type);
    } else {
        throw std::invalid_argument("invalid types: " + type->getStructName().str());
        return SpecType::UNKNOWN_TYPE;
    }
}

unique_ptr<SpecNode> construct_return_spec(Project *proj,
                                           SpoqIRContext &context) {
    if (context.continue_return) {
        auto v = std::move(context.continue_return);
        context.continue_return = nullptr;
        return v;
    }

    unique_ptr<std::vector<unique_ptr<SpecNode>>> tuple =
        std::make_unique<std::vector<unique_ptr<SpecNode>>>();
    if (context.pass_stack.size() == 0)
        assert(context.return_list.size() <= 1 &&
               "multiple return value only supported for loop component");

    if (context.return_list.size() >= 1) {
        for (int i = 0; i < context.return_list.size(); i++) {
            tuple->push_back(
                context.get_llvm_value_spec(context.return_list[i]));
        }
        if (context.return_list.size() == 1)
            context.rettype = tuple->at(0)->type;
        else {
            std::shared_ptr<std::vector<shared_ptr<SpecType>>> children_type =
                std::make_shared<std::vector<shared_ptr<SpecType>>>();
            for (int i = 0; i < context.return_list.size(); i++) {
                children_type->push_back(
                    context.get_llvm_value_type(context.return_list[i]));
            }
            context.rettype = std::make_shared<Tuple>(children_type);
        }

        context.return_list.clear();
        tuple->push_back(std::make_unique<Symbol>(context.abs_data_name,
                                                  context.abs_data_type));
        return Shortcut::_Some_u(Shortcut::_Tuple_u(std::move(tuple)));
    } else {
        return Shortcut::_Some_u(context.get_abs_data());
    }
}
std::pair<unique_ptr<SpecNode>, unique_ptr<SpecNode>> 
SpoqIRModule::gep_inst_to_spec (llvm::Value* gep_inst_or_expr, SpoqIRContext& context) {
    auto gep_inst = llvm::dyn_cast<llvm::GetElementPtrInst>(gep_inst_or_expr);
    auto gep_expr = llvm::dyn_cast<llvm::ConstantExpr>(gep_inst_or_expr);
    if ((!gep_expr || gep_expr->getOpcode() != llvm::Instruction::GetElementPtr) && !gep_inst ) {
        llvm::errs() << *gep_inst_or_expr << "\n";
        assert(false && "gep_inst_to_spec: not a gep instruction");
    }
    auto gep = llvm::dyn_cast<llvm::User>(gep_inst_or_expr);

    auto ptr = context.get_llvm_value_spec(gep->getOperand(0));
    unique_ptr<SpecNode> expr = std::make_unique<IntConst>(0);
    auto source_ptr_type = llvm::dyn_cast<llvm::PointerType>(gep->getOperand(0)->getType());
    assert(source_ptr_type && "source pointer type is not a pointer type for GEP");
    auto source_type = source_ptr_type->getPointerElementType();
    auto const c_source_type = source_type;
    // TODO: fix me like the gep instruction, use pointer type first
    // getSourceElementType();
    std::vector<llvm::Value*> indices;
    for(int i = 1; i < gep->getNumOperands(); i++) {
        llvm::Value* index = gep->getOperand(i);
        indices.push_back(index);
        auto elem_type = llvm::GetElementPtrInst::getIndexedType(c_source_type, indices);
        if(auto sty = llvm::dyn_cast<llvm::StructType>(source_type)) {
            assert(index->getType()->isIntegerTy() && "Struct index is not integer");
            auto index_val = llvm::dyn_cast<llvm::ConstantInt>(index);
            auto offset = context.llvm_dl->getStructLayout(sty)->getElementOffset(index_val->getZExtValue());
            auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
            operands->push_back(std::move(expr));
            operands->push_back(std::make_unique<IntConst>(offset));
            expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
        } else {
            int type_size;
            if(elem_type->isVectorTy()) type_size = context.llvm_dl->getTypeStoreSize(elem_type);
            else type_size = context.llvm_dl->getTypeAllocSize(elem_type);
            auto index_value = context.get_llvm_value_spec(index);
            auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
            operands->push_back(std::move(index_value));
            operands->push_back(std::make_unique<IntConst>(type_size));
            auto mul_expr = std::make_unique<Expr>(Expr::binops::MULT,std:: move(operands));
            operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
            operands->push_back(std::move(mul_expr));
            operands->push_back(std::move(expr));
            expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
        }
        source_type = elem_type;
    }
    auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
    operands->push_back(context.get_llvm_value_spec(gep->getOperand(0)));
    operands->push_back(std::move(expr));
    expr = std::make_unique<Expr>(context.ptr_off_op_name, std::move(operands));
    if (gep_inst) {
        auto sym = context.get_llvm_value_spec(gep);
        return std::make_pair(std::move(sym), std::move(expr));
    } else {
        return std::make_pair(nullptr, std::move(expr));
    }
    // return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
}

std::pair<unique_ptr<SpecNode>, unique_ptr<SpecNode>> 
SpoqIRModule::store_load_to_spec(llvm::Instruction* inst, SpoqIRContext& context) {
    if (auto load = llvm::dyn_cast<llvm::LoadInst>(inst)) {
        // TODO: pointer abstraction here
        unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
        auto ptr_type = llvm::dyn_cast<llvm::PointerType>(load->getPointerOperand()->getType());
        auto value_type = ptr_type->getPointerElementType();
        auto value_size = context.llvm_dl->getTypeStoreSize(value_type);

        operands->push_back(make_unique<IntConst>(value_size));
        operands->push_back(context.get_llvm_value_spec(load->getPointerOperand()));
        operands->push_back(context.get_abs_data());

        auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
        if (value_type->isIntegerTy()) {
            children->push_back(context.get_llvm_value_spec(load, nullptr, false));
        }
        else if (value_type->isPointerTy()) {
            children->push_back(context.get_llvm_value_spec_ptr_in_Z(load));
        }
        else {
            assert(false && "load value type not supported");
        }
        children->push_back(context.get_abs_data());
        auto ret = Shortcut::_Tuple_u(std::move(children));
        auto expr = std::make_unique<Expr>(context.load_op_name, std::move(operands));
        return std::make_pair(std::move(ret), std::move(expr));
    } else if (auto store = llvm::dyn_cast<llvm::StoreInst>(inst)) {
        unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
        auto value_type = store->getValueOperand()->getType();
        auto value_size = context.llvm_dl->getTypeStoreSize(value_type);
        operands->push_back(make_unique<IntConst>(value_size));
        operands->push_back(context.get_llvm_value_spec(store->getPointerOperand()));
        auto value_op = context.get_llvm_value_spec(store->getValueOperand());
        if (value_type->isIntegerTy()) {
            operands->push_back(std::move(value_op));
        } else if (value_type->isPointerTy()) {
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::move(value_op));
            // TODO: pointer abstraction here
            operands->push_back(std::make_unique<Expr>(context.ptr2int_op_name, std::move(vec)));
        } else {
            llvm::errs() << "store inst:" << *store << "\n";
            llvm::errs() << "store value type: " << *value_type << "\n";
            assert(false && "store value type not supported");
        }
        operands->push_back(context.get_abs_data());

        auto ret = context.get_abs_data();

        return std::make_pair(std::move(ret), std::make_unique<Expr>(context.store_op_name, std::move(operands)));
    }
    assert(false && "store_load_to_spec: Not implemented yet[store inst]");
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
            auto op0 = context.get_llvm_value_spec(bi->getOperand(0));
            auto op1 = context.get_llvm_value_spec(bi->getOperand(1));

            auto ptr0 = context.is_ptr_to_int(bi->getOperand(0));
            auto ptr1 = context.is_ptr_to_int(bi->getOperand(1));

            bool reduce = bi->getOpcode() == llvm::Instruction::BinaryOps::Add && (ptr0 || ptr1);
            reduce |= bi->getOpcode() == llvm::Instruction::BinaryOps::Sub && ptr0;

            std::unique_ptr<Expr> rely_expr = nullptr;
            auto rely_operands = std::make_unique<vector<unique_ptr<SpecNode>>>();

            if ( reduce && (ptr0 || ptr1) ) {
                if (ptr0) {
                    rely_operands->push_back(context.ptr2int_to_field(ptr0, "pbase"));
                    operands->push_back(context.ptr2int_to_field(ptr0, "poffset"));
                } else {
                    rely_operands->push_back(context.get_llvm_value_spec(bi->getOperand(0)));
                    operands->push_back(std::move(op0));
                }
                if (ptr1) {
                    rely_operands->push_back(context.ptr2int_to_field(ptr1, "pbase"));
                    operands->push_back(context.ptr2int_to_field(ptr1, "poffset"));
                } else {
                    rely_operands->push_back(context.get_llvm_value_spec(bi->getOperand(1)));
                    operands->push_back(std::move(op1));
                }
                if (ptr0 && ptr1) {
                    rely_expr = std::make_unique<Expr>(Expr::EQUAL, std::move(rely_operands));
                }
            } else {
                operands->push_back(std::move(op0));
                operands->push_back(std::move(op1));
            }

            unique_ptr<Expr> expr = nullptr;

            if (bi->getOperand(0)->getType()->isIntegerTy(1)) {
                assert(bi->getOperand(1)->getType()->isIntegerTy(1) && "Binary operation on bool and ?");
                assert(bool_binops_lut.find(bi->getOpcode()) != bool_binops_lut.end() && "Binary operation not supported");
                expr = std::make_unique<Expr>(bool_binops_lut.at(bi->getOpcode()), std::move(operands));
            } else if(binops_lut.find(bi->getOpcode()) != binops_lut.end()) {
                expr = std::make_unique<Expr>(binops_lut.at(bi->getOpcode()), std::move(operands));
            } else if (bi->getOpcode() == llvm::Instruction::BinaryOps::Xor) {
                if(bi->getOperand(0)->getType()->isIntegerTy(1)) {
                    expr = std::make_unique<Expr>("xorb", std::move(operands));
                } else {
                    expr = std::make_unique<Expr>("Z.lxor", std::move(operands));
                }
            }
            if (expr == nullptr) {
                llvm::errs() << "Binary operation not supported: " << *bi << "\n";
                assert(false && "Binary operation not supported");
            }

            unique_ptr<SpecNode> sym = context.get_llvm_value_spec(bi);
            context.add_cache(context.get_llvm_value_name(bi), expr);
            auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);
            auto new_expr = context.apply_abstraction(std::move(expr));
            auto _let =  Shortcut::_Let_u(std::move(sym), std::move(new_expr), std::move(remain));
            if (rely_expr) {
                return std::make_unique<Rely>(std::move(rely_expr), std::move(_let));
            } else {
                return _let;
            }
        } else if(auto cmp = llvm::dyn_cast<llvm::CmpInst>(spoq_inst->inst)) {
            unique_ptr<vector<unique_ptr<SpecNode>>> operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(cmp->getOperand(0)));
            operands->push_back(context.get_llvm_value_spec(cmp->getOperand(1)));
            unique_ptr<Expr> expr = nullptr;
            if (cmp->getOperand(0)->getType()->isPointerTy()) {
                if (cmp->getPredicate() == llvm::CmpInst::Predicate::ICMP_EQ) {
                    expr = std::make_unique<Expr>(context.ptr_eqb_op_name, std::move(operands));
                } 
                else if (cmp->getPredicate() == llvm::CmpInst::Predicate::ICMP_NE) {
                    expr = std::make_unique<Expr>(context.ptr_eqb_op_name, std::move(operands));
                    operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(expr));
                    expr = std::make_unique<Expr>(Expr::ops::BNOT, std::move(operands));
                }
            }
            else if(cmpops_lut.find(cmp->getPredicate()) != cmpops_lut.end()) {
                expr = std::make_unique<Expr>(cmpops_lut.at(cmp->getPredicate()), std::move(operands));
            }
            if (expr == nullptr) {
                llvm::errs() << "Binary operation not supported: " << *cmp << "\n";
                assert(false && "Binary operation not supported");
            }
            unique_ptr<SpecNode> sym = context.get_llvm_value_spec(cmp);
            context.add_cache(context.get_llvm_value_name(cmp), expr);
            auto new_expr = context.apply_abstraction(std::move(expr));
            return Shortcut::_Let_u(context.get_llvm_value_spec(cmp), std::move(new_expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        } 

        // function call
        if (auto call = llvm::dyn_cast<llvm::CallInst>(spoq_inst->inst)) {
            
            if (call->isDebugOrPseudoInst()) {
                return spoq_inst_to_spec(proj, vec, num + 1, context);
            }
            if (auto callee = call->getCalledFunction()) {
                if (callee->isIntrinsic()) {
                    llvm::errs() << "Intrinsic function call: " << *call << "\n";
                    assert(false && "Not impl: intrinsic function call");
                } else if (callee->getName().startswith("llvm_dbg_")) {
                    return spoq_inst_to_spec(proj, vec, num + 1, context);
                } else {
                    auto args = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    for(int i = 0; i < call->arg_size(); i++) {
                        args->push_back(context.get_llvm_value_spec(call->getArgOperand(i)));
                    }
                    args->push_back(context.get_abs_data());

                    unique_ptr<SpecNode> ret = nullptr;
                    if(call->getType()->isVoidTy()) {
                        ret = context.get_abs_data();
                    } else {
                        auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
                        children->push_back(context.get_llvm_value_spec(call, nullptr, false));
                        children->push_back(context.get_abs_data());
                        ret = Shortcut::_Tuple_u(std::move(children));
                    }


                    auto callee_name = callee->getName().str() + "_spec";
                    auto expr = std::make_unique<Expr>(callee_name, std::move(args));
                    auto new_expr = context.apply_abstraction(std::move(expr));

                    auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);

                    if (proj->cmds.PostEnsure.find(callee->getName().str()) != proj->cmds.PostEnsure.end()) {
                        for (auto & prop : proj->cmds.PostEnsure[callee->getName().str()]) {
                            auto p = prop->deep_copy();
                            if (call->getType()->isVoidTy()) {
                                Shortcut::subst_expression(p.get(), "ret_0", context.abs_data_name);
                            } else{
                                Shortcut::subst_expression(p.get(), "ret_0", context.get_llvm_value_name(call));
                                Shortcut::subst_expression(p.get(), "ret_1", context.abs_data_name);
                            }
                            remain = std::make_unique<Rely>(std::move(p), std::move(remain));
                        }
                    } 

                    return Shortcut::_When_u(std::move(ret), std::move(new_expr), std::move(remain));
                }
            } else if (call->isInlineAsm()) {
                    auto iasm = llvm::dyn_cast<llvm::InlineAsm>(call->getCalledOperand());
                    assert(iasm && "Not an inline asm when isInlineAsm() is true");

                    auto args = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    for(int i = 0; i < call->arg_size(); i++) {
                        args->push_back(context.get_llvm_value_spec(call->getArgOperand(i)));
                    }
                    args->push_back(context.get_abs_data());

                    unique_ptr<SpecNode> ret = nullptr;
                    if(call->getType()->isVoidTy()) {
                        ret = context.get_abs_data();
                    } else {
                        auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
                        children->push_back(context.get_llvm_value_spec(call));
                        children->push_back(context.get_abs_data());
                        ret = Shortcut::_Tuple_u(std::move(children));
                    }


                    auto callee_name = proj->spoq_code.iasm2func[call] + "_spec";
                    auto expr = std::make_unique<Expr>(callee_name, std::move(args));

                    auto remain = spoq_inst_to_spec(proj, vec, num + 1, context);
                    return Shortcut::_When_u(std::move(ret), std::move(expr), std::move(remain));
            }
            else {
                llvm::errs() << "No inline asm && No called function found: " << *call << "\n";
                assert(false && "No inline asm && No called function found");
            }
        }

        
        if (auto load = llvm::dyn_cast<llvm::LoadInst>(spoq_inst->inst)) {
            auto rhs = store_load_to_spec(spoq_inst->inst, context);
            if (load->getType()->isPointerTy()) {
                // TODO: pointer abstraction here
                
                auto children = std::make_unique<vector<unique_ptr<SpecNode>>>();
                children->push_back(context.get_llvm_value_spec_ptr_in_Z(load));
                auto i2p_v = std::make_unique<Expr>(context.int2ptr_op_name, std::move(children));

                auto remain_expr = Shortcut::_Let_u(context.get_llvm_value_spec(load, nullptr, false), std::move(i2p_v), spoq_inst_to_spec(proj, vec, num + 1, context));
                return Shortcut::_When_u(std::move(rhs.first), std::move(rhs.second), std::move(remain_expr));
            } else {
                return Shortcut::_When_u(std::move(rhs.first), std::move(rhs.second), spoq_inst_to_spec(proj, vec, num + 1, context));
            }
        } else if (auto store = llvm::dyn_cast<llvm::StoreInst>(spoq_inst->inst)) {
            auto rhs = store_load_to_spec(spoq_inst->inst, context);
            return Shortcut::_When_u(std::move(rhs.first), std::move(rhs.second), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        if (auto alloc = llvm::dyn_cast<llvm::AllocaInst>(spoq_inst->inst)) {
            std::string name;
            if (!alloc->getName().empty()) name = Shortcut::replace_dot(alloc->getName().str());
            else {
                llvm::raw_string_ostream os(name);
                alloc->printAsOperand(os, false, proj->spoq_code.llvm_module.get());
                name.erase(0, 1);
                name = "v_" + Shortcut::replace_dot(name);
            }
            auto stack_var = proj->cmds.StackMap[context.spoq_func.llvm_func->getName().str()][name];
             // TODO: should we use some more stable way to get the stack_var name?
            if(stack_var.empty()) llvm::errs() << "*alloca: " << *alloc << "\n";
            assert(!stack_var.empty() && "stack_var is empty");
            auto children = make_unique<vector<unique_ptr<SpecNode>>>();
            children->push_back(make_unique<StringConst>(stack_var));
            children->push_back(make_unique<IntConst>(0));
            auto mkptr = std::make_unique<Expr>("mkPtr", std::move(children));
            context.add_cache(context.get_llvm_value_name(alloc), mkptr);
            return Shortcut::_Let_u(context.get_llvm_value_spec(alloc), std::move(mkptr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        if (auto gep = llvm::dyn_cast<llvm::GetElementPtrInst>(spoq_inst->inst)) {
            auto ptr = context.get_llvm_value_spec(gep->getPointerOperand());
            unique_ptr<SpecNode> expr = std::make_unique<IntConst>(0);
            auto source_element_type = gep->getPointerOperandType();
            std::vector<llvm::Value*> indices;
            for(auto idx = gep->idx_begin(); idx != gep->idx_end(); ++idx) {
                llvm::Value* index = *idx;
                indices.push_back(index);
                auto elem_type = llvm::GetElementPtrInst::getIndexedType(gep->getSourceElementType(), indices);
                if(auto sty = llvm::dyn_cast<llvm::StructType>(source_element_type)) {
                    assert(index->getType()->isIntegerTy() && "Struct index is not integer");
                    auto index_val = llvm::dyn_cast<llvm::ConstantInt>(index);
                    // llvm::errs() << *gep << "\n";
                    // llvm::errs() << "*index_val: " << *index << "\n";
                    assert(index_val && "index is not a constant integer");
                    auto offset = context.llvm_dl->getStructLayout(sty)->getElementOffset(index_val->getZExtValue());
                    auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(expr));
                    operands->push_back(std::make_unique<IntConst>(offset));
                    expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
                } else {
                    int type_size;
                    if(elem_type->isVectorTy()) type_size = context.llvm_dl->getTypeStoreSize(elem_type);
                    else type_size = context.llvm_dl->getTypeAllocSize(elem_type);
                    auto index_value = context.get_llvm_value_spec(index);
                    auto operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(index_value));
                    operands->push_back(std::make_unique<IntConst>(type_size));
                    auto mul_expr = std::make_unique<Expr>(Expr::binops::MULT,std:: move(operands));
                    operands = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
                    operands->push_back(std::move(mul_expr));
                    operands->push_back(std::move(expr));
                    expr = make_unique<Expr>(Expr::binops::ADD, std::move(operands));
                }
                source_element_type = elem_type;
            }
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(gep->getPointerOperand()));
            operands->push_back(std::move(expr));
            expr = std::make_unique<Expr>(context.ptr_off_op_name, std::move(operands));
            auto sym = context.get_llvm_value_spec(gep);
            context.add_cache(context.get_llvm_value_name(gep), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        if (auto ex = llvm::dyn_cast<llvm::ExtractValueInst>(spoq_inst->inst)) {
            assert(ex->getNumIndices() == 1 && "ExtractValueInst with 0 or multiple indices not supported");
            auto array = ex->getAggregateOperand();
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(array));
            for(auto index: ex->getIndices()) {
                operands->push_back(std::make_unique<IntConst>(index));
            }
            auto expr = std::make_unique<Expr>(Expr::ops::GET, std::move(operands));
            auto sym = context.get_llvm_value_spec(ex);
            context.add_cache(context.get_llvm_value_name(spoq_inst->inst), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        } else if (auto in = llvm::dyn_cast<llvm::InsertValueInst>(spoq_inst->inst)) {
            assert(in->getNumIndices() == 1 && "ExtractValueInst with 0 or multiple indices not supported");
            auto array = in->getAggregateOperand();
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(array));
            for(auto index: in->getIndices()) {
                operands->push_back(std::make_unique<IntConst>(index));
            }
            operands->push_back(context.get_llvm_value_spec(in->getInsertedValueOperand()));
            auto expr = std::make_unique<Expr>(Expr::ops::SET, std::move(operands));
            auto sym = context.get_llvm_value_spec(in);
            context.add_cache(context.get_llvm_value_name(in), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }


        // pointer-integer conversion
        if (auto p2i = llvm::dyn_cast<llvm::PtrToIntInst>(spoq_inst->inst)) {
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(p2i->getPointerOperand()));
            auto expr = std::make_unique<Expr>(context.ptr2int_op_name, std::move(operands));
            auto sym = context.get_llvm_value_spec(p2i);
            context.add_cache(context.get_llvm_value_name(p2i), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        } else if (auto i2p = llvm::dyn_cast<llvm::IntToPtrInst>(spoq_inst->inst)) {
            auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
            operands->push_back(context.get_llvm_value_spec(i2p->getOperand(0)));
            auto expr = std::make_unique<Expr>(context.int2ptr_op_name, std::move(operands));
            auto sym = context.get_llvm_value_spec(i2p);
            context.add_cache(context.get_llvm_value_name(i2p), expr);
            return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
        }

        // TODO: other conversion operations
        if (auto bc = llvm::dyn_cast<llvm::CastInst>(spoq_inst->inst)) {
            auto src = bc->getSrcTy();
            auto dst = bc->getDestTy();
            if (src->isPointerTy() && dst->isPointerTy()) {
                auto sym = context.get_llvm_value_spec(bc);
                auto expr = context.get_llvm_value_spec(bc->getOperand(0));
                context.add_cache(context.get_llvm_value_name(bc), expr);
                return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
            }
            if (src->isIntegerTy() && dst->isIntegerTy()) {
                if (llvm::dyn_cast<llvm::ZExtInst>(bc) && src->isIntegerTy(1)) {
                    auto sym = context.get_llvm_value_spec(bc);
                    auto args = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    args->push_back(context.get_llvm_value_spec(bc->getOperand(0)));
                    auto expr = std::make_unique<Expr>("spoq_zext_spec", std::move(args));
                    context.add_cache(context.get_llvm_value_name(bc), expr);
                    return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
                } 
                // TODO: overflow / underflow check
                auto sym = context.get_llvm_value_spec(bc);
                auto expr = context.get_llvm_value_spec(bc->getOperand(0));
                context.add_cache(context.get_llvm_value_name(bc), expr);
                return Shortcut::_Let_u(std::move(sym), std::move(expr), spoq_inst_to_spec(proj, vec, num + 1, context));
            }
        }

        if (auto phi = llvm::dyn_cast<llvm::PHINode>(spoq_inst->inst)) {
            // PHI nodes in loopheader are translated as loop spec arguments.
            // PHI nodes in postheaders are translated as a _When for the loop spec call
            // PHI nodes are not in any other blocks.
            // TODO: sanity check
            return spoq_inst_to_spec(proj, vec, num + 1, context);
        }

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
            assert(false && "A if-else should always a final return");
            return nullptr;
        }
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqLoopInst>(vec[num])) {

        // Generate the loop body spec
        context.pass_stack.push(inst->preheader_block);
        auto spec = spoq_inst_to_spec(proj, inst->body, 0, context);
        context.pass_stack.pop();

        auto name = context.get_loop_spec_name(inst->preheader_block);
        auto argtype = context.compute_loop_spec_arg(inst->preheader_block);
        auto rettype = context.compute_loop_return_type(inst->preheader_block);
        // context.spoq_func.loop_context.debug_jump();

        auto def = new Fixpoint(name, rettype, std::move(argtype), std::move(spec));
        auto loc = make_shared<loc_t>(proj->layers[context.layer_id]->name, context.fname(), Project::LOC_LOWSPEC);
        proj->add_definition(std::unique_ptr<Fixpoint>(def), loc);

        auto arg_list = context.compute_loop_continue_arg_list(inst->preheader_block, inst->preheader_block);
        auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for(auto arg: arg_list) {
            v->push_back(context.get_llvm_value_spec(arg));
        }
        v->push_back(context.get_abs_data());
        auto src_loop = std::make_unique<Expr>(context.get_loop_spec_name(inst->preheader_block), std::move(v));

        auto pass_out_list = Shortcut::_Tuple_u(context.compute_loop_break_return_list(inst->preheader_block));
        return Shortcut::_When_u(std::move(pass_out_list), std::move(src_loop), spoq_inst_to_spec(proj, vec, num + 1, context));
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqContinueInst>(vec[num])) {
        assert(num == vec.size() - 1 && "continue is not the last instruction");
        int guard = 0, i = 0;
        auto arg_list = context.compute_loop_continue_arg_list(inst->latch_block, nullptr, &guard);
        auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for(auto arg: arg_list) {
            if (i >= guard) {
                v->push_back(std::make_unique<Symbol>("arg_dummy" + std::to_string(i - guard), context.get_llvm_value_type(arg)));
            } else {
                v->push_back(context.get_llvm_value_spec(arg));
            }
            ++i;
        }
        v->push_back(context.get_abs_data());
        context.continue_return = std::make_unique<Expr>(context.get_loop_spec_name(), std::move(v));
        auto typevec = context.compute_loop_return_type(context.pass_stack.top());
        context.continue_return->type = typevec;
        return spoq_inst_to_spec(proj, vec, num + 1, context);
    } else if (auto inst = Shortcut::dyn_cast_u<SpoqBreakInst>(vec[num])) {
        assert(num == vec.size() - 1 && "continue is not the last instruction");
        context.update_loop_break_return_list(inst->exiting_block);
        return spoq_inst_to_spec(proj, vec, num + 1, context);
    } else {
        assert(false && "Unsupported SpoqIR instruction [LOOP]");
        return nullptr;
    }
}

}; // namespace autov