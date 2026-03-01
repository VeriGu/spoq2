
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
    T__32 = 33, T__33 = 34, MK = 35, INDUC = 36, RECORD = 37, FIXPOINT = 38, 
    SECTION = 39, SECTION_END = 40, APPEND = 41, CONCAT = 42, ADD = 43, 
    MINUS = 44, MULT = 45, DIV = 46, MOD = 47, LSHIFT = 48, RSHIFT = 49, 
    BITAND = 50, BITOR = 51, BAND = 52, BOR = 53, BEQ = 54, BNE = 55, BGT = 56, 
    BLT = 57, BGE = 58, BLE = 59, SEQ = 60, SNE = 61, LIST_EQ = 62, GET = 63, 
    SET = 64, NTH = 65, AND = 66, OR = 67, NOT = 68, BNOT = 69, IMPLIES = 70, 
    IFONLYIF = 71, EQUAL = 72, NOT_EQUAL = 73, GT = 74, LT = 75, GTE = 76, 
    LTE = 77, LP = 78, RP = 79, IF = 80, THEN = 81, LET = 82, ELSE = 83, 
    PARAM = 84, DEF = 85, WHEN = 86, FORALL = 87, EXISTS = 88, MATCH = 89, 
    RETURN = 90, WITH = 91, END = 92, RELY = 93, ANNO = 94, TRUE = 95, FALSE = 96, 
    NUMBER = 97, STR = 98, ID = 99, COMMENT = 100, WS = 101
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

