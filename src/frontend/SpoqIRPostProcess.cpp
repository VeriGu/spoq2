#include <llvm.h>
#include <irtypes.h>
#include <coq.h>
#include <irvalues.h>
#include <instructions.h>
#include <values.h>
#include <inline_asm.h>
#include <SpoqIRModule.h>
#include <regex>

#include "llvm/IR/InlineAsm.h"

using namespace std::string_literals;

namespace autov {

int SpoqIRModule::find_inline_asm(spoq_inst_vec_t &insts) {
    int failed = 0;

    for (const auto &in : insts) {
        if (!in->is_spoq_control()) {
            auto llvm_inst = in->get_llvm_inst();
            llvm::CallInst *call = llvm::dyn_cast<llvm::CallInst>(llvm_inst);
            if (!call || !call->isInlineAsm())
                continue;
            auto asm_func = llvm::dyn_cast_or_null<llvm::InlineAsm>(
                call->getCalledOperand());
            assert(asm_func && "Inline asm function is nullptr");
            string iasm_prefix = "";
            string asm_text = asm_func->getAsmString();
            if (asm_text.find("smc") != string::npos)
                iasm_prefix = "smc_";
            auto norm_asm_id = std::regex_replace(asm_text, std::regex("[^a-zA-Z0-9]"), "_");
            string fname = "iasm_" + iasm_prefix + norm_asm_id;
            if (this->iasm_defs.find(fname) != this->iasm_defs.end()) {
                this->iasm2func[call] = fname;
                continue;
            }

            string old_name = fname;
            string constraints = asm_func->getConstraintString();
            auto rettype = call->getType();

            vector<llvm::Type *> arg_types;
            for (int i = 0; i < call->arg_size(); i++) {
                arg_types.push_back(call->getArgOperand(i)->getType());
            }

            SpoqIRIASM asm_inst;
            try {
                asm_inst = parse_inline_asm(fname, asm_text, rettype, arg_types,
                                            constraints);
                iasm_count += 1;
            } catch (const std::exception &e) {
                failed += 1;
                std::cout << e.what() << std::endl;

                vector<string> ts;
                ts = split(asm_text, '\n');
                if (ts.size() <= 2 && ts[0] == "smc\t#0") {
                    string smc_fname = "iasm_smc" + std::to_string(arg_types.size());
                    this->iasm2func[call] = smc_fname;
                } else {
                    this->iasm2func[call] = fname;
                }

                iasm_count += 1;
                continue;
            }

            string objd, asm_key;
            if (!asm_inst.objdump.empty()) {
                objd = asm_inst.objdump.substr(asm_inst.objdump.find('\n') + 1);
                asm_key = objd;
                if (iasm_objd_cache.find(asm_key) != iasm_objd_cache.end()) {
                    this->iasm2func[call] = iasm_objd_cache[asm_key];
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
                    } else if (inst[0] == "msr" &&
                               inst[1].find(", x0") == inst[1].size() - 4) {
                        string reg = inst[1].substr(0, inst[1].size() - 4);
                        fname = "iasm_set_" + reg;
                    } else {
                        fname = "iasm_" + std::to_string(iasm_count) + "_" +
                                inst[0];
                    }
                }
                string coq = replace(asm_inst.coq, old_name, fname);
                this->iasm_defs[fname] = std::make_shared<SpoqAsmProcedure>(
                    fname, asm_inst.iasm, objd, coq);
                this->iasm_objd_cache[objd] = fname;
                this->iasm2func[call] = fname;
            } else {
                if (!asm_inst.objdump.empty()) {
                    this->iasm_defs[fname] = std::make_shared<SpoqAsmProcedure>(
                        fname, asm_inst.iasm, objd, "");
                    this->iasm_objd_cache[objd] = fname;
                    this->iasm2func[call] = fname;
                } else {
                    this->iasm_defs[fname] = std::make_shared<SpoqAsmProcedure>(
                        fname, asm_inst.iasm, "", "");
                    this->iasm_objd_cache[objd] = fname;
                    this->iasm2func[call] = fname;
                }
            }

        } else if (auto if_inst = dynamic_cast<SpoqIfInst *>(in.get())) {
            failed += find_inline_asm(if_inst->true_body);
            failed += find_inline_asm(if_inst->false_body);
        } else {
            assert(false && "inline asm does not support loop for now");
            // failed += find_inline_asm(*loop_inst->body);
        }
    }

    return failed;
}

std::pair<int, int> SpoqIRModule::extract_inline_asm(SpoqFunction& func) {
    int failed_count = 0;
    if(!func.spoq_insts_converted) assert(false && "spoq_insts not converted");
    int failed = find_inline_asm(func.spoq_insts);
    if (failed > 0) {
        std::cout << "[ERROR] Failed to process " << failed << " inline asm in function " << func.llvm_func->getName().str() << std::endl;
        failed_count += failed;
    }
    auto result = std::pair<int, int>(iasm_defs.size(), failed_count);
    std::cout << result.first << " inline assembly found, " << result.second << " failed to process." << std::endl;
    return result;
}

} // namespace autov::IRLoader