#pragma once

#include <string>
#include <SpecVisitor.h>
#include <project.h>

namespace autov::parser {
class ProgramVisitor : public SpecVisitor {
public:
    Project &proj;
    std::string path;
    Layer *current_layer;

    ProgramVisitor(Project &proj, std::string path) : proj(proj), path(path) {
        current_layer = nullptr;
    }
    ProgramVisitor(Project &proj, std::string path, Layer *layer) :
                    proj(proj), path(path), current_layer(layer) {}

    antlrcpp::Any visitProgram(SpecParser::ProgramContext* ctx) override;

    antlrcpp::Any visitSection_begin(SpecParser::Section_beginContext* ctx) override;

    antlrcpp::Any visitSection_end(SpecParser::Section_endContext* ctx) override;

    antlrcpp::Any visitStatement(SpecParser::StatementContext* ctx) override;

    antlrcpp::Any visitInclude(SpecParser::IncludeContext* ctx) override;

    antlrcpp::Any visitCommand(SpecParser::CommandContext* ctx) override;

    antlrcpp::Any visitType(SpecParser::TypeContext* ctx) override;

    antlrcpp::Any visitDef(SpecParser::DefContext* ctx) override;

    antlrcpp::Any visitTypedef(SpecParser::TypedefContext* ctx) override;

    antlrcpp::Any visitPath(SpecParser::PathContext* ctx) override { return std::any(); }

    antlrcpp::Any visitMk(SpecParser::MkContext* ctx) override { return std::any(); }

    antlrcpp::Any visitString(SpecParser::StringContext* ctx) override { return std::any(); }

    antlrcpp::Any visitDecl(SpecParser::DeclContext* ctx) override;

    antlrcpp::Any visitFixpoint(SpecParser::FixpointContext* ctx) override;

    antlrcpp::Any visitInductive_decl(SpecParser::Inductive_declContext* ctx) override;

    antlrcpp::Any visitInduct_arm(SpecParser::Induct_armContext* ctx) override;

    antlrcpp::Any visitRecord_fields(SpecParser::Record_fieldsContext* ctx) override;

    antlrcpp::Any visitRecord_decl(SpecParser::Record_declContext* ctx) override;

    antlrcpp::Any visitExpr(SpecParser::ExprContext* ctx) override;

    antlrcpp::Any visitRecord_def_stmt(SpecParser::Record_def_stmtContext* ctx) override;

    antlrcpp::Any visitRecord_fields_def(SpecParser::Record_fields_defContext* ctx) override;

    antlrcpp::Any visitExpr_op(SpecParser::Expr_opContext* ctx) override;

    antlrcpp::Any visitTerm(SpecParser::TermContext* ctx) override;

    antlrcpp::Any visitLet_stmt(SpecParser::Let_stmtContext* ctx) override;

    antlrcpp::Any visitMatch_stmt(SpecParser::Match_stmtContext* ctx) override;

    antlrcpp::Any visitMatch_branch(SpecParser::Match_branchContext* ctx) override;

    antlrcpp::Any visitWhen_stmt(SpecParser::When_stmtContext* ctx) override;

    antlrcpp::Any visitAssert_stmt(SpecParser::Assert_stmtContext* ctx) override;

    antlrcpp::Any visitAnno_stmt(SpecParser::Anno_stmtContext* ctx) override;

    antlrcpp::Any visitFunc_call(SpecParser::Func_callContext* ctx) override;

    antlrcpp::Any visitForall_expr(SpecParser::Forall_exprContext* ctx) override;

    antlrcpp::Any visitExists_expr(SpecParser::Exists_exprContext* ctx) override;

    antlrcpp::Any visitIf_stmt(SpecParser::If_stmtContext* ctx) override;

    antlrcpp::Any visitTuple(SpecParser::TupleContext* ctx) override;

    antlrcpp::Any visitValue(SpecParser::ValueContext* ctx) override;

    antlrcpp::Any visitNumber(SpecParser::NumberContext* ctx) override;

    antlrcpp::Any visitBool(SpecParser::BoolContext* ctx) override;

    antlrcpp::Any visitName(SpecParser::NameContext* ctx) override;

    antlrcpp::Any visitVar_anno(SpecParser::Var_annoContext* ctx) override;

protected:
    // utility functions that can be used by subclasses
    Expr::binops parse_binop(const antlr4::Token *binop);
};

void parse(Project *proj, const std::string& path, Layer *current_layer);
void parse(Project *proj, const std::string& path);


class LightProgramVisitor : public ProgramVisitor {
public:

