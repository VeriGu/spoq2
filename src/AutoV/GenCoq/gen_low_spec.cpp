#include <boost/filesystem.hpp>
#include <filesystem>
#include <gen_low_spec.h>

namespace fs = std::filesystem;
namespace autov
{

void gen_low_spec(Project *proj, int i, string fname, string path)
{
    std::ofstream out(path);

    auto loc = loc_t(proj->layers.at(i)->name, fname, "LowSpec");
    vector<string> syms;
    for (auto const &[s, v] : proj->symbols) {
        if (v.loc == loc) {
            syms.push_back(s);
        }
    }

    sort(syms.begin(), syms.end(),
         [proj](string s1, string s2) { return proj->symbols[s1].order < proj->symbols[s2].order; });
    std::set<string> deps = {"CommonDeps", "Code", "DataTypes", "GlobalDefs"};
    for (auto s : syms) {
        if (proj->deps.find(s) == proj->deps.end()) continue;
        for (auto d : proj->deps[s]) {
            if (proj->symbols[d].loc == loc) continue;
            if (proj->symbols[d].loc == loc_t("", "", "")) continue;
            string l = std::get<0>(proj->symbols[d].loc);
            if (std::get<1>(proj->symbols[d].loc) != "") {
                l += "." + std::get<1>(proj->symbols[d].loc);
            }
            if (std::get<2>(proj->symbols[d].loc) != "") {
                l += "." + std::get<2>(proj->symbols[d].loc);
            }
            deps.insert(l);
        }
    }

    for (auto d : deps) {
        out << "Require Import " + d + ".\n";
    }

    out << "\n";
    out << "Local Open Scope string_scope.\n";
    out << "Local Open Scope Z_scope.\n";
    out << "\n";

    for (auto s : syms) {
        if (proj->symbols[s].kind == SymbolKind::Decl) out << string(*proj->decls[s]) + "\n\n";
    }

    out << "Section " + std::get<0>(loc);
    if (std::get<1>(loc) != "") {
        out << "_" + std::get<1>(loc);
    }
    if (std::get<2>(loc) != "") {
        out << "_" + std::get<2>(loc);
    }
    out << ".\n";

    out << "\n";
    out << "  Context `{int_ptr: IntPtrCast}.\n";
    out << "\n";

    for (auto s : syms) {
        if (proj->symbols[s].kind == SymbolKind::Def) {
            out << add_indent(string(*proj->defs[s]), 2) + "\n\n";
        }
    }
    out << "End " + std::get<0>(loc);

    if (std::get<1>(loc) != "") {
        out << "_" + std::get<1>(loc);
    }
    if (std::get<2>(loc) != "") {
        out << "_" + std::get<2>(loc);
    }

    out << ".\n\n";
    for (auto s : syms) {
        if (proj->symbols[s].kind == SymbolKind::Def) {
            if (proj->cmds.NoUnfold.find(s) == proj->cmds.NoUnfold.end())
                out << "#[global] Hint Unfold " + s + ": spec.\n";
        }
    }
    out.close();
}

unique_ptr<vector<string>> generate_low_spec(Project *proj)
{
    auto files = unique_ptr<vector<string>>(new vector<string>());

    int i = 0;
    for (auto const &L : proj->layers) {
        if (i == 0 || L->dummy) {
            i++;
            continue;
        }

        boost::filesystem::path dir(proj->base);
        boost::filesystem::path layer_name(L->name);
        if (!fs::exists((dir / L->name).string())) fs::create_directory((dir / L->name).string());
        for (auto const &p : L->prims) {
            if (!fs::exists((dir / L->name / p).string())) fs::create_directory((dir / L->name / p).string());
            gen_low_spec(proj, i, p, (dir / L->name / p / "LowSpec.v").string());
            files->push_back((layer_name / p / "LowSpec.v").string());
        }
        i++;
    }
    return files;
}
}