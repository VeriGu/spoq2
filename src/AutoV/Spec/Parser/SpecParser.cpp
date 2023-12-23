
// Generated from Spec.g4 by ANTLR 4.12.0


#include "SpecVisitor.h"

#include "SpecParser.h"


using namespace antlrcpp;
using namespace autov::parser;

using namespace antlr4;

namespace {

struct SpecParserStaticData final {
  SpecParserStaticData(std::vector<std::string> ruleNames,
                        std::vector<std::string> literalNames,
                        std::vector<std::string> symbolicNames)
      : ruleNames(std::move(ruleNames)), literalNames(std::move(literalNames)),
        symbolicNames(std::move(symbolicNames)),
        vocabulary(this->literalNames, this->symbolicNames) {}

  SpecParserStaticData(const SpecParserStaticData&) = delete;
  SpecParserStaticData(SpecParserStaticData&&) = delete;
  SpecParserStaticData& operator=(const SpecParserStaticData&) = delete;
  SpecParserStaticData& operator=(SpecParserStaticData&&) = delete;

  std::vector<antlr4::dfa::DFA> decisionToDFA;
  antlr4::atn::PredictionContextCache sharedContextCache;
  const std::vector<std::string> ruleNames;
  const std::vector<std::string> literalNames;
  const std::vector<std::string> symbolicNames;
  const antlr4::dfa::Vocabulary vocabulary;
  antlr4::atn::SerializedATNView serializedATN;
  std::unique_ptr<antlr4::atn::ATN> atn;
};

::antlr4::internal::OnceFlag specParserOnceFlag;
SpecParserStaticData *specParserStaticData = nullptr;

void specParserInitialize() {
  assert(specParserStaticData == nullptr);
  auto staticData = std::make_unique<SpecParserStaticData>(
    std::vector<std::string>{
      "program", "statement", "typedef", "def", "decl", "fixpoint", "path", 
      "include", "command", "section_begin", "section_end", "type", "expr", 
      "expr_op", "term", "tuple", "func_call", "forall_expr", "exists_expr", 
      "var_anno", "let_stmt", "when_stmt", "match_stmt", "match_branch", 
      "assert_stmt", "anno_stmt", "if_stmt", "inductive_decl", "induct_arm", 
      "record_decl", "record_fields", "record_def_stmt", "record_fields_def", 
      "value", "mk", "name", "number", "string", "bool"
    },
    std::vector<std::string>{
      "", "':='", "'.'", "':'", "'Include'", "'Hint'", "'Z'", "'bool'", 
      "'string'", "'Type'", "'Prop'", "'list'", "'option'", "'ZMap.t'", 
      "','", "'=='", "'{'", "'}'", "'['", "']'", "':<'", "'in'", "';'", 
      "'|'", "'=>'", "'{|'", "'|}'", "'mk'", "'Inductive'", "'Record'", 
      "'Fixpoint'", "'Section'", "'End'", "'::'", "'++'", "'+'", "'-'", 
      "'*'", "'/'", "'mod'", "'<<'", "'>>'", "'&'", "'|''", "'&&'", "'||'", 
      "'=\\u003F'", "'<>\\u003F'", "'>\\u003F'", "'<\\u003F'", "'>=\\u003F'", 
      "'<=\\u003F'", "'=s'", "'<>s'", "'@'", "'#'", "'$'", "'/\\'", "'\\/'", 
      "'~'", "'!'", "'->'", "'<->'", "'='", "'<>'", "'>'", "'<'", "'>='", 
      "'<='", "'('", "')'", "'if'", "'then'", "'let'", "'else'", "'Parameter'", 
      "'Definition'", "'when'", "'forall'", "'exists'", "'match'", "'return'", 
      "'with'", "'end'", "'rely'", "'anno'", "'true'", "'false'"
    },
    std::vector<std::string>{
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
      "", "", "", "", "", "", "", "", "", "", "MK", "INDUC", "RECORD", "FIXPOINT", 
      "SECTION", "SECTION_END", "APPEND", "CONCAT", "ADD", "MINUS", "MULT", 
      "DIV", "MOD", "LSHIFT", "RSHIFT", "BITAND", "BITOR", "BAND", "BOR", 
      "BEQ", "BNE", "BGT", "BLT", "BGE", "BLE", "SEQ", "SNE", "GET", "SET", 
      "NTH", "AND", "OR", "NOT", "BNOT", "IMPLIES", "IFONLYIF", "EQUAL", 
      "NOT_EQUAL", "GT", "LT", "GTE", "LTE", "LP", "RP", "IF", "THEN", "LET", 
      "ELSE", "PARAM", "DEF", "WHEN", "FORALL", "EXISTS", "MATCH", "RETURN", 
      "WITH", "END", "RELY", "ANNO", "TRUE", "FALSE", "NUMBER", "STR", "ID", 
      "COMMENT", "WS"
    }
  );
  static const int32_t serializedATNSegment[] = {
  	4,1,92,479,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,
  	7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,14,7,
  	14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,2,21,7,
  	21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,2,27,7,27,2,28,7,
  	28,2,29,7,29,2,30,7,30,2,31,7,31,2,32,7,32,2,33,7,33,2,34,7,34,2,35,7,
  	35,2,36,7,36,2,37,7,37,2,38,7,38,1,0,5,0,80,8,0,10,0,12,0,83,9,0,1,0,
  	1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,3,1,97,8,1,1,2,1,2,1,2,1,
  	2,1,2,1,2,1,3,1,3,1,3,5,3,108,8,3,10,3,12,3,111,9,3,1,3,1,3,1,3,1,3,1,
  	3,1,3,1,4,1,4,1,4,1,4,1,4,1,4,1,5,1,5,1,5,5,5,128,8,5,10,5,12,5,131,9,
  	5,1,5,1,5,1,5,1,5,1,5,1,5,1,6,1,6,1,7,1,7,1,7,1,7,1,8,1,8,1,8,1,8,1,9,
  	1,9,1,9,1,9,1,10,1,10,1,10,1,10,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,
  	11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,4,11,173,8,11,11,11,12,11,
  	174,1,11,1,11,1,11,1,11,1,11,1,11,1,11,3,11,184,8,11,1,11,1,11,1,11,1,
  	11,1,11,1,11,5,11,192,8,11,10,11,12,11,195,9,11,1,12,1,12,1,12,1,12,1,
  	12,1,12,1,12,1,12,3,12,205,8,12,1,13,1,13,1,13,4,13,210,8,13,11,13,12,
  	13,211,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,3,13,223,8,13,1,13,
  	1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,
  	1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,
  	1,13,4,13,255,8,13,11,13,12,13,256,1,13,1,13,1,13,1,13,1,13,1,13,1,13,
  	1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,1,13,5,13,278,
  	8,13,10,13,12,13,281,9,13,1,14,1,14,1,14,1,14,1,14,1,14,1,14,1,14,1,14,
  	1,14,1,14,1,14,3,14,295,8,14,1,14,1,14,1,14,1,14,1,14,1,14,5,14,303,8,
  	14,10,14,12,14,306,9,14,1,15,1,15,1,15,1,15,4,15,312,8,15,11,15,12,15,
  	313,1,15,1,15,1,16,1,16,4,16,320,8,16,11,16,12,16,321,1,17,1,17,4,17,
  	326,8,17,11,17,12,17,327,1,18,1,18,4,18,332,8,18,11,18,12,18,333,1,19,
  	1,19,1,19,1,19,1,19,1,19,1,20,1,20,1,20,1,20,1,20,1,20,1,20,1,20,1,20,
  	1,20,1,20,1,20,1,20,1,20,3,20,356,8,20,1,21,1,21,1,21,1,21,5,21,362,8,
  	21,10,21,12,21,365,9,21,1,21,1,21,1,21,1,21,1,21,1,22,1,22,1,22,1,22,
  	4,22,376,8,22,11,22,12,22,377,1,22,1,22,1,23,1,23,1,23,1,23,1,23,1,24,
  	1,24,1,24,1,24,1,24,1,25,1,25,1,25,1,25,1,25,1,26,1,26,1,26,1,26,1,26,
  	1,26,1,26,1,27,1,27,1,27,1,27,4,27,408,8,27,11,27,12,27,409,1,27,1,27,
  	1,28,1,28,1,28,5,28,417,8,28,10,28,12,28,420,9,28,1,29,1,29,1,29,1,29,
  	1,29,1,29,1,29,1,29,1,29,1,30,1,30,1,30,1,30,1,30,1,30,1,30,1,30,1,30,
  	5,30,440,8,30,10,30,12,30,443,9,30,1,31,1,31,1,31,1,31,1,32,1,32,1,32,
  	1,32,1,32,1,32,1,32,1,32,1,32,5,32,458,8,32,10,32,12,32,461,9,32,1,33,
  	1,33,1,33,1,33,3,33,467,8,33,1,34,1,34,1,35,1,35,1,36,1,36,1,37,1,37,
  	1,38,1,38,1,38,0,3,22,26,28,39,0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,
  	30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,
  	76,0,8,1,0,37,39,2,0,35,36,42,43,2,0,40,41,44,53,1,0,33,34,1,0,63,68,
  	2,0,57,58,62,62,2,0,36,36,59,60,1,0,86,87,505,0,81,1,0,0,0,2,96,1,0,0,
  	0,4,98,1,0,0,0,6,104,1,0,0,0,8,118,1,0,0,0,10,124,1,0,0,0,12,138,1,0,
  	0,0,14,140,1,0,0,0,16,144,1,0,0,0,18,148,1,0,0,0,20,152,1,0,0,0,22,183,
  	1,0,0,0,24,204,1,0,0,0,26,222,1,0,0,0,28,294,1,0,0,0,30,307,1,0,0,0,32,
  	317,1,0,0,0,34,323,1,0,0,0,36,329,1,0,0,0,38,335,1,0,0,0,40,355,1,0,0,
  	0,42,357,1,0,0,0,44,371,1,0,0,0,46,381,1,0,0,0,48,386,1,0,0,0,50,391,
  	1,0,0,0,52,396,1,0,0,0,54,403,1,0,0,0,56,413,1,0,0,0,58,421,1,0,0,0,60,
  	430,1,0,0,0,62,444,1,0,0,0,64,448,1,0,0,0,66,466,1,0,0,0,68,468,1,0,0,
  	0,70,470,1,0,0,0,72,472,1,0,0,0,74,474,1,0,0,0,76,476,1,0,0,0,78,80,3,
  	2,1,0,79,78,1,0,0,0,80,83,1,0,0,0,81,79,1,0,0,0,81,82,1,0,0,0,82,84,1,
  	0,0,0,83,81,1,0,0,0,84,85,5,0,0,1,85,1,1,0,0,0,86,97,3,18,9,0,87,97,3,
  	20,10,0,88,97,3,4,2,0,89,97,3,6,3,0,90,97,3,8,4,0,91,97,3,10,5,0,92,97,
  	3,54,27,0,93,97,3,58,29,0,94,97,3,14,7,0,95,97,3,16,8,0,96,86,1,0,0,0,
  	96,87,1,0,0,0,96,88,1,0,0,0,96,89,1,0,0,0,96,90,1,0,0,0,96,91,1,0,0,0,
  	96,92,1,0,0,0,96,93,1,0,0,0,96,94,1,0,0,0,96,95,1,0,0,0,97,3,1,0,0,0,
  	98,99,5,76,0,0,99,100,3,70,35,0,100,101,5,1,0,0,101,102,3,22,11,0,102,
  	103,5,2,0,0,103,5,1,0,0,0,104,105,5,76,0,0,105,109,3,70,35,0,106,108,
  	3,38,19,0,107,106,1,0,0,0,108,111,1,0,0,0,109,107,1,0,0,0,109,110,1,0,
  	0,0,110,112,1,0,0,0,111,109,1,0,0,0,112,113,5,3,0,0,113,114,3,22,11,0,
  	114,115,5,1,0,0,115,116,3,24,12,0,116,117,5,2,0,0,117,7,1,0,0,0,118,119,
  	5,75,0,0,119,120,3,70,35,0,120,121,5,3,0,0,121,122,3,22,11,0,122,123,
  	5,2,0,0,123,9,1,0,0,0,124,125,5,30,0,0,125,129,3,70,35,0,126,128,3,38,
  	19,0,127,126,1,0,0,0,128,131,1,0,0,0,129,127,1,0,0,0,129,130,1,0,0,0,
  	130,132,1,0,0,0,131,129,1,0,0,0,132,133,5,3,0,0,133,134,3,22,11,0,134,
  	135,5,1,0,0,135,136,3,24,12,0,136,137,5,2,0,0,137,11,1,0,0,0,138,139,
  	5,89,0,0,139,13,1,0,0,0,140,141,5,4,0,0,141,142,3,12,6,0,142,143,5,2,
  	0,0,143,15,1,0,0,0,144,145,5,5,0,0,145,146,3,24,12,0,146,147,5,2,0,0,
  	147,17,1,0,0,0,148,149,5,31,0,0,149,150,3,70,35,0,150,151,5,2,0,0,151,
  	19,1,0,0,0,152,153,5,32,0,0,153,154,3,70,35,0,154,155,5,2,0,0,155,21,
  	1,0,0,0,156,157,6,11,-1,0,157,184,5,6,0,0,158,184,5,7,0,0,159,184,5,8,
  	0,0,160,184,5,9,0,0,161,184,5,10,0,0,162,163,5,11,0,0,163,184,3,22,11,
  	7,164,165,5,12,0,0,165,184,3,22,11,6,166,167,5,13,0,0,167,184,3,22,11,
  	5,168,169,5,69,0,0,169,172,3,22,11,0,170,171,5,37,0,0,171,173,3,22,11,
  	0,172,170,1,0,0,0,173,174,1,0,0,0,174,172,1,0,0,0,174,175,1,0,0,0,175,
  	176,1,0,0,0,176,177,5,70,0,0,177,184,1,0,0,0,178,179,5,69,0,0,179,180,
  	3,22,11,0,180,181,5,70,0,0,181,184,1,0,0,0,182,184,3,70,35,0,183,156,
  	1,0,0,0,183,158,1,0,0,0,183,159,1,0,0,0,183,160,1,0,0,0,183,161,1,0,0,
  	0,183,162,1,0,0,0,183,164,1,0,0,0,183,166,1,0,0,0,183,168,1,0,0,0,183,
  	178,1,0,0,0,183,182,1,0,0,0,184,193,1,0,0,0,185,186,10,3,0,0,186,187,
  	5,61,0,0,187,188,5,69,0,0,188,189,3,22,11,0,189,190,5,70,0,0,190,192,
  	1,0,0,0,191,185,1,0,0,0,192,195,1,0,0,0,193,191,1,0,0,0,193,194,1,0,0,
  	0,194,23,1,0,0,0,195,193,1,0,0,0,196,205,3,40,20,0,197,205,3,42,21,0,
  	198,205,3,44,22,0,199,205,3,48,24,0,200,205,3,50,25,0,201,205,3,52,26,
  	0,202,205,3,62,31,0,203,205,3,26,13,0,204,196,1,0,0,0,204,197,1,0,0,0,
  	204,198,1,0,0,0,204,199,1,0,0,0,204,200,1,0,0,0,204,201,1,0,0,0,204,202,
  	1,0,0,0,204,203,1,0,0,0,205,25,1,0,0,0,206,207,6,13,-1,0,207,209,3,28,
  	14,0,208,210,3,28,14,0,209,208,1,0,0,0,210,211,1,0,0,0,211,209,1,0,0,
  	0,211,212,1,0,0,0,212,223,1,0,0,0,213,214,3,36,18,0,214,215,5,14,0,0,
  	215,216,3,26,13,11,216,223,1,0,0,0,217,218,3,34,17,0,218,219,5,14,0,0,
  	219,220,3,26,13,10,220,223,1,0,0,0,221,223,3,28,14,0,222,206,1,0,0,0,
  	222,213,1,0,0,0,222,217,1,0,0,0,222,221,1,0,0,0,223,279,1,0,0,0,224,225,
  	10,15,0,0,225,226,7,0,0,0,226,278,3,26,13,16,227,228,10,14,0,0,228,229,
  	7,1,0,0,229,278,3,26,13,15,230,231,10,13,0,0,231,232,7,2,0,0,232,278,
  	3,26,13,14,233,234,10,12,0,0,234,235,7,3,0,0,235,278,3,26,13,12,236,237,
  	10,9,0,0,237,238,5,55,0,0,238,239,3,26,13,0,239,240,5,15,0,0,240,241,
  	3,26,13,10,241,278,1,0,0,0,242,243,10,8,0,0,243,244,5,54,0,0,244,278,
  	3,26,13,9,245,246,10,7,0,0,246,247,5,56,0,0,247,278,3,26,13,8,248,254,
  	10,5,0,0,249,250,5,2,0,0,250,251,5,18,0,0,251,252,3,70,35,0,252,253,5,
  	19,0,0,253,255,1,0,0,0,254,249,1,0,0,0,255,256,1,0,0,0,256,254,1,0,0,
  	0,256,257,1,0,0,0,257,258,1,0,0,0,258,259,5,20,0,0,259,260,3,26,13,6,
  	260,278,1,0,0,0,261,262,10,4,0,0,262,263,7,4,0,0,263,278,3,26,13,5,264,
  	265,10,3,0,0,265,266,7,5,0,0,266,278,3,26,13,4,267,268,10,2,0,0,268,269,
  	5,61,0,0,269,278,3,26,13,2,270,271,10,6,0,0,271,272,5,16,0,0,272,273,
  	3,70,35,0,273,274,5,3,0,0,274,275,3,26,13,0,275,276,5,17,0,0,276,278,
  	1,0,0,0,277,224,1,0,0,0,277,227,1,0,0,0,277,230,1,0,0,0,277,233,1,0,0,
  	0,277,236,1,0,0,0,277,242,1,0,0,0,277,245,1,0,0,0,277,248,1,0,0,0,277,
  	261,1,0,0,0,277,264,1,0,0,0,277,267,1,0,0,0,277,270,1,0,0,0,278,281,1,
  	0,0,0,279,277,1,0,0,0,279,280,1,0,0,0,280,27,1,0,0,0,281,279,1,0,0,0,
  	282,283,6,14,-1,0,283,284,5,69,0,0,284,285,3,24,12,0,285,286,5,70,0,0,
  	286,295,1,0,0,0,287,288,5,69,0,0,288,289,7,6,0,0,289,290,3,28,14,0,290,
  	291,5,70,0,0,291,295,1,0,0,0,292,295,3,30,15,0,293,295,3,66,33,0,294,
  	282,1,0,0,0,294,287,1,0,0,0,294,292,1,0,0,0,294,293,1,0,0,0,295,304,1,
  	0,0,0,296,297,10,4,0,0,297,298,5,2,0,0,298,299,5,69,0,0,299,300,3,70,
  	35,0,300,301,5,70,0,0,301,303,1,0,0,0,302,296,1,0,0,0,303,306,1,0,0,0,
  	304,302,1,0,0,0,304,305,1,0,0,0,305,29,1,0,0,0,306,304,1,0,0,0,307,308,
  	5,69,0,0,308,311,3,24,12,0,309,310,5,14,0,0,310,312,3,24,12,0,311,309,
  	1,0,0,0,312,313,1,0,0,0,313,311,1,0,0,0,313,314,1,0,0,0,314,315,1,0,0,
  	0,315,316,5,70,0,0,316,31,1,0,0,0,317,319,3,70,35,0,318,320,3,24,12,0,
  	319,318,1,0,0,0,320,321,1,0,0,0,321,319,1,0,0,0,321,322,1,0,0,0,322,33,
  	1,0,0,0,323,325,5,78,0,0,324,326,3,38,19,0,325,324,1,0,0,0,326,327,1,
  	0,0,0,327,325,1,0,0,0,327,328,1,0,0,0,328,35,1,0,0,0,329,331,5,79,0,0,
  	330,332,3,38,19,0,331,330,1,0,0,0,332,333,1,0,0,0,333,331,1,0,0,0,333,
  	334,1,0,0,0,334,37,1,0,0,0,335,336,5,69,0,0,336,337,3,70,35,0,337,338,
  	5,3,0,0,338,339,3,22,11,0,339,340,5,70,0,0,340,39,1,0,0,0,341,342,5,73,
  	0,0,342,343,3,70,35,0,343,344,5,1,0,0,344,345,3,24,12,0,345,346,5,21,
  	0,0,346,347,3,24,12,0,347,356,1,0,0,0,348,349,5,73,0,0,349,350,3,30,15,
  	0,350,351,5,1,0,0,351,352,3,24,12,0,352,353,5,21,0,0,353,354,3,24,12,
  	0,354,356,1,0,0,0,355,341,1,0,0,0,355,348,1,0,0,0,356,41,1,0,0,0,357,
  	358,5,77,0,0,358,363,3,70,35,0,359,360,5,14,0,0,360,362,3,70,35,0,361,
  	359,1,0,0,0,362,365,1,0,0,0,363,361,1,0,0,0,363,364,1,0,0,0,364,366,1,
  	0,0,0,365,363,1,0,0,0,366,367,5,15,0,0,367,368,3,24,12,0,368,369,5,22,
  	0,0,369,370,3,24,12,0,370,43,1,0,0,0,371,372,5,80,0,0,372,373,3,24,12,
  	0,373,375,5,82,0,0,374,376,3,46,23,0,375,374,1,0,0,0,376,377,1,0,0,0,
  	377,375,1,0,0,0,377,378,1,0,0,0,378,379,1,0,0,0,379,380,5,83,0,0,380,
  	45,1,0,0,0,381,382,5,23,0,0,382,383,3,24,12,0,383,384,5,24,0,0,384,385,
  	3,24,12,0,385,47,1,0,0,0,386,387,5,84,0,0,387,388,3,24,12,0,388,389,5,
  	22,0,0,389,390,3,24,12,0,390,49,1,0,0,0,391,392,5,85,0,0,392,393,3,24,
  	12,0,393,394,5,22,0,0,394,395,3,24,12,0,395,51,1,0,0,0,396,397,5,71,0,
  	0,397,398,3,24,12,0,398,399,5,72,0,0,399,400,3,24,12,0,400,401,5,74,0,
  	0,401,402,3,24,12,0,402,53,1,0,0,0,403,404,5,28,0,0,404,405,3,70,35,0,
  	405,407,5,1,0,0,406,408,3,56,28,0,407,406,1,0,0,0,408,409,1,0,0,0,409,
  	407,1,0,0,0,409,410,1,0,0,0,410,411,1,0,0,0,411,412,5,2,0,0,412,55,1,
  	0,0,0,413,414,5,23,0,0,414,418,3,70,35,0,415,417,3,38,19,0,416,415,1,
  	0,0,0,417,420,1,0,0,0,418,416,1,0,0,0,418,419,1,0,0,0,419,57,1,0,0,0,
  	420,418,1,0,0,0,421,422,5,29,0,0,422,423,3,70,35,0,423,424,5,1,0,0,424,
  	425,3,70,35,0,425,426,5,16,0,0,426,427,3,60,30,0,427,428,5,17,0,0,428,
  	429,5,2,0,0,429,59,1,0,0,0,430,431,3,70,35,0,431,432,5,3,0,0,432,433,
  	3,22,11,0,433,441,1,0,0,0,434,435,5,22,0,0,435,436,3,70,35,0,436,437,
  	5,3,0,0,437,438,3,22,11,0,438,440,1,0,0,0,439,434,1,0,0,0,440,443,1,0,
  	0,0,441,439,1,0,0,0,441,442,1,0,0,0,442,61,1,0,0,0,443,441,1,0,0,0,444,
  	445,5,25,0,0,445,446,3,64,32,0,446,447,5,26,0,0,447,63,1,0,0,0,448,449,
  	3,70,35,0,449,450,5,1,0,0,450,451,3,70,35,0,451,459,1,0,0,0,452,453,5,
  	22,0,0,453,454,3,70,35,0,454,455,5,1,0,0,455,456,3,70,35,0,456,458,1,
  	0,0,0,457,452,1,0,0,0,458,461,1,0,0,0,459,457,1,0,0,0,459,460,1,0,0,0,
  	460,65,1,0,0,0,461,459,1,0,0,0,462,467,3,70,35,0,463,467,3,72,36,0,464,
  	467,3,76,38,0,465,467,3,74,37,0,466,462,1,0,0,0,466,463,1,0,0,0,466,464,
  	1,0,0,0,466,465,1,0,0,0,467,67,1,0,0,0,468,469,5,27,0,0,469,69,1,0,0,
  	0,470,471,5,90,0,0,471,71,1,0,0,0,472,473,5,88,0,0,473,73,1,0,0,0,474,
  	475,5,89,0,0,475,75,1,0,0,0,476,477,7,7,0,0,477,77,1,0,0,0,27,81,96,109,
  	129,174,183,193,204,211,222,256,277,279,294,304,313,321,327,333,355,363,
  	377,409,418,441,459,466
  };
  staticData->serializedATN = antlr4::atn::SerializedATNView(serializedATNSegment, sizeof(serializedATNSegment) / sizeof(serializedATNSegment[0]));

  antlr4::atn::ATNDeserializer deserializer;
  staticData->atn = deserializer.deserialize(staticData->serializedATN);

  const size_t count = staticData->atn->getNumberOfDecisions();
  staticData->decisionToDFA.reserve(count);
  for (size_t i = 0; i < count; i++) { 
    staticData->decisionToDFA.emplace_back(staticData->atn->getDecisionState(i), i);
  }
  specParserStaticData = staticData.release();
}

}

