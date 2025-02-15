#include <boost/filesystem.hpp>
#include <boost/range/algorithm/set_algorithm.hpp>
#include <filesystem>
#include <gen_layer.h>

namespace fs = std::filesystem;

namespace autov
{

void gen_layer_refine_rel(Project *proj, int i, string path)
{
    std::ofstream out(path);

    auto const &layer = proj->layers.at(i);
    auto const &base_layer = proj->layers.at(i - 1);

    vector<string> deps = {"CommonDeps", "DataTypes"};
    for (auto d : deps) {
        out << "Require Import " + d + ".\n";
    }

    out << "\n";
    out << "Definition refrel (hst: " + string(*layer->abs_data) + ") (lst: " + string(*base_layer->abs_data) +
               ") : Prop := hst = lst.\n";
    out.close();
}

void gen_layer(Project *proj, int i, string path)
{
    std::ofstream out(path);
    auto const &layer = proj->layers.at(i);

    std::set<string> ps;
    std::set_union(layer->prims.begin(), layer->prims.end(), layer->passthrough.begin(), layer->passthrough.end(),
                   std::inserter(ps, ps.end()));

    std::set<string> deps;
    deps = {"CommonDeps", "DataTypes"};

    for (auto p : ps) {
        auto spec = p + "_spec";
        auto loc = proj->symbols[spec].loc;
        string l = std::get<0>(loc);
        if (std::get<1>(loc) != "") {
            l += "." + std::get<1>(loc);
        }

        if (std::get<2>(loc) != "") {
            l += "." + std::get<2>(loc);
        }

        deps.insert(l);
    }

    for (auto const &[op, v] : layer->ops) {
        auto loc = proj->symbols[v].loc;
        string l = std::get<0>(loc);
        if (std::get<1>(loc) != "") {
            l += "." + std::get<1>(loc);
        }

        if (std::get<2>(loc) != "") {
            l += "." + std::get<2>(loc);
        }

        deps.insert(l);
    }

    for (auto d : deps) {
        if (d == "") continue;
        out << "Require Import " + d + ".\n";
    }
    out << "\n";

    out << "Local Open Scope string_scope.\n";
    out << "Local Open Scope Z_scope.\n";
    out << std::endl;

    string dinit;
    if (layer->ops.find("init") != layer->ops.end()) {
        dinit = layer->ops["init"];
    } else {
        out << "Parameter " + layer->name + "_init: " + string(*layer->abs_data) + ".\n";
        out << "\n";
        dinit = layer->name + "_init";
    }

    out << "Section " + layer->name + "_Layer.\n";
    out << "\n";
    out << "  Context `{int_ptr: IntPtrCast}.\n";
    out << "\n";

    string fload, fstore, fnewframe, falloc, ffree, fgetreg, fsetreg, fgetflag, fsetflag, fptr2int, fint2ptr, fptreqb,
        fptrltb, fptrgtb;

    if (layer->ops.find("load") != layer->ops.end()) {
        fload = layer->ops["load"];
    } else {
        out << "  Definition " + layer->name + "_load (size: Z) (p: Ptr) (st: " + string(*layer->abs_data) +
                   ") : option (Z * " + string(*layer->abs_data) + ") := None.\n";
        out << "\n";
        fload = layer->name + "_load";
    }

    if (layer->ops.find("store") != layer->ops.end()) {
        fstore = layer->ops["store"];
    } else {
        out << "  Definition " + layer->name + "_store (size: Z) (p: Ptr) (val: Z) (st: " + string(*layer->abs_data) +
                   ") : option " + string(*layer->abs_data) + " := None.\n";
        out << "\n";
        fstore = layer->name + "_store";
    }

    if (layer->ops.find("new_frame") != layer->ops.end()) {
        fnewframe = layer->ops["new_frame"];
    } else {
        out << "  Definition " + layer->name + "_newframe (fname: string) (st: " + string(*layer->abs_data) +
                   ") : option (" + string(*layer->abs_data) + ") := None.\n";
        out << "\n";
        fnewframe = layer->name + "_newframe";
    }

    if (layer->ops.find("alloc") != layer->ops.end()) {
        falloc = layer->ops["alloc"];
    } else {
        out << "  Definition " + layer->name +
                   "_alloca (fname: string) (size: Z) (align: Z) (st: " + string(*layer->abs_data) +
                   ") : option (Ptr * " + string(*layer->abs_data) + ") := None.\n";
        out << "\n";
        falloc = layer->name + "_alloca";
    }

    if (layer->ops.find("free") != layer->ops.end()) {
        ffree = layer->ops["free"];
    } else {
        out << "  Definition " + layer->name + "_free (fname: string) (init_st: " + string(*layer->abs_data) +
                   ") (st: " + string(*layer->abs_data) + ") : option " + string(*layer->abs_data) + " := None.\n";
        out << "\n";
        ffree = layer->name + "_free";
    }

    if (layer->ops.find("get_reg") != layer->ops.end()) {
        fgetreg = layer->ops["get_reg"];
    } else {
        out << "  Definition " + layer->name + "_get_reg (reg: regset) (st: " + string(*layer->abs_data) +
                   ") : option Z := None.\n";
        out << "\n";
        fgetreg = layer->name + "_get_reg";
    }

    if (layer->ops.find("set_reg") != layer->ops.end()) {
        fsetreg = layer->ops["set_reg"];
    } else {
        out << "  Definition " + layer->name + "_set_reg (reg: regset) (val: Z) (st: " + string(*layer->abs_data) +
                   ") : option " + string(*layer->abs_data) + " := None.\n";
        out << "\n";
        fsetreg = layer->name + "_set_reg";
    }

    if (layer->ops.find("get_flag") != layer->ops.end()) {
        fgetflag = layer->ops["get_flag"];
    } else {
        out << "  Definition " + layer->name + "_get_flag (f: flag) (st: " + string(*layer->abs_data) +
                   ") : bool := false.\n";
        out << "\n";
        fgetflag = layer->name + "_get_flag";
    }

    if (layer->ops.find("set_flag") != layer->ops.end()) {
        fsetflag = layer->ops["set_flag"];
    } else {
        out << "  Definition " + layer->name + "_set_flag (f: flag) (val: bool) (st: " + string(*layer->abs_data) +
                   ") : option " + string(*layer->abs_data) + " := None.\n";
        out << "\n";
        fsetflag = layer->name + "_set_flag";
    }

    if (layer->ops.find("ptr2int") != layer->ops.end()) {
        fptr2int = layer->ops["ptr2int"];
    } else {
        out << "  Definition " + layer->name + "_ptr2int (p: Ptr) : Z := 0.\n";
        out << "\n";
        fptr2int = layer->name + "_ptr2int";
    }

    if (layer->ops.find("int2ptr") != layer->ops.end()) {
        fint2ptr = layer->ops["int2ptr"];
    } else {
        out << "  Definition " + layer->name + "_int2ptr (v: Z) : Ptr := (mkPtr \"NULL\" 0).\n";
        out << "\n";
        fint2ptr = layer->name + "_int2ptr";
    }

    if (layer->ops.find("ptr_eqb") != layer->ops.end()) {
        fptreqb = layer->ops["ptr_eqb"];
    } else {
        out << "  Definition " + layer->name + "_ptr_eqb (p1: Ptr) (p2: Ptr) : bool := false.\n";
        out << "\n";
        fptreqb = layer->name + "_ptr_eqb";
    }

    if (layer->ops.find("ptr_ltb") != layer->ops.end()) {
        fptrltb = layer->ops["ptr_ltb"];
    } else {
        out << "  Definition " + layer->name + "_ptr_ltb (p1: Ptr) (p2: Ptr) : bool := false.\n";
        out << "\n";
        fptrltb = layer->name + "_ptr_ltb";
    }

    if (layer->ops.find("ptr_gtb") != layer->ops.end()) {
        fptrgtb = layer->ops["ptr_gtb"];
    } else {
        out << "  Definition " + layer->name + "_ptr_gtb (p1: Ptr) (p2: Ptr) : bool := false.\n";
        out << "\n";
        fptrgtb = layer->name + "_ptr_gtb";
    }

    out << "  Definition " + layer->name + "_layer :=\n";
    out << "    {|\n";
    out << "      State := " + string(*layer->abs_data) + ";\n";
    out << "      Init := " + dinit + ";\n";
    out << "      Load := " + fload + ";\n";
    out << "      Store := " + fstore + ";\n";
    out << "      NewFrame := " + fnewframe + ";\n";
    out << "      Alloca := " + falloc + ";\n";
    out << "      Free := " + ffree + ";\n";
    out << "      GetReg :=" + fgetreg + ";\n";
    out << "      SetReg := " + fsetreg + ";\n";
    out << "      GetFlag := " + fgetflag + ";\n";
    out << "      SetFlag := " + fsetflag + ";\n";
    // out << "      PtrCmp := {rptrcmp};\n")
    out << "      Ptr2Int := " + fptr2int + ";\n";
    out << "      Int2Ptr := " + fint2ptr + ";\n";
    out << "      PtrEqb := " + fptreqb + ";\n";
    out << "      PtrLtb := " + fptrltb + ";\n";
    out << "      PtrGtb := " + fptrgtb + ";\n";
    out << "      PrimCall :=\n";

    auto first = true;

    for (auto p : ps) {
        if (first) {
            out << "          (\"" + p + "\", prim " + p + "_spec)\n";
            first = false;
        } else {
            out << "          :: (\"" + p + "\", prim " + p + "_spec)\n";
        }
    }

    if (ps.size() > 0) {
        out << "          :: nil\n";
    } else {
        out << "          nil\n";
    }
    out << "    |}.\n\n";
    out << "End " + layer->name + "_Layer.\n";
    out.close();
}

unique_ptr<vector<string>> generate_layer(Project *proj)
{
    auto files = unique_ptr<vector<string>>(new vector<string>());
    boost::filesystem::path dir(proj->base);

    int i = 0;
    for (auto const &layer : proj->layers) {
        auto name = layer->name;

        if (layer->dummy) {
            continue;
        }

        if (!fs::exists((dir / name).string())) {
            fs::create_directories((dir / name).string());
        }

        gen_layer(proj, i, (dir / name / "Layer.v").string());

        files->push_back(name + "/Layer.v");

        if (i > 0) {
            gen_layer_refine_rel(proj, i, (dir / name / "RefineRel.v").string());
            files->push_back(name + "/RefineRel.v");
        }

        i++;
    }
    return files;
}
}