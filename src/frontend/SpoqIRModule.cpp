#include "SpoqIRLoader.h"
#include "SpoqIRModule.h"
#include "ir2spec.h"
#include "project.h"
#include <values.h>

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
    if (!spoq_func.cfg_converted) return false;
    if (!spoq_func.spoq_insts_converted) {
        if(!llvm_ir_to_spoq_ir(spoq_func)) return false;
        proj->spoq_code.extract_inline_asm(spoq_func);
        return true;
    }
    return false;
}


bool SpoqIRModule::code_to_spec(Project *proj, string fname, int layer_id,
                                   std::vector<std::string> &low_specs,
                                   std::unordered_map<string, string> &name_map) {
    if (proj == nullptr) return false;
    if (!SpoqIRModule::validate_for_gen_low_spec(proj, fname, layer_id)) return false;

    SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs.at(fname);
    SpoqIRContext context(spoq_func, proj->layers[layer_id]);

    unique_ptr<vector<shared_ptr<Arg>>> args = std::make_unique<vector<shared_ptr<Arg>>>();
    for(auto &arg : spoq_func.llvm_func->args()) {
        auto sym = context.get_llvm_value_spec(&arg);
        auto symbol = dynamic_cast<Symbol*>(sym.get());
        args->push_back(std::make_shared<Arg> (symbol->text, symbol->type));
    }
    args->push_back(make_shared<Arg>(context.abs_data_name, context.abs_data_type));

    unique_ptr<SpecNode> spec = proj->spoq_code.spoq_inst_to_spec(proj, spoq_func.spoq_insts, 0, context);

    if(proj->cmds.InitRely.find(fname) != proj->cmds.InitRely.end()) {
        for(auto & f : proj->cmds.InitRely[fname])
            spec = std::make_unique<Rely>(f->deep_copy(), std::move(spec));
    }    

    shared_ptr<SpecType> rettype = nullptr;
    if(spoq_func.llvm_func->getType()->isVoidTy()) {
        rettype = std::make_shared<Option>(context.abs_data_type);
    } else {
        auto children = std::make_shared<vector<shared_ptr<SpecType>>>();
        children->push_back(context.rettype);
        children->push_back(context.abs_data_type);
        rettype = std::make_shared<Option>(make_shared<Tuple>(children));
    }

    auto spec_name = fname + "_spec_low";
    low_specs.push_back(spec_name);

    name_map[spec_name] = fname + "_spec";
    auto def = new Definition(spec_name, rettype, std::move(args), std::move(spec));

    auto loc = make_shared<loc_t>(proj->layers[layer_id]->name, fname, Project::LOC_LOWSPEC);
    proj->add_definition(std::unique_ptr<Definition>(def), loc);

    // TODO: introduce other dependencies
    proj->deps[def->name] = SpoqIRModule::get_func_dependencies(spoq_func.llvm_func);

    // std::cout << "Generated low spec: " << spec_name << std::endl;
    // std::cout << string(*proj->defs[spec_name]) << "\n";

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
