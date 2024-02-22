#include <gen_high_proof.h>
#include <boost/filesystem.hpp>
#include <filesystem>
namespace fs = std::filesystem;

namespace autov {

  void gen_high_proof(Project *p, int i, string fname, string path, string cache_out) {
    std::fstream cache_o(cache_out);
    string layer = p->layers[i]->name;
    string base_layer = p->layers[i-1]->name;

    auto loc = tuple<string,string,string>(layer, fname, "LowSpec");
    auto loc_proof = tuple<string,string,string>(layer, fname, "RefProof");

    vector<string> syms;
    vector<string> mid_syms;

    for(auto const& [ s ,v ] : p->symbols){
      if(v.loc == loc) {
        syms.push_back(s);
      }

      if(v.loc == loc_proof) {
        mid_syms.push_back(s);
      }
    }

    // Require Import
    std::set<string> deps = {"CommonDeps", "DataTypes", "GlobalDefs", 
            "LayerSem.Libs.Zutils.div_mod_to_equations",
            layer + "." + fname + ".LowSpec", layer +".Spec", layer + "Layer", base_layer + ".Layer", layer + ".RefineRel" };


    for(auto s : syms) {
      if(p->deps.find(s) == p->deps.end()) continue;
      for(auto d : p->deps[s]) {
        if(p->symbols[d].loc == tuple<string,string,string>("","","") || p->symbols[d].loc == loc_proof) continue;

        deps.insert(std::get<0>(p->symbols[d].loc) + "." + std::get<1>(p->symbols[d].loc) + "." + std::get<2>(p->symbols[d].loc));
      }
    }

    
    for(auto s : mid_syms) {
      if(p->deps.find(s) == p->deps.end()) continue;
      for(auto d : p->deps[s]) {
        if(p->symbols[d].loc == tuple<string,string,string>("","","") || p->symbols[d].loc == loc_proof) continue;

        deps.insert(std::get<0>(p->symbols[d].loc) + "." + std::get<1>(p->symbols[d].loc) + "." + std::get<2>(p->symbols[d].loc));
      }
    }
    
    std::ofstream out(path);

    for(string d : deps) {
        out << "Require Import " + d + "\n";
    }

    out << std::endl;

    auto const&L = p->layers[i];
    //Open Scope
    out << "Local Open Scope string_scope.\n";

    out << "Local Open Scope Z_scope.\n";
    out << "Local Opaque Z.eqb Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit xorb List.nth.\n";
    out << std::endl;
    out << "Section " + layer + "_" + fname + "_RefProof." << std::endl; 
    out << std::endl;
    out << "  Context `{int_ptr: IntPtrCast}.\n";
    out << std::endl;

    //mid_specs

    for (auto s : mid_syms) {
      if(p->symbols[s].kind == SymbolKind::Def) {
        out << add_indent(string(*p->defs[s]), 2) << "\n\n";
        cache_o << string(*p->defs[s]) << "\n\n";
        out << "  Hint Unfold " << s << ": spec.\n\n";
      }
    }

    cache_o.close();

    //refine proof
    auto const& spec = p->defs[fname + "_spec"];
    vector<string> vars;
    vector<string> call_param;

    for(auto it = spec->args->rbegin(); it != spec->args->rend(); ++it) {
      auto aname = IRLoader::to_coq_name((*it)->name);
      vars.push_back(aname);
      call_param.push_back(aname);
    }

    vars.push_back("lst");
    vars.push_back("hst");
    vars.push_back("hst'");

    auto gen_loop = false && syms.size() > 1;
    vector<string> loop_vars;
    vector<string> loop_call_param;
    vector<string> loop_ret_args;
    std::function<string(string)> loop_ret;
    if(gen_loop) {
      //it is turned of in default
      out.close();
      return;

      auto const& loop_spec = p->defs[fname + "_loop"];
      for(auto it = loop_spec->args->rbegin(); it != loop_spec->args->rend(); ++it) {
        auto aname = IRLoader::to_coq_name((*it)->name);
        loop_vars.push_back(aname);
        loop_call_param.push_back(aname);
        if(*it != loop_spec->args->at(0)) {
          loop_vars.push_back(aname + "'");
          loop_ret_args.push_back(aname + "'");
        }
      }

      loop_vars.push_back("lst");
      loop_vars.push_back("hst");
      loop_vars.push_back("hst'");
      loop_ret = [&loop_ret_args] (string s) { return "Some ("+ autov::join(loop_ret_args, ", ") + ", " + s + ")"; };
    }


    std::function<string(string)> call_ret;

    if(auto ret = dynamic_cast<Option*>(spec->rettype.get())) {
      if(dynamic_cast<Tuple*>(ret->elem_type.get())) {
        vars.push_back("res");
        call_ret = [] (string s) { return "Some (res, " + s + ")";};
      } else {
        call_ret = [] (string s) { return "Some " + s;};
      }
    } else {
      call_ret = [] (string s) { return "Some " + s;};
    }

    if (mid_syms.size() > 0) {
      if(gen_loop) {
            out << "  Lemma f_" +fname+"_loop_refine_mid:\n";
            out << "    forall " + autov::join(loop_vars, " ") + "\n";
            out << "           (Hrel: refrel hst lst)\n";
            out << "           (Hspec: " + fname + "_loop_mid " + join(loop_call_param, " ") +  " hst" + " = " + loop_ret("hst'") + "),\n";
            out << "      exists lst', " + fname + "_loop_low " + join(loop_call_param, " ") + " lst" + " = " + loop_ret("lst'") + " /\\ refrel hst' lst'.\n";
            out << "    Proof.\n";
            out << "      intros; inv Hrel.\n";
            out << "      autounfold with spec in *; autounfold with sem in *; simpl in *.\n";
            out << "      destruct_spec Hspec; repeat solve_refproof;\n";
            out << "        repeat eexists; try unfold refrel; solve_equality.\n";
            out << "    Qed.\n\n";
      }

      out << "  Lemma f_" +fname+"_refine_mid:\n";
      out << "    forall "  + join(vars, " ") + "\n";
      out << "           (Hrel: refrel hst lst)\n";
      out << "           (Hspec: " + fname + "_spec_mid " + join(call_param, " ") + " hst = " + call_ret("hst'") + "),\n";
      out << "      exists lst', " + fname + "_spec_low " + join(call_param, " ") + " lst = " + call_ret("lst'") + " /\\ refrel hst' lst'.\n";
      out << "    Proof.\n";
      out << "      intros; inv Hrel.\n";
      out << "      autounfold with spec in *; autounfold with sem in *; simpl in *.\n";
      out << "      destruct_spec Hspec; repeat solve_refproof;\n";
      out << "        repeat eexists; try unfold refrel; solve_equality.\n";
      out << "    Qed.\n\n";

      if(gen_loop) {
            out << "  Lemma f_" + fname + "_loop_refine_high:\n";
            out << "    forall "+join(loop_vars," ") + "\n";
            out << "           (Hrel: refrel hst lst)\n";
            out << "           (Hspec: "+fname+"_loop "+join(loop_call_param," ")+ " hst = " + loop_ret("hst'") + "),\n";
            out << "      exists lst', "+fname+"_loop_mid "+join(loop_call_param," ")+ " lst = " + loop_ret("lst'") + " /\\ refrel hst' lst'.\n";
            out << "    Proof.\n";
            out << "      intros; inv Hrel.\n";
            out << "      autounfold with spec in *; autounfold with sem in *; simpl in *.\n";
            out << "      destruct_spec Hspec; repeat solve_refproof;\n";
            out << "        repeat eexists; try unfold refrel; solve_equality.\n";
            out << "    Qed.\n\n";
      }
      
      out << "  Lemma f_"+fname+"_refine_high:\n";
      out << "    forall "+join(vars," ") + "\n";
      out << "           (Hrel: refrel hst lst)\n";

      if(p->has_shadow.find(fname) != p->has_shadow.end()) {
        out << "           (Hspec: "+fname+"_spec_shadow "+ join(call_param," ") + " lst = " + call_ret("hst'") + "),\n";
      } else {
        out << "           (Hspec: "+fname+"_spec "+ join(call_param," ") + " hst = " + call_ret("hst'") + "),\n";
      }
      out << "      exists lst', "+fname+"_spec_mid "+join(call_param," ") + " lst = " + call_ret("lst'") + " /\\ refrel hst' lst'.\n";
      out << "    Proof.\n";


      if(p->cmds.NoUnfold.find(fname + "_spec") != p->cmds.NoUnfold.end()) {
            out << "      Local Transparent "+fname+"_spec.\n";
            out << "      unfold "+fname+"_spec.\n";
      }
      out << "      intros; inv Hrel.\n";
      out << "      autounfold with spec in *; autounfold with sem in *; simpl in *.\n";
      out << "      destruct_spec Hspec; repeat (solve_refproof; repeat rewrite annotation_eq);\n";
      out << "        repeat eexists; try unfold refrel; solve_equality.\n";
      out << "    Qed.\n\n";
      out << "  Lemma f_"+fname+"_refine:\n";
      out << "    forall " + join(vars, " ") + "\n";
      out << "           (Hrel: refrel hst lst)\n";


      if(p->has_shadow.find(fname) != p->has_shadow.end()) {
            out << "           (Hspec: "+fname+"_spec_shadow "+join(call_param," ") + " hst = " + call_ret("hst'") + "),\n";
      } else {
            out << "           (Hspec: "+fname+"_spec "+join(call_param," ") +" hst = " + call_ret("hst'") + "),\n";
      }

      out << "      exists lst', "+ fname +"_spec_low " + join(call_param," ") + " lst = " + call_ret("lst'") + " /\\ refrel hst' lst'.\n";
      out << "    Proof.\n";

      if(p->cmds.NoUnfold.find(fname + "_spec") != p->cmds.NoUnfold.end()) {
            out << "      Local Transparent "+fname+"_spec.\n";
            out << "      unfold "+fname+"_spec.\n";
      }

      out << "      intros; inv Hrel.\n";
      out << "      eapply f_"+fname+"_refine_high in Hspec; try unfold refrel; try reflexivity.\n";
      out << "      destruct Hspec as (lst' & Hspec & Hrel).\n";
      out << "      inv Hrel; try unfold refrel; try reflexivity.\n";
      out << "      eapply f_"+fname+"_refine_mid; try unfold refrel; try reflexivity; try eassumption.\n";
      out << "    Qed.\n\n"; 
    } else {
      out << "  Lemma f_"+fname+"_refine:\n";
      out << "    forall " + join(vars," ") + "\n";
      out << "           (Hrel: refrel hst lst)\n";
      if(p->has_shadow.find(fname) != p->has_shadow.end()) {
        out << "           (Hspec: "+fname+"_spec_shadow "+join(call_param," ") + " hst = " + call_ret("hst'") + "),\n";
      }else {
        out << "           (Hspec: "+fname+"_spec "+join(call_param," ") + " hst = " + call_ret("hst'") + "),\n";
      }

      out << "      exists lst', "+fname+"_spec_low "+join(call_param,"") + " lst = " + call_ret("lst'") + " /\\ refrel hst' lst'.\n";
      out << "    Proof.\n";
      if(p->cmds.NoUnfold.find(fname + "_spec") != p->cmds.NoUnfold.end()) {
        out << "      Local Transparent "+fname+"_spec.\n";
        out << "      unfold "+fname+"_spec.\n";
      }
      out << "      intros; inv Hrel.\n";
      out << "      autounfold with spec in *; autounfold with sem in *; simpl in *.\n";
      out << "      destruct_spec Hspec; repeat solve_refproof;\n";
      out << "        repeat eexists; try unfold refrel; solve_equality.\n";
      out << "    Qed.\n\n";
    }

    out << "End "+layer+"_"+fname+"_RefProof.\n\n";

    out.close();
  }

