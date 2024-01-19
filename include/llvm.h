#pragma once

#include <string>
#include <vector>
#include <map>
#include <unordered_map>
#include <algorithm>
#include <irtypes.h>
#include <coq.h>
#include <instructions.h>
#include <irvalues.h>

namespace autov::IRLoader {
class FuncArg {
public:
    string name;
    shared_ptr<IRType> type;

    FuncArg() = delete;
    FuncArg(string name, shared_ptr<IRType> type) : name(to_coq_name(name)), type(type) {}

    string to_coq() const {
        return "(" + name + ", " + type->to_coq() + ")";
    }
};

class GlobalVar {
public:
    string vname;
    shared_ptr<IRType> vtype;
    bool vconst;
    unique_ptr<IRValue> vinitializer;
    int valign;

    GlobalVar() = delete;
    GlobalVar(string vname, shared_ptr<IRType> vtype, bool vconst, unique_ptr<IRValue> vinitializer, int valign) :
        vname(vname), vtype(vtype), vconst(vconst), vinitializer(std::move(vinitializer)), valign(valign) {}

    string to_coq() const {
        string vinitializer_str;

        if (vinitializer != nullptr)
            vinitializer_str = "(Some " + vinitializer->to_coq() + ")";
        else
            vinitializer_str = "None";

        return "{| vname := \"" + vname + "\";\n" \
               "   vtype := " + vtype->to_coq() + ";\n" \
               "   vconst := " + (vconst ? "true" : "false") + ";\n" \
               "   vinitializer := " + vinitializer_str + ";\n" \
               "   valign := " + std::to_string(valign) + " |}";
    }
};

class IRFunction {
public:
    string fname;
    shared_ptr<IRType> rettype;
    unique_ptr<vector<unique_ptr<FuncArg>>> args;
    bool is_decl;
    string entry;
    using ir_blocks_t = unordered_map<string, unique_ptr<vector<unique_ptr<IRInst>>>>;
    unique_ptr<ir_blocks_t> blocks;

    IRFunction() = delete;
    IRFunction(string fname, shared_ptr<IRType> rettype, unique_ptr<vector<unique_ptr<FuncArg>>> args, bool is_decl,
               string entry = "", unique_ptr<ir_blocks_t> blocks = nullptr) :
        fname(fname), rettype(rettype), args(std::move(args)), is_decl(is_decl), entry(entry), blocks(std::move(blocks)) {}
};

class CFunction {
public:
    string fname;
    shared_ptr<IRType> rettype;
    unique_ptr<vector<unique_ptr<FuncArg>>> args;
    bool is_decl;
    unique_ptr<vector<unique_ptr<IRInst>>> body;
    std::set<string> alloca_vars;

    CFunction() = delete;
    CFunction(string fname, shared_ptr<IRType> rettype, unique_ptr<vector<unique_ptr<FuncArg>>> args, bool is_decl,
              unique_ptr<vector<unique_ptr<IRInst>>> body = nullptr) :
        fname(fname), rettype(rettype), args(std::move(args)), is_decl(is_decl) {
            collect_alloca_vars(body.get());
            this->body = filter_icall(std::move(body));
    }

