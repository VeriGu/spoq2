#include <gen_code.h>
#include <fstream>
#include <boost/filesystem.hpp>

namespace autov {
using std::ofstream;
using IRLoader::IRModule;
using std::string;
using autov::Project;

void print_module(IRModule *ir, string out_path) {
  ofstream fout(out_path);

  string layer_sem_name("LayerSem.");
  string lib_name("LayerSem.Libs");
  fout << "Require Import String.\n";
  fout << "Require Import ZArith.\n";
  fout << "Require Import List.\n";
  fout << "Require Import " << lib_name << ".SMap.\n";
  fout << "Require Import " << layer_sem_name << "IR.\n";
  fout << "Require Import " << layer_sem_name << "IRSem.\n";
  fout << "Require Import " << layer_sem_name << "Asm.AsmInsn.\n";
  fout << "\n";
  fout << "Local Open Scope Z_scope.\n";
  fout << "Local Open Scope string_scope.\n\n";

  fout << "(************ Structures ************)\n\n";

  vector<string> structs_coq;

  for(auto const& [key, typ] : *ir->structs) {
    fout << "Definition s_" << IRLoader::to_coq_name(key) << " :=\n" +
      autov::add_indent(typ->to_coq(), 4) + ".\n";
    
    fout << "\n";
    structs_coq.push_back("(\"" + key + "\")" + ", s_" + IRLoader::to_coq_name(key) + ")");  
  }

  fout << "Definition structures :  list (string * typ) :=\n";
  fout << autov::add_indent(IRLoader::to_code_block(&structs_coq), 4) + ".\n\n";

  vector<string> globvars_coq;

  fout << "(************ Global Variables ************)\n\n";

  for(auto const& [key, glo] : *ir->globalvars) {
     fout << "Definition v_" << IRLoader::to_coq_name(key) << ":=\n" +
      autov::add_indent(glo->to_coq(), 4) + ".\n";

     fout << "\n";
     globvars_coq.push_back("(\"" + key + "\")" + ", v_" + IRLoader::to_coq_name(key) + ")");
  }

  fout << "Definition globvars : list (string * global_var) :=\n";
  fout << autov::add_indent(IRLoader::to_code_block(&globvars_coq), 4) + ".\n\n";


  vector<string> functions_coq;
  fout << "(************ Functions ************)\n\n";
  

  for(auto const& [key, func] : *ir->functions) {
     const string & fcoq = func->to_coq();
     fout << "Definition f_" << IRLoader::to_coq_name(key) << ":=\n" +
      autov::add_indent(fcoq, 4) + ".\n";

     fout << "\n";
     functions_coq.push_back("(\"" + key + "\")" + ", f_" + IRLoader::to_coq_name(key) + ")");

     std::stringstream ss(fcoq);
     string to;
     int nums;
     while(std::getline(ss, to, '\n')) {
      nums++;
     }

     if(nums > 100) {
      LOG_DEBUG << "Very Large Function " << key << " " << nums;
     }
  }

  fout << "Definition funcs :=\n";
  fout << autov::add_indent(IRLoader::to_code_block(&functions_coq), 4) + ".\n\n";


  vector<string> asm_procs;
  fout << "(************ AsmProcs ************)\n\n";
  for(auto const& [key, as] : *ir->asm_procs) {
     if(as->body == ""){
      continue;
     }

     fout << as->to_coq();
     fout << ".\n\n";
     asm_procs.push_back("(\"" + as->name + "\")" + ", v_" + IRLoader::to_coq_name(as->name) + ")");
  }

  fout << "Definition asm_procs : list (string * procedure) :=\n";
  fout << autov::add_indent(IRLoader::to_code_block(&asm_procs), 4) + ".\n\n";


  fout << "(************ IR Module ************)\n\n";
  fout << "Definition code :=\n";
  fout << "  {| structs := structures;\n";
  fout << "     global_vars := globvars;\n";
  fout << "     functions := funcs;\n";
  fout << "     asm_procedures := asm_procs |}.\n";

  fout.close();
}

unique_ptr<vector<string>> generate_code(Project *p) {
  boost::filesystem::path dir(p->base);
  boost::filesystem::path file("Code.v");
  print_module(p->code.get(), (dir / file).string());

  auto vec = unique_ptr<vector<string>>(new vector<string>());
  vec->push_back("Code.v");

  return vec;
}
}