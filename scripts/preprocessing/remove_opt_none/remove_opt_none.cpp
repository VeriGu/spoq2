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

class RMOptNonePass : public llvm::ModulePass {
 public:
  static char ID;
  const llvm::DataLayout* dl;
  llvm::LLVMContext* context;

  static const std::string debug_intrinsics[];

  std::map<llvm::Function*, int> useful;
  std::map<llvm::Function*, int> visited;
  std::vector<llvm::Function*> sources;

  void remove_opt_none(llvm::Module &M);
  RMOptNonePass() : ModulePass(ID) { }
  bool runOnModule(llvm::Module& M) override {
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

char RMOptNonePass::ID = 0;

static llvm::RegisterPass<RMOptNonePass> X(
    "rm_opt_none", "Remove the optnone attribute from all functions",
    false,  // This pass doesn't modify the CFG => true
    false   // This pass is not a pure analysis pass => false
);
