#include <irtypes.h>
#include <irvalues.h>
#include <cstdlib>
#include <filesystem>

namespace autov::IRLoader
{
using std::string;
using std::filesystem::path;

const string aarch64_gcc = "aarch64-linux-gnu-gcc";
const string aarch64_objd = "aarch64-linux-gnu-objdump";
string getAutovHome() {
    const char* autov = std::getenv("AUTOV_HOME");
    if (!autov) {
        // AUTOV_HOME is not set
        return "";  // default value
    }
    return autov;
}

const string autov = getAutovHome();

} // namespace autov::IRLoader