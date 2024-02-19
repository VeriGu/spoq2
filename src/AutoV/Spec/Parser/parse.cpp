#include "SpecLexer.h"
#include "SpecParser.h"
#include "SpecBaseVisitor.h"
#include "SpecVisitor.h"
#include <parser.h>
#include <log.h>
#include <regex>
#include <cassert>

namespace autov::parser {

using std::string;
using std::vector;
using std::tuple;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::static_pointer_cast;
using std::dynamic_pointer_cast;
using std::any_cast;
using std::unordered_map;
using std::holds_alternative;

antlrcpp::Any ProgramVisitor::visitProgram(SpecParser::ProgramContext* ctx) {
    for (auto& stmt : ctx->statement()) {
        //LOG_DEBUG << "Visiting statement: " << stmt->getText();
        visitStatement(stmt);
    }
    return std::any();
}

antlrcpp::Any ProgramVisitor::visitSection_begin(SpecParser::Section_beginContext* ctx) {
    if (current_layer != nullptr) {
        throw std::runtime_error("Last layer " + current_layer->name + " not closed");
    } else {
        current_layer = new Layer(ctx->name()->getText());
    }
    return std::any();
}

antlrcpp::Any ProgramVisitor::visitSection_end(SpecParser::Section_endContext* ctx) {
    if (current_layer == nullptr) {
        throw std::runtime_error("No layer" + ctx->name()->getText() + "to close");
    } else {
        LOG_INFO << "Parsed Layer: " << current_layer->name;
        proj.add_layer(std::unique_ptr<autov::Layer>(current_layer));
        current_layer = nullptr;
    }
    return std::any();
}

antlrcpp::Any ProgramVisitor::visitStatement(SpecParser::StatementContext* ctx) {
    if (ctx->include() != nullptr) {
        visitInclude(ctx->include());
    } else if (ctx->command() != nullptr) {
        visitCommand(ctx->command());
    } else if (ctx->def() != nullptr) {
        visitDef(ctx->def());
    } else if (ctx->decl() != nullptr) {
        visitDecl(ctx->decl());
    } else if (ctx->fixpoint() != nullptr) {
        visitFixpoint(ctx->fixpoint());
    } else if (ctx->inductive_decl() != nullptr) {
        visitInductive_decl(ctx->inductive_decl());
    } else if (ctx->record_decl() != nullptr) {
        visitRecord_decl(ctx->record_decl());
    } else if (ctx->typedef_()) {
        visitTypedef(ctx->typedef_());
    } else if (ctx->section_begin()){
        visitSection_begin(ctx->section_begin());
    } else if (ctx->section_end()) {
        visitSection_end(ctx->section_end());
    } else {
        throw std::runtime_error("Unknown statement");
    }

    return std::any();
}

antlrcpp::Any ProgramVisitor::visitInclude(SpecParser::IncludeContext* ctx) {
    std::string path = ctx->path()->getText();

    path = path.substr(1, path.size() - 2);

    // If `path` is not a absolute path, prepend this->path to it
    if (path[0] != '/') {
        path = this->path.substr(0, this->path.rfind('/') + 1) + path;
    }
    parse(&proj, path, current_layer);
    return std::any();
}

antlrcpp::Any ProgramVisitor::visitTypedef(SpecParser::TypedefContext* ctx) {
    string name = ctx->name()->getText();
    LOG_DEBUG << "Visiting typedef: " << name;
    auto t = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));

    if (name == Project::LAYER_DATA) {
        current_layer->abs_data = t;
    } else {
        proj.add_typedef(name, t);
    }
    return std::any();
}

antlrcpp::Any ProgramVisitor::visitCommand(SpecParser::CommandContext* ctx) {
    auto s = any_cast<SpecNode *>(visitExpr(ctx->expr()));
    auto expr = dynamic_cast<Expr *>(s);

    if (expr == nullptr) {
        return std::any();
    }

    proj.add_command(unique_ptr<Expr>(expr));
    return std::any();
}


