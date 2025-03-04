#include "SpoqIRLoader.h"
#include "SpoqIRModule.h"
#include "ir2spec.h"
#include "project.h"
#include "values.h"
#include "shortcuts.h"


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
        for(auto iasm: proj->spoq_code.iasm_defs) {
            if (proj->defs.find(iasm.first + "_spec") == proj->defs.end()) {
                LOG_ERROR << "cannot find iasm definition, please provide it manually " << iasm.first + "_spec" << std::endl;
                for(auto i2f : proj->spoq_code.iasm2func) {
                    if (i2f.second == iasm.first)
                        llvm::errs() << *(i2f.first) << " -> " << i2f.second << "\n";
                }
                assert(false && "cannot find iasm definition");
            }
        }
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
    if(spoq_func.llvm_func->getReturnType()->isVoidTy()) {
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
    assert(context.rettype != SpecType::UNKNOWN_TYPE && string("return type for is unknown").c_str());

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
    preprocess_llvm_module();
    return true;
}


void SpoqIRModule::preprocess_llvm_module() {
    llvm::StripDebugInfo(*llvm_module);

    LOG_DEBUG << "llvm module preprocessing" << std::endl;
    llvm::LoopAnalysisManager LAM;
    llvm::FunctionAnalysisManager FAM;
    llvm::CGSCCAnalysisManager CGAM;
    llvm::ModuleAnalysisManager MAM;

    llvm::PassBuilder PB;

    PB.registerModuleAnalyses(MAM);
    PB.registerCGSCCAnalyses(CGAM);
    PB.registerFunctionAnalyses(FAM);
    PB.registerLoopAnalyses(LAM);
    PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);

    llvm::ModulePassManager MPM;
    // TODO: there is a chance that LowerSwitchPass use jump table instead of br.
    // If that is the case, we should use a manually written pass to convert switch to if-else.
    MPM.addPass(llvm::createModuleToFunctionPassAdaptor(llvm::LowerSwitchPass()));
    MPM.addPass(llvm::createModuleToFunctionPassAdaptor(llvm::SROAPass()));
    MPM.run((*llvm_module), MAM);
    LOG_DEBUG << "llvm module preprocessing ok" << std::endl;

    for (auto &func : *this->llvm_module) {
        // TODO: fix me, what to do with the intrinsic function.
        // if (func.isIntrinsic()) continue;
        std::string oldName = func.getName().str();
        std::string newName = Shortcut::replace_dot(oldName);
        if (oldName != newName) func.setName(newName);
    }
    for (auto &gv : this->llvm_module->globals()) {
        if (!gv.hasName()) {
            llvm::errs() << "global variable without name\n" << " " << gv << "\n";
            assert(false && "global variable without name");
        }
        // Construct a new name for the global variable
        std::string oldName = gv.getName().str();
        std::string newName = Shortcut::replace_dot(oldName);
        if (oldName != newName) gv.setName(newName);
    }
}


} // namespace autov
