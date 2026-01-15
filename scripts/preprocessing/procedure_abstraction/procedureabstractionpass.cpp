#include "llvm/IR/Type.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/Transforms/Utils/FunctionComparator.h"
#include "llvm/Transforms/Utils/CodeExtractor.h"
#include "llvm/Transforms/IPO/IROutliner.h"
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

class ProcedureAbstractionPass : public llvm::ModulePass {
 public:
  static char ID;

  const llvm::DataLayout* dl;
  llvm::LLVMContext* context;
  ProcedureAbstractionPass() : ModulePass(ID) {
  }
  bool runOnModule(llvm::Module &M) override { 
    context = &M.getContext();
    dl = &M.getDataLayout();
    return true; 
  }
};


char ProcedureAbstractionPass::ID = 0;

static llvm::RegisterPass<ProcedureAbstractionPass> X(
    "renamepass", "Rename all externally accessible identifiers defined in this module.  Struct types, struct fields, functions, and global variables.",
    false,  // This pass doesn't modify the CFG => true
    false   // This pass is not a pure analysis pass => false
);
