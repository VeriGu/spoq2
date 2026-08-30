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
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/GlobalVariable.h"
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

class RMOptNonePass : public llvm::PassInfoMixin<RMOptNonePass> {
 public:
  const llvm::DataLayout* dl;
  llvm::LLVMContext* context;

  static const std::string debug_intrinsics[];

  std::map<llvm::Function*, int> useful;
  std::map<llvm::Function*, int> visited;
  std::vector<llvm::Function*> sources;

  void remove_opt_none(llvm::Module &M);
  RMOptNonePass() { }
  llvm::PreservedAnalyses run(llvm::Module &M, llvm::ModuleAnalysisManager &) {
    runOnModule(M);
    return llvm::PreservedAnalyses::none();
  }
  static bool isRequired() { return true; }

  bool runOnModule(llvm::Module& M) {
    context = &M.getContext();
    dl = &M.getDataLayout();
    remove_opt_none(M);
    return true;
  }
};

void RMOptNonePass::remove_opt_none(llvm::Module& M) {
    for (auto &F: M) {
        llvm::AttributeList attr_list = F.getAttributes();

        attr_list = attr_list.removeFnAttribute(F.getContext(), llvm::Attribute::AttrKind::OptimizeNone);
        F.setAttributes(attr_list);
    }
}


// LLVM 17 dropped the legacy pass manager from opt, so the pass is exposed as a
// New PM plugin.  Run it with:
//   opt-17 --load-pass-plugin=<lib> -passes=rm_opt_none ...
llvm::PassPluginLibraryInfo getRMOptNonePassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "rm_opt_none", LLVM_VERSION_STRING,
          [](llvm::PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](llvm::StringRef Name, llvm::ModulePassManager &MPM,
                   llvm::ArrayRef<llvm::PassBuilder::PipelineElement>) {
                  if (Name == "rm_opt_none") {
                    MPM.addPass(RMOptNonePass());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getRMOptNonePassPluginInfo();
}
