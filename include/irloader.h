#include <string>
#include <map>
#include <unordered_map>
#include <memory>
#include <irtypes.h>
#include <irvalues.h>
#include <instructions.h>
#include <llvm.h>


namespace autov::IRLoader {
using std::string;
using std::unordered_map;
using std::shared_ptr;
using std::unique_ptr;

shared_ptr<IRModule> parse_module(ptree &module, bool postprocess = true);
}; // namespace autov::IRLoader
