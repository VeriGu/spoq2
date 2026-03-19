#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/IntrinsicInst.h"
#include <utility>
#include <string>
#include <vector>
#include <queue>
#include <map>
#include <fstream>
#include <filesystem>
#include <iostream>
#include <optional>
#include "../../../include/anon_structs.h"
// using namespace llvm;
// static cl::opt<bool> MergeFunctionsPDI("mymergefunc-preserve-debug-info",
// cl::Hidden, cl::init(false), cl::desc("Preserve debug info in thunk when
// mergefunc "
//  "transformations are made."));

class ExtractPointersPass : public llvm::ModulePass {
 public:
  static char ID;

  std::string file;
  std::ofstream fout;
  int base_offset = 0x4000000; // TODO: change to the concrete value in RMM
  int base = 0;
  const llvm::DataLayout* dl;
  llvm::LLVMContext* context;
  const int page_size = 4096;

  std::vector<llvm::GlobalVariable*> gv_list;
  std::map< llvm::Type*, int> passed_stack;
  std::map< llvm::GlobalVariable*, std::pair<int, int> > gv_addr;
  std::map< llvm::Function*, std::vector<llvm::AllocaInst*> > stack_list;
  std::map< llvm::Function*, std::vector<llvm::Type*> > stack_local_list;
  std::map< llvm::AllocaInst*, int> alloca_id;
  std::map< llvm::Function*, int> visited;
  std::map< llvm::Value*, std::string > var_name; 
  std::string getStructTypeIdentifier(llvm::StructType*);

  // In order to generate type stability preconditions,
  // We want to link each stack and global var to its type
  // and link each type to a set of subtypes (including itself)
  // since a pointer with that pbase could have any of those types
  std::map<std::string, llvm::Type*> named_stack_ty;
  std::map<std::string, llvm::Type*> named_global_ty;
  std::map<llvm::Type*, std::set<llvm::Type*>> elements_of_type;

  int type_id = 0;
  std::map<llvm::Type*, std::string> unique_type_name;
  std::string getTypeIdentifier(llvm::Type*);
  std::string generateField(llvm::Type*);
  std::string getStackIdentifier(llvm::Type* ty, int id) {
    std::string result;
    if( id == 0 ) return "stack_" + getTypeIdentifier(ty);
    return "stack_" + getTypeIdentifier(ty) + "__" + std::to_string(id);
  }
  std::string getGVIdentifier(llvm::GlobalVariable* v) {
    if(v->isConstant() && v->getType()->isPointerTy() && 
      v->getType()->getPointerElementType()->isArrayTy() && 
      v->getType()->getPointerElementType()->getArrayElementType()->isIntegerTy() && 
      v->hasName() && v->getName().startswith(".str.")){
      std::string name = "g_merged_constant_global_string";
      return name;
    } else {
      std::string name = "g_" + v->getName().str();
      std::replace(name.begin(), name.end(), '.', '_');
      std::replace(name.begin(), name.end(), ':', '_');
      return name;
    }
  }
  std::string getGVLoadStr(llvm::GlobalVariable* v) {
    if(v->isConstant()){
      return getGVIdentifier(v);
    } else {
      return "st.(globals).(" + getGVIdentifier(v) + ")";
    }
        
  }
  std::string getGVStoreStr(llvm::GlobalVariable* v) {
    if(v->isConstant()){
      return "None (* Attempting to load constant *)";
    } else {
      return "st.[globals].[" + getGVIdentifier(v) + "]";
    }
  }

  bool isUnion(llvm::StructType* ty) {
    return ty->getName().startswith("union.");
  }

  std::string generateGlobalBaseDefinition() {
    std::string result;
    for (auto g: gv_list) {
      std::string gv_name = g->getName().str();
      std::transform(gv_name.begin(), gv_name.end(), gv_name.begin(), ::toupper);
      std::replace(gv_name.begin(), gv_name.end(), '.', '_');
      result += "Definition " + gv_name + "_BASE : Z := " + std::to_string(gv_addr[g].first + base_offset) + ".\n";
    }
    result += "Definition MAX_GLOBAL : Z := " + std::to_string(base + base_offset) + ".\n";
    return result;
  }

  std::string generateIntToPtr() {
    std::string result = "Definition global_to_ptr (v: Z) : Ptr := \n" \
    " if (v >=? MAX_GLOBAL ) then (mkPtr \"null\" 0) else\n" \
    " if (v <? 0 ) then (mkPtr \"null\" 0) else\n";
    for (auto it = gv_list.rbegin(); it != gv_list.rend(); it++) {
      auto g = *it;
      std::string gv_name = g->getName().str();
      std::replace(gv_name.begin(), gv_name.end(), '.', '_');
      std::string gv_name_up = gv_name;
      std::transform(gv_name_up.begin(), gv_name_up.end(), gv_name_up.begin(), ::toupper);

      // result += "Definition " + gv_name + "_BASE = " + std::to_string(gv_addr[g].first) + "\n";
      result += " if (v >=? " + gv_name_up + "_BASE) then (mkPtr \"" + gv_name + "\" (v - " + gv_name_up + "_BASE)) else\n";
    }
    result += "   (mkPtr \"null\" 0).";
    return result; 
  }

