#include <boost/algorithm/string.hpp>
#include <string>
#include <vector>
#include <sstream>
#include <memory>
#include <utils.h>
#include <nodes.h>
#include <log.h>
#include <values.h>


namespace autov {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

vector<string> split(const string &s, char delimiter) {
    vector<string> tokens;
    string token;
    std::istringstream tokenStream(s);

    while (std::getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }

    return tokens;
}


string add_indent(const string s, int indent) {
    vector<string> ss = split(s, '\n');
    string result = "";

    for (int i = 0; i < ss.size(); i++) {
        result += string(indent, ' ') + ss[i] + "\n";
    }

    return result;
}

// string join_elems_semi_colon(const vector<Arg> &elems) {
//     std::ostringstream oss;

//     for (auto it = elems.begin(); it != elems.end(); it++) {
//         if (it != elems.begin()) {
//             oss << ";\n";
//         }
//         oss << string(*it);
//     }

//     return oss.str();
// }

string join_elems_semi_colon(const vector<shared_ptr<Arg>> &elems) {
    std::ostringstream oss;

    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << ";\n";
        }
        oss << string(**it);
    }

    return oss.str();
}

// string join_elems_space(const vector<Arg> &elems) {
//     std::ostringstream oss;
//     bool first = true;
//     for (auto it = elems.begin(); it != elems.end(); it++) {
//         if (it != elems.begin()) {
//             oss << " ";
//         }
//         oss << string(*it);
//     }

//     return oss.str();
// }

string join_elems_space(const vector<shared_ptr<Arg>> &elems) {
    std::ostringstream oss;
    bool first = true;
    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << " ";
        }
        oss << string(**it);
    }

    return oss.str();
}

string join_elems_space(const vector<std::unique_ptr<SpecNode>> &elems) {
    std::ostringstream oss;
    bool first = true;
    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << " ";
        }
        oss << string(**it);
    }

    return oss.str();
}

string join_constrs_pipe(const vector<IndConstr> &elems) {
    std::ostringstream oss;
    bool first = true;

    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << "\n|";
        }
        oss << string(*it);
    }

    return oss.str();
}

string join_constrs_pipe(const vector<shared_ptr<IndConstr>> &elems) {
    std::ostringstream oss;
    bool first = true;

    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << "\n|";
        }
        oss << string(**it);
    }

    return oss.str();
}

// string join_underline(const vector<SpecType> &elems) {
//     std::ostringstream oss;
//     bool first = true;

//     for (auto it = elems.begin(); it != elems.end(); it++) {
//         if (it != elems.begin()) {
//             oss << "_";
//         }
//         oss << string(*it);
//     }

//     return oss.str();
// }

string join_underline(const vector<shared_ptr<SpecType>> &elems) {
    std::ostringstream oss;
    bool first = true;

    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << "_";
        }
        oss << string(**it);
    }

    return oss.str();
}

} // namespace autov
