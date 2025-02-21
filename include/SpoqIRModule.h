#pragma once

#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <stdio.h>
#include <unordered_set>
#include <llvm/IR/Instructions.h>

#include "SpoqIR.h"

namespace autov {
    class SpoqIRModule { 
    public:
        static std::set<string> get_func_dependencies(llvm::Function* func);

    };
}