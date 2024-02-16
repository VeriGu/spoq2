#include <gen_high_spec.h>
#include <boost/filesystem.hpp>
#include <filesystem>

namespace fs = std::filesystem;

namespace autov {

void gen_specs(Project *proj, loc_t loc, string out_path, string cache_out = "") {
  std::ofstream cache_o;
  if(cache_out != "") {
    cache_o.open(cache_out);
  }
  std::ofstream out(out_path);


  vector<string> syms;
  for(auto const& [ s ,v ] : proj->symbols){
      if(v.loc == loc) {
        syms.push_back(s);
      }
  }

  //Require Import
  std::set<string> deps = {"CommonDeps", "DataTypes"};
  if(std::get<0>(loc) != "GlobalDefs") {
        deps.insert("GlobalDefs");
  }

  for(auto s : syms) {
    if(proj->deps.find(s) != proj->deps.end()) continue;
    for(auto d : proj->deps[s]) {
      if(proj->symbols[d].loc == loc) continue;
      if(proj->symbols[d].loc == loc_t("","","")) continue;
      string l;
      l += std::get<0>(proj->symbols[d].loc);
      if(std::get<1>(proj->symbols[d].loc) != "") {
        l += ("." + std::get<1>(proj->symbols[d].loc));
      }

      if(std::get<2>(proj->symbols[d].loc) != "") {  
        l += "." + std::get<2>(proj->symbols[d].loc);
      }
      
      deps.insert(l);
    }
  }

  for(auto d : deps) {
    out << "Require Import "+d+".\n";
  }

  out << "\n";

  //Open Scope
  out << "Local Open Scope string_scope.\n";
  out << "Local Open Scope Z_scope.\n";
  out << "\n";


  for(auto s : syms) {
    if(proj->symbols[s].kind == SymbolKind::Decl) {
        out << string(*proj->decls[s]) + "\n\n";
        if(cache_out != "") {
          cache_o << string(*proj->decls[s]) + "\n\n";
        }
    }
  }

  out << "Section " + std::get<0>(loc);
  if(std::get<1>(loc) != "") {
    out << "_" + std::get<1>(loc);
  }
  if(std::get<2>(loc) != "") {
    out << "_" + std::get<2>(loc);
  }
  out << ".\n";

  out << "\n";
  out << "  Context `{int_ptr: IntPtrCast}.\n";
  out <<"\n";

  for(auto s : syms) {
    if(proj->symbols[s].kind == SymbolKind::Def) {
      out << add_indent(string(*proj->defs[s]), 2) + "\n\n";
      if (cache_out != "") {
          cache_o << string(*proj->defs[s]) + "\n\n";
      }
    }  
  }

  if(cache_out != "") {
      cache_o.close();
  }

  out << "End " + std::get<0>(loc);

  if(std::get<1>(loc) != "") {
    out << "_" + std::get<1>(loc);
  }
  if(std::get<2>(loc) != "") {
    out << "_" + std::get<2>(loc);
  }

  out << ".\n\n";

  for (auto s : syms) {
    if(proj->symbols[s].kind == SymbolKind::Def) {
      if(proj->cmds.NoUnfold.find(s) != proj->cmds.NoUnfold.end()) {
          out << "Opaque "+s+".\n";
      } else {
          out << "#[global] Hint Unfold "+s+": spec.\n";
      }
    }
  }
    
  out.close();
}

unique_ptr<vector<string>> generate_high_spec(Project *proj) {
  auto files = unique_ptr<vector<string>>(new vector<string>());
  boost::filesystem::path dir(proj->base);
  boost::filesystem::path file("GlobalDefs.v");

  gen_specs(proj, loc_t("GlobalDefs","",""), (dir/file).string());
  auto cache_dir = dir / ".CachedSpec";
  if(!fs::exists(cache_dir.string())) {
      fs::create_directory(cache_dir.string());
  }

  for(auto const& L : proj->layers) {
    if(!fs::exists((dir / boost::filesystem::path(L->name)).string())) {
        fs::create_directory((dir / boost::filesystem::path(L->name)).string());
    }

    auto cache_out = cache_dir / (L->name + "Spec.v");
    gen_specs(proj, loc_t(L->name, "Spec", ""), (dir / boost::filesystem::path(L->name) / boost::filesystem::path("Spec.v")).string(), cache_out.string());
    files->push_back((boost::filesystem::path(L->name) / "Spec.v").string());
  }

  return files;
}

}