#pragma once

#include <values.h>
#include <nodes.h>
#include <utils.h>
#include <log.h>
#include <unordered_set>
#include <llvm.h>
#include <mutex>
#include <filesystem>
#include <iostream>
#include <fstream>
#include <rules.h>
#include <set>
#include <llvm/IR/Module.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Support/FileSystem.h>
#include <llvm/Bitcode/BitcodeReader.h>

#include "SpoqIRLoader.h"

namespace fs = std::filesystem;


namespace autov {
using std::string;
using std::vector;
using std::tuple;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::static_pointer_cast;
using std::dynamic_pointer_cast;
using std::unordered_map;
using std::holds_alternative;
using IRLoader::IRModule;

using loc_t = tuple<string, string, string>;
using field_t = std::vector<std::string>;

enum class SymbolKind {
    Struct,
    StructElem,
    StructConstr,
    IndConstructor,
    IndType,
    Decl,
    Def,
    TypeDef
};

class SymbolInfo {
public:
    SymbolKind kind;
    string info;
    tuple<string, string, string> loc;
    unsigned long order;
};


class QueryInfo {
public: 
    string query_dir;
    unsigned long query_id;

    QueryInfo() : query_dir(""), query_id(0) {}
    QueryInfo(const string &d) : query_dir(d), query_id(0) {
        if (std::filesystem::exists(d)) {
            std::filesystem::remove_all(d);
        }
        std::filesystem::create_directories(d);
    }
    
    void dump(const string &q) {
        auto dumpfile = query_dir + "/query_" + std::to_string(query_id) + ".smt2";
        std::cout << "Dumping query to " << dumpfile << std::endl;
        std::ofstream ofs(dumpfile);
        ofs << q;
        ofs.close();
        query_id++;
    }

    void save_config(const std::string &config_path) {
        auto dumpfile = query_dir + "/config.v";
        std::cout << "Copying config from " << config_path << " to " << dumpfile << std::endl;

        try {
            fs::copy_file(config_path, dumpfile, fs::copy_options::overwrite_existing);
        } catch (const std::exception &e) {
            std::cerr << "Error copying file: " << e.what() << std::endl;
        }
    }
};

class Project {
public:

#define DEF_CONFIG_KEYWORD(name) static constexpr std::string_view name = #name;
    DEF_CONFIG_KEYWORD(PROJ_BC_PATH)
    DEF_CONFIG_KEYWORD(PROJ_NAME)
    DEF_CONFIG_KEYWORD(PROJ_BASE)

    static const string LOC_DATATYPES;
    static const string LOC_LOWSPEC;
    static const string LOC_SPEC;
    static const string LOC_REFPROOF;
    static const string LOC_GLOBALDEFS;
    static const string LOC_NODEFS;
    static const string LAYER_PRIMS;
    static const string LAYER_CODE;
    static const string LAYER_LOAD;
    static const string LAYER_STORE;
    static const string LAYER_NEW_FRAME;
    static const string LAYER_ALLOC;
    static const string LAYER_FREE;
    static const string LAYER_GET_REG;
    static const string LAYER_SET_REG;
    static const string LAYER_GET_FLAG;
    static const string LAYER_SET_FLAG;
    static const string LAYER_PTR2INT;
    static const string LAYER_INT2PTR;
    static const string LAYER_PTR_EQB;
    static const string LAYER_PTR_LTB;
    static const string LAYER_PTR_GTB;
    static const string LAYER_DATA;
    static const string INV_LAYER;
    static const string LEMMA_LAYER;

    string name;
    string base;
    shared_ptr<IRModule> code;

    std::string code_path;
    SpoqIRModule spoq_code;
    // Types. RO after parsing.
    unordered_map<string, shared_ptr<Struct>> structs;
    unordered_map<string, shared_ptr<Inductive>> indtypes;
    unordered_map<string, shared_ptr<SpecType>> typedefs;

