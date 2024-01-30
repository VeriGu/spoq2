#pragma once

#include <llvm.h>

namespace autov::IRLoader {
shared_ptr<IRModule> post_process(shared_ptr<IRModule> mod);
}; // namespace autov::IRLoader