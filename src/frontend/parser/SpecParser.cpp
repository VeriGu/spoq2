
// Generated from Spec.g4 by ANTLR 4.12.0


#include "SpecVisitor.h"

#include "SpecParser.h"


using namespace antlrcpp;

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
      "program", "statement", "typedef", "def", "invdef", "decl", "fixpoint", 
      "path", "include", "command", "global_anno", "anno_struct", "loop_inv", 
      "section_begin", "section_end", "type", "expr", "expr_op", "term", 
      "tuple", "func_call", "forall_expr", "exists_expr", "var_anno", "let_stmt", 
      "when_stmt", "match_stmt", "match_branch", "assert_stmt", "anno_stmt", 
      "if_stmt", "inductive_decl", "induct_arm", "record_decl", "record_fields", 
      "record_def_stmt", "record_fields_def", "value", "mk", "name", "number", 
      "string", "bool", "veclen", "vecget", "vecreplace"
    },
    std::vector<std::string>{
      "", "':='", "'.'", "':'", "'Invariant'", "'Include'", "'Hint'", "'Anno'", 
      "'array'", "'{'", "'}'", "'base'", "','", "'size'", "'max_elems'", 
      "'Loop_inv'", "'Z'", "'bool'", "'string'", "'Type'", "'Prop'", "'list'", 
      "'option'", "'ZMap.t'", "'PMap.t'", "'SMap'", "'Vector'", "'=='", 
      "'['", "']'", "':<'", "'in'", "';'", "'|'", "'=>'", "'{|'", "'|}'", 
      "'veclen'", "'vecget'", "'vecreplace'", "'mk'", "'Inductive'", "'Record'", 
      "'Fixpoint'", "'Section'", "'End'", "'::'", "'++'", "'+'", "'-'", 
      "'*'", "'/'", "'mod'", "'<<'", "'>>'", "'&'", "'|''", "'&&'", "'||'", 
      "'=\\u003F'", "'<>\\u003F'", "'>\\u003F'", "'<\\u003F'", "'>=\\u003F'", 
      "'<=\\u003F'", "'=s'", "'<>s'", "'=l'", "'@'", "'#'", "'$'", "'/\\'", 
      "'\\/'", "'~'", "'!'", "'->'", "'<->'", "'='", "'<>'", "'>'", "'<'", 
      "'>='", "'<='", "'('", "')'", "'if'", "'then'", "'let'", "'else'", 
      "'Parameter'", "'Definition'", "'when'", "'forall'", "'exists'", "'match'", 
      "'return'", "'with'", "'end'", "'rely'", "'anno'", "'true'", "'false'"
    },
    std::vector<std::string>{
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
      "", "", "", "", "", "", "MK", "INDUC", "RECORD", "FIXPOINT", "SECTION", 
      "SECTION_END", "APPEND", "CONCAT", "ADD", "MINUS", "MULT", "DIV", 
      "MOD", "LSHIFT", "RSHIFT", "BITAND", "BITOR", "BAND", "BOR", "BEQ", 
      "BNE", "BGT", "BLT", "BGE", "BLE", "SEQ", "SNE", "LIST_EQ", "GET", 
      "SET", "NTH", "AND", "OR", "NOT", "BNOT", "IMPLIES", "IFONLYIF", "EQUAL", 
      "NOT_EQUAL", "GT", "LT", "GTE", "LTE", "LP", "RP", "IF", "THEN", "LET", 
      "ELSE", "PARAM", "DEF", "WHEN", "FORALL", "EXISTS", "MATCH", "RETURN", 
      "WITH", "END", "RELY", "ANNO", "TRUE", "FALSE", "NUMBER", "STR", "ID", 
      "COMMENT", "WS"
    }
  );
  static const int32_t serializedATNSegment[] = {
  	4,1,106,557,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,
  	7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,14,7,
  	14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,2,21,7,
  	21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,2,27,7,27,2,28,7,
  	28,2,29,7,29,2,30,7,30,2,31,7,31,2,32,7,32,2,33,7,33,2,34,7,34,2,35,7,
  	35,2,36,7,36,2,37,7,37,2,38,7,38,2,39,7,39,2,40,7,40,2,41,7,41,2,42,7,
  	42,2,43,7,43,2,44,7,44,2,45,7,45,1,0,5,0,94,8,0,10,0,12,0,97,9,0,1,0,
  	1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,3,1,114,8,1,1,
  	2,1,2,1,2,1,2,1,2,1,2,1,3,1,3,1,3,5,3,125,8,3,10,3,12,3,128,9,3,1,3,1,
  	3,1,3,1,3,1,3,1,3,1,4,1,4,1,4,1,4,1,4,1,4,1,5,1,5,1,5,1,5,1,5,1,5,1,6,
  	1,6,1,6,5,6,151,8,6,10,6,12,6,154,9,6,1,6,1,6,1,6,1,6,1,6,1,6,1,7,1,7,
  	1,8,1,8,1,8,1,8,1,9,1,9,1,9,1,9,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,
  	10,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,1,
  	12,1,12,1,12,1,12,1,13,1,13,1,13,1,13,1,14,1,14,1,14,1,14,1,15,1,15,1,
  	15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,
  	15,1,15,1,15,1,15,1,15,1,15,4,15,227,8,15,11,15,12,15,228,1,15,1,15,1,
  	15,1,15,1,15,1,15,1,15,3,15,238,8,15,1,15,1,15,1,15,1,15,1,15,1,15,5,
  	15,246,8,15,10,15,12,15,249,9,15,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,
  	16,3,16,259,8,16,1,17,1,17,1,17,4,17,264,8,17,11,17,12,17,265,1,17,1,
  	17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,277,8,17,1,17,1,17,1,17,1,
  	17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,
  	17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,4,17,309,
  	8,17,11,17,12,17,310,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,
  	1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,5,17,332,8,17,10,17,12,17,
  	335,9,17,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,
  	3,18,349,8,18,1,18,1,18,1,18,1,18,1,18,1,18,5,18,357,8,18,10,18,12,18,
  	360,9,18,1,19,1,19,1,19,1,19,4,19,366,8,19,11,19,12,19,367,1,19,1,19,
  	1,20,1,20,4,20,374,8,20,11,20,12,20,375,1,21,1,21,4,21,380,8,21,11,21,
  	12,21,381,1,22,1,22,4,22,386,8,22,11,22,12,22,387,1,23,1,23,1,23,1,23,
  	1,23,1,23,1,23,1,23,1,23,1,23,1,23,1,23,3,23,402,8,23,1,24,1,24,1,24,
  	1,24,1,24,1,24,1,24,1,24,1,24,1,24,1,24,1,24,1,24,1,24,3,24,418,8,24,
  	1,25,1,25,1,25,1,25,5,25,424,8,25,10,25,12,25,427,9,25,1,25,1,25,1,25,
  	1,25,1,25,1,26,1,26,1,26,1,26,4,26,438,8,26,11,26,12,26,439,1,26,1,26,
  	1,27,1,27,1,27,1,27,1,27,1,28,1,28,1,28,1,28,1,28,1,29,1,29,1,29,1,29,
  	1,29,1,30,1,30,1,30,1,30,1,30,1,30,1,30,1,31,1,31,1,31,1,31,4,31,470,
  	8,31,11,31,12,31,471,1,31,1,31,1,32,1,32,1,32,5,32,479,8,32,10,32,12,
  	32,482,9,32,1,33,1,33,1,33,5,33,487,8,33,10,33,12,33,490,9,33,1,33,1,
  	33,1,33,1,33,1,33,1,33,1,33,1,34,1,34,1,34,1,34,3,34,503,8,34,1,34,1,
  	34,1,34,1,34,1,34,3,34,510,8,34,5,34,512,8,34,10,34,12,34,515,9,34,1,
  	35,1,35,1,35,1,35,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,5,36,530,
  	8,36,10,36,12,36,533,9,36,1,37,1,37,1,37,1,37,3,37,539,8,37,1,38,1,38,
  	1,39,1,39,1,40,1,40,1,41,1,41,1,42,1,42,1,43,1,43,1,44,1,44,1,45,1,45,
  	1,45,0,3,30,34,36,46,0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,
  	36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,
  	82,84,86,88,90,0,8,1,0,50,52,2,0,48,49,55,56,2,0,53,54,57,67,1,0,46,47,
  	1,0,77,82,2,0,71,72,76,76,2,0,49,49,73,74,1,0,100,101,586,0,95,1,0,0,
  	0,2,113,1,0,0,0,4,115,1,0,0,0,6,121,1,0,0,0,8,135,1,0,0,0,10,141,1,0,
  	0,0,12,147,1,0,0,0,14,161,1,0,0,0,16,163,1,0,0,0,18,167,1,0,0,0,20,171,
  	1,0,0,0,22,179,1,0,0,0,24,192,1,0,0,0,26,196,1,0,0,0,28,200,1,0,0,0,30,
  	237,1,0,0,0,32,258,1,0,0,0,34,276,1,0,0,0,36,348,1,0,0,0,38,361,1,0,0,
  	0,40,371,1,0,0,0,42,377,1,0,0,0,44,383,1,0,0,0,46,401,1,0,0,0,48,417,
  	1,0,0,0,50,419,1,0,0,0,52,433,1,0,0,0,54,443,1,0,0,0,56,448,1,0,0,0,58,
  	453,1,0,0,0,60,458,1,0,0,0,62,465,1,0,0,0,64,475,1,0,0,0,66,483,1,0,0,
  	0,68,498,1,0,0,0,70,516,1,0,0,0,72,520,1,0,0,0,74,538,1,0,0,0,76,540,
  	1,0,0,0,78,542,1,0,0,0,80,544,1,0,0,0,82,546,1,0,0,0,84,548,1,0,0,0,86,
  	550,1,0,0,0,88,552,1,0,0,0,90,554,1,0,0,0,92,94,3,2,1,0,93,92,1,0,0,0,
  	94,97,1,0,0,0,95,93,1,0,0,0,95,96,1,0,0,0,96,98,1,0,0,0,97,95,1,0,0,0,
  	98,99,5,0,0,1,99,1,1,0,0,0,100,114,3,26,13,0,101,114,3,28,14,0,102,114,
  	3,4,2,0,103,114,3,6,3,0,104,114,3,10,5,0,105,114,3,8,4,0,106,114,3,12,
  	6,0,107,114,3,62,31,0,108,114,3,66,33,0,109,114,3,16,8,0,110,114,3,18,
  	9,0,111,114,3,20,10,0,112,114,3,24,12,0,113,100,1,0,0,0,113,101,1,0,0,
  	0,113,102,1,0,0,0,113,103,1,0,0,0,113,104,1,0,0,0,113,105,1,0,0,0,113,
  	106,1,0,0,0,113,107,1,0,0,0,113,108,1,0,0,0,113,109,1,0,0,0,113,110,1,
  	0,0,0,113,111,1,0,0,0,113,112,1,0,0,0,114,3,1,0,0,0,115,116,5,90,0,0,
  	116,117,3,78,39,0,117,118,5,1,0,0,118,119,3,30,15,0,119,120,5,2,0,0,120,
  	5,1,0,0,0,121,122,5,90,0,0,122,126,3,78,39,0,123,125,3,46,23,0,124,123,
  	1,0,0,0,125,128,1,0,0,0,126,124,1,0,0,0,126,127,1,0,0,0,127,129,1,0,0,
  	0,128,126,1,0,0,0,129,130,5,3,0,0,130,131,3,30,15,0,131,132,5,1,0,0,132,
  	133,3,32,16,0,133,134,5,2,0,0,134,7,1,0,0,0,135,136,5,4,0,0,136,137,3,
  	78,39,0,137,138,5,1,0,0,138,139,3,32,16,0,139,140,5,2,0,0,140,9,1,0,0,
  	0,141,142,5,89,0,0,142,143,3,78,39,0,143,144,5,3,0,0,144,145,3,30,15,
  	0,145,146,5,2,0,0,146,11,1,0,0,0,147,148,5,43,0,0,148,152,3,78,39,0,149,
  	151,3,46,23,0,150,149,1,0,0,0,151,154,1,0,0,0,152,150,1,0,0,0,152,153,
  	1,0,0,0,153,155,1,0,0,0,154,152,1,0,0,0,155,156,5,3,0,0,156,157,3,30,
  	15,0,157,158,5,1,0,0,158,159,3,32,16,0,159,160,5,2,0,0,160,13,1,0,0,0,
  	161,162,5,103,0,0,162,15,1,0,0,0,163,164,5,5,0,0,164,165,3,14,7,0,165,
  	166,5,2,0,0,166,17,1,0,0,0,167,168,5,6,0,0,168,169,3,32,16,0,169,170,
  	5,2,0,0,170,19,1,0,0,0,171,172,5,7,0,0,172,173,5,8,0,0,173,174,3,78,39,
  	0,174,175,5,9,0,0,175,176,3,22,11,0,176,177,5,10,0,0,177,178,5,2,0,0,
  	178,21,1,0,0,0,179,180,5,11,0,0,180,181,5,3,0,0,181,182,3,80,40,0,182,
  	183,5,12,0,0,183,184,5,13,0,0,184,185,5,3,0,0,185,186,3,80,40,0,186,187,
  	5,12,0,0,187,188,5,14,0,0,188,189,5,3,0,0,189,190,3,80,40,0,190,191,5,
  	2,0,0,191,23,1,0,0,0,192,193,5,15,0,0,193,194,3,32,16,0,194,195,5,2,0,
  	0,195,25,1,0,0,0,196,197,5,44,0,0,197,198,3,78,39,0,198,199,5,2,0,0,199,
  	27,1,0,0,0,200,201,5,45,0,0,201,202,3,78,39,0,202,203,5,2,0,0,203,29,
  	1,0,0,0,204,205,6,15,-1,0,205,238,5,16,0,0,206,238,5,17,0,0,207,238,5,
  	18,0,0,208,238,5,19,0,0,209,238,5,20,0,0,210,211,5,21,0,0,211,238,3,30,
  	15,10,212,213,5,22,0,0,213,238,3,30,15,9,214,215,5,23,0,0,215,238,3,30,
  	15,8,216,217,5,24,0,0,217,238,3,30,15,7,218,219,5,25,0,0,219,238,3,30,
  	15,6,220,221,5,26,0,0,221,238,3,30,15,5,222,223,5,83,0,0,223,226,3,30,
  	15,0,224,225,5,50,0,0,225,227,3,30,15,0,226,224,1,0,0,0,227,228,1,0,0,
  	0,228,226,1,0,0,0,228,229,1,0,0,0,229,230,1,0,0,0,230,231,5,84,0,0,231,
  	238,1,0,0,0,232,233,5,83,0,0,233,234,3,30,15,0,234,235,5,84,0,0,235,238,
  	1,0,0,0,236,238,3,78,39,0,237,204,1,0,0,0,237,206,1,0,0,0,237,207,1,0,
  	0,0,237,208,1,0,0,0,237,209,1,0,0,0,237,210,1,0,0,0,237,212,1,0,0,0,237,
  	214,1,0,0,0,237,216,1,0,0,0,237,218,1,0,0,0,237,220,1,0,0,0,237,222,1,
  	0,0,0,237,232,1,0,0,0,237,236,1,0,0,0,238,247,1,0,0,0,239,240,10,3,0,
  	0,240,241,5,75,0,0,241,242,5,83,0,0,242,243,3,30,15,0,243,244,5,84,0,
  	0,244,246,1,0,0,0,245,239,1,0,0,0,246,249,1,0,0,0,247,245,1,0,0,0,247,
  	248,1,0,0,0,248,31,1,0,0,0,249,247,1,0,0,0,250,259,3,48,24,0,251,259,
  	3,50,25,0,252,259,3,52,26,0,253,259,3,56,28,0,254,259,3,58,29,0,255,259,
  	3,60,30,0,256,259,3,70,35,0,257,259,3,34,17,0,258,250,1,0,0,0,258,251,
  	1,0,0,0,258,252,1,0,0,0,258,253,1,0,0,0,258,254,1,0,0,0,258,255,1,0,0,
  	0,258,256,1,0,0,0,258,257,1,0,0,0,259,33,1,0,0,0,260,261,6,17,-1,0,261,
  	263,3,36,18,0,262,264,3,36,18,0,263,262,1,0,0,0,264,265,1,0,0,0,265,263,
  	1,0,0,0,265,266,1,0,0,0,266,277,1,0,0,0,267,268,3,44,22,0,268,269,5,12,
  	0,0,269,270,3,34,17,11,270,277,1,0,0,0,271,272,3,42,21,0,272,273,5,12,
  	0,0,273,274,3,34,17,10,274,277,1,0,0,0,275,277,3,36,18,0,276,260,1,0,
  	0,0,276,267,1,0,0,0,276,271,1,0,0,0,276,275,1,0,0,0,277,333,1,0,0,0,278,
  	279,10,15,0,0,279,280,7,0,0,0,280,332,3,34,17,16,281,282,10,14,0,0,282,
  	283,7,1,0,0,283,332,3,34,17,15,284,285,10,13,0,0,285,286,7,2,0,0,286,
  	332,3,34,17,14,287,288,10,12,0,0,288,289,7,3,0,0,289,332,3,34,17,12,290,
  	291,10,9,0,0,291,292,5,69,0,0,292,293,3,34,17,0,293,294,5,27,0,0,294,
  	295,3,34,17,10,295,332,1,0,0,0,296,297,10,8,0,0,297,298,5,68,0,0,298,
  	332,3,34,17,9,299,300,10,7,0,0,300,301,5,70,0,0,301,332,3,34,17,8,302,
  	308,10,5,0,0,303,304,5,2,0,0,304,305,5,28,0,0,305,306,3,78,39,0,306,307,
  	5,29,0,0,307,309,1,0,0,0,308,303,1,0,0,0,309,310,1,0,0,0,310,308,1,0,
  	0,0,310,311,1,0,0,0,311,312,1,0,0,0,312,313,5,30,0,0,313,314,3,34,17,
  	6,314,332,1,0,0,0,315,316,10,4,0,0,316,317,7,4,0,0,317,332,3,34,17,5,
  	318,319,10,3,0,0,319,320,7,5,0,0,320,332,3,34,17,4,321,322,10,2,0,0,322,
  	323,5,75,0,0,323,332,3,34,17,2,324,325,10,6,0,0,325,326,5,9,0,0,326,327,
  	3,78,39,0,327,328,5,3,0,0,328,329,3,34,17,0,329,330,5,10,0,0,330,332,
  	1,0,0,0,331,278,1,0,0,0,331,281,1,0,0,0,331,284,1,0,0,0,331,287,1,0,0,
  	0,331,290,1,0,0,0,331,296,1,0,0,0,331,299,1,0,0,0,331,302,1,0,0,0,331,
  	315,1,0,0,0,331,318,1,0,0,0,331,321,1,0,0,0,331,324,1,0,0,0,332,335,1,
  	0,0,0,333,331,1,0,0,0,333,334,1,0,0,0,334,35,1,0,0,0,335,333,1,0,0,0,
  	336,337,6,18,-1,0,337,338,5,83,0,0,338,339,3,32,16,0,339,340,5,84,0,0,
  	340,349,1,0,0,0,341,342,5,83,0,0,342,343,7,6,0,0,343,344,3,36,18,0,344,
  	345,5,84,0,0,345,349,1,0,0,0,346,349,3,38,19,0,347,349,3,74,37,0,348,
  	336,1,0,0,0,348,341,1,0,0,0,348,346,1,0,0,0,348,347,1,0,0,0,349,358,1,
  	0,0,0,350,351,10,4,0,0,351,352,5,2,0,0,352,353,5,83,0,0,353,354,3,78,
  	39,0,354,355,5,84,0,0,355,357,1,0,0,0,356,350,1,0,0,0,357,360,1,0,0,0,
  	358,356,1,0,0,0,358,359,1,0,0,0,359,37,1,0,0,0,360,358,1,0,0,0,361,362,
  	5,83,0,0,362,365,3,32,16,0,363,364,5,12,0,0,364,366,3,32,16,0,365,363,
  	1,0,0,0,366,367,1,0,0,0,367,365,1,0,0,0,367,368,1,0,0,0,368,369,1,0,0,
  	0,369,370,5,84,0,0,370,39,1,0,0,0,371,373,3,78,39,0,372,374,3,32,16,0,
  	373,372,1,0,0,0,374,375,1,0,0,0,375,373,1,0,0,0,375,376,1,0,0,0,376,41,
  	1,0,0,0,377,379,5,92,0,0,378,380,3,46,23,0,379,378,1,0,0,0,380,381,1,
  	0,0,0,381,379,1,0,0,0,381,382,1,0,0,0,382,43,1,0,0,0,383,385,5,93,0,0,
  	384,386,3,46,23,0,385,384,1,0,0,0,386,387,1,0,0,0,387,385,1,0,0,0,387,
  	388,1,0,0,0,388,45,1,0,0,0,389,390,5,83,0,0,390,391,3,78,39,0,391,392,
  	5,3,0,0,392,393,3,30,15,0,393,394,5,84,0,0,394,402,1,0,0,0,395,396,5,
  	83,0,0,396,397,3,78,39,0,397,398,5,3,0,0,398,399,3,32,16,0,399,400,5,
  	84,0,0,400,402,1,0,0,0,401,389,1,0,0,0,401,395,1,0,0,0,402,47,1,0,0,0,
  	403,404,5,87,0,0,404,405,3,78,39,0,405,406,5,1,0,0,406,407,3,32,16,0,
  	407,408,5,31,0,0,408,409,3,32,16,0,409,418,1,0,0,0,410,411,5,87,0,0,411,
  	412,3,38,19,0,412,413,5,1,0,0,413,414,3,32,16,0,414,415,5,31,0,0,415,
  	416,3,32,16,0,416,418,1,0,0,0,417,403,1,0,0,0,417,410,1,0,0,0,418,49,
  	1,0,0,0,419,420,5,91,0,0,420,425,3,78,39,0,421,422,5,12,0,0,422,424,3,
  	78,39,0,423,421,1,0,0,0,424,427,1,0,0,0,425,423,1,0,0,0,425,426,1,0,0,
  	0,426,428,1,0,0,0,427,425,1,0,0,0,428,429,5,27,0,0,429,430,3,32,16,0,
  	430,431,5,32,0,0,431,432,3,32,16,0,432,51,1,0,0,0,433,434,5,94,0,0,434,
  	435,3,32,16,0,435,437,5,96,0,0,436,438,3,54,27,0,437,436,1,0,0,0,438,
  	439,1,0,0,0,439,437,1,0,0,0,439,440,1,0,0,0,440,441,1,0,0,0,441,442,5,
  	97,0,0,442,53,1,0,0,0,443,444,5,33,0,0,444,445,3,32,16,0,445,446,5,34,
  	0,0,446,447,3,32,16,0,447,55,1,0,0,0,448,449,5,98,0,0,449,450,3,32,16,
  	0,450,451,5,32,0,0,451,452,3,32,16,0,452,57,1,0,0,0,453,454,5,99,0,0,
  	454,455,3,32,16,0,455,456,5,32,0,0,456,457,3,32,16,0,457,59,1,0,0,0,458,
  	459,5,85,0,0,459,460,3,32,16,0,460,461,5,86,0,0,461,462,3,32,16,0,462,
  	463,5,88,0,0,463,464,3,32,16,0,464,61,1,0,0,0,465,466,5,41,0,0,466,467,
  	3,78,39,0,467,469,5,1,0,0,468,470,3,64,32,0,469,468,1,0,0,0,470,471,1,
  	0,0,0,471,469,1,0,0,0,471,472,1,0,0,0,472,473,1,0,0,0,473,474,5,2,0,0,
  	474,63,1,0,0,0,475,476,5,33,0,0,476,480,3,78,39,0,477,479,3,46,23,0,478,
  	477,1,0,0,0,479,482,1,0,0,0,480,478,1,0,0,0,480,481,1,0,0,0,481,65,1,
  	0,0,0,482,480,1,0,0,0,483,484,5,42,0,0,484,488,3,78,39,0,485,487,3,46,
  	23,0,486,485,1,0,0,0,487,490,1,0,0,0,488,486,1,0,0,0,488,489,1,0,0,0,
  	489,491,1,0,0,0,490,488,1,0,0,0,491,492,5,1,0,0,492,493,3,78,39,0,493,
  	494,5,9,0,0,494,495,3,68,34,0,495,496,5,10,0,0,496,497,5,2,0,0,497,67,
  	1,0,0,0,498,499,3,78,39,0,499,502,5,3,0,0,500,503,3,30,15,0,501,503,3,
  	32,16,0,502,500,1,0,0,0,502,501,1,0,0,0,503,513,1,0,0,0,504,505,5,32,
  	0,0,505,506,3,78,39,0,506,509,5,3,0,0,507,510,3,30,15,0,508,510,3,32,
  	16,0,509,507,1,0,0,0,509,508,1,0,0,0,510,512,1,0,0,0,511,504,1,0,0,0,
  	512,515,1,0,0,0,513,511,1,0,0,0,513,514,1,0,0,0,514,69,1,0,0,0,515,513,
  	1,0,0,0,516,517,5,35,0,0,517,518,3,72,36,0,518,519,5,36,0,0,519,71,1,
  	0,0,0,520,521,3,78,39,0,521,522,5,1,0,0,522,523,3,78,39,0,523,531,1,0,
  	0,0,524,525,5,32,0,0,525,526,3,78,39,0,526,527,5,1,0,0,527,528,3,78,39,
  	0,528,530,1,0,0,0,529,524,1,0,0,0,530,533,1,0,0,0,531,529,1,0,0,0,531,
  	532,1,0,0,0,532,73,1,0,0,0,533,531,1,0,0,0,534,539,3,78,39,0,535,539,
  	3,80,40,0,536,539,3,84,42,0,537,539,3,82,41,0,538,534,1,0,0,0,538,535,
  	1,0,0,0,538,536,1,0,0,0,538,537,1,0,0,0,539,75,1,0,0,0,540,541,5,40,0,
  	0,541,77,1,0,0,0,542,543,5,104,0,0,543,79,1,0,0,0,544,545,5,102,0,0,545,
  	81,1,0,0,0,546,547,5,103,0,0,547,83,1,0,0,0,548,549,7,7,0,0,549,85,1,
  	0,0,0,550,551,5,37,0,0,551,87,1,0,0,0,552,553,5,38,0,0,553,89,1,0,0,0,
  	554,555,5,39,0,0,555,91,1,0,0,0,31,95,113,126,152,228,237,247,258,265,
  	276,310,331,333,348,358,367,375,381,387,401,417,425,439,471,480,488,502,
  	509,513,531,538
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
    setState(95);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while ((((_la & ~ 0x3fULL) == 0) &&
      ((1ULL << _la) & 68169720955120) != 0) || _la == SpecParser::PARAM

    || _la == SpecParser::DEF) {
      setState(92);
      statement();
      setState(97);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(98);
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

SpecParser::InvdefContext* SpecParser::StatementContext::invdef() {
  return getRuleContext<SpecParser::InvdefContext>(0);
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

SpecParser::Global_annoContext* SpecParser::StatementContext::global_anno() {
  return getRuleContext<SpecParser::Global_annoContext>(0);
}

SpecParser::Loop_invContext* SpecParser::StatementContext::loop_inv() {
  return getRuleContext<SpecParser::Loop_invContext>(0);
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
    setState(113);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 1, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(100);
      section_begin();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(101);
      section_end();
      break;
    }

    case 3: {
      enterOuterAlt(_localctx, 3);
      setState(102);
      typedef_();
      break;
    }

    case 4: {
      enterOuterAlt(_localctx, 4);
      setState(103);
      def();
      break;
    }

    case 5: {
      enterOuterAlt(_localctx, 5);
      setState(104);
      decl();
      break;
    }

    case 6: {
      enterOuterAlt(_localctx, 6);
      setState(105);
      invdef();
      break;
    }

    case 7: {
      enterOuterAlt(_localctx, 7);
      setState(106);
      fixpoint();
      break;
    }

    case 8: {
      enterOuterAlt(_localctx, 8);
      setState(107);
      inductive_decl();
      break;
    }

    case 9: {
      enterOuterAlt(_localctx, 9);
      setState(108);
      record_decl();
      break;
    }

    case 10: {
      enterOuterAlt(_localctx, 10);
      setState(109);
      include();
      break;
    }

    case 11: {
      enterOuterAlt(_localctx, 11);
      setState(110);
      command();
      break;
    }

    case 12: {
      enterOuterAlt(_localctx, 12);
      setState(111);
      global_anno();
      break;
    }

    case 13: {
      enterOuterAlt(_localctx, 13);
      setState(112);
      loop_inv();
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
    setState(115);
    match(SpecParser::DEF);
    setState(116);
    name();
    setState(117);
    match(SpecParser::T__0);
    setState(118);
    type(0);
    setState(119);
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
    setState(121);
    match(SpecParser::DEF);
    setState(122);
    name();
    setState(126);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::LP) {
      setState(123);
      var_anno();
      setState(128);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(129);
    match(SpecParser::T__2);
    setState(130);
    type(0);
    setState(131);
    match(SpecParser::T__0);
    setState(132);
    expr();
    setState(133);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- InvdefContext ------------------------------------------------------------------

SpecParser::InvdefContext::InvdefContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::NameContext* SpecParser::InvdefContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::ExprContext* SpecParser::InvdefContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
}


size_t SpecParser::InvdefContext::getRuleIndex() const {
  return SpecParser::RuleInvdef;
}


std::any SpecParser::InvdefContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitInvdef(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::InvdefContext* SpecParser::invdef() {
  InvdefContext *_localctx = _tracker.createInstance<InvdefContext>(_ctx, getState());
  enterRule(_localctx, 8, SpecParser::RuleInvdef);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(135);
    match(SpecParser::T__3);
    setState(136);
    name();
    setState(137);
    match(SpecParser::T__0);
    setState(138);
    expr();
    setState(139);
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
  enterRule(_localctx, 10, SpecParser::RuleDecl);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(141);
    match(SpecParser::PARAM);
    setState(142);
    name();
    setState(143);
    match(SpecParser::T__2);
    setState(144);
    type(0);
    setState(145);
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
  enterRule(_localctx, 12, SpecParser::RuleFixpoint);
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
    setState(147);
    match(SpecParser::FIXPOINT);
    setState(148);
    name();
    setState(152);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::LP) {
      setState(149);
      var_anno();
      setState(154);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(155);
    match(SpecParser::T__2);
    setState(156);
    type(0);
    setState(157);
    match(SpecParser::T__0);
    setState(158);
    expr();
    setState(159);
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
  enterRule(_localctx, 14, SpecParser::RulePath);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(161);
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
  enterRule(_localctx, 16, SpecParser::RuleInclude);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(163);
    match(SpecParser::T__4);
    setState(164);
    path();
    setState(165);
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
  enterRule(_localctx, 18, SpecParser::RuleCommand);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(167);
    match(SpecParser::T__5);
    setState(168);
    expr();
    setState(169);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Global_annoContext ------------------------------------------------------------------

SpecParser::Global_annoContext::Global_annoContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::NameContext* SpecParser::Global_annoContext::name() {
  return getRuleContext<SpecParser::NameContext>(0);
}

SpecParser::Anno_structContext* SpecParser::Global_annoContext::anno_struct() {
  return getRuleContext<SpecParser::Anno_structContext>(0);
}


size_t SpecParser::Global_annoContext::getRuleIndex() const {
  return SpecParser::RuleGlobal_anno;
}


std::any SpecParser::Global_annoContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitGlobal_anno(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Global_annoContext* SpecParser::global_anno() {
  Global_annoContext *_localctx = _tracker.createInstance<Global_annoContext>(_ctx, getState());
  enterRule(_localctx, 20, SpecParser::RuleGlobal_anno);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(171);
    match(SpecParser::T__6);
    setState(172);
    match(SpecParser::T__7);
    setState(173);
    name();
    setState(174);
    match(SpecParser::T__8);
    setState(175);
    anno_struct();
    setState(176);
    match(SpecParser::T__9);
    setState(177);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Anno_structContext ------------------------------------------------------------------

SpecParser::Anno_structContext::Anno_structContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

std::vector<SpecParser::NumberContext *> SpecParser::Anno_structContext::number() {
  return getRuleContexts<SpecParser::NumberContext>();
}

SpecParser::NumberContext* SpecParser::Anno_structContext::number(size_t i) {
  return getRuleContext<SpecParser::NumberContext>(i);
}


size_t SpecParser::Anno_structContext::getRuleIndex() const {
  return SpecParser::RuleAnno_struct;
}


std::any SpecParser::Anno_structContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitAnno_struct(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Anno_structContext* SpecParser::anno_struct() {
  Anno_structContext *_localctx = _tracker.createInstance<Anno_structContext>(_ctx, getState());
  enterRule(_localctx, 22, SpecParser::RuleAnno_struct);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(179);
    match(SpecParser::T__10);
    setState(180);
    match(SpecParser::T__2);
    setState(181);
    antlrcpp::downCast<Anno_structContext *>(_localctx)->base = number();
    setState(182);
    match(SpecParser::T__11);
    setState(183);
    match(SpecParser::T__12);
    setState(184);
    match(SpecParser::T__2);
    setState(185);
    antlrcpp::downCast<Anno_structContext *>(_localctx)->size = number();
    setState(186);
    match(SpecParser::T__11);
    setState(187);
    match(SpecParser::T__13);
    setState(188);
    match(SpecParser::T__2);
    setState(189);
    antlrcpp::downCast<Anno_structContext *>(_localctx)->max_elems = number();
    setState(190);
    match(SpecParser::T__1);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- Loop_invContext ------------------------------------------------------------------

SpecParser::Loop_invContext::Loop_invContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}

SpecParser::ExprContext* SpecParser::Loop_invContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
}


size_t SpecParser::Loop_invContext::getRuleIndex() const {
  return SpecParser::RuleLoop_inv;
}


std::any SpecParser::Loop_invContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitLoop_inv(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::Loop_invContext* SpecParser::loop_inv() {
  Loop_invContext *_localctx = _tracker.createInstance<Loop_invContext>(_ctx, getState());
  enterRule(_localctx, 24, SpecParser::RuleLoop_inv);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(192);
    match(SpecParser::T__14);
    setState(193);
    expr();
    setState(194);
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
  enterRule(_localctx, 26, SpecParser::RuleSection_begin);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(196);
    match(SpecParser::SECTION);
    setState(197);
    name();
    setState(198);
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
  enterRule(_localctx, 28, SpecParser::RuleSection_end);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(200);
    match(SpecParser::SECTION_END);
    setState(201);
    name();
    setState(202);
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
  size_t startState = 30;
  enterRecursionRule(_localctx, 30, SpecParser::RuleType, precedence);

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
    setState(237);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 5, _ctx)) {
    case 1: {
      setState(205);
      antlrcpp::downCast<TypeContext *>(_localctx)->Z_type = match(SpecParser::T__15);
      break;
    }

    case 2: {
      setState(206);
      antlrcpp::downCast<TypeContext *>(_localctx)->bool_type = match(SpecParser::T__16);
      break;
    }

    case 3: {
      setState(207);
      antlrcpp::downCast<TypeContext *>(_localctx)->str_type = match(SpecParser::T__17);
      break;
    }

    case 4: {
      setState(208);
      antlrcpp::downCast<TypeContext *>(_localctx)->type_type = match(SpecParser::T__18);
      break;
    }

    case 5: {
      setState(209);
      antlrcpp::downCast<TypeContext *>(_localctx)->prop_type = match(SpecParser::T__19);
      break;
    }

    case 6: {
      setState(210);
      antlrcpp::downCast<TypeContext *>(_localctx)->list_type = match(SpecParser::T__20);
      setState(211);
      type(10);
      break;
    }

    case 7: {
      setState(212);
      antlrcpp::downCast<TypeContext *>(_localctx)->option_type = match(SpecParser::T__21);
      setState(213);
      type(9);
      break;
    }

    case 8: {
      setState(214);
      antlrcpp::downCast<TypeContext *>(_localctx)->zmap_type = match(SpecParser::T__22);
      setState(215);
      type(8);
      break;
    }

    case 9: {
      setState(216);
      antlrcpp::downCast<TypeContext *>(_localctx)->pmap_type = match(SpecParser::T__23);
      setState(217);
      type(7);
      break;
    }

    case 10: {
      setState(218);
      antlrcpp::downCast<TypeContext *>(_localctx)->smap_type = match(SpecParser::T__24);
      setState(219);
      type(6);
      break;
    }

    case 11: {
      setState(220);
      antlrcpp::downCast<TypeContext *>(_localctx)->vector_type = match(SpecParser::T__25);
      setState(221);
      type(5);
      break;
    }

    case 12: {
      setState(222);
      match(SpecParser::LP);
      setState(223);
      type(0);
      setState(226); 
      _errHandler->sync(this);
      _la = _input->LA(1);
      do {
        setState(224);
        antlrcpp::downCast<TypeContext *>(_localctx)->tup = match(SpecParser::MULT);
        setState(225);
        type(0);
        setState(228); 
        _errHandler->sync(this);
        _la = _input->LA(1);
      } while (_la == SpecParser::MULT);
      setState(230);
      match(SpecParser::RP);
      break;
    }

    case 13: {
      setState(232);
      match(SpecParser::LP);
      setState(233);
      antlrcpp::downCast<TypeContext *>(_localctx)->par = type(0);
      setState(234);
      match(SpecParser::RP);
      break;
    }

    case 14: {
      setState(236);
      name();
      break;
    }

    default:
      break;
    }
    _ctx->stop = _input->LT(-1);
    setState(247);
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
        setState(239);

        if (!(precpred(_ctx, 3))) throw FailedPredicateException(this, "precpred(_ctx, 3)");
        setState(240);
        match(SpecParser::IMPLIES);
        setState(241);
        match(SpecParser::LP);
        setState(242);
        antlrcpp::downCast<TypeContext *>(_localctx)->codomain = type(0);
        setState(243);
        match(SpecParser::RP); 
      }
      setState(249);
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
  enterRule(_localctx, 32, SpecParser::RuleExpr);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(258);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case SpecParser::LET: {
        enterOuterAlt(_localctx, 1);
        setState(250);
        let_stmt();
        break;
      }

      case SpecParser::WHEN: {
        enterOuterAlt(_localctx, 2);
        setState(251);
        when_stmt();
        break;
      }

      case SpecParser::MATCH: {
        enterOuterAlt(_localctx, 3);
        setState(252);
        match_stmt();
        break;
      }

      case SpecParser::RELY: {
        enterOuterAlt(_localctx, 4);
        setState(253);
        assert_stmt();
        break;
      }

      case SpecParser::ANNO: {
        enterOuterAlt(_localctx, 5);
        setState(254);
        anno_stmt();
        break;
      }

      case SpecParser::IF: {
        enterOuterAlt(_localctx, 6);
        setState(255);
        if_stmt();
        break;
      }

      case SpecParser::T__34: {
        enterOuterAlt(_localctx, 7);
        setState(256);
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
        setState(257);
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

tree::TerminalNode* SpecParser::Expr_opContext::LIST_EQ() {
  return getToken(SpecParser::LIST_EQ, 0);
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
  size_t startState = 34;
  enterRecursionRule(_localctx, 34, SpecParser::RuleExpr_op, precedence);

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
    setState(276);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 9, _ctx)) {
    case 1: {
      setState(261);
      antlrcpp::downCast<Expr_opContext *>(_localctx)->op = term(0);
      setState(263); 
      _errHandler->sync(this);
      alt = 1;
      do {
        switch (alt) {
          case 1: {
                setState(262);
                term(0);
                break;
              }

        default:
          throw NoViableAltException(this);
        }
        setState(265); 
        _errHandler->sync(this);
        alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 8, _ctx);
      } while (alt != 2 && alt != atn::ATN::INVALID_ALT_NUMBER);
      break;
    }

    case 2: {
      setState(267);
      exists_expr();
      setState(268);
      match(SpecParser::T__11);
      setState(269);
      expr_op(11);
      break;
    }

    case 3: {
      setState(271);
      forall_expr();
      setState(272);
      match(SpecParser::T__11);
      setState(273);
      expr_op(10);
      break;
    }

    case 4: {
      setState(275);
      term(0);
      break;
    }

    default:
      break;
    }
    _ctx->stop = _input->LT(-1);
    setState(333);
    _errHandler->sync(this);
    alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 12, _ctx);
    while (alt != 2 && alt != atn::ATN::INVALID_ALT_NUMBER) {
      if (alt == 1) {
        if (!_parseListeners.empty())
          triggerExitRuleEvent();
        previousContext = _localctx;
        setState(331);
        _errHandler->sync(this);
        switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 11, _ctx)) {
        case 1: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(278);

          if (!(precpred(_ctx, 15))) throw FailedPredicateException(this, "precpred(_ctx, 15)");
          setState(279);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!((((_la & ~ 0x3fULL) == 0) &&
            ((1ULL << _la) & 7881299347898368) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(280);
          expr_op(16);
          break;
        }

        case 2: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(281);

          if (!(precpred(_ctx, 14))) throw FailedPredicateException(this, "precpred(_ctx, 14)");
          setState(282);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!((((_la & ~ 0x3fULL) == 0) &&
            ((1ULL << _la) & 108930815987023872) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(283);
          expr_op(15);
          break;
        }

        case 3: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(284);

          if (!(precpred(_ctx, 13))) throw FailedPredicateException(this, "precpred(_ctx, 13)");
          setState(285);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!(((((_la - 53) & ~ 0x3fULL) == 0) &&
            ((1ULL << (_la - 53)) & 32755) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(286);
          expr_op(14);
          break;
        }

        case 4: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(287);

          if (!(precpred(_ctx, 12))) throw FailedPredicateException(this, "precpred(_ctx, 12)");
          setState(288);
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
          setState(289);
          expr_op(12);
          break;
        }

        case 5: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(290);

          if (!(precpred(_ctx, 9))) throw FailedPredicateException(this, "precpred(_ctx, 9)");
          setState(291);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->map_set = match(SpecParser::SET);
          setState(292);
          expr_op(0);
          setState(293);
          match(SpecParser::T__26);
          setState(294);
          expr_op(10);
          break;
        }

        case 6: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(296);

          if (!(precpred(_ctx, 8))) throw FailedPredicateException(this, "precpred(_ctx, 8)");
          setState(297);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->map_get = match(SpecParser::GET);
          setState(298);
          expr_op(9);
          break;
        }

        case 7: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(299);

          if (!(precpred(_ctx, 7))) throw FailedPredicateException(this, "precpred(_ctx, 7)");
          setState(300);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->list_nth = match(SpecParser::NTH);
          setState(301);
          expr_op(8);
          break;
        }

        case 8: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(302);

          if (!(precpred(_ctx, 5))) throw FailedPredicateException(this, "precpred(_ctx, 5)");
          setState(308); 
          _errHandler->sync(this);
          _la = _input->LA(1);
          do {
            setState(303);
            match(SpecParser::T__1);
            setState(304);
            match(SpecParser::T__27);
            setState(305);
            name();
            setState(306);
            match(SpecParser::T__28);
            setState(310); 
            _errHandler->sync(this);
            _la = _input->LA(1);
          } while (_la == SpecParser::T__1);
          setState(312);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->record_set = match(SpecParser::T__29);
          setState(313);
          expr_op(6);
          break;
        }

        case 9: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(315);

          if (!(precpred(_ctx, 4))) throw FailedPredicateException(this, "precpred(_ctx, 4)");
          setState(316);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!(((((_la - 77) & ~ 0x3fULL) == 0) &&
            ((1ULL << (_la - 77)) & 63) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(317);
          expr_op(5);
          break;
        }

        case 10: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(318);

          if (!(precpred(_ctx, 3))) throw FailedPredicateException(this, "precpred(_ctx, 3)");
          setState(319);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _input->LT(1);
          _la = _input->LA(1);
          if (!(((((_la - 71) & ~ 0x3fULL) == 0) &&
            ((1ULL << (_la - 71)) & 35) != 0))) {
            antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = _errHandler->recoverInline(this);
          }
          else {
            _errHandler->reportMatch(this);
            consume();
          }
          setState(320);
          expr_op(4);
          break;
        }

        case 11: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(321);

          if (!(precpred(_ctx, 2))) throw FailedPredicateException(this, "precpred(_ctx, 2)");
          setState(322);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->binop = match(SpecParser::IMPLIES);
          setState(323);
          expr_op(2);
          break;
        }

        case 12: {
          _localctx = _tracker.createInstance<Expr_opContext>(parentContext, parentState);
          pushNewRecursionContext(_localctx, startState, RuleExpr_op);
          setState(324);

          if (!(precpred(_ctx, 6))) throw FailedPredicateException(this, "precpred(_ctx, 6)");
          setState(325);
          antlrcpp::downCast<Expr_opContext *>(_localctx)->record_set2 = match(SpecParser::T__8);
          setState(326);
          name();
          setState(327);
          match(SpecParser::T__2);
          setState(328);
          expr_op(0);
          setState(329);
          match(SpecParser::T__9);
          break;
        }

        default:
          break;
        } 
      }
      setState(335);
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
  size_t startState = 36;
  enterRecursionRule(_localctx, 36, SpecParser::RuleTerm, precedence);

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
    setState(348);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 13, _ctx)) {
    case 1: {
      setState(337);
      match(SpecParser::LP);
      setState(338);
      antlrcpp::downCast<TermContext *>(_localctx)->par = expr();
      setState(339);
      match(SpecParser::RP);
      break;
    }

    case 2: {
      setState(341);
      match(SpecParser::LP);
      setState(342);
      antlrcpp::downCast<TermContext *>(_localctx)->uniop = _input->LT(1);
      _la = _input->LA(1);
      if (!(((((_la - 49) & ~ 0x3fULL) == 0) &&
        ((1ULL << (_la - 49)) & 50331649) != 0))) {
        antlrcpp::downCast<TermContext *>(_localctx)->uniop = _errHandler->recoverInline(this);
      }
      else {
        _errHandler->reportMatch(this);
        consume();
      }
      setState(343);
      term(0);
      setState(344);
      match(SpecParser::RP);
      break;
    }

    case 3: {
      setState(346);
      tuple();
      break;
    }

    case 4: {
      setState(347);
      value();
      break;
    }

    default:
      break;
    }
    _ctx->stop = _input->LT(-1);
    setState(358);
    _errHandler->sync(this);
    alt = getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 14, _ctx);
    while (alt != 2 && alt != atn::ATN::INVALID_ALT_NUMBER) {
      if (alt == 1) {
        if (!_parseListeners.empty())
          triggerExitRuleEvent();
        previousContext = _localctx;
        _localctx = _tracker.createInstance<TermContext>(parentContext, parentState);
        pushNewRecursionContext(_localctx, startState, RuleTerm);
        setState(350);

        if (!(precpred(_ctx, 4))) throw FailedPredicateException(this, "precpred(_ctx, 4)");
        setState(351);
        antlrcpp::downCast<TermContext *>(_localctx)->record_get = match(SpecParser::T__1);
        setState(352);
        match(SpecParser::LP);
        setState(353);
        name();
        setState(354);
        match(SpecParser::RP); 
      }
      setState(360);
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
  enterRule(_localctx, 38, SpecParser::RuleTuple);
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
    setState(361);
    match(SpecParser::LP);
    setState(362);
    expr();
    setState(365); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(363);
      match(SpecParser::T__11);
      setState(364);
      expr();
      setState(367); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__11);
    setState(369);
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
  enterRule(_localctx, 40, SpecParser::RuleFunc_call);
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
    name();
    setState(373); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(372);
      expr();
      setState(375); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__34 || ((((_la - 83) & ~ 0x3fULL) == 0) &&
      ((1ULL << (_la - 83)) & 4165397) != 0));
   
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
  enterRule(_localctx, 42, SpecParser::RuleForall_expr);
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
    setState(377);
    match(SpecParser::FORALL);
    setState(379); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(378);
      var_anno();
      setState(381); 
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
  enterRule(_localctx, 44, SpecParser::RuleExists_expr);
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
    setState(383);
    match(SpecParser::EXISTS);
    setState(385); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(384);
      var_anno();
      setState(387); 
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

