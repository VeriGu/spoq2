
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