  unique_ptr<vector<string>> generate_high_proof(Project *p) {
    auto files = unique_ptr<vector<string>>(new vector<string>());
    boost::filesystem::path dir(p->base);
    boost::filesystem::path file(".CachedSpec");

    string cache_dir = (dir / file).string();
    if(!fs::exists(cache_dir)) {
      fs::create_directory(cache_dir);
    }

    int i = 0;
    for(auto const& L : p->layers) {
      if(i == 0) continue;

      boost::filesystem::path layer_name(L->name);
      if(!fs::exists((dir / layer_name).string())) {
        fs::create_directory((dir / layer_name).string());
      }

      boost::filesystem::path cache_out = cache_dir / boost::filesystem::path(L->name + "SpecMid.v");
      if(fs::exists(cache_out.string())) {
        fs::remove(cache_out.string());
      }
      
      for(auto prim : L->prims) {
        auto prim_path = dir / layer_name / boost::filesystem::path(prim);
        if(!fs::exists(prim_path.string())) {
          fs::create_directory(prim_path.string());
        }

        boost::filesystem::path ref_proof = prim_path / boost::filesystem::path("RefProof.v");
        gen_high_proof(p, i, prim, ref_proof.string(), cache_out.string());
        if(fs::exists(ref_proof.string())) {
          files->push_back((layer_name / boost::filesystem::path(prim) / boost::filesystem::path("RefProof.v")).string());
        }
      }

      ++i;
    }

    return files;
  }
}