// Always return a shared_ptr<SpecType>
antlrcpp::Any ProgramVisitor::visitType(SpecParser::TypeContext* ctx) {
    if (ctx->par) {
        return visit(ctx->type(0));
    } else if (ctx->Z_type) {
        return static_pointer_cast<SpecType>(Int::INT);
    } else if (ctx->bool_type) {
        return static_pointer_cast<SpecType>(Bool::BOOL);
    } else if (ctx->str_type) {
        return static_pointer_cast<SpecType>(String::STRING);
    } else if (ctx->type_type) {
        return static_pointer_cast<SpecType>(Type::TYPE);
    } else if (ctx->prop_type) {
        return static_pointer_cast<SpecType>(Prop::PROP);
    } else if (ctx->list_type) {
        return static_pointer_cast<SpecType>(make_shared<List>(any_cast<shared_ptr<SpecType>>(visitType(ctx->type(0)))));
    } else if (ctx->option_type) {
        auto type = any_cast<shared_ptr<SpecType>>(visitType(ctx->type(0)));
        return static_pointer_cast<SpecType>(make_shared<Option>(type));
    } else if (ctx->domain) {
        auto domain = any_cast<shared_ptr<SpecType>>(visitType(ctx->type(0)));
        auto curried_type = any_cast<shared_ptr<SpecType>>(visitType(ctx->type(1)));
        auto args = make_shared<std::vector<shared_ptr<SpecType>>>();

        args->push_back(shared_ptr<SpecType>(domain));

        if (curried_type && dynamic_cast<Function*>(curried_type.get()) != nullptr) {
            shared_ptr<Function> curried_type_func = dynamic_pointer_cast<Function>(curried_type);

            // push back all the arguments of curried_type_func
            for (auto arg : *curried_type_func->args) {
                args->push_back(arg);
            }

            return static_pointer_cast<SpecType>(make_shared<Function>(curried_type_func->rettype, args));
        } else {
            return static_pointer_cast<SpecType>(make_shared<Function>(std::shared_ptr<SpecType>(curried_type), args));
        }
    } else if (ctx->tup) {
        auto types = make_shared<vector<shared_ptr<SpecType>>>();

        for (auto type : ctx->type()) {
            types->push_back(any_cast<shared_ptr<SpecType>>(visitType(type)));
        }

        return static_pointer_cast<SpecType>(make_shared<Tuple>(types));
    } else if (ctx->map_type) {
        return static_pointer_cast<SpecType>(make_shared<ZMap>(any_cast<shared_ptr<SpecType>>(visitType(ctx->type(0)))));
    } else if (ctx->name()) {
        std::string name = ctx->name()->getText();
        LOG_DEBUG << "Visiting type: " << name;
        autov::SymbolInfo &info = proj.symbols.at(name);

        if (info.kind == autov::SymbolKind::Struct) {
            return static_pointer_cast<SpecType>(proj.structs.at(name));
        } else if (info.kind == autov::SymbolKind::IndType) {
            return static_pointer_cast<SpecType>(proj.indtypes.at(name));
        } else if (info.kind == autov::SymbolKind::TypeDef) {
            return static_pointer_cast<SpecType>(proj.typedefs.at(name));
        } else {
            throw std::runtime_error("Unknown type " + name);
        }
    } else {
        throw std::runtime_error("Unknown type");
    }
    return std::any();
}

static inline string string_from_StringConst(std::unique_ptr<SpecNode>& expr, const std::string& errorMessage) {
    StringConst* strConst = dynamic_cast<StringConst*>(expr.get());
    if (!strConst) {
        throw std::runtime_error(errorMessage);
    }
    return std::get<std::string>(strConst->value);
}

