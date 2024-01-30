#include <llvm.h>
#include <irtypes.h>
#include <coq.h>
#include <irvalues.h>
#include <instructions.h>
#include <values.h>
#include <inline_asm.h>

using namespace std::string_literals;

namespace autov::IRLoader {

std::pair<int, int> extract_inline_asm(shared_ptr<IRModule> mod) {
    struct InlineAsm {
        string fname;
        shared_ptr<AsmProcedure> func;
    };

    unordered_map<string, InlineAsm> inline_asms;
    int iasm_count = 0;

    auto synthesize_coq_def = [](const string& fname, shared_ptr<IRType> rettype, vector<unique_ptr<FuncArg>> &args) {
        return ""s;

        // if isinstance(rettype, TVoid):
        //         coq_ret = "option RData"
        // else:
        //         coq_ret = f"option ({ir_type_to_spec(fname, rettype)} * RData)"

        // if isinstance(rettype, TStruct):
        //         st_str = f"Record st_{fname} := mkst_{fname} " + "{" + "}.\n"
        // else:
        //         st_str = ""
        // return st_str + "Definition " + fname + "_spec " + \
        //         " ".join([f"(arg{i}: {ir_type_to_spec(fname, arg.typ)})" for i, arg in enumerate(args)]) + \
        //         " (st: RData) : " + coq_ret + " := None.\n"
    };

    std::function<int(vector<unique_ptr<IRInst>>&)> find_inline_asm;
    find_inline_asm = [&](vector<unique_ptr<IRInst>>& insts) {
        int failed = 0;

        for (const auto& i : insts) {
            if (dynamic_cast<ICall*>(i.get())) {
                auto call_inst = dynamic_cast<ICall*>(i.get());
                string iasm_prefix;

                if (dynamic_cast<VInlineAsm*>(call_inst->func.get())) {
                    auto asm_func = dynamic_cast<VInlineAsm*>(call_inst->func.get());
                    string asm_text = asm_func->asm_string;

                    if (asm_text.find("smc") != string::npos) {
                        iasm_prefix = "smc_";
                    } else {
                        iasm_prefix = "";
                    }

                    string fname = "iasm_" + iasm_prefix + std::to_string(iasm_count);
                    string old_name = fname;
                    string constraints = asm_func->constraints;
                    shared_ptr<IRType> rettype = call_inst->typ;

                    vector<unique_ptr<FuncArg>> args;
                    shared_ptr<TPtr> func_type = dynamic_pointer_cast<TPtr>(call_inst->func->type);
                    if (func_type == nullptr) {
                        throw std::runtime_error("Unsupported type: " + call_inst->func->type->to_coq());
                    }
                    shared_ptr<TFunction> func_subtype = dynamic_pointer_cast<TFunction>(func_type->subtype);
                    if (func_subtype == nullptr) {
                        throw std::runtime_error("Unsupported subtype: " + func_type->subtype->to_coq());
                    }
                    const auto &arglist = func_subtype->arglist;
                    for (int i = 0; i < arglist->size(); i++) {
                        args.push_back(make_unique<FuncArg>("_" + std::to_string(i), arglist->at(i)));
                    }

                    IASM asm_inst;
                    try {
                        asm_inst = parse_inline_asm(fname, asm_text, rettype, args, constraints);
                    } catch (const std::exception& e) {
                        failed += 1;
                        std::cout << e.what() << std::endl;

                        vector<string> ts;
                        ts = split(asm_text, '\n');
                        if (ts.size() <= 2 && ts[0] == "smc\t#0") {
                            string smc_fname = "iasm_smc" + std::to_string(arglist->size());
                            call_inst->func = make_unique<VGlobal>(call_inst->typ, smc_fname);
                            string coq_def = synthesize_coq_def(smc_fname, rettype, args);
                            std::cout << coq_def;
                        } else {
                            call_inst->func = make_unique<VGlobal>(call_inst->typ, fname);
                            string coq_def = synthesize_coq_def(fname, rettype, args);
                            std::cout << coq_def;
                        }

                        iasm_count += 1;
                        continue;
                    }

                    string objd, asm_key;
                    if (!asm_inst.objdump.empty()) {
                        objd = asm_inst.objdump.substr(asm_inst.objdump.find('\n') + 1);
                        asm_key = objd;
                        if (inline_asms.find(asm_key) != inline_asms.end()) {
                            call_inst->func = make_unique<VGlobal>(call_inst->typ, inline_asms[asm_key].fname);
                            string coq_def = synthesize_coq_def(inline_asms[asm_key].fname, rettype, args);
                            std::cout << coq_def;
                            continue;
                        }
                    }
                    if (!asm_inst.coq.empty()) {
                        vector<string> lines = split(objd, '\n');
                        if (lines.size() == 2 && strip(lines[1]) == "ret") {
                            // single line function
                            vector<string> inst = split(strip(lines[0]), '\t');
                            if (inst[0] == "mrs" && inst[1].find("x0, ") == 0) {
                                string reg = inst[1].substr(4);
                                fname = "iasm_get_" + reg;
                            } else if (inst[0] == "msr" && inst[1].find(", x0") == inst[1].size() - 4) {
                                string reg = inst[1].substr(0, inst[1].size() - 4);
                                fname = "iasm_set_" + reg;
                            } else {
                                fname = "iasm_" + std::to_string(iasm_count) + "_" + inst[0];
                                iasm_count += 1;
                            }
                        } else {
                            iasm_count += 1;
                        }
                        string coq = replace(asm_inst.coq, old_name, fname);
                        mod->asm_procs->insert({fname, make_shared<AsmProcedure>(fname, asm_inst.iasm, objd, coq)});
                        asm_key = objd;
                        inline_asms[asm_key] = {fname, mod->asm_procs->at(fname)};
                        std::cout << asm_key << " // " << fname << " // " << inline_asms[asm_key].func->body << std::endl;
                        call_inst->func = make_unique<VGlobal>(call_inst->typ, inline_asms[asm_key].fname);
                        string coq_def = synthesize_coq_def(inline_asms[asm_key].fname, rettype, args);
                        std::cout << coq_def;
                    } else {
                        if (!asm_inst.objdump.empty()) {
                            mod->asm_procs->insert({fname, make_shared<AsmProcedure>(fname, asm_inst.iasm, objd, "")});
                            asm_key = objd;
                            inline_asms[asm_key] = {fname, mod->asm_procs->at(fname)};
                            std::cout << asm_key << " // " << fname << " // " << inline_asms[asm_key].func->body << std::endl;
                            call_inst->func = make_unique<VGlobal>(call_inst->typ, inline_asms[asm_key].fname);
                            string coq_def = synthesize_coq_def(inline_asms[asm_key].fname, rettype, args);
                            std::cout << coq_def;
                            iasm_count += 1;
                        } else {
                            mod->asm_procs->insert({fname, make_shared<AsmProcedure>(fname, asm_inst.iasm, "", "")});
                            call_inst->func = make_unique<VGlobal>(call_inst->typ, fname);
                            string coq_def = synthesize_coq_def(fname, rettype, args);
                            std::cout << coq_def;
                            iasm_count += 1;
                        }
                    }
                }
            } else if (dynamic_cast<IIf*>(i.get())) {
                auto if_inst = dynamic_cast<IIf*>(i.get());

                failed += find_inline_asm(*if_inst->true_body);
                failed += find_inline_asm(*if_inst->false_body);
            } else if (dynamic_cast<ILoop*>(i.get())) {
                auto loop_inst = dynamic_cast<ILoop*>(i.get());

                failed += find_inline_asm(*loop_inst->body);
            }
        }

        return failed;
    };

    int failed_count = 0;
    vector<string> funcs;
    for (const auto& func : *(mod->functions)) {
        funcs.push_back(func.first);
    }
    std::sort(funcs.begin(), funcs.end());
    for (const auto& f : funcs) {
        shared_ptr<CFunction> func = mod->functions->at(f);

        if (func->body == nullptr) {
            continue;
        }

        int failed = find_inline_asm(*func->body);
        if (failed > 0) {
            std::cout << "[ERROR] Failed to process " << failed << " inline asm in function " << f << std::endl;
            failed_count += failed;
        }
    }

    return std::pair<int, int>(inline_asms.size(), failed_count);
}

shared_ptr<IRModule> post_process(shared_ptr<IRModule> mod) {
    std::pair<int, int> result = extract_inline_asm(mod);
    std::cout << result.first << " inline assembly found, " << result.second << " failed to process." << std::endl;
    return mod;
}

} // namespace autov::IRLoader