  std::string generatePtrToInt() {
    std::string result = "Definition ptr_to_int (p: Ptr) : Z := \n" \
    " if (p.(poffset) <? 0) then (-1) else\n" \
    // " if (p.(pbase) =s \"status\") then (MAX_ERR + p.(poffset)) else\n" 
    " if (p.(pbase) =s \"null\") then 0 else\n" ;
    // " if (v <? 0 ) then (mkPtr \"null\" 0) else\n";
    for (auto it = gv_list.rbegin(); it != gv_list.rend(); it++) {
      auto g = *it;
      std::string gv_name = g->getName().str();
      std::replace(gv_name.begin(), gv_name.end(), '.', '_');
      std::string gv_name_up = gv_name;
      std::transform(gv_name_up.begin(), gv_name_up.end(), gv_name_up.begin(), ::toupper);

      // result += "Definition " + gv_name + "_BASE = " + std::to_string(gv_addr[g].first) + "\n";
      result += " if (p.(pbase) =s \"" + gv_name + "\") then (" + gv_name_up + "_BASE + p.(poffset)) else\n";
    }
    result += "    (-1).";
    return result; 
  }

  void generate(llvm::Module &M);
  void fillTypeElements(llvm::Module &M);
  void collectStack(llvm::Module &M);
  void dumpMemTypInfo(std::string filename, llvm::Module &M);
  std::map<llvm::Type *, int> dfsStack(llvm::Function *func,
                                       std::vector<llvm::Function *> &vec);
  bool checkPassedInst(llvm::Instruction* inst);
  static const std::string debug_intrinsics[];


  bool is_debug_intrinsic(llvm::StringRef fname);
  ExtractPointersPass() : ModulePass(ID) { }
  bool runOnModule(llvm::Module& M) override {
    context = &M.getContext();
    dl = &M.getDataLayout();
    file = M.getName().str() + ".machine.v";
    fout.open(file, std::ios::out | std::ios::trunc);
    generate(M);
    fout.close();
    std::filesystem::path abs_path = std::filesystem::absolute(file);
    llvm::errs() << "machine info dumped into:" << abs_path.string() << "\n";
    return false;
  }
};
const std::string ExtractPointersPass::debug_intrinsics[] = {"llvm.dbg", "printhex_ul", "print_string", "printf", "printf_", "printk", "printhex_ul_dbg", "print_string_dbg", "__debug_save_state", "__debug_restore_state", "_out_", "_debug", "llvm.memcpy", "llvm.memset", "strlen", "memcmp", "memcpy", "memset", "memmove", "_strnlen"};


std::string ExtractPointersPass::getStructTypeIdentifier(llvm::StructType* sty) {
  std::string name;
  if(isUnion(sty)) {
    name = "u_" + sty->getName().str().substr(6);
  } else if(sty->hasName()){
    name = "s_" + sty->getName().str().substr(7);
  } else {
    name = anonStructName(sty);
  }
  std::replace(name.begin(), name.end(), '.', '_');
  std::replace(name.begin(), name.end(), ':', '_');
  return name;
}

std::string ExtractPointersPass::getTypeIdentifier(llvm::Type* ty) {
  if( unique_type_name[ty] != "" ) return unique_type_name[ty];
  if(auto sty = llvm::dyn_cast<llvm::StructType>(ty)) {
    unique_type_name[sty] = getStructTypeIdentifier(sty);
    return unique_type_name[sty];
  }
  unique_type_name[ty] = "type_" + std::to_string(++type_id);
  return unique_type_name[ty];
}

std::string ExtractPointersPass::generateField(llvm::Type* ty) {
  switch(ty->getTypeID()) {
    case llvm::Type::TypeID::IntegerTyID: {
      return "Z";
    }
    case llvm::Type::TypeID::StructTyID: {
      auto sty = llvm::dyn_cast<llvm::StructType>(ty);
      return getStructTypeIdentifier(sty); // remove struct.
    }
    case llvm::Type::TypeID::PointerTyID: {
      return "Z";
    }
    case llvm::Type::TypeID::ArrayTyID: {
      auto aty = llvm::dyn_cast<llvm::ArrayType>(ty);
      auto ety = aty->getElementType();
      if( ety->isIntegerTy() || ety->isPointerTy() ) {
      // TODO: assert Array is [constant x iXXX]
        return "(ZMap.t Z)";
      } else if(ety->isDoubleTy() || ety->isFloatTy() || ety->isFloatingPointTy()){
        return "(ZMap.t Float)";
      } else if(ety->isStructTy()) {
        return "(ZMap.t " + getStructTypeIdentifier(llvm::dyn_cast<llvm::StructType>(ety)) + ")";
      } else if(ety->isArrayTy()){
        auto aty2 = llvm::dyn_cast<llvm::ArrayType>(ety);
        auto ety2 = aty2->getElementType();
        if(ety2->isIntegerTy()){
          return "(ZMap.t (ZMap.t Z))";

        } else {
          return "None (* FIXME: nd array *)";

        }
      } else {
        return "None (* FIXME: unknown subtype *)";
      }
    } 
    case llvm::Type::TypeID::MetadataTyID: {
      return "Metadata";
    }
    case llvm::Type::TypeID::FloatTyID: {
      return "Float";
    }
    case llvm::Type::TypeID::DoubleTyID: {
      return "Double";
    }
    default: {
      return "UnknownType";
    }
  }
}

