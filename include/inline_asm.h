#pragma once

#include <string>

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
} // namespace autov::IRLoader