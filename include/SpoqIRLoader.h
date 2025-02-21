#pragma once

#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <stdio.h>
#include <unordered_set>
#include <llvm/IR/Instructions.h>

#include "SpoqIR.h"
#include "SpoqIRModule.h"

namespace autov {
    class SpoqIRLoader {
    public:
        static void get_spoq_module(SpoqIRModule& spoq_module, unique_ptr<llvm::Module>& llvm_module);
    };

}