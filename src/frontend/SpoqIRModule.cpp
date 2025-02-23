#include "SpoqIRLoader.h"
#include "SpoqIRModule.h"
#include "ir2spec.h"
#include "project.h"

namespace autov {
std::set<string> SpoqIRModule::get_func_dependencies(llvm::Function *func) {
    std::set<string> s;
    if (func == nullptr)
        return s;
    for (auto &bb : *func) {
        for (auto &inst : bb) {
            if (auto call = llvm::dyn_cast<llvm::CallInst>(&inst)) {
                if (auto called = call->getCalledFunction()) {
                    s.insert(called->getName().str());
                }
            }
        }
    }
    return s;
}

bool SpoqIRModule::load_function_and_convert_all(Project *proj) {
    int func_def = 0, succ = 0;
    std::vector<std::pair<int, int>> func_stats;
    for(auto &func: *proj->spoq_code.llvm_module) {
        if(func.isDeclaration()) continue;
        ++func_def;
        auto original_size = func.size();
        auto name = func.getName().str();
        SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs[name];
        spoq_func.llvm_func = &func; // llvm_func;
        bool ret = control_flow_conversion_v2(proj, name, spoq_func);
        if(ret) {
            succ++;
            func_stats.emplace_back(original_size, func.size());
        }
    }
    double sum = 0;
    for(auto p: func_stats) {
        sum += (double)p.second / p.first;
    }
    LOG_DEBUG << "[CFG]" << func_def << " functions, " << succ << " converted with increasing rate " << sum / func_stats.size() << "\n";
    return true;
}

bool SpoqIRModule::validate_for_gen_low_spec(Project* proj, string fname, int layer_id) {
    SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs[fname];
    if (!spoq_func.cfg_converted || !spoq_func.spoq_insts_converted) return false;
    return true;
}

shared_ptr<SpecType> SpoqIRModule::llvm_ir_type_to_spec(llvm::Type* type) {
    if (type->isIntegerTy(1)) {
        return Bool::BOOL;
    } else if(type->isIntegerTy()) {
        return Int::INT;
    } else if (type->isPointerTy()) {
        // TODO: introduc pointer abstraction here
        //  make_shared<TPtr>(llvm_ir_type_to_spec(type->getPointerElementType()));
        return Struct::Ptr;
    } else if (type->isVoidTy()) {
        // TODO: check if this cause memory leakage
        return make_shared<SpecType>("Void");
    } else if (type->isStructTy()) {
        // TODO: handle struct type
        throw std::invalid_argument("invalid types: " + type->getStructName().str());
        // return make_shared<TStruct>(type->getStructName().str());
    } else if (type->isArrayTy()) {
        return make_shared<Array>(llvm_ir_type_to_spec(type->getArrayElementType()));
    } else {
        throw std::invalid_argument("invalid types: " + type->getStructName().str());
        return SpecType::UNKNOWN_TYPE;
    }
}

bool SpoqIRModule::code_to_spec(Project *proj, string fname, int layer_id,
                                   std::vector<std::string> &low_specs) {
    if (proj == nullptr) return false;
    if (!SpoqIRModule::validate_for_gen_low_spec(proj, fname, layer_id)) return false;

    SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs.at(fname);

    // auto abs_data = proj->layers[layer_id]->abs_data;

    // // build arguments
    // vector<shared_ptr<Arg>> args;
    // for(auto &arg : llvm_func->args()) {
    //     auto type = llvm_ir_type_to_spec(arg.getType());
    //     args.push_back(make_shared<Arg>(arg.getName(), type));
    // }
    // args.push_back(make_shared<Arg>("st", abs_data));

    // auto ret_type = llvm_ir_type_to_spec(llvm_func->getReturnType());
    // if (ret_type) {
    //     ret_type = std::make_shared<Option>(abs_data);
    // } else {
    //     auto vec = std::make_shared<vector<shared_ptr<SpecType>>>(
    //         vector<shared_ptr<SpecType>> {ret_type, abs_data}
    //     );
    //     ret_type = std::make_shared<Option>(std::make_shared<Tuple>(vec));
    // }

    // std::map<string, shared_ptr<SpecType>> func_types;
    // func_types["st"] = abs_data;

    // shared_ptr<SpecNode> body = spoq_func_body_to_spec(proj, spoq_func, func_types);

    return true;
}

bool SpoqIRModule::load_llvm_module(std::string code_path) {
    auto buffer = llvm::MemoryBuffer::getFileOrSTDIN(code_path);
    if (!buffer) {
        llvm::errs() << "Error reading file: " << code_path << "\n";
        return false;
    } 
    auto m = llvm::parseBitcodeFile(*buffer.get(), this->llvm_context);
    if (!m) {
        llvm::errs() << "Error reading module: " << code_path << "\n";
        return false;
    }
    this->llvm_module = std::move(m.get());
    for (auto &func : *this->llvm_module) {
        std::string oldName = func.getName().str();
        std::string newName = oldName;
        std::replace(newName.begin(), newName.end(), '.', '_');
        if (oldName != newName) func.setName(newName);
    }
    return true;
}


} // namespace autov