antlrcpp::Any ProgramVisitor::visitDef(SpecParser::DefContext* ctx) {
    string name = ctx->name()->getText();
    auto expr = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr())));
    unique_ptr<vector<shared_ptr<Arg>>> var_anno = make_unique<vector<shared_ptr<Arg>>>();
    auto rettype = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));

    LOG_DEBUG << "Visiting def: " << name;

    for (auto arg : ctx->var_anno()) {
        var_anno->push_back((any_cast<shared_ptr<Arg>>(visitVar_anno(arg))));
    }

    if (name == Project::PROJ_NAME) {
        StringConst *proj_name = dynamic_cast<StringConst *>(expr.get());
        proj.name = std::get<string>(proj_name->value);
    } else if (name == Project::PROJ_BASE) {
        StringConst *base = dynamic_cast<StringConst *>(expr.get());
        string path;

        if (!base) {
            throw std::runtime_error("Base path must be a string literal");
        }

        path = std::get<string>(base->value);
        if (path[0] != '/') {
            path = this->path.substr(0, this->path.rfind('/') + 1) + path;
        }
        proj.base = path;
    } else if (name == Project::LAYER_PRIMS) {
        Expr *prims_list = dynamic_cast<Expr *>(expr.get());

        if (!prims_list) {
            throw std::runtime_error("Prims must be a list");
        }

        while (prims_list && holds_alternative<Expr::binops>(prims_list->op) &&
               std::get<Expr::binops>(prims_list->op) == Expr::APPEND) {
            StringConst *prim = dynamic_cast<StringConst *>(prims_list->elems->at(0).get());

            LOG_DEBUG << "Parsed prim: " << std::get<string>(prim->value);
            if (!prim) {
                throw std::runtime_error("Prims must be a list of strings");
            }

            current_layer->prims.push_back(std::get<string>(prim->value));

            prims_list = dynamic_cast<Expr *>(prims_list->elems->at(1).get());
        }
    } else if (name == Project::LAYER_CODE) {
        string path = string_from_StringConst(expr, "Code path must be a string literal");

        if (path[0] != '/') {
            path = this->path.substr(0, this->path.rfind('/') + 1) + path;
        }

        LOG_DEBUG << "Parsed code: " << path;
        current_layer->code = path;
    } else if (name == Project::LAYER_LOAD) {
        string load = string_from_StringConst(expr, "Load must be a string literal");

        LOG_DEBUG << "Parsed load: " << load;

        current_layer->ops.emplace("load", load);
    } else if (name == Project::LAYER_STORE) {
        string store = string_from_StringConst(expr, "Store must be a string literal");

        LOG_DEBUG << "Parsed store: " << store;
        current_layer->ops.emplace("store", store);
    } else if (name == Project::LAYER_NEW_FRAME) {
        string new_frame = string_from_StringConst(expr, "New frame must be a string literal");

        LOG_DEBUG << "Parsed new_frame: " << new_frame;
        current_layer->ops.emplace("new_frame", new_frame);
    } else if (name == Project::LAYER_ALLOC) {
        string alloc = string_from_StringConst(expr, "Alloc must be a string literal");

        LOG_DEBUG << "Parsed alloc: " << alloc;
        current_layer->ops.emplace("alloc", alloc);
    } else if (name == Project::LAYER_FREE) {
        string free = string_from_StringConst(expr, "Free must be a string literal");

        LOG_DEBUG << "Parsed free: " << free;
        current_layer->ops.emplace("free", free);
    } else if (name == Project::LAYER_GET_REG) {
        string get_reg = string_from_StringConst(expr, "Get reg must be a string literal");

        LOG_DEBUG << "Parsed get_reg: " << get_reg;
        current_layer->ops.emplace("get_reg", get_reg);
    } else if (name == Project::LAYER_SET_REG) {
        string set_reg = string_from_StringConst(expr, "Set reg must be a string literal");

        LOG_DEBUG << "Parsed set_reg: " << set_reg;
        current_layer->ops.emplace("set_reg", set_reg);
    } else if (name == Project::LAYER_GET_FLAG) {
        string get_flag = string_from_StringConst(expr, "Get flag must be a string literal");

        LOG_DEBUG << "Parsed get_flag: " << get_flag;
        current_layer->ops.emplace("get_flag",get_flag);
    } else if (name == Project::LAYER_SET_FLAG) {
        string set_flag = string_from_StringConst(expr, "Set flag must be a string literal");

        LOG_DEBUG << "Parsed set_flag: " << set_flag;
        current_layer->ops.emplace("set_flag", set_flag);
    } else if (name == Project::LAYER_PTR2INT) {
        string ptr2int = string_from_StringConst(expr, "Ptr2int must be a string literal");

        LOG_DEBUG << "Parsed ptr2int: " << ptr2int;
        current_layer->ops.emplace("ptr2int", ptr2int);
    } else if (name == Project::LAYER_INT2PTR) {
        string int2ptr = string_from_StringConst(expr, "Int2ptr must be a string literal");

        LOG_DEBUG << "Parsed int2ptr: " << int2ptr;
        current_layer->ops.emplace("int2ptr", int2ptr);
    } else if (name == Project::LAYER_PTR_EQB) {
        string ptr_eqb = string_from_StringConst(expr, "Ptr_eqb must be a string literal");

        LOG_DEBUG << "Parsed ptr_eqb: " << ptr_eqb;
        current_layer->ops.emplace("ptr_eqb", ptr_eqb);
    } else if (name == Project::LAYER_PTR_LTB) {
        string ptr_ltb = string_from_StringConst(expr, "Ptr_ltb must be a string literal");

        LOG_DEBUG << "Parsed ptr_ltb: " << ptr_ltb;
        current_layer->ops.emplace("ptr_ltb", ptr_ltb);
    } else if (name == Project::LAYER_PTR_GTB) {
        string ptr_gtb = string_from_StringConst(expr, "Ptr_gtb must be a string literal");

        LOG_DEBUG << "Parsed ptr_gtb: " << ptr_gtb;
        current_layer->ops.emplace("ptr_gtb", ptr_gtb);
    } else {
        shared_ptr<loc_t> loc;
        unique_ptr<Definition> def = make_unique<Definition>(name, rettype, std::move(var_anno), std::move(expr));

        if (dynamic_cast<RecordDef *>(expr.get()))
            rettype->record = true;

        if (current_layer) {
            if (name.size() > 8 && name.substr(name.size() - 8) == "spec_mid") {
                loc = make_shared<loc_t>(loc_t(current_layer->name, name.substr(0, name.size() - 9), Project::LOC_REFPROOF));
            } if (name.size() > 8 && name.substr(name.size() - 8) == "spec_low") {
                loc = make_shared<loc_t>(loc_t(current_layer->name, name.substr(0, name.size() - 9), Project::LOC_LOWSPEC));
            } else {
                loc = make_shared<loc_t>(loc_t(current_layer->name, Project::LOC_SPEC, ""));
            }
        } else {
            loc = make_shared<loc_t>(loc_t(Project::LOC_GLOBALDEFS, "", ""));
        }
        proj.add_definition(move(def), loc);
    }

    LOG_INFO << "Parsed Definition " << name;
    return std::any();
}

