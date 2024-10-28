
// Generated from Spec.g4 by ANTLR 4.12.0

#pragma once


#include "antlr4-runtime.h"


namespace autov::parser {


class  SpecParser : public antlr4::Parser {
public:
  enum {
    T__0 = 1, T__1 = 2, T__2 = 3, T__3 = 4, T__4 = 5, T__5 = 6, T__6 = 7, 
    T__7 = 8, T__8 = 9, T__9 = 10, T__10 = 11, T__11 = 12, T__12 = 13, T__13 = 14, 
    T__14 = 15, T__15 = 16, T__16 = 17, T__17 = 18, T__18 = 19, T__19 = 20, 
    T__20 = 21, T__21 = 22, T__22 = 23, T__23 = 24, T__24 = 25, T__25 = 26, 
    MK = 27, INDUC = 28, RECORD = 29, FIXPOINT = 30, SECTION = 31, SECTION_END = 32, 
    APPEND = 33, CONCAT = 34, ADD = 35, MINUS = 36, MULT = 37, DIV = 38, 
    MOD = 39, LSHIFT = 40, RSHIFT = 41, BITAND = 42, BITOR = 43, BAND = 44, 
    BOR = 45, BEQ = 46, BNE = 47, BGT = 48, BLT = 49, BGE = 50, BLE = 51, 
    SEQ = 52, SNE = 53, GET = 54, SET = 55, NTH = 56, AND = 57, OR = 58, 
    NOT = 59, BNOT = 60, IMPLIES = 61, IFONLYIF = 62, EQUAL = 63, NOT_EQUAL = 64, 
    GT = 65, LT = 66, GTE = 67, LTE = 68, LP = 69, RP = 70, IF = 71, THEN = 72, 
    LET = 73, ELSE = 74, PARAM = 75, DEF = 76, WHEN = 77, FORALL = 78, EXISTS = 79, 
    MATCH = 80, RETURN = 81, WITH = 82, END = 83, RELY = 84, ANNO = 85, 
    TRUE = 86, FALSE = 87, NUMBER = 88, STR = 89, ID = 90, COMMENT = 91, 
    WS = 92
  };

  enum {
    RuleProgram = 0, RuleStatement = 1, RuleTypedef = 2, RuleDef = 3, RuleDecl = 4, 
    RuleFixpoint = 5, RulePath = 6, RuleInclude = 7, RuleCommand = 8, RuleSection_begin = 9, 
    RuleSection_end = 10, RuleType = 11, RuleExpr = 12, RuleExpr_op = 13, 
    RuleTerm = 14, RuleTuple = 15, RuleFunc_call = 16, RuleForall_expr = 17, 
    RuleExists_expr = 18, RuleVar_anno = 19, RuleLet_stmt = 20, RuleWhen_stmt = 21, 
    RuleMatch_stmt = 22, RuleMatch_branch = 23, RuleAssert_stmt = 24, RuleAnno_stmt = 25, 
    RuleIf_stmt = 26, RuleInductive_decl = 27, RuleInduct_arm = 28, RuleRecord_decl = 29, 
    RuleRecord_fields = 30, RuleRecord_def_stmt = 31, RuleRecord_fields_def = 32, 
    RuleValue = 33, RuleMk = 34, RuleName = 35, RuleNumber = 36, RuleString = 37, 
    RuleBool = 38
  };

  explicit SpecParser(antlr4::TokenStream *input);

  SpecParser(antlr4::TokenStream *input, const antlr4::atn::ParserATNSimulatorOptions &options);

  ~SpecParser() override;

  std::string getGrammarFileName() const override;

  const antlr4::atn::ATN& getATN() const override;

  const std::vector<std::string>& getRuleNames() const override;

  const antlr4::dfa::Vocabulary& getVocabulary() const override;

  antlr4::atn::SerializedATNView getSerializedATN() const override;


  class ProgramContext;
  class StatementContext;
  class TypedefContext;
  class DefContext;
  class DeclContext;
  class FixpointContext;
  class PathContext;
  class IncludeContext;
  class CommandContext;
  class Section_beginContext;
  class Section_endContext;
  class TypeContext;
  class ExprContext;
  class Expr_opContext;
  class TermContext;
  class TupleContext;
  class Func_callContext;
  class Forall_exprContext;
  class Exists_exprContext;
  class Var_annoContext;
  class Let_stmtContext;
  class When_stmtContext;
  class Match_stmtContext;
  class Match_branchContext;
  class Assert_stmtContext;
  class Anno_stmtContext;
  class If_stmtContext;
  class Inductive_declContext;
  class Induct_armContext;
  class Record_declContext;
  class Record_fieldsContext;
  class Record_def_stmtContext;
  class Record_fields_defContext;
  class ValueContext;
  class MkContext;
  class NameContext;
  class NumberContext;
  class StringContext;
  class BoolContext; 

