#include <boost/filesystem.hpp>
#include <gen_data.h>

namespace autov
{
using autov::join;

void rec_update(std::ofstream &fout, Project *p, shared_ptr<autov::Struct> init, vector<string> &fields,
                shared_ptr<autov::SpecType> cur)
{
    if (fields.size() >= 2) {
        string update =
            "Definition update_" + init->name + "_" + join(fields, "_") + "(_a: " + init->name + ") _b :=\n";
        vector<string> acc_fields;
        for (auto it = fields.begin(); it != fields.end() - 1; ++it) {
            acc_fields.push_back(".(" + *it + ")");
        }
        string elem = "_a" + join(acc_fields, "");

        update += "  update_" + init->name + "_" + join(fields.begin(), fields.end() - 1, "_") + " _a ((" + elem +
                  ").[" + fields.at(fields.size() - 1) + "] :< _b).\n";

        vector<string> temp;
        for (auto f : fields) {
            temp.push_back(".[" + f + "]");
        }
        string notation = "\"_a '" + join(temp, "") + "' ':<' _b\"";

        update += "Notation " + notation + " := (update_" + init->name + "_" + join(fields, "_") +
                  " _a _b) (at level 1).\n\n";

        fout << update;
    }

    if (auto f = dynamic_cast<autov::Struct *>(cur.get())) {
        for (auto e : *f->elems) {
            fields.push_back(e->name);
            rec_update(fout, p, init, fields, e->type);

            // backtrack instead of creating a new list
            fields.pop_back();
        }
    }
}

unique_ptr<vector<string>> generate_data(Project *p)
{
    string f = "DataTypes.v";

    boost::filesystem::path dir(p->base);
    boost::filesystem::path file(f);
    std::ofstream fout((dir / file).string());

    fout << "Require Import CommonDeps.\n\n";
    fout << "Local Open Scope Z_scope.\n\n";

    vector<string> outputs;
    for (auto const &[key, value] : p->symbols) {
        if (key != "Ptr" && std::get<0>(p->symbols[key].loc) == "DataTypes") {
            outputs.push_back(key);
        }
    }

    sort(outputs.begin(), outputs.end(), [p](string x, string y) { return p->symbols[x].order < p->symbols[y].order; });

    for (auto s : outputs) {
        if (p->structs.find(s) != p->structs.end()) {
            fout << p->structs[s]->define();
            fout << "\n\n";
        } else if (p->indtypes.find(s) != p->indtypes.end()) {
            fout << p->indtypes[s]->define();
            fout << "\n\n";
        } else if (p->typedefs.find(s) != p->typedefs.end()) {
            fout << "Definition " + s + ": Type :=" << string(*p->typedefs[s]) << ".";
            fout << "\n\n";
        }
    }

    for (auto s : outputs) {
        if (p->structs.find(s) != p->structs.end()) {
            vector<string> fields;
            for (auto const &elem : *p->structs[s]->elems) {
                fields.push_back(elem->name);
            }
            for (auto name : fields) {
                string update = "Definition update_" + s + "_" + name + "(_a: " + s + ") _b :=\n  mk" + s;
                for (auto i = 0; i < fields.size(); i++) {
                    if (fields[i] == name) {
                        update += " _b";
                    } else {
                        update += " (_a.(" + fields[i] + "))";
                    }
                    if (i < fields.size() - 1 && (i + 1) % 8 == 0) {
                        update += "\n";
                    }
                }
                update += ".\n";
                update += "Notation \"_a '.[" + name + "]' ':<' _b\" := (update_" + s + "_" + name +
                          " _a _b) (at level 1).\n\n";
                fout << update;
            }
        }
    }

    for (auto s : outputs) {
        if (p->structs.find(s) != p->structs.end()) {
            vector<string> fields;
            rec_update(fout, p, p->structs[s], fields, p->structs[s]);
        }
    }

    fout.close();
    auto files = unique_ptr<vector<string>>(new vector<string>({f}));
    return files;
}
}