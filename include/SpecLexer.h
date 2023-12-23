
// Generated from Spec.g4 by ANTLR 4.12.0

#pragma once


#include "antlr4-runtime.h"


namespace autov::parser {


class  SpecLexer : public antlr4::Lexer {
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

  explicit SpecLexer(antlr4::CharStream *input);

  ~SpecLexer() override;


  std::string getGrammarFileName() const override;

  const std::vector<std::string>& getRuleNames() const override;

  const std::vector<std::string>& getChannelNames() const override;

  const std::vector<std::string>& getModeNames() const override;

  const antlr4::dfa::Vocabulary& getVocabulary() const override;

  antlr4::atn::SerializedATNView getSerializedATN() const override;

  const antlr4::atn::ATN& getATN() const override;

  // By default the static state used to implement the lexer is lazily initialized during the first
  // call to the constructor. You can call this function if you wish to initialize the static state
  // ahead of time.
  static void initialize();

private:

  // Individual action functions triggered by action() above.

  // Individual semantic predicate functions triggered by sempred() above.

};

}  // namespace autov::parser
