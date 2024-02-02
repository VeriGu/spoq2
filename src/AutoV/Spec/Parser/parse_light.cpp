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
using std::any_cast;
using std::make_unique;

antlrcpp::Any LightProgramVisitor::visitProgram(SpecParser::ProgramContext* ctx) {
    for (auto& stmt : ctx->statement()) {
        return visitStatement(stmt);
    }
    return std::any();
}

antlrcpp::Any LightProgramVisitor::visitStatement(SpecParser::StatementContext* ctx) {
    if (ctx->include() != nullptr) {
        return visitInclude(ctx->include());
    } else if (ctx->command() != nullptr) {
        return visitCommand(ctx->command());
    } else if (ctx->def() != nullptr) {
        return visitDef(ctx->def());
    } else if (ctx->decl() != nullptr) {
        return visitDecl(ctx->decl());
    } else if (ctx->fixpoint() != nullptr) {
        return visitFixpoint(ctx->fixpoint());
    } else if (ctx->inductive_decl() != nullptr) {
        return visitInductive_decl(ctx->inductive_decl());
    } else if (ctx->record_decl() != nullptr) {
        return visitRecord_decl(ctx->record_decl());
    } else if (ctx->typedef_()) {
        return visitTypedef(ctx->typedef_());
    } else if (ctx->section_begin()){
        return visitSection_begin(ctx->section_begin());
    } else if (ctx->section_end()) {
        return visitSection_end(ctx->section_end());
    } else {
        throw std::runtime_error("Unknown statement");
    }

    return std::any();
}

antlrcpp::Any LightProgramVisitor::visitDef(SpecParser::DefContext* ctx) {
    string name = ctx->name()->getText();
    auto expr = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr())));
    unique_ptr<vector<shared_ptr<Arg>>> var_anno = make_unique<vector<shared_ptr<Arg>>>();
    auto rettype = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));

    for (auto arg : ctx->var_anno()) {
        var_anno->push_back((any_cast<shared_ptr<Arg>>(visitVar_anno(arg))));
    }

    return (Definition *)(new Definition(name, rettype, std::move(var_anno), std::move(expr)));
}

antlrcpp::Any LightProgramVisitor::visitDecl(SpecParser::DeclContext* ctx) {
    string name = ctx->name()->getText();
    auto type = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));

    return (Declaration *)(new Declaration(name, type));
}

antlrcpp::Any LightProgramVisitor::visitFixpoint(SpecParser::FixpointContext* ctx) {
    string name = ctx->name()->getText();
    auto expr = unique_ptr<SpecNode>(any_cast<SpecNode *>(visitExpr(ctx->expr())));
    unique_ptr<vector<shared_ptr<Arg>>> var_anno = make_unique<vector<shared_ptr<Arg>>>();
    auto rettype = any_cast<shared_ptr<SpecType>>(visitType(ctx->type()));

    for (auto arg : ctx->var_anno()) {
        var_anno->push_back((any_cast<shared_ptr<Arg>>(visitVar_anno(arg))));
    }

    return (Fixpoint *)(new Fixpoint(name, rettype, std::move(var_anno), std::move(expr)));
}

antlrcpp::Any LightProgramVisitor::visitInductive_decl(SpecParser::Inductive_declContext* ctx) {
    string name = ctx->name()->getText();
    auto arms = make_shared<vector<shared_ptr<IndConstr>>>();

    for (auto arm : ctx->induct_arm()) {
        arms->push_back(shared_ptr<IndConstr>(any_cast<IndConstr *>(visitInduct_arm(arm))));
    }

    return (Inductive *)(new Inductive(name, std::move(arms)));
}

antlrcpp::Any LightProgramVisitor::visitRecord_decl(SpecParser::Record_declContext* ctx) {
    string name = ctx->name(0)->getText();
    auto fields = any_cast<shared_ptr<vector<shared_ptr<Arg>>>>(visitRecord_fields(ctx->record_fields()));

    return (Struct *)(new Struct(name, fields));
}

// Always returns a *SpecNode
antlrcpp::Any LightProgramVisitor::visitExpr(SpecParser::ExprContext* ctx) {
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
    }

    return any_cast<SpecNode *>(visitExpr_op(ctx->expr_op()));
}

// Returns a SpecNode*
antlrcpp::Any LightProgramVisitor::visitExpr_op(SpecParser::Expr_opContext* ctx) {
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

// Always return a shared_ptr<SpecType>
antlrcpp::Any LightProgramVisitor::visitType(SpecParser::TypeContext* ctx) {
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

        // temp: don't use proj until finalize_project is ready
        return make_shared<SpecType>(name);

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


std::any parse_light(Project *proj, const string& text) {
    std::istringstream stream(text);
    antlr4::ANTLRInputStream input(stream);
    SpecLexer lexer(&input);
    antlr4::CommonTokenStream tokens(&lexer);
    SpecParser parser(&tokens);
    antlr4::tree::ParseTree* tree = parser.program();
    LightProgramVisitor visitor(*proj);
    return visitor.visit(tree);
}

} // namespace autov::parser