antlrcpp::Any ProgramVisitor::visitDecl(SpecParser::DeclContext* ctx) {
    string name = ctx->name()->getText();
    auto type = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));
    shared_ptr<loc_t> loc;

    if (current_layer) {
        loc = make_shared<loc_t>(loc_t(current_layer->name, Project::LOC_SPEC, ""));
    } else {
        loc = make_shared<loc_t>(loc_t(Project::LOC_GLOBALDEFS, "", ""));
    }

    proj.add_declaration(make_unique<Declaration>(name, type), loc);

    LOG_INFO << "Parsed Declaration " << name;

    return std::any();
}

antlrcpp::Any ProgramVisitor::visitFixpoint(SpecParser::FixpointContext* ctx) {
    string name = ctx->name()->getText();
    auto expr = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr())));
    unique_ptr<vector<shared_ptr<Arg>>> var_anno = make_unique<vector<shared_ptr<Arg>>>();
    auto rettype = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));
    shared_ptr<loc_t> loc;

    for (auto arg : ctx->var_anno()) {
        var_anno->push_back((any_cast<shared_ptr<Arg>>(visitVar_anno(arg))));
    }

    if (current_layer) {
        std::regex pattern(R"(([a-zA-Z0-9_]+)(_loop\d+_mid)$)");
        std::smatch match;

        if (std::regex_match(name, match, pattern)) {
            int pos = match.position(2);

            loc = make_shared<loc_t>(loc_t(current_layer->name, name.substr(0, pos), Project::LOC_REFPROOF));
        } else {
            loc = make_shared<loc_t>(loc_t(current_layer->name, Project::LOC_SPEC, ""));
        }
    } else {
        loc = make_shared<loc_t>(loc_t(Project::LOC_GLOBALDEFS, "", ""));
    }

    proj.add_definition(make_unique<Fixpoint>(name, rettype, std::move(var_anno), std::move(expr)), loc);

    LOG_INFO << "Parsed Fixpoint " << name;

    return std::any();
}

antlrcpp::Any ProgramVisitor::visitInductive_decl(SpecParser::Inductive_declContext* ctx) {
    string name = ctx->name()->getText();
    auto arms = make_shared<vector<shared_ptr<IndConstr>>>();

    for (auto arm : ctx->induct_arm()) {
        arms->push_back(shared_ptr<IndConstr>(any_cast<IndConstr *>(visitInduct_arm(arm))));
    }

    proj.add_indtype(make_shared<Inductive>(name, std::move(arms)));

    LOG_INFO << "Parsed Inductive " << name;

    return std::any();
}

antlrcpp::Any ProgramVisitor::visitInduct_arm(SpecParser::Induct_armContext* ctx) {
    string name = ctx->name()->getText();
    auto var_anno = make_unique<vector<shared_ptr<Arg>>>();
    auto vars = ctx->var_anno();

    LOG_DEBUG << "Visiting induct_arm: " << name;

    for (auto anno : vars) {
        LOG_DEBUG << "Visiting var_anno: " << anno->getText();
        var_anno->push_back(any_cast<shared_ptr<Arg>>(visitVar_anno(anno)));
    }

    return (IndConstr *)(new IndConstr(name, std::move(var_anno)));
}

antlrcpp::Any ProgramVisitor::visitRecord_fields(SpecParser::Record_fieldsContext* ctx) {
    auto args = shared_ptr<vector<shared_ptr<Arg>>>(new vector<shared_ptr<Arg>>());
    auto type = ctx->type();
    auto name = ctx->name();
    auto type_it = type.begin();
    auto name_it = name.begin();

    for (; type_it != type.end() && name_it != name.end(); type_it++, name_it++) {
        // if ((*name_it)->getText() == "repl") {
        //     LOG_DEBUG << "Visiting record field: " << (*name_it)->getText();
        //     LOG_DEBUG << "type: " << (*type_it)->getText();
        //     LOG_DEBUG << "Parsed type: " << string(*any_cast<shared_ptr<SpecType>>(visitType(*type_it)));
        // }
        args->push_back(make_shared<Arg>((*name_it)->getText(), any_cast<shared_ptr<SpecType>>(visitType(*type_it))));
    }

    return args;
}

