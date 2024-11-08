#include <boost/filesystem.hpp>
#include <filesystem>
#include <gen_low_proof.h>
#include <regex>

namespace fs = std::filesystem;

namespace autov
{
void gen_low_proof_func(Project *p, int i, string fname, string path)
{
    auto layer = p->layers[i]->name;
    auto base_layer = p->layers[i - 1]->name;
    auto func = (*p->code->functions)[fname];
    auto loc = loc_t(layer, fname, "LowSpec");

    vector<string> syms;
    for (auto const &[s, v] : p->symbols) {
        if (v.loc == loc) {
            syms.push_back(s);
        }
    }

    // Require Import
    std::set<string> deps = {"CommonDeps",         "Code", "DataTypes",
                             "GlobalDefs",         "Zwf",  layer + "." + fname + "." + "LowSpec",
                             base_layer + ".Layer"};
    if (std::get<0>(loc) != "GlobalDefs") {
        deps.insert("GlobalDefs");
    }

    std::set<string> dep_defs;
    for (auto s : syms) {
        if (p->deps.find(s) == p->deps.end()) continue;
        for (auto d : p->deps[s]) {
            if (p->symbols[d].loc == loc_t("", "", "")) continue;
            dep_defs.insert(d);
            string l = "";
            l += (std::get<0>(p->symbols[d].loc));
            if (std::get<1>(p->symbols[d].loc) != "") {
                l += ("." + std::get<1>(p->symbols[d].loc));
            }

            if (std::get<2>(p->symbols[d].loc) != "") {
                l += ("." + std::get<2>(p->symbols[d].loc));
            }

            deps.insert(l);
        }
    }

    std::ofstream out(path);
    for (auto d : deps) {
        out << "Require Import " + d + ".\n";
    }
    out << "\n";

    // Open Scope
    out << "Local Open Scope string_scope.\n";
    out << "Local Open Scope Z_scope.\n";
    out << "Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit "
           "Z.clearbit xorb List.nth.\n";
    out << "\n";

    out << "Section " + layer + "_" + fname + "_CodeProof.\n";
    out << "\n";
    out << "  Context `{int_ptr: IntPtrCast}.\n";
    out << "\n";

    for (auto d : dep_defs) {
        // probaly need to escape fname
        string lit = R"(^)" + fname + R"(.*?_(loop\d+_rank|loop\d+_low|funptr_wrap\d+)$)";
        std::regex pattern(lit);
        if (std::regex_match(d, pattern)) {
            out << "  Hint Unfold " + d + ":spec.\n";
            continue;
        }
        out << "  Local Opaque " + d + ".\n";
    }

    vector<string> vars;
    vector<string> call_param;
    string call_ret;
    vector<string> code_param;
    string code_ret;

    for (auto const &arg : *func->args) {
        auto aname = IRLoader::to_coq_name(arg->name);
        vars.push_back(aname);
        call_param.push_back(aname);
        if (dynamic_cast<TInt *>(arg->type.get())) {
            code_param.push_back("VInt " + aname);
        } else if (dynamic_cast<TBool *>(arg->type.get())) {
            code_param.push_back("VBool " + aname);
        } else if (dynamic_cast<TPtr *>(arg->type.get())) {
            code_param.push_back("VPtr " + aname);
        }
    }

    vars.push_back("st");
    vars.push_back("st'");
    call_param.push_back("st");

    if (dynamic_cast<TVoid *>(func->rettype.get())) {
        call_ret = "Some st'";
        code_ret = "None";
    } else if (dynamic_cast<TInt *>(func->rettype.get())) {
        vars.push_back("res");
        call_ret = "Some (res, st')";
        code_ret = "(Some (VInt res))";
    } else if (dynamic_cast<TBool *>(func->rettype.get())) {
        vars.push_back("res");
        call_ret = "Some (res, st')";
        code_ret = "(Some (VBool res))";
    } else if (dynamic_cast<TPtr *>(func->rettype.get())) {
        vars.push_back("res");
        call_ret = "Some (res, st')";
        code_ret = "(Some (VPtr res))";
    }

    out << "    Lemma f_" + fname + "_correct:\n";
    out << "      forall " + join(vars, " ") + "\n";
    out << "             (Hspec: " + fname + "_spec_low " + join(call_param, " ") + " = " + call_ret + "),\n";
    out << "        exec_func " + base_layer + "_layer code \"" + fname + "\"\n";
    out << "                  [" + join(code_param, "; ") + "]\n";
    out << "                  st st' " + code_ret + ".\n";

    if (syms.size() == 1) {
        out << "    Proof.\n";
        out << "        intros; simpl_func Hspec; simpl in *;\n";
        out << "          unshelve (eapply exec_func_call);\n";
        out << "         (lia ||\n";
        out << "          match goal with\n";
        out << "          | [ |- temp_env ] => shelve\n";
        out << "          | [ |- function ] => shelve\n";
        out << "          | [ |- function_body ] => shelve\n";
        out << "          | [ |- State _ ] => shelve\n";
        out << "          | _ => idtac\n";
        out << "          end);\n";
        out << "         unshelve (try reflexivity; try solve [repeat vcgen | (frewrite; repeat vcgen)]);\n";
        out << "         (lia ||\n";
        out << "          match goal with\n";
        out << "          | [ |- temp_env ] => shelve\n";
        out << "          | _ => idtac\n";
        out << "          end).\n";
        // out << "       unshelve (intros; simpl_func Hspec; simpl in *;\n")
        // out << "         eapply exec_func_call; try reflexivity; try solve [repeat vcgen]); try lia.\n")
        out << "    Qed.\n\n";
    } else {
        // gen_loop_proof(proj, base_layer, fname, out)
        out << "Admitted.\n\n";
    }
    out << "End " + layer + "_" + fname + "_CodeProof.\n\n";

    out.close();
}

void gen_low_proof_proc(Project *p, int i, string fname, string path)
{
    auto layer = p->layers[i]->name;
    auto base_layer = p->layers[i - 1]->name;
    auto proc = (*p->code->asm_procs)[fname];
    auto loc = loc_t(layer, fname, "LowSpec");

    vector<string> syms;
    for (auto const &[s, v] : p->symbols) {
        if (v.loc == loc) {
            syms.push_back(s);
        }
    }

    std::ofstream out(path);

    // Require Import
    std::set<string> deps = {
        "CommonDeps", "Code", "DataTypes", "GlobalDefs", layer + "." + fname + "." + "LowSpec", base_layer + ".Layer"};
    if (std::get<0>(loc) != "GlobalDefs") {
        deps.insert("GlobalDefs");
    }

    std::set<string> dep_defs;
    for (auto s : syms) {
        if (p->deps.find(s) != p->deps.end()) continue;
        for (auto d : p->deps[s]) {
            dep_defs.insert(d);
            if (p->symbols[d].loc == loc_t("", "", "")) continue;
            deps.insert(std::get<0>(p->symbols[d].loc));
            if (std::get<1>(p->symbols[d].loc) != "") {
                deps.insert("." + std::get<1>(p->symbols[d].loc));
            }

            if (std::get<2>(p->symbols[d].loc) != "") {
                deps.insert("." + std::get<2>(p->symbols[d].loc));
            }
        }
    }

    for (auto d : deps) {
        out << "Require Import " + d + ".\n";
    }
    out << "\n";

    // Open Scope
    out << "Local Open Scope string_scope.\n";
    out << "Local Open Scope Z_scope.\n";
    out << "Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit "
           "Z.clearbit.\n";
    out << "\n";

    out << "Section " + layer + "_" + fname + "_CodeProof.\n";
    out << "\n";
    out << "  Context `{int_ptr: IntPtrCast}.\n";
    out << "\n";

    // code proof
    auto const &spec = p->defs[p->name + "spec_low"];
    vector<string> vars;
    vector<string> call_param;
    string call_ret;
    string Hprep;
    string Hret;
    string st_init;
    string st_final;

    if (spec->args->size() == 2) {
        vars.push_back("st0");
        vars.push_back(spec->args->at(0)->name);
        call_param.push_back(spec->args->at(0)->name);
        call_param.push_back("st");
        Hprep = "(Harg: " + base_layer + "_layer.(SetReg) (Rx0 SZ32) " + spec->args->at(0)->name + " st0 = Some st)";
        st_init = "st";
    } else {
        call_param.push_back("st");
        st_init = "st";
    }

    vars.push_back("st");
    vars.push_back("st'");

    if (spec->rettype->name.find("Option_Tuple") != string::npos) {
        vars.push_back("res");
        vars.push_back("st''");
        call_ret = "Some (ret, st')";
        Hret = "(Hret: " + base_layer + "_layer.(SetReg) (Rx0 SZ32) res st' = Some st'')";
        st_final = "st''";
    } else {
        call_ret = "Some st'";
        st_final = "st'";
    }

    out << "    Lemma f_" + fname + "_correct:\n";
    out << "      forall " + join(vars, " ") + "\n";
    if (Hprep != "") out << "             " + Hprep + "\n";

    out << "             (Hspec: " + fname + "_spec_low " + join(call_param, " ") + " = " + call_ret + ")";
    if (Hret != "") out << "\n             " + Hret;
    out << ",\n";
    out << "         exec_proc " + base_layer + "_layer code \"" + fname + "\" " + st_init + " " + st_final + ".\n";
    out << "    Proof.\n";
    out << "      solve_single_mrs_msr Hspec.\n";
    out << "    Qed.\n\n";
    out << "End " + layer + "_" + fname + "_CodeProof.\n\n";
    out.close();
}

unique_ptr<vector<string>> generate_low_proof(Project *p)
{
    auto files = unique_ptr<vector<string>>(new vector<string>());
    int i = 0;
    for (auto const &L : p->layers) {
        if (i == 0 || L->dummy) {
            i++;
            continue;
        }

        boost::filesystem::path layer_name(L->name);
        boost::filesystem::path dir(p->base);
        if (!fs::exists((dir / layer_name).string())) {
            fs::create_directory((dir / layer_name).string());
        }
        for (auto prim : L->prims) {
            auto prim_path = dir / layer_name / boost::filesystem::path(prim);
            if (!fs::exists(prim_path.string())) {
                fs::create_directory(prim_path.string());
            }
            if (p->code->functions->find(prim) != p->code->functions->end()) {
                gen_low_proof_func(p, i, prim, (dir / layer_name / prim / "CodeProof.v").string());
            } else {
                gen_low_proof_proc(p, i, prim, (dir / layer_name / prim / "CodeProof.v").string());
            }
            if (fs::exists((dir / layer_name / prim / "CodeProof.v").string())) {
                files->push_back((layer_name / prim / "CodeProof.v").string());
            }
        }
        i++;
    }

    return files;
}
}
