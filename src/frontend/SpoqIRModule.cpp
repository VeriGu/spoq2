#include "SpoqIRLoader.h"
#include "SpoqIRModule.h"
#include "ir2spec.h"
#include "project.h"
#include "values.h"
#include "shortcuts.h"
#include "cmd.h"

extern SpoqOption OPTS;
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
        if (name == "init_el2_data_page") continue;
        // if (name == "zif_exif_read_data_vuln") continue;
        // if (name == "zif_exif_read_data_patch") continue;
        // if (name == "exif_discard_imageinfo_vuln") continue;
        // if (name == "exif_discard_imageinfo_patch") continue;
        // if (name == "zif_exif_thumbnail_vuln") continue;
        // if (name != "zif_exif_thumbnail_patch") continue;
        SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs[name];
        spoq_func.llvm_func = &func; // llvm_func;
        bool ret = false;
        try {
            ret = control_flow_conversion_v2(name, spoq_func);
        } catch (const std::runtime_error& e) { 
            std::cout << "error: " << e.what() << std::endl;
            spoq_func.spoq_insts.clear();
            spoq_func.stub = true;
        }
        if(ret) {
            succ++;
            func_stats.emplace_back(original_size, func.size());
            if (func.size() > 100) {
                LOG_DEBUG << "[CFG] " << name << " converted, original size: " << original_size
                          << ", new size: " << func.size() << "\n";
            }
        } else {
            LOG_ERROR << "[CFG] " << name << " not converted.\n" ;
        }
    }
    double sum = 0;
    for(auto p: func_stats) {
        sum += (double)p.second / p.first;
    }
    LOG_DEBUG << "[CFG]" << func_def << " functions, " << succ << " converted with increasing rate " << sum / func_stats.size() << "\n";
    return true;
}

std::map<std::string, bool> missed;
bool SpoqIRModule::validate_for_gen_low_spec(Project* proj, string fname, int layer_id) {
    SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs[fname];
    if (!spoq_func.cfg_converted) {
        LOG_ERROR << "cannot convert control flow for function " << fname << std::endl;
        return false;
    }
    if (!spoq_func.spoq_insts_converted) {
        if(!llvm_ir_to_spoq_ir(spoq_func)) {
            LOG_ERROR << "cannot convert llvm IR to Spoq IR for function " << fname << std::endl;
            return false;
        }
        proj->spoq_code.extract_inline_asm(spoq_func);
        for(auto iasm: proj->spoq_code.iasm_defs) {
            if (proj->defs.find(iasm.first + "_spec") == proj->defs.end()) {
                // if (checked[iasm.first]) continue;
                // checked[iasm.first] = true;
                LOG_ERROR << "cannot find iasm definition, please provide it manually " << iasm.first + "_spec" << std::endl;
                // std::cout << "# " << iasm.first + "_spec" << std::endl;
                for(auto i2f : proj->spoq_code.iasm2func) {
                    if (i2f.second == iasm.first)
                        llvm::errs() << *(i2f.first) << " -> " << i2f.second << "\n";
                }
                if (OPTS.dry_run_asm) {
                    if (missed[iasm.first]) continue; // This one has already be recorded.
                    missed[iasm.first] = true;
                    std::ofstream file("missing_asm.txt", std::ios::app);
                    if (file) file << iasm.first + "_spec\n";
                } else {
                    if (layer_id >= 1) assert(false && "cannot find iasm definition");
                }
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
    if (OPTS.dry_run_asm) return false;

    SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs.at(fname);
    SpoqIRContext context(spoq_func, proj->layers[layer_id], layer_id, proj->abs_config, proj->abs_layout);

    unique_ptr<vector<shared_ptr<Arg>>> args = std::make_unique<vector<shared_ptr<Arg>>>();
    for(auto &arg : spoq_func.llvm_func->args()) {
        auto sym = context.get_llvm_value_spec(&arg, nullptr, false);
        auto symbol = dynamic_cast<Symbol*>(sym.get());
        assert(symbol && "arg is not a symbol without abstraction");
        args->push_back(std::make_shared<Arg> (symbol->text, symbol->type));
    }
    args->push_back(make_shared<Arg>(context.abs_data_name, context.abs_data_type));

    unique_ptr<SpecNode> spec;
    if (!spoq_func.stub) {
        spec = proj->spoq_code.spoq_inst_to_spec(proj, spoq_func.spoq_insts, 0, context);
    } else {
        spec = std::make_unique<Symbol>("None");
    }

    if(proj->cmds.InitRely.find(fname) != proj->cmds.InitRely.end()) {
        for(auto & f : proj->cmds.InitRely[fname])
            spec = std::make_unique<Rely>(f->deep_copy(), std::move(spec));
    }    

    for (auto & f : context.abs_rely) {
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
    name_map[spec_name] = fname + "_spec";
    for(auto &loop: context.loop_spec_name) {
        low_specs.push_back(loop.second);
        name_map[loop.second] = loop.second.substr(0, loop.second.size() - 4);
    }
    low_specs.push_back(spec_name);

    auto def = new Definition(spec_name, rettype, std::move(args), std::move(spec));

    auto loc = make_shared<loc_t>(proj->layers[layer_id]->name, fname, Project::LOC_LOWSPEC);
    proj->add_definition(std::unique_ptr<Definition>(def), loc);

    // TODO: introduce other dependencies
    proj->deps[def->name] = SpoqIRModule::get_func_dependencies(spoq_func.llvm_func);

    for (auto &spec_name: low_specs) {
        LOG_INFO << "Generated low spec: " << spec_name;
        std::cout << string(*proj->defs[spec_name]) << std::endl;
        // LOG_INFO << string(*proj->defs[spec_name]).substr(0,100);
    }

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
        // unsigned count = 0;
        // for (auto &BB : func) {
        //     for(auto &inst: BB) {
        //         if (llvm::dyn_cast<llvm::GetElementPtrInst>(&inst)) {
        //             count++;
        //         }
        //     }
        // }
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
