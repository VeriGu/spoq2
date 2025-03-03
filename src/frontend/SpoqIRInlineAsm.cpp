#include <irtypes.h>
#include <irvalues.h>
#include <cstdlib>
#include <filesystem>
#include <variant>
#include <inline_asm.h>
#include <iomanip>
#include <regex>
#include <fstream>
#include <cassert>
#include <numeric>

#include <SpoqIRModule.h>

namespace autov {

using std::string;
using std::filesystem::path;
using std::variant;

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
const string asmgen = path(autov) / "scripts" / "AsmGen" / "asmgen.native";

using type_str_t = variant<string, unique_ptr<vector<string>>>;

std::string SpoqIRModule::llvm_ir_type_to_str(llvm::Type* type, bool input) {
    if (type->isIntegerTy(1)) return "bool";
    else if (type->isIntegerTy(8))  return "u8";
    else if (type->isIntegerTy(16))  return "u16";
    else if (type->isIntegerTy(32))  return "u32";
    else if (type->isIntegerTy(64))  return "u64";
    else if (type->isIntegerTy()) throw std::runtime_error("Unsupported integer type: " + std::to_string(type->getIntegerBitWidth()));

    if (type->isPointerTy() && type->getPointerElementType()->isIntegerTy()) {
        return llvm_ir_type_to_str(type->getPointerElementType(), input) + "*";
    }

    if (type->isVoidTy()) return "void";

    llvm::errs() << "*type: " << *type << "\n";
    assert(false && "unsupported type for inline asm");

    // FIXME: support if (type->isStructTy())
}

static string construct_ret_struct(vector<string> &rettype) {
    string ret = "struct ret_st {\n";
    if (rettype.size() < 2)
        throw std::runtime_error("Struct return type must have at least 2 elements");

    for (int i = 0; i < rettype.size(); i++) {
        ret += "    " + rettype[i] + " out" + std::to_string(i) + ";\n";
    }

    ret += "};\n";
    return ret;
}

static string escape(const std::string& s) {
    std::string res;
    for (char c : s) {
        switch (c) {
            case '\\': res += "\\\\"; break;
            case '\n': res += "\\n"; break;
            case '\t': res += "\\t"; break;
            // ... add more escape sequences here
            default: res += c; break;
        }
    }
    return res;
}

SpoqIRIASM SpoqIRModule::parse_inline_asm(string fname, string asm_text, llvm::Type* rettype,
                      vector<llvm::Type*> &arglist, string constraints) {

    if (asm_text.find("pushsection") != string::npos) {
        throw std::runtime_error("pushsection is not supported");
    }

    if (asm_text == "") {
        std::cout << "asm_text is empty" << std::endl;
    }
    auto parsed_rettype = llvm_ir_type_to_str(rettype, false);
    auto args = make_unique<vector<std::string>>();
    string arg_str = "", ret_st = "";
    vector<string> vars;
    bool _first = true;

    for (auto &arg : arglist)
        args->push_back(llvm_ir_type_to_str(arg, true));

    for (int i = 0; i < args->size(); i++) {
        if (!_first)
            arg_str += ", ";
        else
            _first = false;
        arg_str += args->at(i) + " in" + std::to_string(i);
    }

    if (arg_str == "") arg_str = "void";

    for (int i = 0; i < args->size(); ++i) {
        vars.push_back("in" + std::to_string(i));
    }

    if (parsed_rettype != "void") { vars.insert(vars.begin(), "out"); }

    /* TODO: a more general format matching pattern. */
    for (size_t i = 0; i < vars.size(); ++i) {
        std::ostringstream old1, old2, old3, newStr;
        old1 << "$" << i;
        old2 << "${" << i << ":x}";
        old3 << "${" << i << ":w}";

        size_t pos = 0;
        while ((pos = asm_text.find(old1.str(), pos)) != std::string::npos) {
            newStr << "%" << i;
            asm_text.replace(pos, old1.str().length(), newStr.str());
            pos += newStr.str().length();
        }

        pos = 0;
        while ((pos = asm_text.find(old2.str(), pos)) != std::string::npos) {
            newStr << "%" << "x" << i;
            asm_text.replace(pos, old2.str().length(), newStr.str());
            pos += newStr.str().length();
        }

        pos = 0;
        while ((pos = asm_text.find(old3.str(), pos)) != std::string::npos) {
            newStr << "%" << "w"  << i;
            asm_text.replace(pos, old3.str().length(), newStr.str());
            pos += newStr.str().length();
        }
    }

    asm_text = escape(asm_text);
    size_t pos = 0;
    while((pos = asm_text.find("\"", pos)) != std::string::npos) {
        asm_text.replace(pos, 1, "\\\"");
        pos += 2; // Move past the inserted characters
    }
    asm_text = "\"" + asm_text + "\"";

    SpoqIRIASM ret = SpoqIRIASM(fname, asm_text, "", "", "");

    if (asm_text.find("stxr") != string::npos) {
        LOG_WARNING << "stxr is not supported";
        return ret;
    }

    vector<string> cons;

    std::stringstream ss(constraints);
    string token;

    while (std::getline(ss, token, ',')) {
        cons.push_back(token);
    }

    vector<string> out_cons, in_cons, out_reg_cons;
    string out_cons_text, in_cons_text, cons_text;
    int out_cons_as_reg_cnt = 0, out_cons_as_arg_cnt = 0, in_cons_cnt = 0;
    const static std::regex r("[rwx](\\d)");

    /* both out-/in-oprand consumes args (in0/in1/...)
        record the next to-be-consumed arg N */
    int args_curr = 0; 

    for (auto &c : cons) {
        std::smatch x;
        std::regex_search(c, x, r);

        if (c[0] == '=') {
            if (c.size() > 2 && c[1] == '*') {
                /* out-constraint write to address of arg, consume 1 arg */
                out_cons_as_arg_cnt += 1;
                out_cons.push_back("=" + c.substr(2));
                out_cons_text += "\"=" + c.substr(2) + "\" (*in" + std::to_string(args_curr) + "),";
                args_curr += 1;
            } else {
                /* ut-constraint write to reg, does not consume args */
                if (!x.empty()) {
                    std::string cc;
                    for (char ch : c) {
                        if (std::string("{}=0123456789").find(ch) == std::string::npos) {
                            cc += ch;
                        }
                    }
                    out_cons.push_back(cc);
                    out_reg_cons.push_back(x[0]);
                } else {
                    out_cons.push_back(c.substr(1));
                }
                if (ret_st != "") {
                    out_cons_text += "\"" + c + "\" (out.out" + std::to_string(out_cons_as_reg_cnt) + "),";
                } else {
                    out_cons_text += "\"" + c + "\" (out),";
                }
                out_cons_as_reg_cnt += 1;
            }
        } else if (c[0] == '~') {
            continue;
        } else {
            if (!x.empty()) {
                in_cons.push_back(c.substr(1, c.size() - 2));
                if (in_cons_cnt > 8) {
                    throw std::runtime_error("Too many input registers for inline asm");
                }
            } else {
                in_cons.push_back(c);
            }
            in_cons_text += "\"" + c + "\" (in" + std::to_string(args_curr) + "),";
            in_cons_cnt += 1;
            args_curr += 1;
        }
    }

    if (in_cons_cnt + out_cons_as_arg_cnt != arglist.size()) {
        throw std::runtime_error("Inline asm constraints does not match arguments(maybe unsupported constraint?)");
    }
    auto str_rettype = parsed_rettype;

    // Strip the last comma
    if (out_cons.size() > 0)
        out_cons_text.pop_back();
    if (in_cons.size() > 0)
        in_cons_text.pop_back();

    cons_text = ": " + out_cons_text + " : " + in_cons_text;

    std::ofstream f(fname + ".c");
    f << "#include <stdbool.h>\n";
    f << "typedef unsigned long long u64;\n";
    f << "typedef unsigned u32;\n";
    f << "typedef unsigned char u8;\n";
    f << "\n";
    if (!ret_st.empty()) {
        f << ret_st;
        f << "struct ret_st " << fname << "(" << arg_str << ")\n";
    } else {
        f << str_rettype << " " << fname << "(" << arg_str << ")\n";
    }
    f << "{\n";

    // Output as return value
    if (str_rettype != "void") {
        if (!ret_st.empty()) {
            // Multiple outputs are returned as a struct
            f << "    struct ret_st out;\n";
        } else {
            f << "    " << str_rettype << " out;\n";
        }
    }

    f << "    asm volatile(" << asm_text << cons_text << ");\n";
    if (str_rettype != "void") {
        f << "    return out;\n";
    }
    f << "}\n";

    f.close();


    std::ifstream c_file(fname + ".c");
    ret.c = string((std::istreambuf_iterator<char>(c_file)),
                    std::istreambuf_iterator<char>());

    bool failed = false;

    std::system((aarch64_gcc + " -O2 -c " + cross_compile_param + fname + ".c 2> /dev/null").c_str());
    std::system((aarch64_objd + " -d " + fname + ".o > " + fname + "_objdump  2> /dev/null").c_str());

    if (std::filesystem::exists(fname + "_objdump")) {
        std::ifstream f(fname + "_objdump");
        vector<string> lines;
        string line;

        while (std::getline(f, line))
            lines.push_back(line + "\n");

        if (lines.size() > 6) {
            string objd = lines[6];

            for (auto it = lines.begin() + 7; it != lines.end(); ++it) {
                vector<string> tk;
                std::istringstream iss(*it);
                bool _first = true;

                for(std::string s; std::getline(iss, s, '\t'); )
                    tk.push_back(s);
                for (auto t = tk.begin() + 2; t != tk.end(); ++t) {
                    if (!_first)
                        objd += "\t";
                    else
                        _first = false;
                    objd += *t;
                }

                if (it->find("ret") != string::npos)
                    break;
            }
            ret.objdump = objd;
            std::ofstream out(fname + "_objdump");
            out << objd;
            out.close();
            std::system((asmgen + " < " + fname + "_objdump > " + fname + ".v  2> /dev/null").c_str());
            std::ifstream coq_file(fname + ".v");
            string coq((std::istreambuf_iterator<char>(coq_file)),
                    std::istreambuf_iterator<char>());
            std::istringstream iss(coq);
            iss >> std::ws;
            std::getline(iss, coq, '\0');
            coq.erase(std::find_if(coq.rbegin(), coq.rend(), [](unsigned char ch) {
                return !std::isspace(ch);
            }).base(), coq.end());
            coq = coq.empty() ? "" : coq;
            ret.coq = coq;
        } else {
            failed = true;
        }
    }

    if (std::filesystem::exists(fname + ".c"))
        std::system(("rm " + fname + ".c").c_str());
    if (std::filesystem::exists(fname + ".o"))
        std::system(("rm " + fname + ".o").c_str());
    if (std::filesystem::exists(fname + "_objdump"))
        std::system(("rm " + fname + "_objdump").c_str());
    if (std::filesystem::exists(fname + ".v"))
        std::system(("rm " + fname + ".v").c_str());

    if (failed)
        throw std::runtime_error("Failed to compile iasm");

    return ret;
}

} // namespace autov