antlrcpp::Any ProgramVisitor::visitRecord_decl(SpecParser::Record_declContext* ctx) {
    string name = ctx->name(0)->getText();
    auto fields = any_cast<shared_ptr<vector<shared_ptr<Arg>>>>(visitRecord_fields(ctx->record_fields()));

    proj.add_struct(make_shared<Struct>(name, fields));
    LOG_INFO << "Parsed Record " << name;
    return std::any();
}

// Always returns a *SpecNode
antlrcpp::Any ProgramVisitor::visitExpr(SpecParser::ExprContext* ctx) {
    if (ctx->if_stmt()) {
        return any_cast<SpecNode *>(visitIf_stmt(ctx->if_stmt()));
    } else if (ctx->when_stmt()) {
        return any_cast<SpecNode *>(visitWhen_stmt(ctx->when_stmt()));
    } else if (ctx->assert_stmt()) {
        return any_cast<SpecNode *>(visitAssert_stmt(ctx->assert_stmt()));
    } else if (ctx->anno_stmt()) {
        return any_cast<SpecNode *>(visitAnno_stmt(ctx->anno_stmt()));
    } else if (ctx->match_stmt()) {
        return any_cast<SpecNode *>(visitMatch_stmt(ctx->match_stmt()));
    } else if (ctx->let_stmt()) {
        return any_cast<SpecNode *>(visitLet_stmt(ctx->let_stmt()));
    } else if (ctx->record_def_stmt()) {
        return any_cast<SpecNode *>(visitRecord_def_stmt(ctx->record_def_stmt()));
    }

    return any_cast<SpecNode *>(visitExpr_op(ctx->expr_op()));
}

antlrcpp::Any ProgramVisitor::visitRecord_def_stmt(SpecParser::Record_def_stmtContext* ctx) {
    auto raw_fields = visitRecord_fields_def(ctx->record_fields_def());
    auto fields = unique_ptr<std::map<unique_ptr<Symbol>, unique_ptr<SpecNode>>>(
        any_cast<std::map<unique_ptr<Symbol>, unique_ptr<SpecNode>>*>(raw_fields)
    );

    return (SpecNode *)(new RecordDef(std::move(fields)));
}

// Retruns a std::map<unique_ptr<Symbol>, unique_ptr<SpecNode>>*
antlrcpp::Any ProgramVisitor::visitRecord_fields_def(SpecParser::Record_fields_defContext* ctx) {
    auto *field = new std::map<unique_ptr<Symbol>, unique_ptr<SpecNode>>();
    auto names = ctx->name();

    for (auto it = names.begin(); it != names.end(); it++) {
        auto name = unique_ptr<Symbol>(any_cast<Symbol *>(visitName(*it)));
        auto value = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitName(*(++it))));

        (*field)[std::move(name)] = std::move(value);
    }

    return field;
}

Expr::binops ProgramVisitor::parse_binop(const antlr4::Token *binop) {
    switch (binop->getType()) {
        case SpecLexer::MULT:
            return Expr::binops::MULT;
        case SpecLexer::DIV:
            return Expr::binops::DIV;
        case SpecLexer::MOD:
            return Expr::binops::MOD;
        case SpecLexer::ADD:
            return Expr::binops::ADD;
        case SpecLexer::MINUS:
            return Expr::binops::MINUS;
        case SpecLexer::BITAND:
            return Expr::binops::BITAND;
        case SpecLexer::BITOR:
            return Expr::binops::BITOR;
        case SpecLexer::BEQ:
            return Expr::binops::BEQ;
        case SpecLexer::BNE:
            return Expr::binops::BNE;
        case SpecLexer::BGT:
            return Expr::binops::BGT;
        case SpecLexer::BGE:
            return Expr::binops::BGE;
        case SpecLexer::BLT:
            return Expr::binops::BLT;
        case SpecLexer::BLE:
            return Expr::binops::BLE;
        case SpecLexer::BAND:
            return Expr::binops::BAND;
        case SpecLexer::BOR:
            return Expr::binops::BOR;
        case SpecLexer::LSHIFT:
            return Expr::binops::LSHIFT;
        case SpecLexer::RSHIFT:
            return Expr::binops::RSHIFT;
        case SpecLexer::SEQ:
            return Expr::binops::SEQ;
        case SpecLexer::SNE:
            return Expr::binops::SNE;
        case SpecLexer::APPEND:
            return Expr::binops::APPEND;
        case SpecLexer::CONCAT:
            return Expr::binops::CONCAT;
        case SpecLexer::EQUAL:
            return Expr::binops::EQUAL;
        case SpecLexer::NOT_EQUAL:
            return Expr::binops::NOT_EQUAL;
        case SpecLexer::LT:
            return Expr::binops::LT;
        case SpecLexer::LTE:
            return Expr::binops::LTE;
        case SpecLexer::GT:
            return Expr::binops::GT;
        case SpecLexer::GTE:
            return Expr::binops::GTE;
        case SpecLexer::IFONLYIF:
            return Expr::binops::IFONLYIF;
        case SpecLexer::OR:
            return Expr::binops::OR;
        case SpecLexer::AND:
            return Expr::binops::AND;
        case SpecLexer::IMPLIES:
            return Expr::binops::IMPLIES;
        default:
            throw std::runtime_error("Unknown binop");
    }

    // Should never reach here
    assert(false);
}

