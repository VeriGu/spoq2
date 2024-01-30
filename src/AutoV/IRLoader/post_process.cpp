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

    auto synthesize_coq_def = [](const string& fname, shared_ptr<IRType> rettype, vector<shared_ptr<FuncArg>> &args) {
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

                    vector<shared_ptr<FuncArg>> args;
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