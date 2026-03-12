
// Generated from Spec.g4 by ANTLR 4.12.0

#pragma once


#include "antlr4-runtime.h"




class  SpecParser : public antlr4::Parser {
public:
  enum {
    T__0 = 1, T__1 = 2, T__2 = 3, T__3 = 4, T__4 = 5, T__5 = 6, T__6 = 7, 
    T__7 = 8, T__8 = 9, T__9 = 10, T__10 = 11, T__11 = 12, T__12 = 13, T__13 = 14, 
    T__14 = 15, T__15 = 16, T__16 = 17, T__17 = 18, T__18 = 19, T__19 = 20, 
    T__20 = 21, T__21 = 22, T__22 = 23, T__23 = 24, T__24 = 25, T__25 = 26, 
    T__26 = 27, T__27 = 28, T__28 = 29, T__29 = 30, T__30 = 31, T__31 = 32, 
    T__32 = 33, T__33 = 34, T__34 = 35, MK = 36, INDUC = 37, RECORD = 38, 
    FIXPOINT = 39, SECTION = 40, SECTION_END = 41, APPEND = 42, CONCAT = 43, 
    ADD = 44, MINUS = 45, MULT = 46, DIV = 47, MOD = 48, LSHIFT = 49, RSHIFT = 50, 
    BITAND = 51, BITOR = 52, BAND = 53, BOR = 54, BEQ = 55, BNE = 56, BGT = 57, 
    BLT = 58, BGE = 59, BLE = 60, SEQ = 61, SNE = 62, LIST_EQ = 63, GET = 64, 
    SET = 65, NTH = 66, AND = 67, OR = 68, NOT = 69, BNOT = 70, IMPLIES = 71, 
    IFONLYIF = 72, EQUAL = 73, NOT_EQUAL = 74, GT = 75, LT = 76, GTE = 77, 
    LTE = 78, LP = 79, RP = 80, IF = 81, THEN = 82, LET = 83, ELSE = 84, 
    PARAM = 85, DEF = 86, WHEN = 87, FORALL = 88, EXISTS = 89, MATCH = 90, 
    RETURN = 91, WITH = 92, END = 93, RELY = 94, ANNO = 95, TRUE = 96, FALSE = 97, 
    NUMBER = 98, STR = 99, ID = 100, COMMENT = 101, WS = 102
  };

  enum {
    RuleProgram = 0, RuleStatement = 1, RuleTypedef = 2, RuleDef = 3, RuleInvdef = 4, 
    RuleDecl = 5, RuleFixpoint = 6, RulePath = 7, RuleInclude = 8, RuleCommand = 9, 
    RuleGlobal_anno = 10, RuleAnno_struct = 11, RuleLoop_inv = 12, RuleSection_begin = 13, 
    RuleSection_end = 14, RuleType = 15, RuleExpr = 16, RuleExpr_op = 17, 
    RuleTerm = 18, RuleTuple = 19, RuleFunc_call = 20, RuleForall_expr = 21, 
    RuleExists_expr = 22, RuleVar_anno = 23, RuleLet_stmt = 24, RuleWhen_stmt = 25, 
    RuleMatch_stmt = 26, RuleMatch_branch = 27, RuleAssert_stmt = 28, RuleAnno_stmt = 29, 
    RuleIf_stmt = 30, RuleInductive_decl = 31, RuleInduct_arm = 32, RuleRecord_decl = 33, 
    RuleRecord_fields = 34, RuleRecord_def_stmt = 35, RuleRecord_fields_def = 36, 
    RuleValue = 37, RuleMk = 38, RuleName = 39, RuleNumber = 40, RuleString = 41, 
    RuleBool = 42
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
  class InvdefContext;
  class DeclContext;
  class FixpointContext;
  class PathContext;
  class IncludeContext;
  class CommandContext;
  class Global_annoContext;
  class Anno_structContext;
  class Loop_invContext;
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
    InvdefContext *invdef();
    FixpointContext *fixpoint();
    Inductive_declContext *inductive_decl();
    Record_declContext *record_decl();
    IncludeContext *include();
    CommandContext *command();
    Global_annoContext *global_anno();
    Loop_invContext *loop_inv();


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

  class  InvdefContext : public antlr4::ParserRuleContext {
  public:
    InvdefContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NameContext *name();
    ExprContext *expr();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  InvdefContext* invdef();

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

  class  Global_annoContext : public antlr4::ParserRuleContext {
  public:
    Global_annoContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    NameContext *name();
    Anno_structContext *anno_struct();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Global_annoContext* global_anno();

  class  Anno_structContext : public antlr4::ParserRuleContext {
  public:
    SpecParser::NumberContext *base = nullptr;
    SpecParser::NumberContext *size = nullptr;
    SpecParser::NumberContext *max_elems = nullptr;
    Anno_structContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<NumberContext *> number();
    NumberContext* number(size_t i);


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Anno_structContext* anno_struct();

  class  Loop_invContext : public antlr4::ParserRuleContext {
  public:
    Loop_invContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExprContext *expr();


    virtual std::any accept(antlr4::tree::ParseTreeVisitor *visitor) override;
   
  };

  Loop_invContext* loop_inv();

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
    antlr4::Token *zmap_type = nullptr;
    antlr4::Token *smap_type = nullptr;
    antlr4::Token *vector_type = nullptr;
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
    antlr4::tree::TerminalNode *LIST_EQ();
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

