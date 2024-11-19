
// Generated from Spec.g4 by ANTLR 4.12.0

#pragma once


#include "antlr4-runtime.h"
#include "SpecParser.h"


namespace autov::parser {
/**
 * This class defines an abstract visitor for a parse tree
 * produced by SpecParser.
 */
class  SpecVisitor : public antlr4::tree::AbstractParseTreeVisitor {
public:

  /**
   * Visit parse trees produced by SpecParser.
   */
    virtual std::any visitProgram(SpecParser::ProgramContext *context) = 0;

    virtual std::any visitStatement(SpecParser::StatementContext *context) = 0;

    virtual std::any visitTypedef(SpecParser::TypedefContext *context) = 0;

    virtual std::any visitDef(SpecParser::DefContext *context) = 0;

    virtual std::any visitInvdef(SpecParser::InvdefContext *context) = 0;

    virtual std::any visitDecl(SpecParser::DeclContext *context) = 0;

    virtual std::any visitFixpoint(SpecParser::FixpointContext *context) = 0;

    virtual std::any visitPath(SpecParser::PathContext *context) = 0;

    virtual std::any visitInclude(SpecParser::IncludeContext *context) = 0;

    virtual std::any visitCommand(SpecParser::CommandContext *context) = 0;

    virtual std::any visitGlobal_anno(SpecParser::Global_annoContext *context) = 0;

    virtual std::any visitAnno_struct(SpecParser::Anno_structContext *context) = 0;

    virtual std::any visitLoop_inv(SpecParser::Loop_invContext *context) = 0;

    virtual std::any visitSection_begin(SpecParser::Section_beginContext *context) = 0;

    virtual std::any visitSection_end(SpecParser::Section_endContext *context) = 0;

    virtual std::any visitType(SpecParser::TypeContext *context) = 0;

    virtual std::any visitExpr(SpecParser::ExprContext *context) = 0;

    virtual std::any visitExpr_op(SpecParser::Expr_opContext *context) = 0;

    virtual std::any visitTerm(SpecParser::TermContext *context) = 0;

    virtual std::any visitTuple(SpecParser::TupleContext *context) = 0;

    virtual std::any visitFunc_call(SpecParser::Func_callContext *context) = 0;

    virtual std::any visitForall_expr(SpecParser::Forall_exprContext *context) = 0;

    virtual std::any visitExists_expr(SpecParser::Exists_exprContext *context) = 0;

    virtual std::any visitVar_anno(SpecParser::Var_annoContext *context) = 0;

    virtual std::any visitLet_stmt(SpecParser::Let_stmtContext *context) = 0;

    virtual std::any visitWhen_stmt(SpecParser::When_stmtContext *context) = 0;

    virtual std::any visitMatch_stmt(SpecParser::Match_stmtContext *context) = 0;

    virtual std::any visitMatch_branch(SpecParser::Match_branchContext *context) = 0;

    virtual std::any visitAssert_stmt(SpecParser::Assert_stmtContext *context) = 0;

    virtual std::any visitAnno_stmt(SpecParser::Anno_stmtContext *context) = 0;

    virtual std::any visitIf_stmt(SpecParser::If_stmtContext *context) = 0;

    virtual std::any visitInductive_decl(SpecParser::Inductive_declContext *context) = 0;

    virtual std::any visitInduct_arm(SpecParser::Induct_armContext *context) = 0;

    virtual std::any visitRecord_decl(SpecParser::Record_declContext *context) = 0;

    virtual std::any visitRecord_fields(SpecParser::Record_fieldsContext *context) = 0;

    virtual std::any visitRecord_def_stmt(SpecParser::Record_def_stmtContext *context) = 0;

    virtual std::any visitRecord_fields_def(SpecParser::Record_fields_defContext *context) = 0;

    virtual std::any visitValue(SpecParser::ValueContext *context) = 0;

    virtual std::any visitMk(SpecParser::MkContext *context) = 0;

    virtual std::any visitName(SpecParser::NameContext *context) = 0;

    virtual std::any visitNumber(SpecParser::NumberContext *context) = 0;

    virtual std::any visitString(SpecParser::StringContext *context) = 0;

    virtual std::any visitBool(SpecParser::BoolContext *context) = 0;


};

} // namespace autov::parser