    LightProgramVisitor(Project &proj) : ProgramVisitor(proj, "") {}

    // These are used by LightProgramVisitor but implemented in ProgramVisitor:

    // antlrcpp::Any visitInduct_arm(SpecParser::Induct_armContext* ctx) override;
    // antlrcpp::Any visitRecord_fields(SpecParser::Record_fieldsContext* ctx) override;
    // antlrcpp::Any visitTerm(SpecParser::TermContext* ctx) override;
    // antlrcpp::Any visitLet_stmt(SpecParser::Let_stmtContext* ctx) override;
    // antlrcpp::Any visitMatch_stmt(SpecParser::Match_stmtContext* ctx) override;
    // antlrcpp::Any visitMatch_branch(SpecParser::Match_branchContext* ctx) override;
    // antlrcpp::Any visitWhen_stmt(SpecParser::When_stmtContext* ctx) override;
    // antlrcpp::Any visitAssert_stmt(SpecParser::Assert_stmtContext* ctx) override;
    // antlrcpp::Any visitAnno_stmt(SpecParser::Anno_stmtContext* ctx) override;
    // antlrcpp::Any visitFunc_call(SpecParser::Func_callContext* ctx) override;
    // antlrcpp::Any visitForall_expr(SpecParser::Forall_exprContext* ctx) override;
    // antlrcpp::Any visitExists_expr(SpecParser::Exists_exprContext* ctx) override;
    // antlrcpp::Any visitIf_stmt(SpecParser::If_stmtContext* ctx) override;
    // antlrcpp::Any visitTuple(SpecParser::TupleContext* ctx) override;
    // antlrcpp::Any visitValue(SpecParser::ValueContext* ctx) override;
    // antlrcpp::Any visitNumber(SpecParser::NumberContext* ctx) override;
    // antlrcpp::Any visitBool(SpecParser::BoolContext* ctx) override;
    // antlrcpp::Any visitName(SpecParser::NameContext* ctx) override;
    // antlrcpp::Any visitVar_anno(SpecParser::Var_annoContext* ctx) override;
    antlrcpp::Any visitType(SpecParser::TypeContext* ctx) override;


    // These are redefined in LightProgramVisitor:

    antlrcpp::Any visitProgram(SpecParser::ProgramContext* ctx) override;
    antlrcpp::Any visitStatement(SpecParser::StatementContext* ctx) override;
    antlrcpp::Any visitDef(SpecParser::DefContext* ctx) override;
    antlrcpp::Any visitDecl(SpecParser::DeclContext* ctx) override;
    antlrcpp::Any visitFixpoint(SpecParser::FixpointContext* ctx) override;
    antlrcpp::Any visitInductive_decl(SpecParser::Inductive_declContext* ctx) override;
    antlrcpp::Any visitRecord_decl(SpecParser::Record_declContext* ctx) override;
    antlrcpp::Any visitExpr(SpecParser::ExprContext* ctx) override;
    antlrcpp::Any visitExpr_op(SpecParser::Expr_opContext* ctx) override;


    // These are not used in LightProgramVisitor:

    // antlrcpp::Any visitSection_begin(SpecParser::Section_beginContext* ctx) override;
    // antlrcpp::Any visitSection_end(SpecParser::Section_endContext* ctx) override;
    // antlrcpp::Any visitInclude(SpecParser::IncludeContext* ctx) override;
    // antlrcpp::Any visitCommand(SpecParser::CommandContext* ctx) override;
    // antlrcpp::Any visitTypedef(SpecParser::TypedefContext* ctx) override;
    // antlrcpp::Any visitPath(SpecParser::PathContext* ctx) override { return std::any(); }
    // antlrcpp::Any visitMk(SpecParser::MkContext* ctx) override { return std::any(); }
    // antlrcpp::Any visitString(SpecParser::StringContext* ctx) override { return std::any(); }
    // antlrcpp::Any visitRecord_def_stmt(SpecParser::Record_def_stmtContext* ctx) override;
    // antlrcpp::Any visitRecord_fields_def(SpecParser::Record_fields_defContext* ctx) override;

};

std::any parse_light(Project *proj, const std::string& text);

} // namespace autov::parser