SpecParser::SpecParser(TokenStream *input) : SpecParser(input, antlr4::atn::ParserATNSimulatorOptions()) {}

SpecParser::SpecParser(TokenStream *input, const antlr4::atn::ParserATNSimulatorOptions &options) : Parser(input) {
  SpecParser::initialize();
  _interpreter = new atn::ParserATNSimulator(this, *specParserStaticData->atn, specParserStaticData->decisionToDFA, specParserStaticData->sharedContextCache, options);
}

SpecParser::~SpecParser() {
  delete _interpreter;
}

const atn::ATN& SpecParser::getATN() const {
  return *specParserStaticData->atn;
}

std::string SpecParser::getGrammarFileName() const {
  return "Spec.g4";
}

const std::vector<std::string>& SpecParser::getRuleNames() const {
  return specParserStaticData->ruleNames;
}

const dfa::Vocabulary& SpecParser::getVocabulary() const {
  return specParserStaticData->vocabulary;
}

antlr4::atn::SerializedATNView SpecParser::getSerializedATN() const {
  return specParserStaticData->serializedATN;
}


//----------------- ProgramContext ------------------------------------------------------------------

SpecParser::ProgramContext::ProgramContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::ProgramContext::EOF() {
  return getToken(SpecParser::EOF, 0);
}

