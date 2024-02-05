#include <gen_project.h>
#include <filesystem>
#include <boost/filesystem.hpp>

namespace fs = std::filesystem;

namespace autov {
void generate_proj(Project *p) {
  string proj_name = p->name;
  string proj_dir = p->base;

  if(!fs::exists(proj_dir)) {
    fs::create_directory(proj_dir);
  }

  vector<string> files;
  unique_ptr<vector<string>> data = autov::generate_data(p);
  unique_ptr<vector<string>> code = autov::generate_code(p);
  unique_ptr<vector<string>> low_spec = autov::generate_low_spec(p);
  unique_ptr<vector<string>> low_proof = autov::generate_low_proof(p);
  unique_ptr<vector<string>> high_spec = autov::generate_high_spec(p);
  unique_ptr<vector<string>> high_proof = autov::generate_high_proof(p);
  unique_ptr<vector<string>> layer = autov::generate_layer(p);


  files.insert(files.begin(), data->begin(), data->end());
  files.insert(files.begin(), code->begin(), code->end());
  files.insert(files.begin(), low_spec->begin(), low_spec->end());
  files.insert(files.begin(), low_proof->begin(), low_proof->end());
  files.insert(files.begin(), high_spec->begin(), high_proof->end());
  files.insert(files.begin(), high_proof->begin(), high_proof->end());
  files.insert(files.begin(), layer->begin(), layer->end());

  std::ofstream fout(proj_dir + "/CommonDeps.v");
  for(string dep : {"LayerSem.Libs.Coqlib", "LayerSem.Libs.CommonLib", "LayerSem.Libs.Maps",
                "LayerSem.Libs.SMap", "LayerSem.Libs.Notations",
                "LayerSem.IR", "LayerSem.IRSem", "LayerSem.Asm.AsmInsn", 
                "LayerSem.Asm.AsmSem", "LayerSem.LayerRefine", "LayerSem.PrimSem"}) {
      fout << "Require Export " << dep << ".\n";
  }

  fout.close();


  files.push_back("./CommonDeps.v");

  boost::filesystem::path dir(p->base);
  boost::filesystem::path file("_CoqProject");
  std::ofstream mkfile((dir / file).string());
  mkfile << "-R . " << proj_name << "\n\n";

  sort(files.begin(), files.end());

  for(auto f : files) {
    mkfile << f << std::endl;
  }

  mkfile.close();
}
}