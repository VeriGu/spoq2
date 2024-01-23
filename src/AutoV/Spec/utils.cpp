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


string join_elems_space(const vector<unique_ptr<SpecNode>> &elems, int elem_indent) {
    std::ostringstream oss;
    bool first = true;
    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << "\n";
        }
        oss << add_indent(string(**it), elem_indent);
    }

    return oss.str();
}

string join_elems_space(const vector<unique_ptr<SpecNode>> &elems) {
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

string join_elems_comma(const vector<unique_ptr<SpecNode>> &elems, int elem_indent) {
    std::ostringstream oss;
    bool first = true;
    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << ",\n";
        }
        oss << add_indent(string(**it), elem_indent);
    }

    return oss.str();
}

string join_elems_comma1(const vector<unique_ptr<SpecNode>> &elems, int elem_indent) {
    std::ostringstream oss;
    bool first = true;
    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << "  ,\n";
        }
        oss << add_indent(string(**it), elem_indent);
    }

    return oss.str();
}

string join_elems_comma(const vector<unique_ptr<SpecNode>> &elems) {
    std::ostringstream oss;
    bool first = true;
    for (auto it = elems.begin(); it != elems.end(); it++) {
        if (it != elems.begin()) {
            oss << ", ";
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