SpecParser::ExprContext* SpecParser::Var_annoContext::expr() {
  return getRuleContext<SpecParser::ExprContext>(0);
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
  enterRule(_localctx, 46, SpecParser::RuleVar_anno);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(401);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 19, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(389);
      match(SpecParser::LP);
      setState(390);
      name();
      setState(391);
      match(SpecParser::T__2);
      setState(392);
      type(0);
      setState(393);
      match(SpecParser::RP);
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(395);
      match(SpecParser::LP);
      setState(396);
      name();
      setState(397);
      match(SpecParser::T__2);
      setState(398);
      expr();
      setState(399);
      match(SpecParser::RP);
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
  enterRule(_localctx, 48, SpecParser::RuleLet_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(417);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 20, _ctx)) {
    case 1: {
      enterOuterAlt(_localctx, 1);
      setState(403);
      match(SpecParser::LET);
      setState(404);
      name();
      setState(405);
      match(SpecParser::T__0);
      setState(406);
      expr();
      setState(407);
      match(SpecParser::T__30);
      setState(408);
      expr();
      break;
    }

    case 2: {
      enterOuterAlt(_localctx, 2);
      setState(410);
      match(SpecParser::LET);
      setState(411);
      tuple();
      setState(412);
      match(SpecParser::T__0);
      setState(413);
      expr();
      setState(414);
      match(SpecParser::T__30);
      setState(415);
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
  enterRule(_localctx, 50, SpecParser::RuleWhen_stmt);
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
    setState(419);
    match(SpecParser::WHEN);

    setState(420);
    name();
    setState(425);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::T__11) {
      setState(421);
      match(SpecParser::T__11);
      setState(422);
      name();
      setState(427);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(428);
    match(SpecParser::T__26);
    setState(429);
    expr();
    setState(430);
    match(SpecParser::T__31);
    setState(431);
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
  enterRule(_localctx, 52, SpecParser::RuleMatch_stmt);
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
    setState(433);
    match(SpecParser::MATCH);
    setState(434);
    expr();
    setState(435);
    match(SpecParser::WITH);
    setState(437); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(436);
      match_branch();
      setState(439); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__32);
    setState(441);
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
  enterRule(_localctx, 54, SpecParser::RuleMatch_branch);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(443);
    match(SpecParser::T__32);
    setState(444);
    expr();
    setState(445);
    match(SpecParser::T__33);
    setState(446);
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
  enterRule(_localctx, 56, SpecParser::RuleAssert_stmt);

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
    match(SpecParser::RELY);
    setState(449);
    expr();
    setState(450);
    match(SpecParser::T__31);
    setState(451);
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
  enterRule(_localctx, 58, SpecParser::RuleAnno_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(453);
    match(SpecParser::ANNO);
    setState(454);
    expr();
    setState(455);
    match(SpecParser::T__31);
    setState(456);
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
  enterRule(_localctx, 60, SpecParser::RuleIf_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(458);
    match(SpecParser::IF);
    setState(459);
    expr();
    setState(460);
    match(SpecParser::THEN);
    setState(461);
    expr();
    setState(462);
    match(SpecParser::ELSE);
    setState(463);
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
  enterRule(_localctx, 62, SpecParser::RuleInductive_decl);
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
    setState(465);
    match(SpecParser::INDUC);
    setState(466);
    name();
    setState(467);
    match(SpecParser::T__0);
    setState(469); 
    _errHandler->sync(this);
    _la = _input->LA(1);
    do {
      setState(468);
      induct_arm();
      setState(471); 
      _errHandler->sync(this);
      _la = _input->LA(1);
    } while (_la == SpecParser::T__32);
    setState(473);
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
  enterRule(_localctx, 64, SpecParser::RuleInduct_arm);
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
    setState(475);
    match(SpecParser::T__32);
    setState(476);
    name();
    setState(480);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::LP) {
      setState(477);
      var_anno();
      setState(482);
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

std::vector<SpecParser::Var_annoContext *> SpecParser::Record_declContext::var_anno() {
  return getRuleContexts<SpecParser::Var_annoContext>();
}

SpecParser::Var_annoContext* SpecParser::Record_declContext::var_anno(size_t i) {
  return getRuleContext<SpecParser::Var_annoContext>(i);
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
  enterRule(_localctx, 66, SpecParser::RuleRecord_decl);
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
    setState(483);
    match(SpecParser::RECORD);
    setState(484);
    name();
    setState(488);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::LP) {
      setState(485);
      var_anno();
      setState(490);
      _errHandler->sync(this);
      _la = _input->LA(1);
    }
    setState(491);
    match(SpecParser::T__0);
    setState(492);
    name();
    setState(493);
    match(SpecParser::T__8);
    setState(494);
    record_fields();
    setState(495);
    match(SpecParser::T__9);
    setState(496);
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

std::vector<SpecParser::ExprContext *> SpecParser::Record_fieldsContext::expr() {
  return getRuleContexts<SpecParser::ExprContext>();
}

SpecParser::ExprContext* SpecParser::Record_fieldsContext::expr(size_t i) {
  return getRuleContext<SpecParser::ExprContext>(i);
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
  enterRule(_localctx, 68, SpecParser::RuleRecord_fields);
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
    setState(498);
    name();
    setState(499);
    match(SpecParser::T__2);
    setState(502);
    _errHandler->sync(this);
    switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 26, _ctx)) {
    case 1: {
      setState(500);
      type(0);
      break;
    }

    case 2: {
      setState(501);
      expr();
      break;
    }

    default:
      break;
    }
    setState(513);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::T__31) {
      setState(504);
      match(SpecParser::T__31);
      setState(505);
      name();
      setState(506);
      match(SpecParser::T__2);
      setState(509);
      _errHandler->sync(this);
      switch (getInterpreter<atn::ParserATNSimulator>()->adaptivePredict(_input, 27, _ctx)) {
      case 1: {
        setState(507);
        type(0);
        break;
      }

      case 2: {
        setState(508);
        expr();
        break;
      }

      default:
        break;
      }
      setState(515);
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
  enterRule(_localctx, 70, SpecParser::RuleRecord_def_stmt);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(516);
    match(SpecParser::T__34);
    setState(517);
    record_fields_def();
    setState(518);
    match(SpecParser::T__35);
   
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
  enterRule(_localctx, 72, SpecParser::RuleRecord_fields_def);
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
    setState(520);
    name();
    setState(521);
    match(SpecParser::T__0);
    setState(522);
    name();
    setState(531);
    _errHandler->sync(this);
    _la = _input->LA(1);
    while (_la == SpecParser::T__31) {
      setState(524);
      match(SpecParser::T__31);
      setState(525);
      name();
      setState(526);
      match(SpecParser::T__0);
      setState(527);
      name();
      setState(533);
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
  enterRule(_localctx, 74, SpecParser::RuleValue);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    setState(538);
    _errHandler->sync(this);
    switch (_input->LA(1)) {
      case SpecParser::ID: {
        enterOuterAlt(_localctx, 1);
        setState(534);
        name();
        break;
      }

      case SpecParser::NUMBER: {
        enterOuterAlt(_localctx, 2);
        setState(535);
        number();
        break;
      }

      case SpecParser::TRUE:
      case SpecParser::FALSE: {
        enterOuterAlt(_localctx, 3);
        setState(536);
        bool_();
        break;
      }

      case SpecParser::STR: {
        enterOuterAlt(_localctx, 4);
        setState(537);
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
  enterRule(_localctx, 76, SpecParser::RuleMk);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(540);
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
  enterRule(_localctx, 78, SpecParser::RuleName);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(542);
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
  enterRule(_localctx, 80, SpecParser::RuleNumber);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(544);
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
  enterRule(_localctx, 82, SpecParser::RuleString);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(546);
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
  enterRule(_localctx, 84, SpecParser::RuleBool);
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
    setState(548);
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

//----------------- VeclenContext ------------------------------------------------------------------

SpecParser::VeclenContext::VeclenContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}


size_t SpecParser::VeclenContext::getRuleIndex() const {
  return SpecParser::RuleVeclen;
}


std::any SpecParser::VeclenContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitVeclen(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::VeclenContext* SpecParser::veclen() {
  VeclenContext *_localctx = _tracker.createInstance<VeclenContext>(_ctx, getState());
  enterRule(_localctx, 86, SpecParser::RuleVeclen);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(550);
    match(SpecParser::T__36);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- VecgetContext ------------------------------------------------------------------

SpecParser::VecgetContext::VecgetContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}


size_t SpecParser::VecgetContext::getRuleIndex() const {
  return SpecParser::RuleVecget;
}


std::any SpecParser::VecgetContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitVecget(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::VecgetContext* SpecParser::vecget() {
  VecgetContext *_localctx = _tracker.createInstance<VecgetContext>(_ctx, getState());
  enterRule(_localctx, 88, SpecParser::RuleVecget);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(552);
    match(SpecParser::T__37);
   
  }
  catch (RecognitionException &e) {
    _errHandler->reportError(this, e);
    _localctx->exception = std::current_exception();
    _errHandler->recover(this, _localctx->exception);
  }

  return _localctx;
}

//----------------- VecreplaceContext ------------------------------------------------------------------

SpecParser::VecreplaceContext::VecreplaceContext(ParserRuleContext *parent, size_t invokingState)
  : ParserRuleContext(parent, invokingState) {
}


size_t SpecParser::VecreplaceContext::getRuleIndex() const {
  return SpecParser::RuleVecreplace;
}


std::any SpecParser::VecreplaceContext::accept(tree::ParseTreeVisitor *visitor) {
  if (auto parserVisitor = dynamic_cast<SpecVisitor*>(visitor))
    return parserVisitor->visitVecreplace(this);
  else
    return visitor->visitChildren(this);
}

SpecParser::VecreplaceContext* SpecParser::vecreplace() {
  VecreplaceContext *_localctx = _tracker.createInstance<VecreplaceContext>(_ctx, getState());
  enterRule(_localctx, 90, SpecParser::RuleVecreplace);

#if __cplusplus > 201703L
  auto onExit = finally([=, this] {
#else
  auto onExit = finally([=] {
#endif
    exitRule();
  });
  try {
    enterOuterAlt(_localctx, 1);
    setState(554);
    match(SpecParser::T__38);
   
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
    case 15: return typeSempred(antlrcpp::downCast<TypeContext *>(context), predicateIndex);
    case 17: return expr_opSempred(antlrcpp::downCast<Expr_opContext *>(context), predicateIndex);
    case 18: return termSempred(antlrcpp::downCast<TermContext *>(context), predicateIndex);

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