    // Axioms/layers. RO after parsing.
    vector<unique_ptr<Expr>> axioms;
    vector<unique_ptr<Layer>> layers;
    unordered_map<string, string> includes;

    unordered_map<string, unique_ptr<Declaration>> decls;
    unordered_map<string, unique_ptr<Definition>> defs;
    vector<string> def_order;
    unordered_map<string, SymbolInfo> symbols;

    std::set<string> skip_state_specs;

    /** Backend rules BEGIN */
    SpecRules rules;
    /** Backend rules END */
    // coi[spec_name][invariant_name] -> coi
    /** autoproof-related variables BEGIN */
    unordered_map<string, std::unordered_map<string, std::set<string>>> coi;
    unordered_map<string, std::set<field_t>> inv_fields;
    std::set<string> lemmas;
    unordered_map<string, std::set<Definition *>> inv_lemmas;
    unordered_map<string, bool> verified_specs;
    QueryInfo query_saver;
    /** autoproof-related variables END */

    class cmds {
    public:
        std::set<string> Unfold;
        std::set<string> NoUnfold;
        std::set<string> NoTrans;
        std::set<string> OnlyTrans;
        std::set<string> TrySplit;
        std::unordered_map<string, vector<string>> AddDep;
        bool NoUnfoldAll = false;
        bool NoHighSpec = false;
        std::map<string, vector<unique_ptr<SpecNode>>> InitRely;
        std::map<string, vector<unique_ptr<SpecNode>>> PostEnsure;
        std::unordered_map<string, std::unordered_map<string, string>> StackMap;
    };
    cmds cmds;

    unordered_map<string, std::set<string>> deps;
    unordered_map<string, std::set<string>> prim_deps;

    std::set<string> has_shadow;

    Project();

    void add_symbol(string symbol, SymbolKind kind, string info, shared_ptr<loc_t> loc);
    void add_symbol(string symbol, SymbolKind kind, string info, shared_ptr<loc_t> loc, unsigned long order);
    void update_symbol_loc(string symbol, shared_ptr<loc_t> loc);

    void add_struct(shared_ptr<Struct> s, shared_ptr<loc_t> loc);
    void add_struct(shared_ptr<Struct> s);

    void add_indtype(shared_ptr<Inductive> ind, shared_ptr<loc_t> loc);
    void add_indtype(shared_ptr<Inductive> ind);

    void add_typedef(string name, shared_ptr<SpecType> t);

    void add_declaration(unique_ptr<Declaration> decl, shared_ptr<loc_t> loc);

    void add_definition(unique_ptr<Definition> def, shared_ptr<loc_t> loc);
    void add_definition(unique_ptr<Definition> def, shared_ptr<loc_t> loc, unsigned long order);
    void update_definition_body(Definition *def);

    void add_layer(unique_ptr<Layer> layer);

    void add_command(unique_ptr<Expr> cmd);
    void add_command(unique_ptr<Expr> cmd, unique_ptr<Layer> layer);

    bool is_ind_constr(string name);
    bool is_struct_constr(string name);
    shared_ptr<SpecType> get_indtype_by_constr(string name);

    bool is_known_symbol(string name);

    std::set<string> calc_dependencies(SpecNode *expr);

    void finalize_project();

    // finalize project with llvm module and SpoqInst
    bool finalize_project_v2();

    /**
     * @brief control flow conversion algorithm on llvm
     * 
     * @return true 
     * @return false 
     */
    bool control_flow_conversion_v2();

    static std::tuple<string, vector<Definition *> *, vector<unique_ptr<Definition>> *> infer_spec_task_v2(Project* proj, int layer_id, string fname);

    static bool infer_low_spec_v2(Project* proj, int layer_id, string fname, bool &have_loop, bool &have_sub, std::unordered_map<string, string> &name_map, 
    std::vector<std::string>& low_specs);
};

}; // namespace autov