#include <instructions.h>
#include <llvm.h>
#include <values.h>
#include <irtypes.h>
#include <project.h>

namespace autov {
using IRLoader::IRModule;
using autov::Project;

void print_module(IRModule *ir, const std::string& out_path);
unique_ptr<vector<string>> generate_code(Project *p);
}