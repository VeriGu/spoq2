#include "llvm/IR/Type.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
// PassPlugin.h moved from llvm/Passes/ to llvm/Plugins/ in LLVM 23, and the
// plugin API version went from 1 to 2.  Including the old path silently picks
// up an older LLVM if one is installed under /usr/local.
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/IRBuilder.h"
#include <utility>
#include <string>
#include <vector>
#include <queue>
#include <map>
#include <fstream>
// using namespace llvm;
// static cl::opt<bool> MergeFunctionsPDI("mymergefunc-preserve-debug-info",
// cl::Hidden, cl::init(false), cl::desc("Preserve debug info in thunk when
// mergefunc "
//  "transformations are made."));

class CleanerPass : public llvm::PassInfoMixin<CleanerPass> {
 public:
  const llvm::DataLayout* dl;
  llvm::LLVMContext* context;

  static const std::string debug_intrinsics[];

  std::map<llvm::Function*, int> useful;
  std::map<llvm::Function*, int> visited;
  std::vector<llvm::Function*> sources;

  bool is_debug_intrinsic(llvm::StringRef fname);
  void dfs(llvm::Function* F, int block);
  void clean(llvm::Module &M);
  CleanerPass() { }
  llvm::PreservedAnalyses run(llvm::Module &M, llvm::ModuleAnalysisManager &) {
    runOnModule(M);
    return llvm::PreservedAnalyses::none();
  }
  static bool isRequired() { return true; }

  bool runOnModule(llvm::Module& M) {
    context = &M.getContext();
    dl = &M.getDataLayout();
    clean(M);
    return true;
  }
};

// YYY: modify this list to mannually replace some functions with dummy ones.
// YYY: only (integer, pointer, void) return type functions are supported for now.
// const std::string CleanerPass::debug_intrinsics[] = {"llvm.dbg", "printhex_ul", "print_string", "printf", "printf_", "printk", "printhex_ul_dbg", "print_string_dbg", "__debug_save_state", "__debug_restore_state", "_out_", "_debug",  "strlen", "_strnlen", "ticks_to_ns_time" };
const std::string CleanerPass::debug_intrinsics[] = {"llvm.dbg", "printhex_ul", "print_string", "printf", "printf_", "printk", "printhex_ul_dbg", "print_string_dbg", "__debug_save_state", "__debug_restore_state", "_out_", "_debug", "ticks_to_ns_time" };

void CleanerPass::dfs(llvm::Function* f, int block) {
  if (f->isDeclaration()) return;
  if (is_debug_intrinsic(f->getName())) block = 1;

  for (auto& b : *f) {
    for (auto& inst : b) {
      if (auto call = llvm::dyn_cast<llvm::CallInst>(&inst)) {
        if (llvm::Function* callee = call->getCalledFunction()) {
          if (!block && !is_debug_intrinsic(callee->getName()))
            useful[callee] = 1;
          if (!visited[callee]) { 
            visited[callee] = 1;
            dfs(callee, block);
          }
        }
      }
    }
  }
}

void CleanerPass::clean(llvm::Module& M) {
  for (auto &F: M) dfs(&F, 1);
  for (auto &F: M) if( !visited[&F] ) sources.push_back(&F);
  visited.clear();
  for (auto f: sources) {
    if (!is_debug_intrinsic(f->getName())) {
      useful[f] = 1;
      dfs(f, 0);
    }
  }
  for (auto& F : M) {
    if (!useful[&F] && !F.isDeclaration()) {
      auto rty = F.getReturnType();

      F.setLinkage(llvm::GlobalValue::LinkageTypes::InternalLinkage);
      if (rty->isVoidTy() || rty->isIntegerTy() || rty->isPointerTy()) {
        F.dropAllReferences();
        while (!F.empty()) F.begin()->eraseFromParent();
        llvm::BasicBlock* BB =
            llvm::BasicBlock::Create(F.getContext(), "entry", &F);
        llvm::IRBuilder<> builder(BB);
        if (rty->isVoidTy()) builder.CreateRetVoid();
        if (rty->isIntegerTy())
          builder.CreateRet(llvm::ConstantInt::get(rty, 0));
        if (rty->isPointerTy())
          builder.CreateRet(llvm::ConstantPointerNull::get(
              llvm::dyn_cast<llvm::PointerType>(rty)));
      }
    }
    std::vector<llvm::Instruction*> insts_to_drop;
    for( auto &bb : F) {
      for( llvm::Instruction& inst_ref: bb){
        auto inst = &inst_ref;
        if (inst && llvm::isa<llvm::CallInst>(inst)) {
          auto call_inst = llvm::dyn_cast<llvm::CallInst>(inst);
          auto target = call_inst->getCalledFunction();
          if (!target || !target->hasName()){
            continue;
          }
          auto name = target->getName();
          if(name.starts_with("llvm.lifetime")){
            insts_to_drop.push_back(inst);
          }
        }
      }
    }
    for (auto inst: insts_to_drop){
      inst->eraseFromParent();
    }
  }
}

bool CleanerPass::is_debug_intrinsic(llvm::StringRef fname) {
  for (auto l : debug_intrinsics) {
    if (fname.starts_with(l) || fname.ends_with(l)) return true;
  }
  return false;
}


// LLVM 17 dropped the legacy pass manager from opt, so the pass is exposed as a
// New PM plugin.  Run it with:
//   opt-17 --load-pass-plugin=<lib> -passes=cleaner ...
llvm::PassPluginLibraryInfo getCleanerPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "cleaner", LLVM_VERSION_STRING,
          [](llvm::PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](llvm::StringRef Name, llvm::ModulePassManager &MPM,
                   llvm::ArrayRef<llvm::PassBuilder::PipelineElement>) {
                  if (Name == "cleaner") {
                    MPM.addPass(CleanerPass());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getCleanerPassPluginInfo();
}
