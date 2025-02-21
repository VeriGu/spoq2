#include "SpoqIRLoader.h"

namespace autov {
std::set<string> SpoqIRModule::get_func_dependencies(llvm::Function *func) {
    std::set<string> s;
    if (func == nullptr)
        return s;
    for (auto &bb : *func) {
        for (auto &inst : bb) {
            if (auto call = llvm::dyn_cast<llvm::CallInst>(&inst)) {
                if (auto called = call->getCalledFunction()) {
                    s.insert(called->getName().str());
                }
            }
        }
    }
    return s;
}
} // namespace autov
