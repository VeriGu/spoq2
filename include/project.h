#pragma once

#include <values.h>
#include <nodes.h>
#include <utils.h>
#include <log.h>
#include <unordered_set>
#include <llvm.h>
#include <mutex>


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

struct PtrConstaint{
    unsigned long base;
    unsigned long size;
    unsigned long max_elems;
};

class GlobalPtrConstraint {
public:
    //a map from state field to its base, size, max_elems 

    //to access a granule, we need its index to be correct
    //granule @ index.

    //anno array granules {base: GRANULE_BASE, size: SIZE, max_elems: MAX_ELEMs}
    //then any addr that access to st.granules can satisfy the constaint: 
    //(v > 0 /\ v>=granule_base /\ v < GRANULES_BASE + max_elems * size)

    unordered_map<string, PtrConstaint> contraintmap;
};

class Project {
public:
    static const string LOC_DATATYPES;
    static const string LOC_LOWSPEC;
    static const string LOC_SPEC;
    static const string LOC_REFPROOF;
    static const string LOC_GLOBALDEFS;
    static const string LOC_NODEFS;
    static const string PROJ_NAME;
    static const string PROJ_BASE;
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

    string name;
    string base;
    shared_ptr<IRModule> code;

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
    unordered_map<string, vector<unique_ptr<Expr>>> loop_invs;
    
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
        bool CheckInv = false;
        bool CheckLoopInv = false;
        std::set<string> invs;
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

    void add_loop_inv(unique_ptr<Expr> cmd);

    bool is_ind_constr(string name);
    bool is_struct_constr(string name);
    shared_ptr<SpecType> get_indtype_by_constr(string name);

    bool is_known_symbol(string name);

    std::set<string> calc_dependencies(SpecNode *expr);

    void finalize_project();

};

}; // namespace autov