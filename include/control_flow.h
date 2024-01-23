#pragma once
#include <irtypes.h>
#include <irvalues.h>
#include <instructions.h>
#include <llvm.h>
#include <coq.h>

namespace autov::IRLoader
{
unique_ptr<vector<unique_ptr<IRInst>>> control_flow_conversion(ir_blocks_t *blocks);
} // namespace autov::IRLoader
