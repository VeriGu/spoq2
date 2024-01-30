#pragma once

#include <string>
#include <llvm.h>
#include <irtypes.h>

namespace autov::IRLoader {
using std::string;

class IASM {
public:
    string fname;
    string iasm;
    string c;
    string objdump;
    string coq;
};

IASM parse_inline_asm(string fname, string asm_text, shared_ptr<IRType> rettype, vector<unique_ptr<FuncArg>> &arglist, string constraints);

} // namespace autov::IRLoader