    string to_coq() const {
        string body_str;

        if (body != nullptr)
            body_str = "\n" + add_indent("(Some \n" + add_indent(to_coq_code_block(body.get()), 4) + ")", 4);
        else
            body_str = "None";

        return "{| fname := \"" + fname + "\";\n" \
               "   rettype := " + rettype->to_coq() + ";\n" \
               "   fargs :=\n" +\
                    add_indent(to_coq_code_block(args.get()), 4) + ";\n" \
               "   alloca_vars := " + to_list(alloca_vars) + ";\n" \
               "   body := " + body_str + "|}";
    }

private:
    void collect_alloca_vars(vector<unique_ptr<IRInst>> *insts) {
        if (insts == nullptr)
            return;

        for (const auto &i : *insts) {
            if (dynamic_cast<IAlloc*>(i.get())) {
                alloca_vars.insert(dynamic_cast<IAlloc*>(i.get())->assign);
            } else if (dynamic_cast<IIf*>(i.get())) {
                auto if_inst = dynamic_cast<IIf*>(i.get());

                collect_alloca_vars(if_inst->true_body.get());
                collect_alloca_vars(if_inst->false_body.get());
            } else if (dynamic_cast<ILoop*>(i.get())) {
                auto loop_inst = dynamic_cast<ILoop*>(i.get());

                collect_alloca_vars(loop_inst->body.get());
            }
        }
    }
    unique_ptr<vector<unique_ptr<IRInst>>> filter_icall(unique_ptr<vector<unique_ptr<IRInst>>> body) {
        static std::vector<std::function<bool(std::string)>> debug_prims = {
            [](std::string p) {
                static std::vector<std::string> valid_strings = {
                    "printhex_ul",
                    "print_string",
                    "printf",
                    "printf_",
                    "printk",
                    "printhex_ul_dbg",
                    "print_string_dbg",
                    "__debug_save_state",
                    "__debug_restore_state",
                };

                return std::find(valid_strings.begin(), valid_strings.end(), p) != valid_strings.end();
            },
            [](std::string p) { return p.find("llvm_dbg") == 0; },
            [](std::string p) { return p.find("llvm_lifetime") == 0; },
        };

        unique_ptr<vector<unique_ptr<IRInst>>> after_filter;

        if (body == nullptr)
            return nullptr;

        after_filter = std::make_unique<vector<unique_ptr<IRInst>>>();
        for (auto &i : *body) {
            if (dynamic_cast<ICall*>(i.get())) {
                auto call_inst = dynamic_cast<ICall*>(i.get());

                if (call_inst &&
                    (!dynamic_cast<VGlobal*>(call_inst->func.get()) ||
                    !std::any_of(debug_prims.begin(), debug_prims.end(),
                                [&](const auto& f) {
                    auto func_name = dynamic_cast<_VSymbol*>(call_inst->func.get())->name;
                    return f(func_name);
                }))) {
                    after_filter->push_back(std::move(i));
                }
            } else if (dynamic_cast<IIf*>(i.get())) {
                auto orig_if = dynamic_cast<IIf*>(i.get());
                auto filtered_then = filter_icall(std::move(orig_if->true_body));
                auto filtered_else = filter_icall(std::move(orig_if->false_body));
                auto filtered_if = make_unique<IIf>(std::move(orig_if->cond), std::move(filtered_then), std::move(filtered_else));

                after_filter->push_back(std::move(filtered_if));
                i.reset();
            } else if (dynamic_cast<ILoop*>(i.get())) {
                auto orig_loop = dynamic_cast<ILoop*>(i.get());
                auto filtered_body = filter_icall(std::move(orig_loop->body));

                after_filter->push_back(std::make_unique<ILoop>(std::move(filtered_body), orig_loop->lineno));
                i.reset();
            } else {
                after_filter->push_back(std::move(i));
            }
        }

        return after_filter;
    }
};

class AsmProcedure {
public:
    string name;
    string origin;
    string objdump;
    string body;

    AsmProcedure() = delete;
    AsmProcedure(string name, string origin, string objdump, string body) :
        name(name), origin(origin), objdump(objdump), body(body) {}

    string to_coq() const {
        return body;
    }
};

class IRModule {
public:
    shared_ptr<unordered_map<string, shared_ptr<TStruct>>> structs;
    shared_ptr<unordered_map<string, shared_ptr<GlobalVar>>> globalvars;
    shared_ptr<unordered_map<string, shared_ptr<CFunction>>> functions; // Is IRFunction also going here?
    shared_ptr<unordered_map<string, shared_ptr<AsmProcedure>>> asm_procs;
    // TODO: debug info
};

}; // namespace autov::IRLoader