// Returns a SpecNode*
antlrcpp::Any ProgramVisitor::visitExpr_op(SpecParser::Expr_opContext* ctx) {
    if (ctx->binop) {
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));
        auto op1 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(1))));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        elems->push_back(move(op0));
        elems->push_back(move(op1));

        return (SpecNode *)(new Expr(parse_binop(ctx->binop), std::move(elems)));
    } else if (ctx->record_set) {
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));
        auto op1 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(1))));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        elems->push_back(move(op0));

        for (auto name : ctx->name()) {
            elems->push_back(unique_ptr<SpecNode>(any_cast<SpecNode *>(visitName(name))));
        }

        elems->push_back(move(op1));

        return (SpecNode *)(new Expr(Expr::ops::RecordSet, std::move(elems)));
    } else if (ctx->record_set2) {
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));
        auto name = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitName(ctx->name(0))));
        auto op1 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(1))));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        elems->push_back(move(op0));
        elems->push_back(move(name));
        elems->push_back(move(op1));

        return (SpecNode *)(new Expr(Expr::ops::RecordSet, std::move(elems)));
    } else if (ctx->map_get) {
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));
        auto op1 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(1))));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        elems->push_back(move(op0));
        elems->push_back(move(op1));

        return (SpecNode *)(new Expr(Expr::ops::GET, std::move(elems)));
    } else if (ctx->map_set) {
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));
        auto op1 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(1))));
        auto op2 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(2))));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        elems->push_back(move(op0));
        elems->push_back(move(op1));
        elems->push_back(move(op2));

        return (SpecNode *)(new Expr(Expr::ops::SET, std::move(elems)));
    } else if (ctx->list_nth) {
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));
        auto op1 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(1))));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        elems->push_back(move(op0));
        elems->push_back(move(op1));

        return (SpecNode *)(new Expr(Expr::ops::NTH, std::move(elems)));
    } else if (ctx->forall_expr()) {
        auto vars = unique_ptr<vector<shared_ptr<Arg>>>(any_cast<vector<shared_ptr<Arg>> *>(visitForall_expr(ctx->forall_expr())));
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));

        return (SpecNode *)(new Forall(move(vars), std::move(op0)));
    } else if (ctx->exists_expr()) {
        auto vars = unique_ptr<vector<shared_ptr<Arg>>>(any_cast<vector<shared_ptr<Arg>> *>(visitExists_expr(ctx->exists_expr())));
        auto op0 = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr_op(ctx->expr_op(0))));

        return (SpecNode *)(new Exists(move(vars), std::move(op0)));
    } else if (ctx->op) {
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
        unique_ptr<SpecNode> op;
        auto term = ctx->term();

        op = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitTerm(term[0])));
        for (auto it = term.begin() + 1; it != term.end(); it++) {
            elems->push_back(unique_ptr<SpecNode>(any_cast<SpecNode *>(visitTerm(*it))));
        }

        if (dynamic_cast<Symbol *>(op.get()) != nullptr) {
            // static const unordered_map<string, Expr::binops> str_to_binops_map = {
            //     {"Z.lnot", Expr::Zlnot},
            //     {"Z.lxor", Expr::Zlxor},
            //     {"Z.testbit", Expr::Ztestbit},
            //     {"xorb", Expr::xorb}
            // };

            // if (str_to_binops_map.find(((Symbol *)op.get())->text) != str_to_binops_map.end()) {
            //     return (SpecNode *)(new Expr(str_to_binops_map.at(((Symbol *)op.get())->text), std::move(elems)));
            // } else
            if (((Symbol *)op.get())->text == "None")
                return (SpecNode *)(new Expr(Expr::None, std::move(elems)));
            else if (((Symbol *)op.get())->text == "Some")
                return (SpecNode *)(new Expr(Expr::Some, std::move(elems)));
            else
                return (SpecNode *)(new Expr(string(((Symbol *)op.get())->text), std::move(elems)));
        } else {
            return (SpecNode *)(new Expr(move(op), std::move(elems)));
        }
    }

    return visitTerm(ctx->term(0));
}

