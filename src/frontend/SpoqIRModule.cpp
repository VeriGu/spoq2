#include "SpoqIRLoader.h"
#include "SpoqIRModule.h"
#include "ir2spec.h"
#include "project.h"
#include "values.h"
#include "shortcuts.h"
#include "cmd.h"
#include "llvm/IR/Operator.h"

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
        if (name == "zif_exif_read_data_vuln") continue; // would fail and abort anyway
        if (name == "zif_exif_read_data_patch") continue;
        if (name == "exif_discard_imageinfo") continue;
        if (name == "zif_exif_thumbnail_vuln") continue;
        if (name == "zif_exif_thumbnail_patch") continue;
        if (name == "sws_setColorspaceDetails") continue;
        if (name == "fill_rgb2yuv_table") continue;
        if (name == "phar_flush") continue; // php015
        if (name == "avcodec_string") continue; // ffm050
        if (name.find("avcodec_open") != std::string::npos) continue; // ffm050
        if (name.find("avcodec_decode") != std::string::npos) continue; // ffm050
        if (name.find("av_get_") != std::string::npos) continue; // ffm050
        if (name.find("get_buffer") != std::string::npos) continue; // ffm050
        if (name.find("for_cond") != std::string::npos) continue;
        SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs[name];
        spoq_func.llvm_func = &func; // llvm_func;
        bool ret = false;
        try {
            LOG_DEBUG << "[CFG] Attempting conversion on: " << name << ".";
            ret = control_flow_conversion_v2(name, spoq_func);
        } catch (const std::runtime_error& e) {
            llvm::errs() << "error: " << e.what() << "\n";
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

namespace {

/* ---- expression builders for the attribute properties below ---- */

unique_ptr<SpecNode> attr_field(unique_ptr<SpecNode> obj, const char *field) {
    auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
    v->push_back(std::move(obj));
    v->push_back(std::make_unique<Symbol>(field));
    return std::make_unique<Expr>(Expr::RecordGet, std::move(v));
}

unique_ptr<SpecNode> attr_bin(Expr::binops op, unique_ptr<SpecNode> a, unique_ptr<SpecNode> b) {
    auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
    v->push_back(std::move(a));
    v->push_back(std::move(b));
    return std::make_unique<Expr>(op, std::move(v));
}

unique_ptr<SpecNode> attr_apply(const char *fn, unique_ptr<SpecNode> arg) {
    auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
    v->push_back(std::move(arg));
    return std::make_unique<Expr>(std::string(fn), std::move(v));
}

unique_ptr<SpecNode> attr_not(unique_ptr<SpecNode> a) {
    auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
    v->push_back(std::move(a));
    return std::make_unique<Expr>(Expr::NOT, std::move(v));
}

/// What the memory attributes on a declaration let us say about its effect on
/// the abstract state.
enum class AttrEffect {
    Unknown,   ///< the attributes permit an arbitrary write; say nothing
    Pure,      ///< no write at all: the output state is the input state
    ArgMem,    ///< only the object named by the one pointer argument may change
};

/// Classify [func] and, for ArgMem, report which parameter carries the pointer.
///
/// This mirrors the reasoning that used to run per callsite.  One narrowing is
/// worth keeping: argument memory the callee cannot name is argument memory it
/// cannot touch, so with no pointer parameter a permission like
/// memory(argmem: readwrite) licenses no write at all.  An integer parameter
/// holding an address does not make that unsound -- accessing it is a write to
/// "other" memory, which the remaining effects still have to allow.
AttrEffect classify_memory_attrs(const llvm::Function &func, unsigned &ptr_param) {
    auto effects = func.getMemoryEffects();

    std::vector<unsigned> ptr_params;
    for (unsigned i = 0; i < func.arg_size(); i++)
        if (func.getArg(i)->getType()->isPointerTy()) ptr_params.push_back(i);

    if (ptr_params.empty())
        effects = effects.getWithoutLoc(llvm::IRMemLocation::ArgMem);

    if (effects.onlyReadsMemory()) return AttrEffect::Pure;

    // Only the single-pointer case is handled: with several pointers the frame
    // would have to allow all of the objects they name to change at once.
    if (ptr_params.size() == 1 &&
        effects.getWithoutLoc(llvm::IRMemLocation::ArgMem).onlyReadsMemory()) {
        ptr_param = ptr_params.front();
        return AttrEffect::ArgMem;
    }

    return AttrEffect::Unknown;
}

/// `post = pre`: the callee wrote nothing.
unique_ptr<SpecNode> pure_property(const string &pre, const string &post,
                                   shared_ptr<SpecType> state_type) {
    return attr_bin(Expr::EQUAL, std::make_unique<Symbol>(post, state_type),
                    std::make_unique<Symbol>(pre, state_type));
}

/// Everything in RData except the object [ptr] names is pinned to the pre-state.
///
/// Which region that object lives in is not known statically, so the property is
/// a three-way disjunction over the same regions store_RData dispatches on: in
/// each arm the other two regions are equal to the pre-state.  Written as one
/// Rely rather than woven into the state so that the state stays a plain symbol
/// and later loads and stores are not forced to reason through an if-expression.
unique_ptr<SpecNode> argmem_property(const string &pre, const string &post,
                                     const string &ptr, shared_ptr<SpecType> state_type) {
    auto pre_st = [&]() -> unique_ptr<SpecNode> {
        return std::make_unique<Symbol>(pre, state_type);
    };
    auto post_st = [&]() -> unique_ptr<SpecNode> {
        return std::make_unique<Symbol>(post, state_type);
    };
    auto arg_ptr = [&]() -> unique_ptr<SpecNode> {
        return std::make_unique<Symbol>(ptr, Struct::Ptr);
    };
    auto same = [&](const char *field) {
        return attr_bin(Expr::EQUAL, attr_field(post_st(), field), attr_field(pre_st(), field));
    };

    // The heap arm: only the block the pointer names may differ, and an
    // argmem-only callee cannot allocate, so nextBlock is pinned too.
    auto key = [&]() { return attr_apply("spvn", attr_field(arg_ptr(), "pbase")); };
    auto blocks_of = [&](unique_ptr<SpecNode> st) {
        return attr_field(attr_field(std::move(st), "heap"), "blocks");
    };
    auto changed = std::make_unique<vector<unique_ptr<SpecNode>>>();
    changed->push_back(blocks_of(post_st()));
    changed->push_back(key());
    auto updated = std::make_unique<vector<unique_ptr<SpecNode>>>();
    updated->push_back(blocks_of(pre_st()));
    updated->push_back(key());
    updated->push_back(std::make_unique<Expr>(Expr::GET, std::move(changed)));
    auto mem = std::make_unique<vector<unique_ptr<SpecNode>>>();
    mem->push_back(std::make_unique<Expr>(Expr::SET, std::move(updated)));
    mem->push_back(attr_field(attr_field(pre_st(), "heap"), "nextBlock"));
    auto heap_framed = attr_bin(Expr::EQUAL, attr_field(post_st(), "heap"),
                                std::make_unique<Expr>(std::string("mkMEM"), std::move(mem)));

    auto heap_arm =
        attr_bin(Expr::AND,
                 attr_bin(Expr::AND, attr_not(attr_apply("is_global_ptr", arg_ptr())),
                          attr_not(attr_apply("is_stack_ptr", arg_ptr()))),
                 attr_bin(Expr::AND, std::move(heap_framed),
                          attr_bin(Expr::AND, same("stack"), same("globals"))));
    auto stack_arm = attr_bin(Expr::AND, attr_apply("is_stack_ptr", arg_ptr()),
                              attr_bin(Expr::AND, same("heap"), same("globals")));
    auto global_arm = attr_bin(Expr::AND, attr_apply("is_global_ptr", arg_ptr()),
                               attr_bin(Expr::AND, same("heap"), same("stack")));

    return attr_bin(Expr::OR, std::move(heap_arm),
                    attr_bin(Expr::OR, std::move(stack_arm), std::move(global_arm)));
}

}  // namespace

void SpoqIRModule::synthesize_attribute_specs(Project *proj) {
    for (auto &func : *proj->spoq_code.llvm_module) {
        if (!func.isDeclaration()) continue;
        if (func.isIntrinsic()) continue;

        const string name = func.getName().str();
        const string spec_name = name + "_spec";
        const string oracle_name = name + "_oracle";

        // Only a Parameter can be rewritten this way.  A user-written Definition
        // already says more than the attributes do, and a name we have already
        // rewritten must not be rewritten twice.
        auto decl_it = proj->decls.find(spec_name);
        if (decl_it == proj->decls.end()) continue;
        if (proj->defs.find(spec_name) != proj->defs.end()) continue;
        if (proj->symbols.find(oracle_name) != proj->symbols.end()) {
            LOG_WARNING << "[ATTR] " << spec_name << " has usable memory attributes but "
                        << oracle_name << " is already taken; leaving it uninterpreted.";
            continue;
        }

        unsigned ptr_param = 0;
        const AttrEffect effect = classify_memory_attrs(func, ptr_param);
        if (effect == AttrEffect::Unknown) continue;

        // The declared type is curried and flattened: the LLVM parameters
        // followed by the state.  Anything else is a spec whose shape we do not
        // understand well enough to wrap.
        auto fn_type = dynamic_pointer_cast<Function>(decl_it->second->type);
        if (!fn_type || fn_type->args->size() != func.arg_size() + 1) {
            LOG_WARNING << "[ATTR] " << spec_name << " has usable memory attributes but its "
                        << "declared type does not match the LLVM signature; skipping.";
            continue;
        }
        auto ret_option = dynamic_pointer_cast<Option>(fn_type->rettype);
        if (!ret_option) {
            LOG_WARNING << "[ATTR] " << spec_name << " does not return an option; skipping.";
            continue;
        }
        auto state_type = fn_type->args->back();
        // `option (T * RData)` for a value-returning spec, `option RData` for void.
        auto ret_tuple = dynamic_pointer_cast<Tuple>(ret_option->elem_type);
        const bool returns_value = ret_tuple != nullptr && ret_tuple->types->size() == 2;

        const string pre_state = "st";
        const string post_state = "st_callee";
        const string ret_value = "ret_value";

        // Formal parameters.  The pointer the frame talks about has to be
        // nameable, so every parameter gets a name here rather than relying on
        // whatever the .ll happened to carry.
        auto args = std::make_unique<vector<shared_ptr<Arg>>>();
        std::vector<string> arg_names;
        for (unsigned i = 0; i < func.arg_size(); i++) {
            arg_names.push_back("v_" + std::to_string(i));
            args->push_back(make_shared<Arg>(arg_names.back(), (*fn_type->args)[i]));
        }
        args->push_back(make_shared<Arg>(pre_state, state_type));

        // The oracle call: the same arguments, forwarded unchanged.
        auto call_args = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for (unsigned i = 0; i < func.arg_size(); i++)
            call_args->push_back(std::make_unique<Symbol>(arg_names[i], (*fn_type->args)[i]));
        call_args->push_back(std::make_unique<Symbol>(pre_state, state_type));
        auto oracle_call = std::make_unique<Expr>(oracle_name, std::move(call_args));

        // What the oracle's result is destructured into, and what we hand back.
        auto result = [&]() -> unique_ptr<SpecNode> {
            if (!returns_value) return std::make_unique<Symbol>(post_state, state_type);
            auto v = std::make_unique<vector<unique_ptr<SpecNode>>>();
            v->push_back(std::make_unique<Symbol>(ret_value, (*ret_tuple->types)[0]));
            v->push_back(std::make_unique<Symbol>(post_state, state_type));
            return Shortcut::_Tuple_u(std::move(v));
        };

        // The frame talks about the pointer's pbase, so the *declared* type of
        // that parameter has to actually be Ptr.  A spec that models the pointer
        // as an integer would give an ill-typed property, so fall back to saying
        // nothing rather than emitting Coq that will not typecheck.
        if (effect == AttrEffect::ArgMem &&
            (*fn_type->args)[ptr_param] != static_pointer_cast<SpecType>(Struct::Ptr)) {
            LOG_WARNING << "[ATTR] " << spec_name << " is argmem-only but parameter "
                        << ptr_param << " is declared as "
                        << (*fn_type->args)[ptr_param]->name
                        << " rather than Ptr; leaving it uninterpreted.";
            continue;
        }

        auto property = effect == AttrEffect::Pure
                            ? pure_property(pre_state, post_state, state_type)
                            : argmem_property(pre_state, post_state, arg_names[ptr_param],
                                              state_type);

        // rely (<attribute>); Some <result> -- the Rely is the top of the body
        // proper, so unfolding f_spec at any callsite brings the attribute with
        // it exactly once.
        auto body = Shortcut::_When_u(
            result(), std::move(oracle_call),
            std::make_unique<Rely>(std::move(property), Shortcut::_Some_u(result())));

        // Demote the Parameter to the oracle it now is, and define the wrapper in
        // its place.  Callers keep referring to f_spec and see the wrapper.
        auto loc = make_shared<loc_t>(proj->symbols[spec_name].loc);
        auto oracle = make_unique<Declaration>(oracle_name, decl_it->second->type);
        proj->decls.erase(decl_it);
        proj->symbols.erase(spec_name);
        proj->add_declaration(std::move(oracle), loc);
        proj->add_definition(
            make_unique<Definition>(spec_name, fn_type->rettype, std::move(args), std::move(body)),
            loc);

        LOG_INFO << "[ATTR] " << name << ": "
                 << (effect == AttrEffect::Pure ? "state-preserving" : "argmem-framed")
                 << " by attribute; " << spec_name << " defined over " << oracle_name << ".";
    }
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


/**
 * @brief Recover the struct a pointer argument points at, or nullptr if it isn't one.
 *
 * Opaque pointers dropped the pointee from the pointer type itself, so fall back on
 * what the IR still records: an explicit byval/sret type, or the element type of a
 * GEP that walks the argument.  A pointer we cannot resolve is simply treated as not
 * pointing at a struct, which drops an alignment assumption but never adds one.
 */
static llvm::Type *pointee_struct_type(llvm::Argument &arg) {
    for (auto *ty : {arg.getParamByValType(), arg.getParamStructRetType()})
        if (ty && ty->isStructTy())
            return ty;

    for (auto *user : arg.users()) {
        auto *gep = llvm::dyn_cast<llvm::GEPOperator>(user);
        if (!gep || gep->getPointerOperand() != &arg)
            continue;
        if (gep->getSourceElementType()->isStructTy())
            return gep->getSourceElementType();
    }

    return nullptr;
}

bool SpoqIRModule::code_to_spec(Project *proj, string fname, int layer_id,
                                   std::vector<std::string> &low_specs,
                                   std::unordered_map<string, string> &name_map) {
    if (proj == nullptr) return false;
    if (!SpoqIRModule::validate_for_gen_low_spec(proj, fname, layer_id)) return false;
    if (OPTS.dry_run_asm) return false;

    SpoqFunction& spoq_func = proj->spoq_code.spoq_funcs.at(fname);
    SpoqIRContext context(spoq_func, proj->layers[layer_id], layer_id, proj->abs_config, proj->abs_layout);

    unique_ptr<SpecNode> spec;
    if (!spoq_func.stub) {
        spec = proj->spoq_code.spoq_inst_to_spec(proj, spoq_func.spoq_insts, 0, context);
    } else {
        LOG_WARNING << "Function " << spoq_func.llvm_func->getName().str() << " is a stub returning None.";
        spec = std::make_unique<Symbol>("None");
    }

    if(proj->cmds.InitRely.find(fname) != proj->cmds.InitRely.end()) {
        for(auto & f : proj->cmds.InitRely[fname])
            spec = std::make_unique<Rely>(f->deep_copy(), std::move(spec));
    }

    unique_ptr<vector<shared_ptr<Arg>>> args = std::make_unique<vector<shared_ptr<Arg>>>();
    for(auto &arg : spoq_func.llvm_func->args()) {
        auto sym = context.get_llvm_value_spec(&arg, nullptr, false);
        auto symbol = dynamic_cast<Symbol*>(sym.get());
        assert(symbol && "arg is not a symbol without abstraction");

        if(arg.getType()->isPointerTy()){
            // We make an assumption about LLVM IR.
            // IR compiled from C code will never pass a pointer to a struct as a parameter
            // that does not point at the beginning of the struct or 1 past the end of the struct
            auto pointee_ty = pointee_struct_type(arg);
            if(pointee_ty){
                std::unique_ptr<SpecNode> mod_expr = sym->deep_copy();
                auto record_get_elems = make_unique<std::vector<unique_ptr<SpecNode>>>();
                record_get_elems->push_back(std::move(mod_expr));
                record_get_elems->push_back(make_unique<Symbol>("poffset"));
                mod_expr = make_unique<Expr>(Expr::RecordGet, std::move(record_get_elems));
                auto mod_elems = make_unique<std::vector<unique_ptr<SpecNode>>>();
                mod_elems->push_back(std::move(mod_expr));
                // calculate total aggregate size
                auto aggregate_size = context.llvm_dl->getTypeAllocSize(pointee_ty);
                mod_elems->push_back(make_unique<IntConst>(aggregate_size));
                mod_expr = make_unique<Expr>(Expr::binops::MOD, std::move(mod_elems));
                auto rely_prop_elems = make_unique<std::vector<unique_ptr<SpecNode>>>();
                rely_prop_elems->push_back(std::move(mod_expr));
                rely_prop_elems->push_back(make_unique<IntConst>(0));
                auto rely_prop = make_unique<Expr>(Expr::binops::EQUAL, std::move(rely_prop_elems));
                spec = make_unique<Rely>(std::move(rely_prop), std::move(spec));

            }

        }
        args->push_back(std::make_shared<Arg> (symbol->text, symbol->type));
    }
    args->push_back(make_shared<Arg>(context.abs_data_name, context.abs_data_type));

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
    // LLVM 15's SROA only speculated phis/selects and never touched the CFG,
    // which is what the loop/CFG reconstruction below is written against.
    // PreserveCFG keeps that behaviour; the default (ModifyCFG) would let SROA
    // unfold selects into new blocks and change the loop shapes we translate.
    MPM.addPass(llvm::createModuleToFunctionPassAdaptor(
        llvm::SROAPass(llvm::SROAOptions::PreserveCFG)));
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