std::vector<SpecParser::StatementContext *> SpecParser::ProgramContext::statement() {
  return getRuleContexts<SpecParser::StatementContext>();
}

SpecParser::StatementContext* SpecParser::ProgramContext::statement(size_t i) {
  return getRuleContext<SpecParser::StatementContext>(i);
}


size_t SpecParser::ProgramContext::getRuleIndex() const {
  return SpecParser::RuleProgram;
}


std::any SpecParser::ProgramContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitProgram(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::ProgramContext* SpecParser::program() {
  ProgramContext *_localctx = _tracker.createInstance<ProgramContext>(_ctx, getState());
  enterRule(_localctx, 0, SpecParser::RuleProgram);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(81);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & 8321499184) != 0) || _la == SpecParser::PARAM

    || _la == SpecParser::DEF) {
      setState(78);
      statement();
      setState(83);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(84);
    match(SpecParser::EOF);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- StatementContext ------------------------------------------------------------------

SpecParser::StatementContext::StatementContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::Section_beginContext* SpecParser::StatementContext::section_begin() {
  return getRuleContext<SpecParser::Section_beginContext>(0);
}

SpecParser::Section_endContext* SpecParser::StatementContext::section_end() {
  return getRuleContext<SpecParser::Section_endContext>(0);
}

SpecParser::TypedefContext* SpecParser::StatementContext::typedef_() {
  return getRuleContext<SpecParser::TypedefContext>(0);
}

SpecParser::DefContext* SpecParser::StatementContext::def() {
  return getRuleContext<SpecParser::DefContext>(0);
}

SpecParser::DeclContext* SpecParser::StatementContext::decl() {
  return getRuleContext<SpecParser::DeclContext>(0);
}

SpecParser::FixpointContext* SpecParser::StatementContext::fixpoint() {
  return getRuleContext<SpecParser::FixpointContext>(0);
}

SpecParser::Inductive_declContext* SpecParser::StatementContext::inductive_decl() {
  return getRuleContext<SpecParser::Inductive_declContext>(0);
}

SpecParser::Record_declContext* SpecParser::StatementContext::record_decl() {
  return getRuleContext<SpecParser::Record_declContext>(0);
}

SpecParser::IncludeContext* SpecParser::StatementContext::include() {
  return getRuleContext<SpecParser::IncludeContext>(0);
}

SpecParser::CommandContext* SpecParser::StatementContext::command() {
  return getRuleContext<SpecParser::CommandContext>(0);
}


size_t SpecParser::StatementContext::getRuleIndex() const {
  return SpecParser::RuleStatement;
}


std::any SpecParser::StatementContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitStatement(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::StatementContext* SpecParser::statement() {
  StatementContext *_localctx = _tracker.createInstance<StatementContext>(_ctx, getState());
  enterRule(_localctx, 2, SpecParser::RuleStatement);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(96);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 1, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(86);
      section_begin();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(87);
      section_end();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(88);
      typedef_();
      break;
    }

    case 4: {
      enterOuterAlt(_localctx, 4);
      setState(89);
      def();
      break;
    }

    case 5: {
      enterOuterAlt(_localctx, 5);
      setState(90);
      decl();
      break;
    }

    case 6: {
      enterOuterAlt(_localctx, 6);
      setState(91);
      fixpoint();
      break;
    }

    case 7: {
      enterOuterAlt(_localctx, 7);
      setState(92);
      inductive_decl();
      break;
    }

    case 8: {
      enterOuterAlt(_localctx, 8);
      setState(93);
      record_decl();
      break;
    }

    case 9: {
      enterOuterAlt(_localctx, 9);
      setState(94);
      include();
      break;
    }

    case 10: {
      enterOuterAlt(_localctx, 10);
      setState(95);
      command();
      break;
    }

    default:
      break;
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypedefContext ------------------------------------------------------------------

SpecParser::TypedefContext::TypedefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::TypedefContext::DEF() {
  return getToken(SpecParser::DEF, 0);
}

SpecParser::NameContext* SpecParser::TypedefContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::TypeContext* SpecParser::TypedefContext::type() {
  return getRuleContext<SpecParser::TypeContext>(0);
}


size_t SpecParser::TypedefContext::getRuleIndex() const {
  return SpecParser::RuleTypedef;
}


std::any SpecParser::TypedefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitTypedef(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::TypedefContext* SpecParser::typedef_() {
  TypedefContext *_localctx = _tracker.createInstance<TypedefContext>(_ctx, getState());
  enterRule(_localctx, 4, SpecParser::RuleTypedef);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(98);
    match(SpecParser::DEF);
    setState(99);
    name();
    setState(100);
    match(SpecParser::T__0);
    setState(101);
    type(0);
    setState(102);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- DefContext ------------------------------------------------------------------

SpecParser::DefContext::DefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::DefContext::DEF() {
  return getToken(SpecParser::DEF, 0);
}

SpecParser::NameContext* SpecParser::DefContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::TypeContext* SpecParser::DefContext::type() {
  return getRuleContext<SpecParser::TypeContext>(0);
}

SpecParser::ExprContext* SpecParser::DefContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
}

std::vector<SpecParser::Var_annoContext *> SpecParser::DefContext::var_anno() {
  return getRuleContexts<SpecParser::Var_annoContext>();
}

SpecParser::Var_annoContext* SpecParser::DefContext::var_anno(size_t i) {
  return getRuleContext<SpecParser::Var_annoContext>(i);
}


size_t SpecParser::DefContext::getRuleIndex() const {
  return SpecParser::RuleDef;
}


std::any SpecParser::DefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitDef(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::DefContext* SpecParser::def() {
  DefContext *_localctx = _tracker.createInstance<DefContext>(_ctx, getState());
  enterRule(_localctx, 6, SpecParser::RuleDef);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(104);
    match(SpecParser::DEF);
    setState(105);
    name();
    setState(109);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::LP) {
      setState(106);
      var_anno();
      setState(111);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(112);
    match(SpecParser::T__2);
    setState(113);
    type(0);
    setState(114);
    match(SpecParser::T__0);
    setState(115);
    expr();
    setState(116);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- DeclContext ------------------------------------------------------------------

SpecParser::DeclContext::DeclContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::DeclContext::PARAM() {
  return getToken(SpecParser::PARAM, 0);
}

SpecParser::NameContext* SpecParser::DeclContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::TypeContext* SpecParser::DeclContext::type() {
  return getRuleContext<SpecParser::TypeContext>(0);
}


size_t SpecParser::DeclContext::getRuleIndex() const {
  return SpecParser::RuleDecl;
}


std::any SpecParser::DeclContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitDecl(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::DeclContext* SpecParser::decl() {
  DeclContext *_localctx = _tracker.createInstance<DeclContext>(_ctx, getState());
  enterRule(_localctx, 8, SpecParser::RuleDecl);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(118);
    match(SpecParser::PARAM);
    setState(119);
    name();
    setState(120);
    match(SpecParser::T__2);
    setState(121);
    type(0);
    setState(122);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- FixpointContext ------------------------------------------------------------------

SpecParser::FixpointContext::FixpointContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::FixpointContext::FIXPOINT() {
  return getToken(SpecParser::FIXPOINT, 0);
}

SpecParser::NameContext* SpecParser::FixpointContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::TypeContext* SpecParser::FixpointContext::type() {
  return getRuleContext<SpecParser::TypeContext>(0);
}

SpecParser::ExprContext* SpecParser::FixpointContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
}

std::vector<SpecParser::Var_annoContext *> SpecParser::FixpointContext::var_anno() {
  return getRuleContexts<SpecParser::Var_annoContext>();
}

SpecParser::Var_annoContext* SpecParser::FixpointContext::var_anno(size_t i) {
  return getRuleContext<SpecParser::Var_annoContext>(i);
}


size_t SpecParser::FixpointContext::getRuleIndex() const {
  return SpecParser::RuleFixpoint;
}


std::any SpecParser::FixpointContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitFixpoint(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::FixpointContext* SpecParser::fixpoint() {
  FixpointContext *_localctx = _tracker.createInstance<FixpointContext>(_ctx, getState());
  enterRule(_localctx, 10, SpecParser::RuleFixpoint);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(124);
    match(SpecParser::FIXPOINT);
    setState(125);
    name();
    setState(129);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::LP) {
      setState(126);
      var_anno();
      setState(131);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(132);
    match(SpecParser::T__2);
    setState(133);
    type(0);
    setState(134);
    match(SpecParser::T__0);
    setState(135);
    expr();
    setState(136);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- PathContext ------------------------------------------------------------------

SpecParser::PathContext::PathContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::PathContext::STR() {
  return getToken(SpecParser::STR, 0);
}


size_t SpecParser::PathContext::getRuleIndex() const {
  return SpecParser::RulePath;
}


std::any SpecParser::PathContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitPath(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::PathContext* SpecParser::path() {
  PathContext *_localctx = _tracker.createInstance<PathContext>(_ctx, getState());
  enterRule(_localctx, 12, SpecParser::RulePath);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(138);
    match(SpecParser::STR);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- IncludeContext ------------------------------------------------------------------

SpecParser::IncludeContext::IncludeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::PathContext* SpecParser::IncludeContext::path() {
  return getRuleContext<SpecParser::PathContext>(0);
}


size_t SpecParser::IncludeContext::getRuleIndex() const {
  return SpecParser::RuleInclude;
}


std::any SpecParser::IncludeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitInclude(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::IncludeContext* SpecParser::include() {
  IncludeContext *_localctx = _tracker.createInstance<IncludeContext>(_ctx, getState());
  enterRule(_localctx, 14, SpecParser::RuleInclude);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(140);
    match(SpecParser::T__3);
    setState(141);
    path();
    setState(142);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- CommandContext ------------------------------------------------------------------

SpecParser::CommandContext::CommandContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::ExprContext* SpecParser::CommandContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
}


size_t SpecParser::CommandContext::getRuleIndex() const {
  return SpecParser::RuleCommand;
}


std::any SpecParser::CommandContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitCommand(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::CommandContext* SpecParser::command() {
  CommandContext *_localctx = _tracker.createInstance<CommandContext>(_ctx, getState());
  enterRule(_localctx, 16, SpecParser::RuleCommand);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(144);
    match(SpecParser::T__4);
    setState(145);
    expr();
    setState(146);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Section_beginContext ------------------------------------------------------------------

SpecParser::Section_beginContext::Section_beginContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Section_beginContext::SECTION() {
  return getToken(SpecParser::SECTION, 0);
}

SpecParser::NameContext* SpecParser::Section_beginContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}


size_t SpecParser::Section_beginContext::getRuleIndex() const {
  return SpecParser::RuleSection_begin;
}


std::any SpecParser::Section_beginContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitSection_begin(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Section_beginContext* SpecParser::section_begin() {
  Section_beginContext *_localctx = _tracker.createInstance<Section_beginContext>(_ctx, getState());
  enterRule(_localctx, 18, SpecParser::RuleSection_begin);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(148);
    match(SpecParser::SECTION);
    setState(149);
    name();
    setState(150);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Section_endContext ------------------------------------------------------------------

SpecParser::Section_endContext::Section_endContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Section_endContext::SECTION_END() {
  return getToken(SpecParser::SECTION_END, 0);
}

SpecParser::NameContext* SpecParser::Section_endContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}


size_t SpecParser::Section_endContext::getRuleIndex() const {
  return SpecParser::RuleSection_end;
}


std::any SpecParser::Section_endContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitSection_end(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Section_endContext* SpecParser::section_end() {
  Section_endContext *_localctx = _tracker.createInstance<Section_endContext>(_ctx, getState());
  enterRule(_localctx, 20, SpecParser::RuleSection_end);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(152);
    match(SpecParser::SECTION_END);
    setState(153);
    name();
    setState(154);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- TypeContext ------------------------------------------------------------------

SpecParser::TypeContext::TypeContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<SpecParser::TypeContext *> SpecParser::TypeContext::type() {
  return getRuleContexts<SpecParser::TypeContext>();
}

SpecParser::TypeContext* SpecParser::TypeContext::type(size_t i) {
  return getRuleContext<SpecParser::TypeContext>(i);
}

tree::TerminalNode* SpecParser::TypeContext::LP() {
  return getToken(SpecParser::LP, 0);
}

tree::TerminalNode* SpecParser::TypeContext::RP() {
  return getToken(SpecParser::RP, 0);
}

std::vector<tree::TerminalNode *> SpecParser::TypeContext::MULT() {
  return getTokens(SpecParser::MULT);
}

tree::TerminalNode* SpecParser::TypeContext::MULT(size_t i) {
  return getToken(SpecParser::MULT, i);
}

SpecParser::NameContext* SpecParser::TypeContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

tree::TerminalNode* SpecParser::TypeContext::IMPLIES() {
  return getToken(SpecParser::IMPLIES, 0);
}


size_t SpecParser::TypeContext::getRuleIndex() const {
  return SpecParser::RuleType;
}


std::any SpecParser::TypeContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitType(this);
  else
    return visitor->visitChildren(this);
}


SpecParser::TypeContext* SpecParser::type() {
   return type(0);
}

SpecParser::TypeContext* SpecParser::type(int precedence) {
  ParserRuleContext *parentContext = _ctx;
  size_t parentState = getState();
  SpecParser::TypeContext *_localctx = _tracker.createInstance<TypeContext>(_ctx, parentState);
  SpecParser::TypeContext *previousContext = _localctx;
  (void)previousContext; // Silence compiler, in case the context is not used by generated code.
  size_t startState = 22;
  enterRecursionRule(_localctx, 22, SpecParser::RuleType, precedence);

    size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    unrollRecursionContexts(parentContext);
  });
  try {
    size_t alt;
    enterOuterAlt(_localctx, 1);
    setState(183);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 5, _ctx)) {
    case 1: {
      setState(157);
      antlrcpp::downCast<TypeContext *>(_localctx)->Z_type = match(SpecParser::T__5);
      break;
    }

    case 2: {
      setState(158);
      antlrcpp::downCast<TypeContext *>(_localctx)->bool_type = match(SpecParser::T__6);
      break;
    }

    case 3: {
      setState(159);
      antlrcpp::downCast<TypeContext *>(_localctx)->str_type = match(SpecParser::T__7);
      break;
    }

    case 4: {
      setState(160);
      antlrcpp::downCast<TypeContext *>(_localctx)->type_type = match(SpecParser::T__8);
      break;
    }

    case 5: {
      setState(161);
      antlrcpp::downCast<TypeContext *>(_localctx)->prop_type = match(SpecParser::T__9);
      break;
    }

    case 6: {
      setState(162);
      antlrcpp::downCast<TypeContext *>(_localctx)->list_type = match(SpecParser::T__10);
      setState(163);
      type(7);
      break;
    }

    case 7: {
      setState(164);
      antlrcpp::downCast<TypeContext *>(_localctx)->option_type = match(SpecParser::T__11);
      setState(165);
      type(6);
      break;
    }

    case 8: {
      setState(166);
      antlrcpp::downCast<TypeContext *>(_localctx)->map_type = match(SpecParser::T__12);
      setState(167);
      type(5);
      break;
    }

    case 9: {
      setState(168);
      match(SpecParser::LP);
      setState(169);
      type(0);
      setState(172); 
      _errHandler->sync(this);
      _la = _input->LA(1);
      do {
        setState(170);
        antlrcpp::downCast<TypeContext *>(_localctx)->tup = match(SpecParser::MULT);
        setState(171);
        type(0);
        setState(174); 
        _errHandler->sync(this);
        _la = _input->LA(1);
      } while (_la == SpecParser::MULT);
      setState(176);
      match(SpecParser::RP);
      break;
    }

    case 10: {
      setState(178);
      match(SpecParser::LP);
      setState(179);
      antlrcpp::downCast<TypeContext *>(_localctx)->par = type(0);
      setState(180);
      match(SpecParser::RP);
      break;
    }

    case 11: {
      setState(182);
      name();
      break;
    }

    default:
      break;
    }
    _ctx->stop = _input->LT(-1);
    setState(193);
    _errHandler->sync(this);
    alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 6, _ctx);
    while (alt != 2 && alt != atn::ATN::INVALID_ALT_NUMBER) {
      if (alt == 1) {
        if (!_parseListeners.empty())
          triggerExitRuleEvent();
        previousContext = _localctx;
        _localctx = _tracker.createInstance<TypeContext>(parentContext, parentState);
        _localctx->domain = previousContext;
        pushNewRecursionContext(_localctx, startState, RuleType);
        setState(185);

        if (!(precpred(_ctx, 3))) throw FailedPredicateException(this, "precpred(_ctx, 3)");
        setState(186);
        match(SpecParser::IMPLIES);
        setState(187);
        match(SpecParser::LP);
        setState(188);
        antlrcpp::downCast<TypeContext *>(_localctx)->codomain = type(0);
        setState(189);
        match(SpecParser::RP); 
      }
      setState(195);
      _errHandler->sync(this);
      alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 6, _ctx);
    }
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }
  return _localctx;
}

//----------------- ExprContext ------------------------------------------------------------------

SpecParser::ExprContext::ExprContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::Let_stmtContext* SpecParser::ExprContext::let_stmt() {
  return getRuleContext<SpecParser::Let_stmtContext>(0);
}

SpecParser::When_stmtContext* SpecParser::ExprContext::when_stmt() {
  return getRuleContext<SpecParser::When_stmtContext>(0);
}

SpecParser::Match_stmtContext* SpecParser::ExprContext::match_stmt() {
  return getRuleContext<SpecParser::Match_stmtContext>(0);
}

SpecParser::Assert_stmtContext* SpecParser::ExprContext::assert_stmt() {
  return getRuleContext<SpecParser::Assert_stmtContext>(0);
}

SpecParser::Anno_stmtContext* SpecParser::ExprContext::anno_stmt() {
  return getRuleContext<SpecParser::Anno_stmtContext>(0);
}

SpecParser::If_stmtContext* SpecParser::ExprContext::if_stmt() {
  return getRuleContext<SpecParser::If_stmtContext>(0);
}

SpecParser::Record_def_stmtContext* SpecParser::ExprContext::record_def_stmt() {
  return getRuleContext<SpecParser::Record_def_stmtContext>(0);
}

SpecParser::Expr_opContext* SpecParser::ExprContext::expr_op() {
  return getRuleContext<SpecParser::Expr_opContext>(0);
}


size_t SpecParser::ExprContext::getRuleIndex() const {
  return SpecParser::RuleExpr;
}


std::any SpecParser::ExprContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitExpr(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::ExprContext* SpecParser::expr() {
  ExprContext *_localctx = _tracker.createInstance<ExprContext>(_ctx, getState());
  enterRule(_localctx, 24, SpecParser::RuleExpr);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(204);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case SpecParser::LET: {
        enterOuterAlt(_localctx, 1);
        setState(196);
        let_stmt();
        break;
      }

      case SpecParser::WHEN: {
        enterOuterAlt(_localctx, 2);
        setState(197);
        when_stmt();
        break;
      }

      case SpecParser::MATCH: {
        enterOuterAlt(_localctx, 3);
        setState(198);
        match_stmt();
        break;
      }

      case SpecParser::RELY: {
        enterOuterAlt(_localctx, 4);
        setState(199);
        assert_stmt();
        break;
      }

      case SpecParser::ANNO: {
        enterOuterAlt(_localctx, 5);
        setState(200);
        anno_stmt();
        break;
      }

      case SpecParser::IF: {
        enterOuterAlt(_localctx, 6);
        setState(201);
        if_stmt();
        break;
      }

      case SpecParser::T__24: {
        enterOuterAlt(_localctx, 7);
        setState(202);
        record_def_stmt();
        break;
      }

      case SpecParser::LP:
      case SpecParser::FORALL:
      case SpecParser::EXISTS:
      case SpecParser::TRUE:
      case SpecParser::FALSE:
      case SpecParser::NUMBER:
      case SpecParser::STR:
      case SpecParser::ID: {
        enterOuterAlt(_localctx, 8);
        setState(203);
        expr_op(0);
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Expr_opContext ------------------------------------------------------------------

SpecParser::Expr_opContext::Expr_opContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<SpecParser::TermContext *> SpecParser::Expr_opContext::term() {
  return getRuleContexts<SpecParser::TermContext>();
}

SpecParser::TermContext* SpecParser::Expr_opContext::term(size_t i) {
  return getRuleContext<SpecParser::TermContext>(i);
}

SpecParser::Exists_exprContext* SpecParser::Expr_opContext::exists_expr() {
  return getRuleContext<SpecParser::Exists_exprContext>(0);
}

std::vector<SpecParser::Expr_opContext *> SpecParser::Expr_opContext::expr_op() {
  return getRuleContexts<SpecParser::Expr_opContext>();
}

SpecParser::Expr_opContext* SpecParser::Expr_opContext::expr_op(size_t i) {
  return getRuleContext<SpecParser::Expr_opContext>(i);
}

SpecParser::Forall_exprContext* SpecParser::Expr_opContext::forall_expr() {
  return getRuleContext<SpecParser::Forall_exprContext>(0);
}

tree::TerminalNode* SpecParser::Expr_opContext::MULT() {
  return getToken(SpecParser::MULT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::DIV() {
  return getToken(SpecParser::DIV, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::MOD() {
  return getToken(SpecParser::MOD, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::ADD() {
  return getToken(SpecParser::ADD, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::MINUS() {
  return getToken(SpecParser::MINUS, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BITAND() {
  return getToken(SpecParser::BITAND, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BITOR() {
  return getToken(SpecParser::BITOR, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BEQ() {
  return getToken(SpecParser::BEQ, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BNE() {
  return getToken(SpecParser::BNE, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BGT() {
  return getToken(SpecParser::BGT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BGE() {
  return getToken(SpecParser::BGE, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BLT() {
  return getToken(SpecParser::BLT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BLE() {
  return getToken(SpecParser::BLE, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BAND() {
  return getToken(SpecParser::BAND, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::BOR() {
  return getToken(SpecParser::BOR, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::LSHIFT() {
  return getToken(SpecParser::LSHIFT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::RSHIFT() {
  return getToken(SpecParser::RSHIFT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::SEQ() {
  return getToken(SpecParser::SEQ, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::SNE() {
  return getToken(SpecParser::SNE, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::APPEND() {
  return getToken(SpecParser::APPEND, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::CONCAT() {
  return getToken(SpecParser::CONCAT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::SET() {
  return getToken(SpecParser::SET, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::GET() {
  return getToken(SpecParser::GET, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::NTH() {
  return getToken(SpecParser::NTH, 0);
}

std::vector<SpecParser::NameContext *> SpecParser::Expr_opContext::name() {
  return getRuleContexts<SpecParser::NameContext>();
}

SpecParser::NameContext* SpecParser::Expr_opContext::name(size_t i) {
  return getRuleContext<SpecParser::NameContext>(i);
}

tree::TerminalNode* SpecParser::Expr_opContext::EQUAL() {
  return getToken(SpecParser::EQUAL, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::NOT_EQUAL() {
  return getToken(SpecParser::NOT_EQUAL, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::LT() {
  return getToken(SpecParser::LT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::LTE() {
  return getToken(SpecParser::LTE, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::GT() {
  return getToken(SpecParser::GT, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::GTE() {
  return getToken(SpecParser::GTE, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::IFONLYIF() {
  return getToken(SpecParser::IFONLYIF, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::OR() {
  return getToken(SpecParser::OR, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::AND() {
  return getToken(SpecParser::AND, 0);
}

tree::TerminalNode* SpecParser::Expr_opContext::IMPLIES() {
  return getToken(SpecParser::IMPLIES, 0);
}


size_t SpecParser::Expr_opContext::getRuleIndex() const {
  return SpecParser::RuleExpr_op;
}


std::any SpecParser::Expr_opContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitExpr_op(this);
  else
    return visitor->visitChildren(this);
}


SpecParser::Expr_opContext* SpecParser::expr_op() {
   return expr_op(0);
}

SpecParser::Expr_opContext* SpecParser::expr_op(int precedence) {
  ParserRuleContext *parentContext = _ctx;
  size_t parentState = getState();
  SpecParser::Expr_opContext *_localctx = _tracker.createInstance<Expr_opContext>(_ctx, parentState);
  SpecParser::Expr_opContext *previousContext = _localctx;
  (void)previousContext; // Silence compiler, in case the context is not used by generated code.
  size_t startState = 26;
  enterRecursionRule(_localctx, 26, SpecParser::RuleExpr_op, precedence);

    size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    unrollRecursionContexts(parentContext);
  });
  try {
    size_t alt;
    enterOuterAlt(_localctx, 1);
    setState(222);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 9, _ctx)) {
    case 1: {
      setState(207);
      antlrcpp::downCast<Expr_opContext *>(_localctx)->op = term(0);
      setState(209); 
      _errHandler->sync(this);
      alt = 1;
      do {
        switch (alt) {
          case 1: {
                setState(208);
                term(0);
                break;
              }

        default:
          throw NoViableAltException(this);
        }
        setState(211); 
        _errHandler->sync(this);
        alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 8, _ctx);
      } while (alt != 2 && alt != atn::ATN::INVALID_ALT_NUMBER);
      break;
    }

    case 2: {
      setState(213);
      exists_expr();
      setState(214);
      match(SpecParser::T__13);
      setState(215);
      expr_op(11);
      break;
    }

    case 3: {
      setState(217);
      forall_expr();
      setState(218);
      match(SpecParser::T__13);
      setState(219);
      expr_op(10);
      break;
    }

    case 4: {
      setState(221);
      term(0);
      break;
    }

    default:
      break;
    }
    _ctx->stop = _input->LT(-1);
    setState(279);
    _errHandler->sync(this);
    alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 12, _ctx);
    while (alt != 2 && alt != atn::ATN::INVALID_ALT_NUMBER) {
      if (alt == 1) {
        if (!_parseListeners.empty())
          triggerExitRuleEvent();
        previousContext = _localctx;
        setState(277);
        _errHandler->sync(this);
        switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 11, _ctx)) {
        case 1: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(224);

          if (!(precpred(_ctx, 15))) throw FailedPredicateException(this, "precpred(_ctx, 15)");
          setState(225);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!((((_la & ~ 0x3fULL) == 0) &&
            ((1ULL << _la) & 962072674304) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(226);
          expr_op(16);
          break;
        }

        case 2: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(227);

          if (!(precpred(_ctx, 14))) throw FailedPredicateException(this, "precpred(_ctx, 14)");
          setState(228);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!((((_la & ~ 0x3fULL) == 0) &&
            ((1ULL << _la) & 13297218748416) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(229);
          expr_op(15);
          break;
        }

        case 3: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(230);

          if (!(precpred(_ctx, 13))) throw FailedPredicateException(this, "precpred(_ctx, 13)");
          setState(231);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!((((_la & ~ 0x3fULL) == 0) &&
            ((1ULL << _la) & 18000104858320896) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(232);
          expr_op(14);
          break;
        }

        case 4: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(233);

          if (!(precpred(_ctx, 12))) throw FailedPredicateException(this, "precpred(_ctx, 12)");
          setState(234);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!(_la == SpecParser::APPEND

          || _la == SpecParser::CONCAT)) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(235);
          expr_op(12);
          break;
        }

        case 5: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(236);

          if (!(precpred(_ctx, 9))) throw FailedPredicateException(this, "precpred(_ctx, 9)");
          setState(237);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->map_set = match(SpecParser::SET);
          setState(238);
          expr_op(0);
          setState(239);
          match(SpecParser::T__14);
          setState(240);
          expr_op(10);
          break;
        }

        case 6: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(242);

          if (!(precpred(_ctx, 8))) throw FailedPredicateException(this, "precpred(_ctx, 8)");
          setState(243);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->map_get = match(SpecParser::GET);
          setState(244);
          expr_op(9);
          break;
        }

        case 7: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(245);

          if (!(precpred(_ctx, 7))) throw FailedPredicateException(this, "precpred(_ctx, 7)");
          setState(246);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->list_nth = match(SpecParser::NTH);
          setState(247);
          expr_op(8);
          break;
        }

        case 8: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(248);

          if (!(precpred(_ctx, 5))) throw FailedPredicateException(this, "precpred(_ctx, 5)");
          setState(254); 
          _errHandler->sync(this);
          _la = _input->LA(1);
          do {
            setState(249);
            match(SpecParser::T__1);
            setState(250);
            match(SpecParser::T__17);
            setState(251);
            name();
            setState(252);
            match(SpecParser::T__18);
            setState(256); 
            _errHandler->sync(this);
            _la = _input->LA(1);
          } while (_la == SpecParser::T__1);
          setState(258);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->record_set = match(SpecParser::T__19);
          setState(259);
          expr_op(6);
          break;
        }

        case 9: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(261);

          if (!(precpred(_ctx, 4))) throw FailedPredicateException(this, "precpred(_ctx, 4)");
          setState(262);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!(((((_la - 63) & ~ 0x3fULL) == 0) &&
            ((1ULL << (_la - 63)) & 63) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(263);
          expr_op(5);
          break;
        }

        case 10: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(264);

          if (!(precpred(_ctx, 3))) throw FailedPredicateException(this, "precpred(_ctx, 3)");
          setState(265);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!((((_la & ~ 0x3fULL) == 0) &&
            ((1ULL << _la) & 5044031582654955520) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(266);
          expr_op(4);
          break;
        }

        case 11: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(267);

          if (!(precpred(_ctx, 2))) throw FailedPredicateException(this, "precpred(_ctx, 2)");
          setState(268);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = match(SpecParser::IMPLIES);
          setState(269);
          expr_op(2);
          break;
        }

        case 12: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(270);

          if (!(precpred(_ctx, 6))) throw FailedPredicateException(this, "precpred(_ctx, 6)");
          setState(271);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->record_set2 = match(SpecParser::T__15);
          setState(272);
          name();
          setState(273);
          match(SpecParser::T__2);
          setState(274);
          expr_op(0);
          setState(275);
          match(SpecParser::T__16);
          break;
        }

        default:
          break;
        } 
      }
      setState(281);
      _errHandler->sync(this);
      alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 12, _ctx);
    }
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }
  return _localctx;
}

//----------------- TermContext ------------------------------------------------------------------

SpecParser::TermContext::TermContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::TermContext::LP() {
  return getToken(SpecParser::LP, 0);
}

tree::TerminalNode* SpecParser::TermContext::RP() {
  return getToken(SpecParser::RP, 0);
}

SpecParser::ExprContext* SpecParser::TermContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
}

SpecParser::TermContext* SpecParser::TermContext::term() {
  return getRuleContext<SpecParser::TermContext>(0);
}

tree::TerminalNode* SpecParser::TermContext::MINUS() {
  return getToken(SpecParser::MINUS, 0);
}

tree::TerminalNode* SpecParser::TermContext::NOT() {
  return getToken(SpecParser::NOT, 0);
}

tree::TerminalNode* SpecParser::TermContext::BNOT() {
  return getToken(SpecParser::BNOT, 0);
}

SpecParser::TupleContext* SpecParser::TermContext::tuple() {
  return getRuleContext<SpecParser::TupleContext>(0);
}

SpecParser::ValueContext* SpecParser::TermContext::value() {
  return getRuleContext<SpecParser::ValueContext>(0);
}

SpecParser::NameContext* SpecParser::TermContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}


size_t SpecParser::TermContext::getRuleIndex() const {
  return SpecParser::RuleTerm;
}


std::any SpecParser::TermContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitTerm(this);
  else
    return visitor->visitChildren(this);
}


SpecParser::TermContext* SpecParser::term() {
   return term(0);
}

SpecParser::TermContext* SpecParser::term(int precedence) {
  ParserRuleContext *parentContext = _ctx;
  size_t parentState = getState();
  SpecParser::TermContext *_localctx = _tracker.createInstance<TermContext>(_ctx, parentState);
  SpecParser::TermContext *previousContext = _localctx;
  (void)previousContext; // Silence compiler, in case the context is not used by generated code.
  size_t startState = 28;
  enterRecursionRule(_localctx, 28, SpecParser::RuleTerm, precedence);

    size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    unrollRecursionContexts(parentContext);
  });
  try {
    size_t alt;
    enterOuterAlt(_localctx, 1);
    setState(294);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 13, _ctx)) {
    case 1: {
      setState(283);
      match(SpecParser::LP);
      setState(284);
      antlrcpp::downCast<TermContext *>(_localctx)->par = expr();
      setState(285);
      match(SpecParser::RP);
      break;
    }

    case 2: {
      setState(287);
      match(SpecParser::LP);
      setState(288);
      antlrcpp::downCast<TermContext *>(_localctx)->uniop = _input->LT(1);
      _la = _input->LA(1);
      if (!((((_la & ~ 0x3fULL) == 0) &&
        ((1ULL << _la) & 1729382325629747200) != 0))) {
        antlrcpp::downCast<TermContext *>(_localctx)->uniop = _errHandler->recoverInline(this);
      }
      else {
        _errHandler->reportMatch(this);
        consume();
      }
      setState(289);
      term(0);
      setState(290);
      match(SpecParser::RP);
      break;
    }

    case 3: {
      setState(292);
      tuple();
      break;
    }

    case 4: {
      setState(293);
      value();
      break;
    }

    default:
      break;
    }
    _ctx->stop = _input->LT(-1);
    setState(304);
    _errHandler->sync(this);
    alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 14, _ctx);
    while (alt != 2 && alt != atn::ATN::INVALID_ALT_NUMBER) {
      if (alt == 1) {
        if (!_parseListeners.empty())
          triggerExitRuleEvent();
        previousContext = _localctx;
        _localctx = _tracker.createInstance<TermContext>(parentContext, parentState);
        pushNewRecursionContext(_localctx, startState, RuleTerm);
        setState(296);

        if (!(precpred(_ctx, 4))) throw FailedPredicateException(this, "precpred(_ctx, 4)");
        setState(297);
        antlrcpp::downCast<TermContext *>(_localctx)->record_get = match(SpecParser::T__1);
        setState(298);
        match(SpecParser::LP);
        setState(299);
        name();
        setState(300);
        match(SpecParser::RP); 
      }
      setState(306);
      _errHandler->sync(this);
      alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 14, _ctx);
    }
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }
  return _localctx;
}

//----------------- TupleContext ------------------------------------------------------------------

SpecParser::TupleContext::TupleContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::TupleContext::LP() {
  return getToken(SpecParser::LP, 0);
}

std::vector<SpecParser::ExprContext *> SpecParser::TupleContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::TupleContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}

tree::TerminalNode* SpecParser::TupleContext::RP() {
  return getToken(SpecParser::RP, 0);
}


size_t SpecParser::TupleContext::getRuleIndex() const {
  return SpecParser::RuleTuple;
}


std::any SpecParser::TupleContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitTuple(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::TupleContext* SpecParser::tuple() {
  TupleContext *_localctx = _tracker.createInstance<TupleContext>(_ctx, getState());
  enterRule(_localctx, 30, SpecParser::RuleTuple);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(307);
    match(SpecParser::LP);
    setState(308);
    expr();
    setState(311); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(309);
      match(SpecParser::T__13);
      setState(310);
      expr();
      setState(313); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__13);
    setState(315);
    match(SpecParser::RP);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Func_callContext ------------------------------------------------------------------

SpecParser::Func_callContext::Func_callContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::NameContext* SpecParser::Func_callContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

std::vector<SpecParser::ExprContext *> SpecParser::Func_callContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::Func_callContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}


size_t SpecParser::Func_callContext::getRuleIndex() const {
  return SpecParser::RuleFunc_call;
}


std::any SpecParser::Func_callContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitFunc_call(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Func_callContext* SpecParser::func_call() {
  Func_callContext *_localctx = _tracker.createInstance<Func_callContext>(_ctx, getState());
  enterRule(_localctx, 32, SpecParser::RuleFunc_call);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(317);
    name();
    setState(319); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(318);
      expr();
      setState(321); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__24 || ((((_la - 69) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 69)) & 4165397) != 0));
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Forall_exprContext ------------------------------------------------------------------

SpecParser::Forall_exprContext::Forall_exprContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Forall_exprContext::FORALL() {
  return getToken(SpecParser::FORALL, 0);
}

std::vector<SpecParser::Var_annoContext *> SpecParser::Forall_exprContext::var_anno() {
  return getRuleContexts<SpecParser::Var_annoContext>();
}

SpecParser::Var_annoContext* SpecParser::Forall_exprContext::var_anno(size_t i) {
  return getRuleContext<SpecParser::Var_annoContext>(i);
}


size_t SpecParser::Forall_exprContext::getRuleIndex() const {
  return SpecParser::RuleForall_expr;
}


std::any SpecParser::Forall_exprContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitForall_expr(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Forall_exprContext* SpecParser::forall_expr() {
  Forall_exprContext *_localctx = _tracker.createInstance<Forall_exprContext>(_ctx, getState());
  enterRule(_localctx, 34, SpecParser::RuleForall_expr);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(323);
    match(SpecParser::FORALL);
    setState(325); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(324);
      var_anno();
      setState(327); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::LP);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Exists_exprContext ------------------------------------------------------------------

SpecParser::Exists_exprContext::Exists_exprContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Exists_exprContext::EXISTS() {
  return getToken(SpecParser::EXISTS, 0);
}

std::vector<SpecParser::Var_annoContext *> SpecParser::Exists_exprContext::var_anno() {
  return getRuleContexts<SpecParser::Var_annoContext>();
}

SpecParser::Var_annoContext* SpecParser::Exists_exprContext::var_anno(size_t i) {
  return getRuleContext<SpecParser::Var_annoContext>(i);
}


size_t SpecParser::Exists_exprContext::getRuleIndex() const {
  return SpecParser::RuleExists_expr;
}


std::any SpecParser::Exists_exprContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitExists_expr(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Exists_exprContext* SpecParser::exists_expr() {
  Exists_exprContext *_localctx = _tracker.createInstance<Exists_exprContext>(_ctx, getState());
  enterRule(_localctx, 36, SpecParser::RuleExists_expr);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(329);
    match(SpecParser::EXISTS);
    setState(331); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(330);
      var_anno();
      setState(333); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::LP);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Var_annoContext ------------------------------------------------------------------

SpecParser::Var_annoContext::Var_annoContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Var_annoContext::LP() {
  return getToken(SpecParser::LP, 0);
}

SpecParser::NameContext* SpecParser::Var_annoContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::TypeContext* SpecParser::Var_annoContext::type() {
  return getRuleContext<SpecParser::TypeContext>(0);
}

tree::TerminalNode* SpecParser::Var_annoContext::RP() {
  return getToken(SpecParser::RP, 0);
}


size_t SpecParser::Var_annoContext::getRuleIndex() const {
  return SpecParser::RuleVar_anno;
}


std::any SpecParser::Var_annoContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitVar_anno(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Var_annoContext* SpecParser::var_anno() {
  Var_annoContext *_localctx = _tracker.createInstance<Var_annoContext>(_ctx, getState());
  enterRule(_localctx, 38, SpecParser::RuleVar_anno);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(335);
    match(SpecParser::LP);
    setState(336);
    name();
    setState(337);
    match(SpecParser::T__2);
    setState(338);
    type(0);
    setState(339);
    match(SpecParser::RP);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Let_stmtContext ------------------------------------------------------------------

SpecParser::Let_stmtContext::Let_stmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Let_stmtContext::LET() {
  return getToken(SpecParser::LET, 0);
}

SpecParser::NameContext* SpecParser::Let_stmtContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

std::vector<SpecParser::ExprContext *> SpecParser::Let_stmtContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::Let_stmtContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}

SpecParser::TupleContext* SpecParser::Let_stmtContext::tuple() {
  return getRuleContext<SpecParser::TupleContext>(0);
}


size_t SpecParser::Let_stmtContext::getRuleIndex() const {
  return SpecParser::RuleLet_stmt;
}


std::any SpecParser::Let_stmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitLet_stmt(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Let_stmtContext* SpecParser::let_stmt() {
  Let_stmtContext *_localctx = _tracker.createInstance<Let_stmtContext>(_ctx, getState());
  enterRule(_localctx, 40, SpecParser::RuleLet_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(355);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 19, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(341);
      match(SpecParser::LET);
      setState(342);
      name();
      setState(343);
      match(SpecParser::T__0);
      setState(344);
      expr();
      setState(345);
      match(SpecParser::T__20);
      setState(346);
      expr();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(348);
      match(SpecParser::LET);
      setState(349);
      tuple();
      setState(350);
      match(SpecParser::T__0);
      setState(351);
      expr();
      setState(352);
      match(SpecParser::T__20);
      setState(353);
      expr();
      break;
    }

    default:
      break;
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- When_stmtContext ------------------------------------------------------------------

SpecParser::When_stmtContext::When_stmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::When_stmtContext::WHEN() {
  return getToken(SpecParser::WHEN, 0);
}

std::vector<SpecParser::ExprContext *> SpecParser::When_stmtContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::When_stmtContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}

std::vector<SpecParser::NameContext *> SpecParser::When_stmtContext::name() {
  return getRuleContexts<SpecParser::NameContext>();
}

SpecParser::NameContext* SpecParser::When_stmtContext::name(size_t i) {
  return getRuleContext<SpecParser::NameContext>(i);
}


size_t SpecParser::When_stmtContext::getRuleIndex() const {
  return SpecParser::RuleWhen_stmt;
}


std::any SpecParser::When_stmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitWhen_stmt(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::When_stmtContext* SpecParser::when_stmt() {
  When_stmtContext *_localctx = _tracker.createInstance<When_stmtContext>(_ctx, getState());
  enterRule(_localctx, 42, SpecParser::RuleWhen_stmt);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(357);
    match(SpecParser::WHEN);

    setState(358);
    name();
    setState(363);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::T__13) {
      setState(359);
      match(SpecParser::T__13);
      setState(360);
      name();
      setState(365);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(366);
    match(SpecParser::T__14);
    setState(367);
    expr();
    setState(368);
    match(SpecParser::T__21);
    setState(369);
    expr();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Match_stmtContext ------------------------------------------------------------------

SpecParser::Match_stmtContext::Match_stmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Match_stmtContext::MATCH() {
  return getToken(SpecParser::MATCH, 0);
}

SpecParser::ExprContext* SpecParser::Match_stmtContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
}

tree::TerminalNode* SpecParser::Match_stmtContext::WITH() {
  return getToken(SpecParser::WITH, 0);
}

tree::TerminalNode* SpecParser::Match_stmtContext::END() {
  return getToken(SpecParser::END, 0);
}

std::vector<SpecParser::Match_branchContext *> SpecParser::Match_stmtContext::match_branch() {
  return getRuleContexts<SpecParser::Match_branchContext>();
}

SpecParser::Match_branchContext* SpecParser::Match_stmtContext::match_branch(size_t i) {
  return getRuleContext<SpecParser::Match_branchContext>(i);
}


size_t SpecParser::Match_stmtContext::getRuleIndex() const {
  return SpecParser::RuleMatch_stmt;
}


std::any SpecParser::Match_stmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitMatch_stmt(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Match_stmtContext* SpecParser::match_stmt() {
  Match_stmtContext *_localctx = _tracker.createInstance<Match_stmtContext>(_ctx, getState());
  enterRule(_localctx, 44, SpecParser::RuleMatch_stmt);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(371);
    match(SpecParser::MATCH);
    setState(372);
    expr();
    setState(373);
    match(SpecParser::WITH);
    setState(375); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(374);
      match_branch();
      setState(377); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__22);
    setState(379);
    match(SpecParser::END);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Match_branchContext ------------------------------------------------------------------

SpecParser::Match_branchContext::Match_branchContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<SpecParser::ExprContext *> SpecParser::Match_branchContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::Match_branchContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}


size_t SpecParser::Match_branchContext::getRuleIndex() const {
  return SpecParser::RuleMatch_branch;
}


std::any SpecParser::Match_branchContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitMatch_branch(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Match_branchContext* SpecParser::match_branch() {
  Match_branchContext *_localctx = _tracker.createInstance<Match_branchContext>(_ctx, getState());
  enterRule(_localctx, 46, SpecParser::RuleMatch_branch);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(381);
    match(SpecParser::T__22);
    setState(382);
    expr();
    setState(383);
    match(SpecParser::T__23);
    setState(384);
    expr();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Assert_stmtContext ------------------------------------------------------------------

SpecParser::Assert_stmtContext::Assert_stmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Assert_stmtContext::RELY() {
  return getToken(SpecParser::RELY, 0);
}

std::vector<SpecParser::ExprContext *> SpecParser::Assert_stmtContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::Assert_stmtContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}


size_t SpecParser::Assert_stmtContext::getRuleIndex() const {
  return SpecParser::RuleAssert_stmt;
}


std::any SpecParser::Assert_stmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitAssert_stmt(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Assert_stmtContext* SpecParser::assert_stmt() {
  Assert_stmtContext *_localctx = _tracker.createInstance<Assert_stmtContext>(_ctx, getState());
  enterRule(_localctx, 48, SpecParser::RuleAssert_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(386);
    match(SpecParser::RELY);
    setState(387);
    expr();
    setState(388);
    match(SpecParser::T__21);
    setState(389);
    expr();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Anno_stmtContext ------------------------------------------------------------------

SpecParser::Anno_stmtContext::Anno_stmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Anno_stmtContext::ANNO() {
  return getToken(SpecParser::ANNO, 0);
}

std::vector<SpecParser::ExprContext *> SpecParser::Anno_stmtContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::Anno_stmtContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}


size_t SpecParser::Anno_stmtContext::getRuleIndex() const {
  return SpecParser::RuleAnno_stmt;
}


std::any SpecParser::Anno_stmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitAnno_stmt(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Anno_stmtContext* SpecParser::anno_stmt() {
  Anno_stmtContext *_localctx = _tracker.createInstance<Anno_stmtContext>(_ctx, getState());
  enterRule(_localctx, 50, SpecParser::RuleAnno_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(391);
    match(SpecParser::ANNO);
    setState(392);
    expr();
    setState(393);
    match(SpecParser::T__21);
    setState(394);
    expr();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- If_stmtContext ------------------------------------------------------------------

SpecParser::If_stmtContext::If_stmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::If_stmtContext::IF() {
  return getToken(SpecParser::IF, 0);
}

std::vector<SpecParser::ExprContext *> SpecParser::If_stmtContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::If_stmtContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
}

tree::TerminalNode* SpecParser::If_stmtContext::THEN() {
  return getToken(SpecParser::THEN, 0);
}

tree::TerminalNode* SpecParser::If_stmtContext::ELSE() {
  return getToken(SpecParser::ELSE, 0);
}


size_t SpecParser::If_stmtContext::getRuleIndex() const {
  return SpecParser::RuleIf_stmt;
}


std::any SpecParser::If_stmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitIf_stmt(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::If_stmtContext* SpecParser::if_stmt() {
  If_stmtContext *_localctx = _tracker.createInstance<If_stmtContext>(_ctx, getState());
  enterRule(_localctx, 52, SpecParser::RuleIf_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(396);
    match(SpecParser::IF);
    setState(397);
    expr();
    setState(398);
    match(SpecParser::THEN);
    setState(399);
    expr();
    setState(400);
    match(SpecParser::ELSE);
    setState(401);
    expr();
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Inductive_declContext ------------------------------------------------------------------

SpecParser::Inductive_declContext::Inductive_declContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Inductive_declContext::INDUC() {
  return getToken(SpecParser::INDUC, 0);
}

SpecParser::NameContext* SpecParser::Inductive_declContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

std::vector<SpecParser::Induct_armContext *> SpecParser::Inductive_declContext::induct_arm() {
  return getRuleContexts<SpecParser::Induct_armContext>();
}

SpecParser::Induct_armContext* SpecParser::Inductive_declContext::induct_arm(size_t i) {
  return getRuleContext<SpecParser::Induct_armContext>(i);
}


size_t SpecParser::Inductive_declContext::getRuleIndex() const {
  return SpecParser::RuleInductive_decl;
}


std::any SpecParser::Inductive_declContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitInductive_decl(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Inductive_declContext* SpecParser::inductive_decl() {
  Inductive_declContext *_localctx = _tracker.createInstance<Inductive_declContext>(_ctx, getState());
  enterRule(_localctx, 54, SpecParser::RuleInductive_decl);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(403);
    match(SpecParser::INDUC);
    setState(404);
    name();
    setState(405);
    match(SpecParser::T__0);
    setState(407); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(406);
      induct_arm();
      setState(409); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__22);
    setState(411);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Induct_armContext ------------------------------------------------------------------

SpecParser::Induct_armContext::Induct_armContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::NameContext* SpecParser::Induct_armContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

std::vector<SpecParser::Var_annoContext *> SpecParser::Induct_armContext::var_anno() {
  return getRuleContexts<SpecParser::Var_annoContext>();
}

SpecParser::Var_annoContext* SpecParser::Induct_armContext::var_anno(size_t i) {
  return getRuleContext<SpecParser::Var_annoContext>(i);
}


size_t SpecParser::Induct_armContext::getRuleIndex() const {
  return SpecParser::RuleInduct_arm;
}


std::any SpecParser::Induct_armContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitInduct_arm(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Induct_armContext* SpecParser::induct_arm() {
  Induct_armContext *_localctx = _tracker.createInstance<Induct_armContext>(_ctx, getState());
  enterRule(_localctx, 56, SpecParser::RuleInduct_arm);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(413);
    match(SpecParser::T__22);
    setState(414);
    name();
    setState(418);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::LP) {
      setState(415);
      var_anno();
      setState(420);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Record_declContext ------------------------------------------------------------------

SpecParser::Record_declContext::Record_declContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::Record_declContext::RECORD() {
  return getToken(SpecParser::RECORD, 0);
}

std::vector<SpecParser::NameContext *> SpecParser::Record_declContext::name() {
  return getRuleContexts<SpecParser::NameContext>();
}

SpecParser::NameContext* SpecParser::Record_declContext::name(size_t i) {
  return getRuleContext<SpecParser::NameContext>(i);
}

SpecParser::Record_fieldsContext* SpecParser::Record_declContext::record_fields() {
  return getRuleContext<SpecParser::Record_fieldsContext>(0);
}


size_t SpecParser::Record_declContext::getRuleIndex() const {
  return SpecParser::RuleRecord_decl;
}


std::any SpecParser::Record_declContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitRecord_decl(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Record_declContext* SpecParser::record_decl() {
  Record_declContext *_localctx = _tracker.createInstance<Record_declContext>(_ctx, getState());
  enterRule(_localctx, 58, SpecParser::RuleRecord_decl);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(421);
    match(SpecParser::RECORD);
    setState(422);
    name();
    setState(423);
    match(SpecParser::T__0);
    setState(424);
    name();
    setState(425);
    match(SpecParser::T__15);
    setState(426);
    record_fields();
    setState(427);
    match(SpecParser::T__16);
    setState(428);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Record_fieldsContext ------------------------------------------------------------------

SpecParser::Record_fieldsContext::Record_fieldsContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<SpecParser::NameContext *> SpecParser::Record_fieldsContext::name() {
  return getRuleContexts<SpecParser::NameContext>();
}

SpecParser::NameContext* SpecParser::Record_fieldsContext::name(size_t i) {
  return getRuleContext<SpecParser::NameContext>(i);
}

std::vector<SpecParser::TypeContext *> SpecParser::Record_fieldsContext::type() {
  return getRuleContexts<SpecParser::TypeContext>();
}

SpecParser::TypeContext* SpecParser::Record_fieldsContext::type(size_t i) {
  return getRuleContext<SpecParser::TypeContext>(i);
}


size_t SpecParser::Record_fieldsContext::getRuleIndex() const {
  return SpecParser::RuleRecord_fields;
}


std::any SpecParser::Record_fieldsContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitRecord_fields(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Record_fieldsContext* SpecParser::record_fields() {
  Record_fieldsContext *_localctx = _tracker.createInstance<Record_fieldsContext>(_ctx, getState());
  enterRule(_localctx, 60, SpecParser::RuleRecord_fields);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(430);
    name();
    setState(431);
    match(SpecParser::T__2);
    setState(432);
    type(0);
    setState(441);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::T__21) {
      setState(434);
      match(SpecParser::T__21);
      setState(435);
      name();
      setState(436);
      match(SpecParser::T__2);
      setState(437);
      type(0);
      setState(443);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Record_def_stmtContext ------------------------------------------------------------------

SpecParser::Record_def_stmtContext::Record_def_stmtContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::Record_fields_defContext* SpecParser::Record_def_stmtContext::record_fields_def() {
  return getRuleContext<SpecParser::Record_fields_defContext>(0);
}


size_t SpecParser::Record_def_stmtContext::getRuleIndex() const {
  return SpecParser::RuleRecord_def_stmt;
}


std::any SpecParser::Record_def_stmtContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitRecord_def_stmt(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Record_def_stmtContext* SpecParser::record_def_stmt() {
  Record_def_stmtContext *_localctx = _tracker.createInstance<Record_def_stmtContext>(_ctx, getState());
  enterRule(_localctx, 62, SpecParser::RuleRecord_def_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(444);
    match(SpecParser::T__24);
    setState(445);
    record_fields_def();
    setState(446);
    match(SpecParser::T__25);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Record_fields_defContext ------------------------------------------------------------------

SpecParser::Record_fields_defContext::Record_fields_defContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<SpecParser::NameContext *> SpecParser::Record_fields_defContext::name() {
  return getRuleContexts<SpecParser::NameContext>();
}

SpecParser::NameContext* SpecParser::Record_fields_defContext::name(size_t i) {
  return getRuleContext<SpecParser::NameContext>(i);
}


size_t SpecParser::Record_fields_defContext::getRuleIndex() const {
  return SpecParser::RuleRecord_fields_def;
}


std::any SpecParser::Record_fields_defContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitRecord_fields_def(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Record_fields_defContext* SpecParser::record_fields_def() {
  Record_fields_defContext *_localctx = _tracker.createInstance<Record_fields_defContext>(_ctx, getState());
  enterRule(_localctx, 64, SpecParser::RuleRecord_fields_def);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(448);
    name();
    setState(449);
    match(SpecParser::T__0);
    setState(450);
    name();
    setState(459);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::T__21) {
      setState(452);
      match(SpecParser::T__21);
      setState(453);
      name();
      setState(454);
      match(SpecParser::T__0);
      setState(455);
      name();
      setState(461);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- ValueContext ------------------------------------------------------------------

SpecParser::ValueContext::ValueContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::NameContext* SpecParser::ValueContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::NumberContext* SpecParser::ValueContext::number() {
  return getRuleContext<SpecParser::NumberContext>(0);
}

SpecParser::BoolContext* SpecParser::ValueContext::bool_() {
  return getRuleContext<SpecParser::BoolContext>(0);
}

SpecParser::StringContext* SpecParser::ValueContext::string() {
  return getRuleContext<SpecParser::StringContext>(0);
}


size_t SpecParser::ValueContext::getRuleIndex() const {
  return SpecParser::RuleValue;
}


std::any SpecParser::ValueContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitValue(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::ValueContext* SpecParser::value() {
  ValueContext *_localctx = _tracker.createInstance<ValueContext>(_ctx, getState());
  enterRule(_localctx, 66, SpecParser::RuleValue);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(466);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case SpecParser::ID: {
        enterOuterAlt(_localctx, 1);
        setState(462);
        name();
        break;
      }

      case SpecParser::NUMBER: {
        enterOuterAlt(_localctx, 2);
        setState(463);
        number();
        break;
      }

      case SpecParser::TRUE:
      case SpecParser::FALSE: {
        enterOuterAlt(_localctx, 3);
        setState(464);
        bool_();
        break;
      }

      case SpecParser::STR: {
        enterOuterAlt(_localctx, 4);
        setState(465);
        string();
        break;
      }

    default:
      throw NoViableAltException(this);
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- MkContext ------------------------------------------------------------------

SpecParser::MkContext::MkContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::MkContext::MK() {
  return getToken(SpecParser::MK, 0);
}


size_t SpecParser::MkContext::getRuleIndex() const {
  return SpecParser::RuleMk;
}


std::any SpecParser::MkContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitMk(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::MkContext* SpecParser::mk() {
  MkContext *_localctx = _tracker.createInstance<MkContext>(_ctx, getState());
  enterRule(_localctx, 68, SpecParser::RuleMk);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(468);
    match(SpecParser::MK);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- NameContext ------------------------------------------------------------------

SpecParser::NameContext::NameContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::NameContext::ID() {
  return getToken(SpecParser::ID, 0);
}


size_t SpecParser::NameContext::getRuleIndex() const {
  return SpecParser::RuleName;
}


std::any SpecParser::NameContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitName(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::NameContext* SpecParser::name() {
  NameContext *_localctx = _tracker.createInstance<NameContext>(_ctx, getState());
  enterRule(_localctx, 70, SpecParser::RuleName);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(470);
    match(SpecParser::ID);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- NumberContext ------------------------------------------------------------------

SpecParser::NumberContext::NumberContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::NumberContext::NUMBER() {
  return getToken(SpecParser::NUMBER, 0);
}


size_t SpecParser::NumberContext::getRuleIndex() const {
  return SpecParser::RuleNumber;
}


std::any SpecParser::NumberContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitNumber(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::NumberContext* SpecParser::number() {
  NumberContext *_localctx = _tracker.createInstance<NumberContext>(_ctx, getState());
  enterRule(_localctx, 72, SpecParser::RuleNumber);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(472);
    match(SpecParser::NUMBER);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- StringContext ------------------------------------------------------------------

SpecParser::StringContext::StringContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::StringContext::STR() {
  return getToken(SpecParser::STR, 0);
}


size_t SpecParser::StringContext::getRuleIndex() const {
  return SpecParser::RuleString;
}


std::any SpecParser::StringContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitString(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::StringContext* SpecParser::string() {
  StringContext *_localctx = _tracker.createInstance<StringContext>(_ctx, getState());
  enterRule(_localctx, 74, SpecParser::RuleString);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(474);
    match(SpecParser::STR);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- BoolContext ------------------------------------------------------------------

SpecParser::BoolContext::BoolContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

tree::TerminalNode* SpecParser::BoolContext::TRUE() {
  return getToken(SpecParser::TRUE, 0);
}

tree::TerminalNode* SpecParser::BoolContext::FALSE() {
  return getToken(SpecParser::FALSE, 0);
}


size_t SpecParser::BoolContext::getRuleIndex() const {
  return SpecParser::RuleBool;
}


std::any SpecParser::BoolContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitBool(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::BoolContext* SpecParser::bool_() {
  BoolContext *_localctx = _tracker.createInstance<BoolContext>(_ctx, getState());
  enterRule(_localctx, 76, SpecParser::RuleBool);
  size_t _la = 0;

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(476);
    _la = _input->LA(1);
    if (!(_la == SpecParser::TRUE

    || _la == SpecParser::FALSE)) {
    _errHandler->recoverInline(this);
    }
    else {
      _errHandler->reportMatch(this);
      consume();
    }
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

bool SpecParser::sempred(RuleContext *context, size_t ruleIndex, size_t predicateIndex) {
  switch (ruleIndex) {
    case 11: return typeSempred(antlrcpp::downCast<TypeContext *>(context), predicateIndex);
    case 13: return expr_opSempred(antlrcpp::downCast<Expr_opContext *>(context), predicateIndex);
    case 14: return termSempred(antlrcpp::downCast<TermContext *>(context), predicateIndex);

  default:
    break;
  }
  return true;
}

bool SpecParser::typeSempred(TypeContext *_localctx, size_t predicateIndex) {
  switch (predicateIndex) {
    case 0: return precpred(_ctx, 3);

  default:
    break;
  }
  return true;
}

bool SpecParser::expr_opSempred(Expr_opContext *_localctx, size_t predicateIndex) {
  switch (predicateIndex) {
    case 1: return precpred(_ctx, 15);
    case 2: return precpred(_ctx, 14);
    case 3: return precpred(_ctx, 13);
    case 4: return precpred(_ctx, 12);
    case 5: return precpred(_ctx, 9);
    case 6: return precpred(_ctx, 8);
    case 7: return precpred(_ctx, 7);
    case 8: return precpred(_ctx, 5);
    case 9: return precpred(_ctx, 4);
    case 10: return precpred(_ctx, 3);
    case 11: return precpred(_ctx, 2);
    case 12: return precpred(_ctx, 6);

  default:
    break;
  }
  return true;
}

bool SpecParser::termSempred(TermContext *_localctx, size_t predicateIndex) {
  switch (predicateIndex) {
    case 13: return precpred(_ctx, 4);

  default:
    break;
  }
  return true;
}

void SpecParser::initialize() {
  ::antlr4::internal::call_once(specParserOnceFlag, specParserInitialize);
}
