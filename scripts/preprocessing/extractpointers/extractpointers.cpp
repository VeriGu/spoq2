#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
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

  std::string stack_load_rdata;
  std::string stack_store_rdata;

  int type_id = 0;
  std::map<llvm::Type*, std::string> unique_type_name;
  std::string getTypeIdentifier(llvm::Type*);
  std::string generateField(llvm::Type*);
  std::string getStackIdentifier(llvm::Type* ty, int id) {
    if( id == 0 ) return "stack_" + getTypeIdentifier(ty);
    return "stack_" + getTypeIdentifier(ty) + "__" + std::to_string(id);
  }
  std::string getGVIdentifier(llvm::Value* v) {
    std::string name = "g_" + v->getName().str();
    std::replace(name.begin(), name.end(), '.', '_');
    std::replace(name.begin(), name.end(), ':', '_');
    return name;
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
  void collectStack(llvm::Module &M);
  std::map<llvm::Type*, int> dfsStack(llvm::Function* func, std::vector<llvm::Function*>& vec);
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
  }
  else {
    name = "s_" + sty->getName().str().substr(7);
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
      } else if(ety->isStructTy()) {
        return "(ZMap.t " + getStructTypeIdentifier(llvm::dyn_cast<llvm::StructType>(ety)) + ")";
      } else {
        return "None (* FIXME: nd array *)";
      }
    }
    default: {
      return "None";
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

void ExtractPointersPass::collectStack(llvm::Module &M) {
  std::map<llvm::Function*, int> has_pre;
  int passed_count = 0, local_count = 0;
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

  std::string result = "Record STACK :=\n"\
  " mkSTACK {\n";
  std::string load_result = "";
  std::string store_result = "";

  int sum = 0;
  for (auto &x : sn) {
    sum += x.second;
    for (int num = 0; num < x.second; num++) { 
      result += "    " + getStackIdentifier(x.first, num) + ": " + generateField(x.first) + ";\n";
      if (x.first->isIntegerTy() || x.first->isPointerTy()) {
        load_result += 
        "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
        "      Some(st.(stack).(" + getStackIdentifier(x.first, num) + "), st)) else\n";

        store_result += 
        "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
        "      Some(st.[stack].[" + getStackIdentifier(x.first, num) + "] :< v)) else\n";
      }
      else if (auto sty = llvm::dyn_cast<llvm::StructType>(x.first)) {
        load_result += 
        "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
        "      when ret == load_" + getStructTypeIdentifier(sty) + " sz p.(poffset) st.(stack).(" \
        + getStackIdentifier(x.first, num) + ");\n" \
        "      Some(ret, st)) else\n";

        store_result += 
        "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
        "      when ret == store_" + getStructTypeIdentifier(sty) + " sz p.(poffset) v st.(stack).(" \
        + getStackIdentifier(x.first, num) + ");\n" \
        "      Some(st.[stack].[" + getStackIdentifier(x.first, num) + "] :< ret)) else\n";
      }
      else if (auto aty = llvm::dyn_cast<llvm::ArrayType>(x.first)) {
        auto ety = aty->getElementType();
        int element_size = dl->getTypeAllocSize(ety);
        if (ety->isIntegerTy() || ety->isPointerTy()) {
          load_result += 
          "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
          "      let idx := p.(poffset) / " + std::to_string(element_size) + " in \n"\
          "      let ptr := st.(stack).(" + getStackIdentifier(x.first, num) + ") @ idx in\n"\
          "      Some(ptr, st)) else\n";

          store_result += 
          "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
          "      let idx := p.(poffset) / " + std::to_string(element_size) + " in \n"\
          "      let ptr := (st.(stack).(" + getStackIdentifier(x.first, num) + ") # idx == v) in\n"\
          "      Some(st.[stack].[" +  getStackIdentifier(x.first, num) + "] :< ptr)) else\n";
        } else if (auto sty = llvm::dyn_cast<llvm::StructType>(ety)) {
          load_result += 
          "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
          "       let idx := p.(poffset) / " + std::to_string(element_size) + " in\n" \
          "       let elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
          "       when ret == load_"+ getStructTypeIdentifier(sty) +" sz elem_ofs (st.(stack).(" \
          + getStackIdentifier(x.first, num) + ") @ idx);\n " \
          "       Some(ret, st)) else\n";

          store_result += 
          "  if (p.(pbase) =s \"" + getStackIdentifier(x.first, num) + "\") then (\n" \
          "       let idx := p.(poffset) / " + std::to_string(element_size) + " in\n" \
          "       let elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
          "       when ret == store_"+ getStructTypeIdentifier(sty) +" sz elem_ofs v (st.(stack).(" \
          + getStackIdentifier(x.first, num) + ") @ idx);\n " \
          "       Some(st.[stack].[" + getStackIdentifier(x.first, num) + "] :< (st.(stack).(" + getStackIdentifier(x.first, num) + ") # idx == ret))) else\n";
        }
      } else {
        // llvm::errs() << "Cannot handle." << "\n";
      }
    }
  }
  result.erase(result.rfind(";"), 1);  // remove the last ;
  result += "    }.\n";
  stack_load_rdata = load_result;
  stack_store_rdata = store_result;

  fout << result 
    << "\n(* Definition load_stack (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=\n" 
    << load_result 
    << "  None.\n*) (* load_stack *)\n";
  fout << "\n(* Definition store_stack (sz: Z) (p: Ptr) (v: z) (st: RData) : option RData :=\n" 
    << store_result 
    << "None.\n*) (* store_stack *)\n";

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
  std::string g_result = "Record GLOBALS :=\n" \
                         "  mkGLOBALS {\n";
  for (llvm::GlobalVariable& globalVar : M.globals()) {
    if (globalVar.getName().startswith("llvm.")) continue;
    if (globalVar.isConstant()) continue;
    auto gv_type = globalVar.getValueType();
    if (globalVar.isDeclaration()) continue;
    if (llvm::dyn_cast<llvm::FunctionType>(gv_type)) continue;
    if (!gv_type->isSized()) continue;
    int size = dl->getTypeAllocSize(gv_type);
    int page = ((size - 1) / page_size) + 1;
    page_count += page;
    gv_list.push_back(&globalVar);
    gv_addr[&globalVar] = std::make_pair(base, base + page_size * page);
    base += page_size * page;

    auto vty = globalVar.getValueType();

    g_result += "      " + getGVIdentifier(&globalVar) + ": " + generateField(globalVar.getValueType()) + ";\n";
    if (vty->isIntegerTy() || vty->isPointerTy()) {
      g_load_result += 
      "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
      "      Some(st.(share).(globals).(" + getGVIdentifier(&globalVar) + "), st)) else\n";

      g_store_result += 
      "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
      "      Some(st.[share].[globals].[" + getGVIdentifier(&globalVar) + "] :< v)) else\n";
    }
    else if (auto sty = llvm::dyn_cast<llvm::StructType>(vty)) {
      g_load_result += 
      "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
      "      when ret == load_" + getStructTypeIdentifier(sty) + " sz p.(poffset) st.(share).(globals).(" \
      + getGVIdentifier(&globalVar) + ");\n" \
      "      Some(ret, st)) else\n";

      g_store_result += 
      "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
      "      when ret == store_" + getStructTypeIdentifier(sty) + " sz p.(poffset) v st.(share).(globals).(" \
      + getGVIdentifier(&globalVar) + ");\n" \
      "      Some(st.[share].[globals].[" + getGVIdentifier(&globalVar) + "] :< ret)) else\n";
    }
    else if (auto aty = llvm::dyn_cast<llvm::ArrayType>(vty)) {
      auto ety = aty->getElementType();
      int element_size = dl->getTypeAllocSize(ety);
      if (ety->isIntegerTy() || ety->isPointerTy()) {
        g_load_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "      let idx := p.(poffset) / " + std::to_string(element_size) + " in \n"\
        "      let ptr := st.(share).(globals).(" + getGVIdentifier(&globalVar) + ") @ idx in\n"\
        "      Some(ptr, st)) else\n";

        g_store_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "      let idx := p.(poffset) / " + std::to_string(element_size) + " in \n"\
        "      let ptr := (st.(share).(globals).(" + getGVIdentifier(&globalVar) + ") # idx == v) in\n"\
        "      Some(st.[share].[globals].[" +  getGVIdentifier(&globalVar) + "] :< ptr)) else\n";
      } else if (auto sty = llvm::dyn_cast<llvm::StructType>(ety)) {
        g_load_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "       let idx := p.(poffset) / " + std::to_string(element_size) + " in\n" \
        "       let elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
        "       when ret == load_"+ getStructTypeIdentifier(sty) +" sz elem_ofs (st.(share).(globals).(" \
        + getGVIdentifier(&globalVar) + ") @ idx);\n " \
        "       Some(ret, st)) else\n";

        g_store_result += 
        "  if (p.(pbase) =s \"" + getGVIdentifier(&globalVar).substr(2) + "\") then (\n" \
        "       let idx := p.(poffset) / " + std::to_string(element_size) + " in\n" \
        "       let elem_ofs := p.(poffset) mod " + std::to_string(element_size) + " in\n" \
        "       when ret == store_"+ getStructTypeIdentifier(sty) +" sz elem_ofs v (st.(share).(globals).(" \
        + getGVIdentifier(&globalVar) + ") @ idx);\n " \
        "       Some(st.[share].[globals].[" + getGVIdentifier(&globalVar) + "] :< " + "(st.(share).(globals).(" + getGVIdentifier(&globalVar) + ") # idx == ret) )) else\n";
      }
    } else {
      // llvm::errs() << "Cannot handle." << "\n";
    }
  }
  g_result.erase(g_result.rfind(";"), 1);  // remove the last ;
  g_result += "    }.\n";
  fout << g_result 
    << "\n(* Definition load_RData (sz: Z) (p: Ptr) (st: RData) : (option (Z * RData)) :=\n"
    << g_load_result 
    << "  None."
    << "\n*) (* load_RData *)\n";
  fout << "\n(* Definition store_RData (sz: Z) (p: Ptr) (v: Z) (st: RData) : option RData :=\n"
   << g_store_result 
   << "  None."
   << "\n*) (* store_RData *)\n\n";

  // llvm::errs() << "page: " << page_count << " " << "base:" << base << "\n";

  std::string result = generateGlobalBaseDefinition() + "\n" +
                       generateIntToPtr() + "\n" + generatePtrToInt() + "\n";
  fout << result;
}

char ExtractPointersPass::ID = 0;

static llvm::RegisterPass<ExtractPointersPass> X(
    "extractpointers", "Extract datatype and global objects",
    false,  // This pass doesn't modify the CFG => true
    false   // This pass is not a pure analysis pass => false
);
