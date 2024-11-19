
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
    T__32 = 33, MK = 34, INDUC = 35, RECORD = 36, FIXPOINT = 37, SECTION = 38, 
    SECTION_END = 39, APPEND = 40, CONCAT = 41, ADD = 42, MINUS = 43, MULT = 44, 
    DIV = 45, MOD = 46, LSHIFT = 47, RSHIFT = 48, BITAND = 49, BITOR = 50, 
    BAND = 51, BOR = 52, BEQ = 53, BNE = 54, BGT = 55, BLT = 56, BGE = 57, 
    BLE = 58, SEQ = 59, SNE = 60, GET = 61, SET = 62, NTH = 63, AND = 64, 
    OR = 65, NOT = 66, BNOT = 67, IMPLIES = 68, IFONLYIF = 69, EQUAL = 70, 
    NOT_EQUAL = 71, GT = 72, LT = 73, GTE = 74, LTE = 75, LP = 76, RP = 77, 
    IF = 78, THEN = 79, LET = 80, ELSE = 81, PARAM = 82, DEF = 83, WHEN = 84, 
    FORALL = 85, EXISTS = 86, MATCH = 87, RETURN = 88, WITH = 89, END = 90, 
    RELY = 91, ANNO = 92, TRUE = 93, FALSE = 94, NUMBER = 95, STR = 96, 
    ID = 97, COMMENT = 98, WS = 99
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