  class  ProgramContext : public antlr4::ParserRuleContext {
  public:
    ProgramContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *EOF();
    std::vector<StatementContext *> statement();
    StatementContext* statement(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ProgramContext* program();

  class  StatementContext : public antlr4::ParserRuleContext {
  public:
    StatementContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Section_beginContext *section_begin();
    Section_endContext *section_end();
    TypedefContext *typedef_();
    DefContext *def();
    DeclContext *decl();
    FixpointContext *fixpoint();
    Inductive_declContext *inductive_decl();
    Record_declContext *record_decl();
    IncludeContext *include();
    CommandContext *command();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  StatementContext* statement();

  class  TypedefContext : public antlr4::ParserRuleContext {
  public:
    TypedefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DEF();
    NameContext *name();
    TypeContext *type();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypedefContext* typedef_();

  class  DefContext : public antlr4::ParserRuleContext {
  public:
    DefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DEF();
    NameContext *name();
    TypeContext *type();
    ExprContext *expr();
    std::vector<Var_annoContext *> var_anno();
    Var_annoContext* var_anno(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  DefContext* def();

  class  DeclContext : public antlr4::ParserRuleContext {
  public:
    DeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *PARAM();
    NameContext *name();
    TypeContext *type();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  DeclContext* decl();

  class  FixpointContext : public antlr4::ParserRuleContext {
  public:
    FixpointContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *FIXPOINT();
    NameContext *name();
    TypeContext *type();
    ExprContext *expr();
    std::vector<Var_annoContext *> var_anno();
    Var_annoContext* var_anno(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  FixpointContext* fixpoint();

  class  PathContext : public antlr4::ParserRuleContext {
  public:
    PathContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *STR();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  PathContext* path();

  class  IncludeContext : public antlr4::ParserRuleContext {
  public:
    IncludeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    PathContext *path();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  IncludeContext* include();

  class  CommandContext : public antlr4::ParserRuleContext {
  public:
    CommandContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExprContext *expr();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  CommandContext* command();

  class  Section_beginContext : public antlr4::ParserRuleContext {
  public:
    Section_beginContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SECTION();
    NameContext *name();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Section_beginContext* section_begin();

  class  Section_endContext : public antlr4::ParserRuleContext {
  public:
    Section_endContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SECTION_END();
    NameContext *name();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Section_endContext* section_end();

  class  TypeContext : public antlr4::ParserRuleContext {
  public:
    SpecParser::TypeContext *domain = nullptr;
    antlr4::Token *Z_type = nullptr;
    antlr4::Token *bool_type = nullptr;
    antlr4::Token *str_type = nullptr;
    antlr4::Token *type_type = nullptr;
    antlr4::Token *prop_type = nullptr;
    antlr4::Token *list_type = nullptr;
    antlr4::Token *option_type = nullptr;
    antlr4::Token *map_type = nullptr;
    antlr4::Token *tup = nullptr;
    SpecParser::TypeContext *par = nullptr;
    SpecParser::TypeContext *codomain = nullptr;
    TypeContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<TypeContext *> type();
    TypeContext* type(size_t i);
    antlr4::tree::TerminalNode *LP();
    antlr4::tree::TerminalNode *RP();
    std::vector<antlr4::tree::TerminalNode *> MULT();
    antlr4::tree::TerminalNode* MULT(size_t i);
    NameContext *name();
    antlr4::tree::TerminalNode *IMPLIES();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TypeContext* type();
  TypeContext* type(int precedence);
  class  ExprContext : public antlr4::ParserRuleContext {
  public:
    ExprContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Let_stmtContext *let_stmt();
    When_stmtContext *when_stmt();
    Match_stmtContext *match_stmt();
    Assert_stmtContext *assert_stmt();
    Anno_stmtContext *anno_stmt();
    If_stmtContext *if_stmt();
    Record_def_stmtContext *record_def_stmt();
    Expr_opContext *expr_op();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ExprContext* expr();

  class  Expr_opContext : public antlr4::ParserRuleContext {
  public:
    SpecParser::TermContext *op = nullptr;
    antlr4::Token *binop = nullptr;
    antlr4::Token *map_set = nullptr;
    antlr4::Token *map_get = nullptr;
    antlr4::Token *list_nth = nullptr;
    antlr4::Token *record_set = nullptr;
    antlr4::Token *record_set2 = nullptr;
    Expr_opContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<TermContext *> term();
    TermContext* term(size_t i);
    Exists_exprContext *exists_expr();
    std::vector<Expr_opContext *> expr_op();
    Expr_opContext* expr_op(size_t i);
    Forall_exprContext *forall_expr();
    antlr4::tree::TerminalNode *MULT();
    antlr4::tree::TerminalNode *DIV();
    antlr4::tree::TerminalNode *MOD();
    antlr4::tree::TerminalNode *ADD();
    antlr4::tree::TerminalNode *MINUS();
    antlr4::tree::TerminalNode *BITAND();
    antlr4::tree::TerminalNode *BITOR();
    antlr4::tree::TerminalNode *BEQ();
    antlr4::tree::TerminalNode *BNE();
    antlr4::tree::TerminalNode *BGT();
    antlr4::tree::TerminalNode *BGE();
    antlr4::tree::TerminalNode *BLT();
    antlr4::tree::TerminalNode *BLE();
    antlr4::tree::TerminalNode *BAND();
    antlr4::tree::TerminalNode *BOR();
    antlr4::tree::TerminalNode *LSHIFT();
    antlr4::tree::TerminalNode *RSHIFT();
    antlr4::tree::TerminalNode *SEQ();
    antlr4::tree::TerminalNode *SNE();
    antlr4::tree::TerminalNode *APPEND();
    antlr4::tree::TerminalNode *CONCAT();
    antlr4::tree::TerminalNode *SET();
    antlr4::tree::TerminalNode *GET();
    antlr4::tree::TerminalNode *NTH();
    std::vector<NameContext *> name();
    NameContext* name(size_t i);
    antlr4::tree::TerminalNode *EQUAL();
    antlr4::tree::TerminalNode *NOT_EQUAL();
    antlr4::tree::TerminalNode *LT();
    antlr4::tree::TerminalNode *LTE();
    antlr4::tree::TerminalNode *GT();
    antlr4::tree::TerminalNode *GTE();
    antlr4::tree::TerminalNode *IFONLYIF();
    antlr4::tree::TerminalNode *OR();
    antlr4::tree::TerminalNode *AND();
    antlr4::tree::TerminalNode *IMPLIES();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Expr_opContext* expr_op();
  Expr_opContext* expr_op(int precedence);
  class  TermContext : public antlr4::ParserRuleContext {
  public:
    SpecParser::ExprContext *par = nullptr;
    antlr4::Token *uniop = nullptr;
    antlr4::Token *record_get = nullptr;
    TermContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LP();
    antlr4::tree::TerminalNode *RP();
    ExprContext *expr();
    TermContext *term();
    antlr4::tree::TerminalNode *MINUS();
    antlr4::tree::TerminalNode *NOT();
    antlr4::tree::TerminalNode *BNOT();
    TupleContext *tuple();
    ValueContext *value();
    NameContext *name();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TermContext* term();
  TermContext* term(int precedence);
  class  TupleContext : public antlr4::ParserRuleContext {
  public:
    TupleContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LP();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *RP();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  TupleContext* tuple();

  class  Func_callContext : public antlr4::ParserRuleContext {
  public:
    Func_callContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NameContext *name();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Func_callContext* func_call();

  class  Forall_exprContext : public antlr4::ParserRuleContext {
  public:
    Forall_exprContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *FORALL();
    std::vector<Var_annoContext *> var_anno();
    Var_annoContext* var_anno(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Forall_exprContext* forall_expr();

  class  Exists_exprContext : public antlr4::ParserRuleContext {
  public:
    Exists_exprContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *EXISTS();
    std::vector<Var_annoContext *> var_anno();
    Var_annoContext* var_anno(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Exists_exprContext* exists_expr();

  class  Var_annoContext : public antlr4::ParserRuleContext {
  public:
    Var_annoContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LP();
    NameContext *name();
    TypeContext *type();
    antlr4::tree::TerminalNode *RP();
    ExprContext *expr();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Var_annoContext* var_anno();

  class  Let_stmtContext : public antlr4::ParserRuleContext {
  public:
    Let_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LET();
    NameContext *name();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    TupleContext *tuple();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Let_stmtContext* let_stmt();

  class  When_stmtContext : public antlr4::ParserRuleContext {
  public:
    When_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *WHEN();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    std::vector<NameContext *> name();
    NameContext* name(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  When_stmtContext* when_stmt();

  class  Match_stmtContext : public antlr4::ParserRuleContext {
  public:
    Match_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *MATCH();
    ExprContext *expr();
    antlr4::tree::TerminalNode *WITH();
    antlr4::tree::TerminalNode *END();
    std::vector<Match_branchContext *> match_branch();
    Match_branchContext* match_branch(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Match_stmtContext* match_stmt();

  class  Match_branchContext : public antlr4::ParserRuleContext {
  public:
    Match_branchContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Match_branchContext* match_branch();

  class  Assert_stmtContext : public antlr4::ParserRuleContext {
  public:
    Assert_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RELY();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Assert_stmtContext* assert_stmt();

  class  Anno_stmtContext : public antlr4::ParserRuleContext {
  public:
    Anno_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ANNO();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Anno_stmtContext* anno_stmt();

  class  If_stmtContext : public antlr4::ParserRuleContext {
  public:
    If_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *IF();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *THEN();
    antlr4::tree::TerminalNode *ELSE();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  If_stmtContext* if_stmt();

  class  Inductive_declContext : public antlr4::ParserRuleContext {
  public:
    Inductive_declContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *INDUC();
    NameContext *name();
    std::vector<Induct_armContext *> induct_arm();
    Induct_armContext* induct_arm(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Inductive_declContext* inductive_decl();

  class  Induct_armContext : public antlr4::ParserRuleContext {
  public:
    Induct_armContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NameContext *name();
    std::vector<Var_annoContext *> var_anno();
    Var_annoContext* var_anno(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Induct_armContext* induct_arm();

  class  Record_declContext : public antlr4::ParserRuleContext {
  public:
    Record_declContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RECORD();
    std::vector<NameContext *> name();
    NameContext* name(size_t i);
    Record_fieldsContext *record_fields();
    std::vector<Var_annoContext *> var_anno();
    Var_annoContext* var_anno(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Record_declContext* record_decl();

  class  Record_fieldsContext : public antlr4::ParserRuleContext {
  public:
    Record_fieldsContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<NameContext *> name();
    NameContext* name(size_t i);
    std::vector<TypeContext *> type();
    TypeContext* type(size_t i);
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Record_fieldsContext* record_fields();

  class  Record_def_stmtContext : public antlr4::ParserRuleContext {
  public:
    Record_def_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Record_fields_defContext *record_fields_def();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Record_def_stmtContext* record_def_stmt();

  class  Record_fields_defContext : public antlr4::ParserRuleContext {
  public:
    Record_fields_defContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<NameContext *> name();
    NameContext* name(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Record_fields_defContext* record_fields_def();

  class  ValueContext : public antlr4::ParserRuleContext {
  public:
    ValueContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NameContext *name();
    NumberContext *number();
    BoolContext *bool_();
    StringContext *string();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  ValueContext* value();

  class  MkContext : public antlr4::ParserRuleContext {
  public:
    MkContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *MK();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  MkContext* mk();

  class  NameContext : public antlr4::ParserRuleContext {
  public:
    NameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ID();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  NameContext* name();

  class  NumberContext : public antlr4::ParserRuleContext {
  public:
    NumberContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *NUMBER();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  NumberContext* number();

  class  StringContext : public antlr4::ParserRuleContext {
  public:
    StringContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *STR();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  StringContext* string();

  class  BoolContext : public antlr4::ParserRuleContext {
  public:
    BoolContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *TRUE();
    antlr4::tree::TerminalNode *FALSE();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  BoolContext* bool_();


  bool sempred(antlr4::RuleContext *_localctx, size_t ruleIndex, size_t predicateIndex) override;

  bool typeSempred(TypeContext *_localctx, size_t predicateIndex);
  bool expr_opSempred(Expr_opContext *_localctx, size_t predicateIndex);
  bool termSempred(TermContext *_localctx, size_t predicateIndex);

  // By default the static state used to implement the parser is lazily initialized during the first
  // call to the constructor. You can call this function if you wish to initialize the static state
  // ahead of time.
  static void initialize();

private:
};

}  // namespace autov::parser
