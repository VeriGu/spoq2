
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
    T__32 = 33, T__33 = 34, T__34 = 35, T__35 = 36, T__36 = 37, T__37 = 38, 
    T__38 = 39, MK = 40, INDUC = 41, RECORD = 42, FIXPOINT = 43, SECTION = 44, 
    SECTION_END = 45, APPEND = 46, CONCAT = 47, ADD = 48, MINUS = 49, MULT = 50, 
    DIV = 51, MOD = 52, LSHIFT = 53, RSHIFT = 54, BITAND = 55, BITOR = 56, 
    BAND = 57, BOR = 58, BEQ = 59, BNE = 60, BGT = 61, BLT = 62, BGE = 63, 
    BLE = 64, SEQ = 65, SNE = 66, LIST_EQ = 67, GET = 68, SET = 69, NTH = 70, 
    AND = 71, OR = 72, NOT = 73, BNOT = 74, IMPLIES = 75, IFONLYIF = 76, 
    EQUAL = 77, NOT_EQUAL = 78, GT = 79, LT = 80, GTE = 81, LTE = 82, LP = 83, 
    RP = 84, IF = 85, THEN = 86, LET = 87, ELSE = 88, PARAM = 89, DEF = 90, 
    WHEN = 91, FORALL = 92, EXISTS = 93, MATCH = 94, RETURN = 95, WITH = 96, 
    END = 97, RELY = 98, ANNO = 99, TRUE = 100, FALSE = 101, NUMBER = 102, 
    STR = 103, ID = 104, COMMENT = 105, WS = 106
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