bool ExtractPointersPass::is_debug_intrinsic(llvm::StringRef fname) {
  for (auto l : debug_intrinsics) {
    if (fname.startswith(l) || fname.endswith(l)) return true;
  }
  return false;
}

std::map<llvm::Type*, int> ExtractPointersPass::dfsStack(
    llvm::Function* func, std::vector<llvm::Function*>& vec) {
  visited[func] = 1;
  std::vector<llvm::Function*> succ;
  for (auto& B : func->getBasicBlockList()) {
    for (auto& I : B) {
      auto inst = &I;
      if (auto ci = llvm::dyn_cast<llvm::CallInst>(inst)) {
        auto callee = ci->getCalledFunction();
        if (callee) {
          if (is_debug_intrinsic(callee->getName())) continue;
          succ.push_back(callee);
        } else {  
          // TODO: inline assembly 
        }
      }
    }
  }
  if (succ.size() > 0) {
    std::map<llvm::Type*, int> sn;
    for (auto fptr : succ) {
      if (visited[fptr]) continue;
      vec.push_back(fptr);
      auto sn_suc = dfsStack(fptr, vec);
      for (auto& x : sn_suc) {
        sn[x.first] = std::max(sn[x.first], x.second);
      }
      vec.pop_back();
    }
    for (auto ti : stack_list[func]) {
      auto ty = ti->getAllocatedType();
      alloca_id[ti] = sn[ty];
      sn[ty] += 1;
    }
    visited[func] = 0;
    return sn;
  } else {
    std::map<llvm::Type*, int> s;
    for (auto fptr : vec) {
      for (auto ti : stack_list[fptr]) {
        auto ty = ti->getAllocatedType();
        s[ty] += 1;
        if (passed_stack[ty] < s[ty]) {
          passed_stack[ty] = s[ty];
          // llvm::errs() << *ty << " " << passed_stack[ty] << " " << func->getName() << "\n";
        }
      }
    }
    std::map<llvm::Type*, int> sn;
    for (auto ti : stack_list[func]) {
      auto ty = ti->getAllocatedType();
      alloca_id[ti] = sn[ty];
      sn[ty] += 1;
    }
    visited[func] = 0;
    return sn;
  }
}

bool ExtractPointersPass::checkPassedInst(llvm::Instruction* inst) {
  // TODO: for now, put all allocated variable in the stack
  if (auto ai = llvm::dyn_cast<llvm::AllocaInst>(inst)) {
    if (auto sty = llvm::dyn_cast<llvm::StructType>(ai->getAllocatedType())) {
      if (sty->getName().empty()) { // except %.sroa.3 in @sort_granules
        return 0;
      }
    }
  }
  return 1; 
  /* ******************************************** */
  int passed = 0;
  for (auto it = inst->user_begin(); it != inst->user_end(); ++it) {
    auto user = *it;
    if (auto lu = llvm::dyn_cast<llvm::LoadInst>(user)) {
      if (lu->getPointerOperand() == inst) continue;
    }
    if (auto su = llvm::dyn_cast<llvm::StoreInst>(user)) {
      if (su->getPointerOperand() == inst) continue;
    }
    if (auto gu = llvm::dyn_cast<llvm::GetElementPtrInst>(user)) {
      if (gu->getPointerOperand() == inst) {
        int b = checkPassedInst(gu);
        if(!b) continue;
      }
    }
    if (auto bu = llvm::dyn_cast<llvm::BitCastInst>(user)) {
      int b = checkPassedInst(bu);
      if (!b) continue;
    }
    if (auto cu = llvm::dyn_cast<llvm::CallInst>(user)) {
      auto callee = cu->getCalledFunction();
      if (callee && is_debug_intrinsic(callee->getName())) continue;
    }
    passed |= 1;
    if (passed) break;
  }
  return passed;
}