static Expr::ops parse_uniop(const antlr4::Token *uniop) {
    switch (uniop->getType()) {
        case SpecLexer::NOT:
            return Expr::ops::NOT;
        case SpecLexer::BNOT:
            return Expr::ops::BNOT;
        case SpecLexer::MINUS:
            return Expr::ops::NEG;
        default:
            throw std::runtime_error("Unknown uniop");
    }

    // Should never reach here
    assert(false);
}

// Returns a SpecNode*
antlrcpp::Any ProgramVisitor::visitTerm(SpecParser::TermContext* ctx) {
    if (ctx->uniop) {
        auto term = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitTerm(ctx->term())));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
        auto op = parse_uniop(ctx->uniop);

        elems->push_back(move(term));

        if (op == Expr::ops::NEG)
            return (SpecNode *)(new Expr(Expr::binops::MINUS, std::move(elems)));

        return (SpecNode *)(new Expr(parse_uniop(ctx->uniop), std::move(elems)));
    } else if (ctx->record_get) {
        auto term = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitTerm(ctx->term())));
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

        elems->push_back(move(term));
        elems->push_back(unique_ptr<SpecNode>(any_cast<SpecNode *>(visitName(ctx->name()))));

        return (SpecNode *)(new Expr(Expr::RecordGet, std::move(elems)));
    } else if (ctx->tuple()) {
        return visitTuple(ctx->tuple());
    } else if (ctx->value()) {
        return visitValue(ctx->value());
    }

    return visitExpr(ctx->par);
}

antlrcpp::Any ProgramVisitor::visitLet_stmt(SpecParser::Let_stmtContext* ctx) {
    auto src = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(0))));
    auto body = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(1))));

    if (ctx->tuple()) {
        auto pattern = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitTuple(ctx->tuple())));
        auto match_list = make_unique<vector<unique_ptr<PatternMatch>>>();
        auto match = make_unique<PatternMatch>(move(pattern), std::move(body));

        match_list->push_back(move(match));

        return (SpecNode *)(new Match(move(src), std::move(match_list)));
    } else if (ctx->name()) {
        auto pattern = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitName(ctx->name())));
        auto match_list = make_unique<vector<unique_ptr<PatternMatch>>>();
        auto match = make_unique<PatternMatch>(move(pattern), std::move(body));

        match_list->push_back(move(match));

        return (SpecNode *)(new Match(move(src), std::move(match_list)));
    }

    throw std::runtime_error("Unknown pattern");
    return std::any();
}

antlrcpp::Any ProgramVisitor::visitMatch_stmt(SpecParser::Match_stmtContext* ctx) {
    auto src = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr())));
    auto match_list = make_unique<vector<unique_ptr<PatternMatch>>>();

    for (auto match_branch : ctx->match_branch()) {
        match_list->push_back(unique_ptr<PatternMatch>(any_cast<PatternMatch *>(visitMatch_branch(match_branch))));
    }

    return (SpecNode *)(new Match(move(src), std::move(match_list)));
}

antlrcpp::Any ProgramVisitor::visitMatch_branch(SpecParser::Match_branchContext* ctx) {
    auto pattern = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(0))));
    auto body = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(1))));

    if (dynamic_cast<Symbol *>(pattern.get())) {
        auto s = dynamic_cast<Symbol *>(pattern.get());

        if (s->text == "None") {
            pattern = unique_ptr<SpecNode>(new Expr(Expr::None, make_unique<vector<unique_ptr<SpecNode>>>()));
        }
    }

    return (PatternMatch *)(new PatternMatch(move(pattern), std::move(body)));
}

antlrcpp::Any ProgramVisitor::visitWhen_stmt(SpecParser::When_stmtContext* ctx) {
    auto names = make_unique<vector<unique_ptr<SpecNode>>>();
    unique_ptr<SpecNode> value;
    unique_ptr<SpecNode> body;
    unique_ptr<SpecNode> tuple_node;

    for (auto name : ctx->name()) {
        names->push_back(unique_ptr<SpecNode>(any_cast<SpecNode *>(visitName(name))));
    }

    value = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(0))));
    body = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(1))));

    if (names->size() == 1) {
        return (SpecNode *)(Match::raw_when(move((*names)[0]), std::move(value), std::move(body)));
    }

    tuple_node = make_unique<Expr>(Expr::Tuple, std::move(names));
    return (SpecNode *)(Match::raw_when(move(tuple_node), std::move(value), std::move(body)));

}

antlrcpp::Any ProgramVisitor::visitAssert_stmt(SpecParser::Assert_stmtContext* ctx) {
    auto prop = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(0))));
    auto body = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(1))));

    return (SpecNode *)(new Rely(move(prop), std::move(body)));
}

