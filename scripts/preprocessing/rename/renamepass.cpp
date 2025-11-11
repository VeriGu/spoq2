#include "llvm/IR/Type.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/Support/JSON.h"
#include <utility>
#include <string>
#include <vector>
#include <queue>
#include <map>
#include <fstream>
#include <filesystem>

// using namespace llvm;
// static cl::opt<bool> MergeFunctionsPDI("mymergefunc-preserve-debug-info",
// cl::Hidden, cl::init(false), cl::desc("Preserve debug info in thunk when
// mergefunc "
//  "transformations are made."));

class RenamePass : public llvm::ModulePass {
 public:
  static char ID;

  std::string file;
  const llvm::DataLayout* dl;
  llvm::LLVMContext* context;
  std::map<std::string, std::map<int, std::string> > field_names;
  std::map<std::string, int> parsed_type;
  std::map<std::string, llvm::StructType*> used_id;
  std::map<llvm::StructType*, std::vector<llvm::Type*>> generated_types;
  RenamePass() : ModulePass(ID) {
  }
  bool renameAll(llvm::Module &M);
  bool runOnModule(llvm::Module &M) override { 
    context = &M.getContext();
    dl = &M.getDataLayout();
    renameAll(M);
    return true; 
  }
};

std::string remove_extension(std::string s) {
  size_t pos = s.find_last_of('.');
  if (pos == std::string::npos) {
    return s;
  }
  return s.substr(0, pos);
}
std::string getSuffix(llvm::Module &M) {
  std::string filename = M.getSourceFileName();
  size_t pos = filename.find_last_of('_');
  if(pos == std::string::npos) return "_unknown";
  return remove_extension(filename.substr(pos));
}
bool RenamePass::renameAll(llvm::Module &M) {
  llvm::json::Object changes;

  std::string suffix = getSuffix(M);
  // Rename global variables:
  changes["globals"] = llvm::json::Object();
  for(auto &gv: M.globals()) {
    if(!gv.hasName() || gv.getName().startswith("llvm.")) continue;
    std::string old_name = gv.getName().str();
    std::string new_name = old_name + suffix;
    gv.setName(new_name);
    (*changes["globals"].getAsObject())[old_name] = new_name;
  }

  // Rename functions:
  changes["functions"] = llvm::json::Object();
  for(auto &fn: M) {
    if(!fn.hasName() || fn.getName().startswith("llvm.")) continue;
    std::string old_name = fn.getName().str();
    std::string new_name = old_name + suffix;
    fn.setName(new_name);
    (*changes["functions"].getAsObject())[old_name] = new_name;
  }

  // Rename metadata nodes:
  changes["metadata"] = llvm::json::Object();
  std::vector<std::string> md_names;
  for(auto &md: M.getNamedMDList()){
    if (md.getName().startswith("llvm.")) continue;
    md_names.push_back(md.getName().str());
  }
  for(auto name: md_names){
    auto md = M.getNamedMetadata(name);
    std::string new_name = name + suffix;
    auto new_md = M.getOrInsertNamedMetadata(new_name);
    for (auto md_op : md->operands()) {
      new_md->addOperand(md_op);
    }
    md->eraseFromParent();
    (*changes["metadata"].getAsObject())[name] = new_name;
  };

  // Rename struct types and their fields:  generateRecordForStruct(M);
  changes["struct_types"] = llvm::json::Object();

  // std::string out_filename = "rename_changes" + M.getSourceFileName() + ".json";
  // std::error_code ec;
  // llvm::raw_fd_ostream outfile(out_filename, ec);
  llvm::errs() << llvm::json::Value(std::move(changes)) << "\n";
  // outfile.close();
  return true;
}
// bool RenamePass::isUnion(llvm::StructType* ty) {
//   return ty->getName().startswith("union.");
// }

// std::string RenamePass::getFieldIdentifier(llvm::StructType* sty, int count) {
//   std::string tyname = sty->getName().str();
//   if(isUnion(sty)) tyname = tyname.substr(6);
//   else tyname = tyname.substr(7);
//   std::string name = field_names[tyname][count];
//   if(name == "") name = getStructTypeIdentifier(sty) + "_" + std::to_string(count);
//   else if(!used_id[name]){
//     used_id[name] = sty;
//   }
//   else if(used_id[name] != sty) {
//     field_names[tyname][count] += "_" + getStructTypeIdentifier(sty);
//     name = field_names[tyname][count];
//   } 
//   return "e_" + name;
// }

// std::string RenamePass::getStructTypeIdentifier(llvm::StructType* sty) {
//   std::string name;
//   if(isUnion(sty)) 
//     name = "u_" + sty->getName().str().substr(6); // remove "union."
//   else
//     name = "s_" + sty->getName().str().substr(7); // remove "struct."
//   std::replace(name.begin(), name.end(), '.', '_');
//   std::replace(name.begin(), name.end(), ':', '_');
//   return name;
// }

// bool RenamePass::expandType(llvm::Type* ty, std::vector<llvm::Type*>& vec) {
//   bool success = true;
//   switch(ty->getTypeID()) {
//     case llvm::Type::TypeID::IntegerTyID: {
//       vec.push_back(ty);
//       return true;
//     }
//     case llvm::Type::TypeID::StructTyID: {
//       auto sty = llvm::dyn_cast<llvm::StructType>(ty);
//       for(auto &e: sty->elements()) {
//         success &= expandType(e, vec);
//       }
//       return success;
//     }
//     default: {
//       // llvm::errs() << "[warning] unhandled type: " << getTypeName(ty) << "\n";
//       return false;
//     }
//   }
// }

// std::string RenamePass::getTypeName(llvm::Type* ty) {
//   std::string name;
//   llvm::raw_string_ostream rso(name);
//   ty->print(rso);
//   return name;
// }

// std::vector<llvm::StructType*> RenamePass::sortTypes(std::vector<llvm::StructType*> vec) {
//   std::map<llvm::StructType*, int> predecessor;
//   std::map<llvm::StructType*, std::vector<llvm::StructType*> > g;
//   std::vector<llvm::StructType*> sorted;
//   for(auto ty: vec) predecessor[ty] = 0; 
//   for(auto ty: vec) {
//     for(llvm::Type* e: ty->elements()) {
//       if(llvm::StructType* se = llvm::dyn_cast<llvm::StructType>(e)) {
//         predecessor[ty] += 1;
//         g[se].push_back(ty);
//       } else if(llvm::ArrayType* ae = llvm::dyn_cast<llvm::ArrayType>(e)) {
//         if(llvm::StructType* se = llvm::dyn_cast<llvm::StructType>(ae->getElementType())){
//           predecessor[ty] += 1;
//           g[se].push_back(ty);
//         }
//       }
//     }
//   }
//   std::queue<llvm::StructType*> q;
//   for(auto ty: vec) {
//     if(predecessor[ty] == 0)
//       q.push(ty);
//   }
//   while(!q.empty()) {
//     llvm::StructType* x = q.front(); q.pop();
//     sorted.push_back(x);
//     for(auto se: g[x]) {
//         predecessor[se] -= 1;
//         if( predecessor[se] == 0 ) {
//           q.push(se);
//         }
//     }
//   }
//   return sorted;
// }


char RenamePass::ID = 0;

static llvm::RegisterPass<RenamePass> X(
    "renamepass", "Rename all externally accessible identifiers defined in this module.  Struct types, struct fields, functions, and global variables.",
    false,  // This pass doesn't modify the CFG => true
    false   // This pass is not a pure analysis pass => false
);