void ExtractPointersPass::fillTypeElements(llvm::Module &M) {
  for (auto t: M.getIdentifiedStructTypes()){
    this->elements_of_type[t].insert(t);
    for (auto &e_ty: t->elements()){
      this->elements_of_type[t].insert(e_ty);
      this->elements_of_type[e_ty].insert(e_ty);
    }
  }
  for (auto &gv: M.globals()){
    auto ty = gv.getType();
    this->elements_of_type[ty].insert(ty);
    if(ty->isStructTy()){
      for(size_t idx = 0; idx < ty->getStructNumElements(); idx++){
        this->elements_of_type[ty].insert(ty->getStructElementType(idx));
      }
    } else if (ty->isArrayTy()) {
      this->elements_of_type[ty].insert(ty->getArrayElementType());
    }
  }

  bool changed = true;
  while(changed){
    changed = false;
    for (auto [outer_ty, inner_tys]: this->elements_of_type){
      for (auto inner_ty: inner_tys) {
        size_t old_size = this->elements_of_type[outer_ty].size();
        this->elements_of_type[outer_ty].merge(this->elements_of_type[inner_ty]);
        if (this->elements_of_type[outer_ty].size() != old_size) {
          changed = true;
        }
      }
    }
  }
}
void ExtractPointersPass::collectStack(llvm::Module &M) {
  std::map<llvm::Function*, int> has_pre;
  int passed_count = 0, local_count = 0;
  /*
  3/3/26: RJS
  I am changing the memory model to a associative-array-based stack
  OLD WAY:
  Stack is a Record with a field for each stack value
  Produce a stack-load and stack-store function that are big
  if-then chains
  NEW WAY:
  stack is an associative array string -> StackVal
  StackVal is an Inductive data type with branches:
  1. Z
  2. Zmap Z
  3. For every struct type in the stack, that type
  4. For every array/pointer to a struct in the stack, that type.

  */
  for (auto& F : M) {
    if( is_debug_intrinsic(F.getName()) ) continue;
    for (auto& B : F) {
      for (auto& I : B) {
        auto inst = &I;

        if (auto ci = llvm::dyn_cast<llvm::CallInst>(inst)) {
          auto callee = ci->getCalledFunction();
          if (callee) has_pre[callee] = 1;
          if (auto di = llvm::dyn_cast<llvm::DbgDeclareInst>(inst)) {
            if( auto var = di->getVariableLocationOp( 0 ) ) {
              var_name[var] = di->getVariable()->getName().str();
            }
          }
        }
        if (auto ai = llvm::dyn_cast<llvm::AllocaInst>(inst)) {
          int passed = checkPassedInst(ai);
          auto ty = ai->getAllocatedType();
          if(passed) { 
            stack_list[&F].push_back(ai);
            passed_count += 1;
          } else {
            stack_local_list[&F].push_back(ty);
            alloca_id[ai] = -1;
            local_count += 1;
          }
        }
      }
    }
  }

  std::vector<llvm::Function*> vec;
  std::map<llvm::Type*, int> sn;
  for (auto& F : M) {
    if (has_pre[&F]) continue;
    auto sn_suc = dfsStack(&F, vec);
    for (auto& x : sn_suc) {
      sn[x.first] = std::max(sn[x.first], x.second);
    }
  }
/*
We need to produce 3+n items.
The definition of StackVal, with a branch for each possible type in the stack
The definition of stack_load, with a branch for each possible StackVal.
The definition of stack_store, with a branch for each possible StackVal.

n-times, where n is the number of structs
struct_store and struct_load functions to be used in stack_load and stack_store.

The necessary information is:
What are all the types that are stored on the stack?
For each stack pointer, what type is in it?

At this point we have the sn map from type to the number of times that type occurs in the stack
and getStackIdentifies which tells us for each type and idx what the right name is.
Therefore, we are ready to build the stack model.

We first make one pass through the types to build the StackVal type
and to build the load_stack definition.
For store_stack,
we get the current value of the pointer, match it, and need to set
all the other branches to None.
We can do this in a proxy definition for each type
*/

  // store_stack and load_stack match bodies for StackVal branches
  // will be prefixed by rely statements fixing the possible source stack pointers
  // Map stack type identifiers from getStructTypeIdentifier to stackval branch and possible pointers
  using stackval_info_entry_t = std::tuple<std::string,bool,bool,std::optional<std::string>, int, std::vector<std::string>>;
  std::map<std::string,stackval_info_entry_t> stackval_info;
  // This corresponds to  | ZVal (ZValConstr: Z)
  stackval_info_entry_t z_val_entry = {"ZVal", false, false, std::nullopt, 0, {}};
  stackval_info.emplace("Z", z_val_entry);
  stackval_info_entry_t zmap_val_entry = {"ZMapVal", true, false, std::nullopt, 0, {}};
  stackval_info.emplace("(ZMap.t Z)", zmap_val_entry);

  std::string stackkey_def = "Inductive StackKey := \n";
  std::string stackval_def = "Inductive StackVal := \n";
  // stackval_info_entry_t z_val_entry = {"ZVal", false, {}};
  // "| ZVal (zStackVal: Z)\n"
  // "| ZMapVal (zmapStackVal: (ZMap.t Z))"; // left unclosed!
  std::string load_result = "Definition load_stack (sz: Z) (p: Ptr) (stack_map: STACK): (option Z) := \n" \
  "\tmatch (stack_map @ p.(pbase)) with\n" \
  "\t\t| Some sv => match sv with\n";
  // "\t\t\t| ZVal z => Some z\n"
  // "\t\t\t| ZMapVal zmap => Some (zmap @ p.(poffset))\n";
  std::string store_result = "Definition store_stack (sz: Z) (p: Ptr) (v: Z) (stack_map: STACK): (option STACK) := \n" \
  "\tmatch (stack_map @ p.(pbase)) with\n" \
  "\t\t| Some sv => match sv with\n";
  // "\t\t\t| ZVal z => Some (stack_map # p.(pbase) == Some(ZVal v))\n"
  // "\t\t\t| ZMapVal zmap => Some (stack_map # p.(pbase) == Some(ZMapVal (zmap # p.(poffset) == v)))\n";
  std::string is_stack_ptr = "Definition is_stack_ptr (p: Ptr): bool := (false = true)";
  for (auto &x : sn) {
    std::string stackval_branch_id = "";
    std::string stackval_accessor = "";
    std::optional<std::string> struct_name = std::nullopt;
    bool is_struct = false;
    int element_size = 0;
    if (auto sty = llvm::dyn_cast<llvm::StructType>(x.first)){
      is_struct = true;
      auto struct_id = getStructTypeIdentifier(sty);
      struct_name = struct_id;
      stackval_branch_id = struct_id + "Val";
      stackval_accessor = struct_id;
    } else if(auto aty = llvm::dyn_cast<llvm::ArrayType>(x.first)){
      auto ety = aty->getElementType();
      if (auto sty = llvm::dyn_cast<llvm::StructType>(ety)){
        is_struct = true;
        auto struct_id = getStructTypeIdentifier(sty);
        struct_name = struct_id;
        element_size = dl->getTypeAllocSize(ety);
        stackval_branch_id = struct_id + "ArrVal";
        stackval_accessor = ("(ZMap.t "+struct_id+")", struct_id);
      } else {
        stackval_branch_id = "ZMapVal";
        stackval_accessor = generateField(x.first);
      }
    } else {
      stackval_branch_id = "Z";
      stackval_accessor = generateField(x.first);
    }
    if(stackval_info.count(stackval_accessor) == 0){
      stackval_info_entry_t entry = {stackval_branch_id, x.first->isArrayTy(), is_struct, struct_name, element_size, {}};
      stackval_info.emplace(stackval_accessor, entry);
    }
    for(int i = 0; i < x.second; i++){
      this->named_stack_ty[getStackIdentifier(x.first, i)] = x.first;
      is_stack_ptr += " \\/ \n\tp.(pbase) =s \"" + getStackIdentifier(x.first, i) + "\"";
      stackkey_def += "\t| sk_"+getStackIdentifier(x.first, i) + "\n";
      auto &[branch_id, is_map, is_struct, struct_name, element_size, name_vec] = stackval_info.at(stackval_accessor);
      name_vec.push_back(getStackIdentifier(x.first, i));
    }
  }

  for (auto [type_ident, entry]: stackval_info){
    auto [stackval_ident, is_map, is_struct, struct_id_opt, element_size, pointers] = entry;
    std::string constr_e_ident = stackval_ident + "_val";

    // StackVal
    if(is_map){
      stackval_def += "\t| "+stackval_ident+" ("+stackval_ident+"Constr: (ZMap.t "+type_ident+"))\n";
    } else {
      stackval_def += "\t| "+stackval_ident+" ("+stackval_ident+"Constr: "+type_ident+")\n";
    }

    std::string rely_clause;
    rely_clause = "false";
    for (auto &pointer_name : pointers){
      rely_clause += " \\/ (p.(pbase) =s \"" + pointer_name + "\")";
    }
    rely_clause = "rely ("+rely_clause+");";
    // Load & Store
    if(!is_map && !is_struct){
      // Z
      load_result  += "\t\t\t| " + stackval_ident + " " + constr_e_ident + " => "+rely_clause+\
        "\n\t\t\t\tSome " + constr_e_ident + "\n";
      store_result += "\t\t\t| " + stackval_ident + " " + constr_e_ident + " => "+rely_clause+\
      "\n\t\t\t\tSome (stack_map # p.(pbase) == Some(" + stackval_ident + " " + constr_e_ident + "))\n";
    } else if(is_map && !is_struct){
      // ZMap.t Z
    } else if(!is_map && is_struct){
      auto struct_id = struct_id_opt.value();
      std::string load_ret_name = "ret_load_" + stackval_ident;
      std::string store_ret_name = "ret_store_" + stackval_ident;

      load_result += "\t\t\t| "+stackval_ident+" "+constr_e_ident +" => \n";
      load_result += "\t\t\t\t" + rely_clause + "\n";
      load_result += "\t\t\t\twhen "+load_ret_name+" == load_" + struct_id + " sz p.(poffset) " + constr_e_ident + ";\n";
      load_result += "\t\t\t\t\tSome("+load_ret_name+")\n";

      store_result += "\t\t\t| " + stackval_ident + " "+ constr_e_ident+" => \n"\
                      "\t\t\t\t" + rely_clause +"\n"\
                      "\t\t\t\twhen "+store_ret_name+" == store_" + struct_id + " sz p.(poffset) v "+constr_e_ident+";\n"\
                      "\t\t\t\tSome(stack_map # p.(pbase) == Some(" + stackval_ident + " "+store_ret_name+"))\n";

      // struct
    } else if(is_map && is_struct){
      auto struct_id = struct_id_opt.value();
      std::string load_ret_name = "ret_load_arr_" + struct_id;
      std::string store_ret_name = "ret_store_arr_" + struct_id;
        load_result += "\t\t\t| " + stackval_ident + " "+constr_e_ident+" => \n";
        load_result += "\t\t\t\t" + rely_clause + "\n";
        load_result += "\t\t\t\tlet idx := p.(poffset) /" + std::to_string(element_size) + " in\n" \
          "\t\t\t\tlet elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
          "\t\t\t\twhen "+load_ret_name+" == load_" + struct_id + " sz elem_ofs ("+constr_e_ident+" @ idx);\n"\
          "\t\t\t\t\tSome("+load_ret_name+")\n";
        store_result += "\t\t\t| " + stackval_ident +" "+constr_e_ident+" => \n"\
                      "\t\t\t\t" + rely_clause +"\n"\
                      "\t\t\t\tlet idx := p.(poffset) /" + std::to_string(element_size) + " in\n" \
                      "\t\t\t\tlet elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
                      
                      "\t\t\t\twhen "+store_ret_name+" == store_" + struct_id + " sz p.(poffset) v ("+constr_e_ident+" @ idx);\n"\
                      "\t\t\t\tSome(stack_map # p.(pbase) == Some(" + stackval_ident + " ("+constr_e_ident+" # idx == "+store_ret_name+")))\n";

      // ZMap.t struct
    } else {
      assert(false);
    }
  }

  stackval_def += ".\n";
  stackval_def += "Definition STACK := (SMap (option StackVal)).";

  load_result += "\t\tend\n" \
                "\t| None => None\n" \
                 "end.";
  store_result += "\t\tend\n" \
                  "\t| None => None\n" \
                 "end.";
  is_stack_ptr += ".\n";
  stackkey_def += "| sk_Null.\n";
  std::string hint_result = "";
  for (auto& F : M) {
    auto func = &F;
    for (auto ti : stack_list[func]) {
      auto ai = llvm::dyn_cast<llvm::AllocaInst>(ti);
      std::string name;
      if (!ai->getName().empty())
        name = ai->getName().str();
      else {
        llvm::raw_string_ostream os(name);
        ti->printAsOperand(os, false, &M);
        name.erase(0, 1);
      }
      name = "v_" + name;
      hint_result = hint_result + "Hint StackVar " + func->getName().str() + " " + name + " "
                   + getStackIdentifier(ai->getAllocatedType(), alloca_id[ti])
                   + ".\n";
    }
  }
  fout << "\n" << hint_result << "\n";
  fout << "\n" << is_stack_ptr << "\n";
  fout << "\n" << stackval_def << "\n";
  fout << "\n" << stackkey_def << "\n";
  fout << "\n" << load_result << " (* load_stack *)\n"; 
  fout << store_result << " (* store_stack *)\n"; 
    
}
void ExtractPointersPass::dumpMemTypInfo(std::string filename, llvm::Module &M){
  llvm::json::Object result;
  result["mem_ty_map"] = llvm::json::Object();
  (*result["mem_ty_map"].getAsObject())["globals"] = llvm::json::Object();
  for(auto [name, ty]: this->named_global_ty ){
    (*(*result["mem_ty_map"].getAsObject())["globals"].getAsObject())[name] = getTypeIdentifier(ty);
  }
  (*result["mem_ty_map"].getAsObject())["stack"] = llvm::json::Object();
  for(auto [name, ty]: this->named_stack_ty ){
    (*(*result["mem_ty_map"].getAsObject())["stack"].getAsObject())[name] = getTypeIdentifier(ty);
  }

  result["ty_elem_map"] = llvm::json::Object();
  for(auto [ty, ty_set]: this->elements_of_type){
  (*result["ty_elem_map"].getAsObject())[getTypeIdentifier(ty)] = llvm::json::Array();
    for(auto inner_ty: ty_set){

      (*(*result["ty_elem_map"].getAsObject())[getTypeIdentifier(ty)].getAsArray()).push_back(getTypeIdentifier(inner_ty));
    }

  }

  result["fn_arg_ty_map"] = llvm::json::Object();
  for(auto &fn: M.functions()){
    (*result["fn_arg_ty_map"].getAsObject())[fn.getName().str()] = llvm::json::Array();

    for(auto &arg: fn.args()){
      auto ty = arg.getType();
      // here need to check if ty is pointer and if it is get the unique id of the pointed to type
      std::string ty_str;
      if (ty->isPointerTy()) {
        ty_str = getTypeIdentifier(ty->getPointerElementType());
      } else if (ty->isArrayTy()) {
        ty_str = getTypeIdentifier(ty->getArrayElementType());
      } else {
        ty_str = "not_ptr_or_array";
      }
      (*(*result["fn_arg_ty_map"].getAsObject())[fn.getName().str()].getAsArray()).push_back(ty_str);

      if(ty_str != "not_ptr_or_array" && result["ty_elem_map"].getAsObject()->find(ty_str) == result["ty_elem_map"].getAsObject()->end()) {
        // if the type is not in the ty_elem_map, we need to add it
        llvm::Type* inner_ty;
        if(ty->isPointerTy()) {
          inner_ty = ty->getPointerElementType();
        } else if (ty->isArrayTy()) {
          inner_ty = ty->getArrayElementType();
        } else {
          llvm::errs() << "Type " << ty_str << " inner elements not known, needed for fn: " << fn.getName().str() << "\n";
          continue;
        }
        (*result["ty_elem_map"].getAsObject())[ty_str] = llvm::json::Array();
        (*(*result["ty_elem_map"].getAsObject())[ty_str].getAsArray()).push_back(getTypeIdentifier(inner_ty));
      }
    }
  }

  std::error_code error_msg;
  llvm::StringRef refname(filename);
  llvm::raw_fd_ostream mem_typ_file(refname, error_msg, llvm::sys::fs::OpenFlags::OF_None);


  mem_typ_file << llvm::json::Value(std::move(result)) << "\n";
  mem_typ_file.close();

  llvm::errs() << "memory type info dumped to " << filename << "\n";
  
}
void ExtractPointersPass::generate(llvm::Module& M) {
  // print out all PtrToInt instruction
  // for (auto& F : M) {
  //   if( is_debug_intrinsic(F.getName()) ) continue;
  //   for (auto& B : F) {
  //     for (auto& I : B) {
  //       auto inst = &I;
  //       if(auto p2i = llvm::dyn_cast<llvm::PtrToIntInst>(inst)) {
  //         llvm::errs() << *p2i << " " << *(p2i->getPointerOperand()) << "\n";
  //       }
  //     }
  //   }
  // }

  collectStack(M);

  int page_count = 0;
  std::vector<llvm::GlobalVariable*> fail_gv;
  std::string g_load_result = "";
  std::string g_store_result = "";
  std::string is_global_ptr = "Definition is_global_ptr (p: Ptr): bool := (false = true)";
  std::string g_result = "Record GLOBALS :=\n" \
                         "  mkGLOBALS {\n";
  std::set<std::string> done_ids;
  
  for (llvm::GlobalVariable& globalVar : M.globals()) {
    if (globalVar.getName().startswith("llvm.")) continue;
    // if (globalVar.isConstant()) continue;
    auto gv_type = globalVar.getValueType();
    if (globalVar.isDeclaration()) continue;
    if (llvm::dyn_cast<llvm::FunctionType>(gv_type)) continue;
    if (!gv_type->isSized()) continue;
    std::string id = getGVIdentifier(&globalVar);
    if(done_ids.count(id) > 0){
      continue;
    } else{
      done_ids.insert(id);
    }
    int size = dl->getTypeAllocSize(gv_type);
    int page = ((size - 1) / page_size) + 1;
    page_count += page;
    gv_list.push_back(&globalVar);
    gv_addr[&globalVar] = std::make_pair(base, base + page_size * page);
    base += page_size * page;

    auto vty = globalVar.getValueType();
    this->named_global_ty[getGVIdentifier(&globalVar)] = globalVar.getValueType();
    is_global_ptr += "\\/\n\t\"" + getGVIdentifier(&globalVar).substr(2) + "\" =s p.(pbase)";
    // Pointers are not explicitly represented, but instead kept in a pointers field in order to mitigate long runtime from explicit modeling
    // Trying to create a smt query sort of like this
    // (declare-datatypes ((GLOBALS 0)) (((mkGLOBALS (pointers (Array Int (Array Int Int)))))))
    
    // Constant items don't need to be in RData, keep them out of the globals Record.
    if(globalVar.isConstant()){
      std::string new_decl = "Parameter " + getGVIdentifier(&globalVar) + ": " + generateField(globalVar.getValueType()) + ".\n";
      // auto arr_type = llvm::dyn_cast<llvm::ArrayType>(globalVar.getType());
      // if(arr_type){
      //   auto len = arr_type->getNumElements();
      // TODO: Use the length of a constant array to implement semantics for out of bounds access.
      // }
      g_result = new_decl + g_result;
    } else {
      g_result += "      " + getGVIdentifier(&globalVar) + ": " + generateField(globalVar.getValueType()) + ";\n";
    }

    if (vty->isIntegerTy() || vty->isPointerTy()) {
      g_load_result += 
      "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
      "      Some(" + getGVLoadStr(&globalVar) + ")) else\n";
      if(globalVar.isConstant()){
        // g_store_result += 
        // "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then None else\n";
      } else {
        g_store_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "      Some(" + getGVStoreStr(&globalVar) + " :< v)) else\n";
      }
      
    }
    else if (auto sty = llvm::dyn_cast<llvm::StructType>(vty)) {
      g_load_result += 
      "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
      "      when ret == load_" + getStructTypeIdentifier(sty) + " sz p.(poffset) " + \
        getGVLoadStr(&globalVar) + ";\n" \
      "      Some(ret)) else\n";
      
      if(globalVar.isConstant()){
        // g_store_result += 
        // "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then None else\n";
      } else {
        g_store_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "      when ret == store_" + getStructTypeIdentifier(sty) + " sz p.(poffset) v st.(globals).(" \
        + getGVIdentifier(&globalVar) + ");\n" \
        "      Some(" + getGVStoreStr(&globalVar) + " :< ret)) else\n";
      }
    }
    else if (auto aty = llvm::dyn_cast<llvm::ArrayType>(vty)) {
      auto ety = aty->getElementType();
      int element_size = dl->getTypeAllocSize(ety);
      if (ety->isIntegerTy() || ety->isPointerTy()) {
        g_load_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "      let idx := p.(poffset) / " + std::to_string(element_size) + " in \n"\
        "      let ptr := " + getGVLoadStr(&globalVar) + " @ idx in\n"\
        "      Some(ptr)) else\n";
        if (globalVar.isConstant()){
          // g_store_result += 
          // "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then None else\n";
        } else {
          g_store_result += 
          "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
          "      let idx := p.(poffset) / " + std::to_string(element_size) + " in \n"\
          "      let ptr := (" + getGVLoadStr(&globalVar) + " # idx == v) in\n"\
          "      Some(" + getGVStoreStr(&globalVar) + " :< ptr)) else\n";
        }
      } else if (auto sty = llvm::dyn_cast<llvm::StructType>(ety)) {
        // An array of structs, so we need to get the element, then use the struct load function
        g_load_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "       let idx := p.(poffset) / " + std::to_string(element_size) + " in\n" \
        "       let elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
        "       when ret == load_"+ getStructTypeIdentifier(sty) +" sz elem_ofs (" + getGVLoadStr(&globalVar) +\
        " @ idx);\n " \
        "       Some(ret)) else\n";
        if (globalVar.isConstant()){
        // g_store_result += 
        // "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then None else\n";
        } else {
        g_store_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "       let idx := p.(poffset) / " + std::to_string(element_size) + " in\n" \
        "       let elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
        "       when ret == (store_"+ getStructTypeIdentifier(sty) +" sz elem_ofs v " + getGVLoadStr(&globalVar) + " @ idx);\n " \
        "       Some(" + getGVStoreStr(&globalVar) + ":< " + "(st.(globals).(" + getGVIdentifier(&globalVar) + ") # idx == ret) )) else\n";
        }
      }
    } else {
      // llvm::errs() << "Cannot handle." << "\n";
    }
  }
  if(g_result.rfind(";")== std::string::npos) {
    g_result += "    __spoq_dummy_field: Z;";
  }
  g_result.erase(g_result.rfind(";"), 1);  // remove the last ;
  g_result += "    }.\n";
  fout << g_result 
    << "Record RData := mkRData {" \
    "\tstack: STACK;" \
    "\theap: MEM;" \
    "\tglobals: GLOBALS" \
    "}.\n"
    << is_global_ptr << ".\n"
    << "\nDefinition load_global (sz: Z) (p: Ptr) (st: RData) : (option Z) :=\n"
    << g_load_result 
    << "  None. (* load_global *)\n";
  fout << "\nDefinition store_global (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=\n"
   << g_store_result 
   << "  None. (* store_global *)\n\n";

  // llvm::errs() << "page: " << page_count << " " << "base:" << base << "\n";

  std::string result = generateGlobalBaseDefinition() + "\n" +
                       generateIntToPtr() + "\n" + generatePtrToInt() + "\n";
  fout << result;
  fillTypeElements(M);
  dumpMemTypInfo(M.getName().str() + ".memtypes.json", M);
}

char ExtractPointersPass::ID = 0;

static llvm::RegisterPass<ExtractPointersPass> X(
    "extractpointers", "Extract datatype and global objects",
    false,  // This pass doesn't modify the CFG => true
    false   // This pass is not a pure analysis pass => false
);