antlrcpp::Any ProgramVisitor::visitAnno_stmt(SpecParser::Anno_stmtContext* ctx) {
    auto prop = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(0))));
    auto body = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(1))));

    return (SpecNode *)(new Rely(move(prop), std::move(body)));
}

antlrcpp::Any ProgramVisitor::visitFunc_call(SpecParser::Func_callContext* ctx) {
    return std::any();
}

// Returns a vector<shared_ptr<Arg>>*
antlrcpp::Any ProgramVisitor::visitForall_expr(SpecParser::Forall_exprContext* ctx) {
    auto args = new vector<shared_ptr<Arg>>();

    for (auto arg : ctx->var_anno()) {
        args->push_back(any_cast<shared_ptr<Arg>>(visitVar_anno(arg)));
    }

    return args;
}

antlrcpp::Any ProgramVisitor::visitExists_expr(SpecParser::Exists_exprContext* ctx) {
    auto args = new vector<shared_ptr<Arg>>();

    for (auto arg : ctx->var_anno()) {
        args->push_back(any_cast<shared_ptr<Arg>>(visitVar_anno(arg)));
    }

    return args;
}

// Always returns a SpecNode*
antlrcpp::Any ProgramVisitor::visitIf_stmt(SpecParser::If_stmtContext* ctx) {
    unique_ptr<SpecNode> cond, then, els;

    cond = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(0))));
    then = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(1))));
    els = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr(2))));

    return (SpecNode *)(new If(std::move(cond), std::move(then), std::move(els)));
}

// Returns a SpecNode*
antlrcpp::Any ProgramVisitor::visitTuple(SpecParser::TupleContext* ctx) {
    auto elems = make_unique<vector<unique_ptr<SpecNode>>>();

    for (auto expr : ctx->expr()) {
        elems->push_back(unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(expr))));
    }

    return (SpecNode *)(new Expr(Expr::ops::Tuple, std::move(elems)));
}

// Returns a SpecNode*
antlrcpp::Any ProgramVisitor::visitValue(SpecParser::ValueContext* ctx) {
    if (ctx->string()) {
        string str = ctx->string()->getText();

        str = str.substr(1, str.size() - 2);

        //LOG_DEBUG << "Parsed string: " << str;
        return (SpecNode *)(new StringConst(str));
    } else if (ctx->number()) {
        unsigned long value = std::stoul(ctx->number()->getText());

        return (SpecNode *)(new IntConst(value));
    } else if (ctx->bool_()) {
        bool value = ctx->bool_()->getText() == "true";

        return (SpecNode *)(new BoolConst(value));
    } else if (ctx->name()) {
        return visitName(ctx->name());
    } else {
        throw std::runtime_error("Unknown value");
    }

    return std::any();
}

// Returns a unsigned long
antlrcpp::Any ProgramVisitor::visitNumber(SpecParser::NumberContext* ctx) {
    return std::stoul(ctx->getText());
}

// Returns a bool
antlrcpp::Any ProgramVisitor::visitBool(SpecParser::BoolContext* ctx) {
    return ctx->getText() == "true";
}

// Returns a SpecNode*
antlrcpp::Any ProgramVisitor::visitName(SpecParser::NameContext* ctx) {
    return (SpecNode *)(new Symbol(ctx->getText()));
}

// Returns a shared_ptr<Arg>
antlrcpp::Any ProgramVisitor::visitVar_anno(SpecParser::Var_annoContext* ctx) {
    shared_ptr<SpecType> arg_type = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));

    return make_shared<Arg>(ctx->name()->getText(), arg_type);
}

void parse(Project *proj, const std::string& path) {
    std::ifstream stream(path);
    antlr4::ANTLRInputStream input(stream);
    SpecLexer lexer(&input);
    antlr4::CommonTokenStream tokens(&lexer);
    SpecParser parser(&tokens);
    antlr4::tree::ParseTree* tree = parser.program();
    ProgramVisitor visitor(*proj, path);

    std::cout << "Parsing " << path << std::endl;
    visitor.visit(tree);
    std::cout << "Done parsing " << path << std::endl;

    //std::cout << tree->toStringTree(&parser) << std::endl;
}

void parse(Project *proj, const std::string& path, Layer *current_layer) {
    std::ifstream stream(path);
    antlr4::ANTLRInputStream input(stream);
    SpecLexer lexer(&input);
    antlr4::CommonTokenStream tokens(&lexer);
    SpecParser parser(&tokens);
    antlr4::tree::ParseTree* tree = parser.program();
    ProgramVisitor visitor(*proj, path, current_layer);

    std::cout << "Parsing " << path << std::endl;
    visitor.visit(tree);
    std::cout << "Done parsing " << path << std::endl;
}

} // namespace autov::parser
