
// Generated from Spec.g4 by ANTLR 4.12.0

#pragma once


#include "antlr4-runtime.h"




class  SpecLexer : public antlr4::Lexer {
public:
  enum {
    T__0 = 1, T__1 = 2, T__2 = 3, T__3 = 4, T__4 = 5, T__5 = 6, T__6 = 7, 
    T__7 = 8, T__8 = 9, T__9 = 10, T__10 = 11, T__11 = 12, T__12 = 13, T__13 = 14, 
    T__14 = 15, T__15 = 16, T__16 = 17, T__17 = 18, T__18 = 19, T__19 = 20, 
    T__20 = 21, T__21 = 22, T__22 = 23, T__23 = 24, T__24 = 25, T__25 = 26, 
    T__26 = 27, T__27 = 28, T__28 = 29, T__29 = 30, T__30 = 31, T__31 = 32, 
    MK = 33, INDUC = 34, RECORD = 35, FIXPOINT = 36, SECTION = 37, SECTION_END = 38, 
    APPEND = 39, CONCAT = 40, ADD = 41, MINUS = 42, MULT = 43, DIV = 44, 
    MOD = 45, LSHIFT = 46, RSHIFT = 47, BITAND = 48, BITOR = 49, BAND = 50, 
    BOR = 51, BEQ = 52, BNE = 53, BGT = 54, BLT = 55, BGE = 56, BLE = 57, 
    SEQ = 58, SNE = 59, GET = 60, SET = 61, NTH = 62, AND = 63, OR = 64, 
    NOT = 65, BNOT = 66, IMPLIES = 67, IFONLYIF = 68, EQUAL = 69, NOT_EQUAL = 70, 
    GT = 71, LT = 72, GTE = 73, LTE = 74, LP = 75, RP = 76, IF = 77, THEN = 78, 
    LET = 79, ELSE = 80, PARAM = 81, DEF = 82, WHEN = 83, FORALL = 84, EXISTS = 85, 
    MATCH = 86, RETURN = 87, WITH = 88, END = 89, RELY = 90, ANNO = 91, 
    TRUE = 92, FALSE = 93, NUMBER = 94, STR = 95, ID = 96, COMMENT = 97, 
    WS = 98
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

