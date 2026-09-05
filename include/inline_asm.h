#pragma once

#include <string>
#include <utility>
#include <llvm.h>
#include <irtypes.h>

namespace autov::IRLoader {
using std::string;

static string cross_compile_param = " -march=armv8.4-a ";
class IASM {
public:
    string fname;
    string iasm;
    string c;
    string objdump;
    string coq;

    IASM(string fname, string iasm, string c, string objdump, string coq) :
        fname(std::move(fname)), iasm(std::move(iasm)), c(std::move(c)), objdump(std::move(objdump)), coq(std::move(coq)) {}

    IASM() = default;
};

IASM parse_inline_asm(const string& fname, string asm_text, const shared_ptr<IRType>& rettype,
                      vector<unique_ptr<FuncArg>> &arglist, const string& constraints);

} // namespace autov::IRLoader


namespace autov {
    using std::string;
    
    static string cross_compile_param = " -march=armv8.4-a ";
    class SpoqIRIASM {
    public:
        string fname;
        string iasm;
        string c;
        string objdump;
        string coq;
    
        SpoqIRIASM(string fname, string iasm, string c, string objdump, string coq) :
            fname(std::move(fname)), iasm(std::move(iasm)), c(std::move(c)), objdump(std::move(objdump)), coq(std::move(coq)) {}
    
        SpoqIRIASM() = default;
    };
    
}; // namespace autov