
// Generated from Spec.g4 by ANTLR 4.12.0

#pragma once


#include "antlr4-runtime.h"
#include "SpecVisitor.h"

namespace autov::parser {
/**
 * This class provides an empty implementation of SpecVisitor, which can be
 * extended to create a visitor which only needs to handle a subset of the available methods.
 */
class  SpecBaseVisitor : public SpecVisitor {
public:

  virtual std::any visitProgram(SpecParser::ProgramContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitStatement(SpecParser::StatementContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTypedef(SpecParser::TypedefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitDef(SpecParser::DefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInvdef(SpecParser::InvdefContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitDecl(SpecParser::DeclContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFixpoint(SpecParser::FixpointContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitPath(SpecParser::PathContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInclude(SpecParser::IncludeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitCommand(SpecParser::CommandContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitGlobal_anno(SpecParser::Global_annoContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAnno_struct(SpecParser::Anno_structContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLoop_inv(SpecParser::Loop_invContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSection_begin(SpecParser::Section_beginContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitSection_end(SpecParser::Section_endContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitType(SpecParser::TypeContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitExpr(SpecParser::ExprContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitExpr_op(SpecParser::Expr_opContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTerm(SpecParser::TermContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitTuple(SpecParser::TupleContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitFunc_call(SpecParser::Func_callContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitForall_expr(SpecParser::Forall_exprContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitExists_expr(SpecParser::Exists_exprContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitVar_anno(SpecParser::Var_annoContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitLet_stmt(SpecParser::Let_stmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitWhen_stmt(SpecParser::When_stmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitMatch_stmt(SpecParser::Match_stmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitMatch_branch(SpecParser::Match_branchContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAssert_stmt(SpecParser::Assert_stmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitAnno_stmt(SpecParser::Anno_stmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitIf_stmt(SpecParser::If_stmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInductive_decl(SpecParser::Inductive_declContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitInduct_arm(SpecParser::Induct_armContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRecord_decl(SpecParser::Record_declContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRecord_fields(SpecParser::Record_fieldsContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRecord_def_stmt(SpecParser::Record_def_stmtContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitRecord_fields_def(SpecParser::Record_fields_defContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitValue(SpecParser::ValueContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitMk(SpecParser::MkContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitName(SpecParser::NameContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitNumber(SpecParser::NumberContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitString(SpecParser::StringContext *ctx) override {
    return visitChildren(ctx);
  }

  virtual std::any visitBool(SpecParser::BoolContext *ctx) override {
    return visitChildren(ctx);
  }


};

}

