#ifndef Z3_PCACHE_HPP
#define Z3_PCACHE_HPP


#include <boost/regex.hpp>
#include <cstring>
#include <fstream>
#include <iostream>
#include <string>

class LiteralCacheEntry {
 public:
  std::string statement;
  int result;
  std::map<std::string, std::string> symbol_table;

  // return if this has the same statement as e_statement.
  bool compareEqual(std::string e_statement) {
    return statement == e_statement;
  }

  friend std::ostream& operator<<(std::ostream& os, LiteralCacheEntry e) {
    os << "statement:" << e.statement << "\n";
    os << "result:" << e.result << "\n";
    return os;
  }
};

class SMTParser {
 private:
  int isSpace(char c) { return c == ' ' || c == '\t' || c == '\n'; }

 public:
  // parse and generalize the give string
  std::pair<std::string, std::map<std::string, std::string>> parse(
      std::string statement) {
    std::pair<std::string, std::map<std::string, std::string>> p;
    p.first = statement;
    p.first.erase(std::remove(p.first.begin(), p.first.end(), '\n'),
                  p.first.end());

    boost::regex pattern("\\$x[0-9]*|\\?x[0-9]*");  // ?x123 or $x123
    std::string replacement = "$x";  // Replacement string

    std::unordered_map<std::string, int> seen;  // Map to store seen patterns and their replacement index
    int counter = 1;
    auto replace_with_counter = [&seen, &counter](const boost::smatch& match) {
      std::string match_str = match.str();
      auto id = match_str.substr(2);
      if (seen.find(id) == seen.end()) {  
        seen[id] = counter++; 
      }
      return match_str.substr(0, 2) + std::to_string(seen[id]);  
    };
    p.first = boost::regex_replace(p.first, pattern, replace_with_counter,
                                   boost::match_default | boost::format_all);
    return p;
  }

  std::pair<int, const char*> parseNextString(const char* s, std::string& r) {
    const char* ptr = s;
    r = "";
    if (*ptr != '{') return std::make_pair<>(-1, s);
    int degree = 1;
    ++ptr;
    while (*ptr != '\0') {
      if (*ptr == '}') {
        --degree;
        if (degree == 0) break;
      }
      r = r + (*ptr);
      ptr++;
    }
    if (degree != 0) return std::make_pair<>(-1, s);
    return std::make_pair<>(1, ptr);
  }

  std::pair<int, const char*> parseNextInt(const char* s, int& result) {
    std::string r = "";
    auto p = parseNextString(s, r);
    if (p.first < 0) return p;
    result = std::stoi(r);
    return p;
  }

  std::pair<int, const char*> parseFromTheFirstLiteralRecord(
      const char* record, LiteralCacheEntry* e) {
    const char* ptr = record;
    while (*ptr != '{' && *ptr != '\0') ++ptr;
    if (*ptr == '\0') return std::make_pair<>(-1, record);
    ++ptr;
    int degree = 1;
    int d2_cnt = 0;
    e->statement = "";
    while (degree != 0 && *ptr != '\0') {
      if (*ptr == '}') {
        --degree;
        if (degree == 0) break;
        ++ptr;
      } else if (*ptr == '{') {
        ++degree;
        if (degree == 2) d2_cnt++;
        if (degree == 2 && d2_cnt == 1) {
          auto p = parseNextString(ptr, e->statement);
          if (p.first < 0) return p;
          ptr = p.second;
        }
        if (degree == 2 && d2_cnt == 2) {
          auto p = parseNextInt(ptr, e->result);
          if (p.first < 0) return p;
          ptr = p.second;
        }
      } else {
        ++ptr;
      }
    }
    if (degree != 0) return std::make_pair<>(-1, record);
    return std::make_pair<>(1, ptr);
  }

  std::string generateLiteralRecord(LiteralCacheEntry* e) {
    std::string record = "";
    record = record + "{" + "{" + e->statement + "}" + "{" +
             std::to_string(e->result) + "}";
    record = record + "}";
    return record;
  }
};

class SMTHashMapCache {
 private:
  const int MAP_SIZE = 128;
  std::map<uint, std::vector<LiteralCacheEntry*>> cache_map;

  SMTParser parser;

  int loaded = 0;

  std::string cache_file;

  LiteralCacheEntry* last_hit = nullptr;

  int count_query = 0;
  int count_hit = 0;

  std::hash<std::string> hasher;

  // return the hash value (unsigned 32) of current literal cache entry.
  uint computeHashU32(std::string statement) {
    return hasher(statement) % MAP_SIZE;
  }

  int pushToFile(LiteralCacheEntry* e) {
    // TODO: avoid repeatedly open/close the cache file.
    std::ofstream out(cache_file, std::ios::app | std::ios::out);
    auto info = parser.generateLiteralRecord(e);
    out << info;
    out.close();
    return 1;
  }

 public:
  SMTHashMapCache(std::string path) {
    setCacheFile(path);
    loadFromFile();
  }
  ~SMTHashMapCache() {
    std::cout << "Z3 persistent cache hit: " << count_hit << "/" << count_query
              << "(" << count_hit / (count_query + 0.001) << ")\n";
  }
  void setCacheFile(std::string filepath) { this->cache_file = filepath; }

  int loadFromFile() {
    if (loaded) return -1;

    std::ifstream in(this->cache_file, std::ios::in);
    if (!in.good()) {
      return 0;
    }

    std::string file_content;
    std::getline(in, file_content);
    in.close();

    const char* ptr = file_content.c_str();
    while (1) {
      LiteralCacheEntry* e = new LiteralCacheEntry();
      auto p = parser.parseFromTheFirstLiteralRecord(ptr, e);
      if (p.first < 0) {
        delete e;
        break;
      } else {
        cache_map[computeHashU32(e->statement)].push_back(e);
        ptr = p.second + 1;
      }
    }
    loaded = 1;
    return 1;
  }

  std::pair<int, std::string> get(std::string statement) {
    ++count_query;
    if (count_query % 500 == 0) {
      std::cout << "Z3 persistent cache hit: " << count_hit << "/"
                << count_query << "(" << count_hit / (count_query + 0.001)
                << ")\n";
    }
    auto p = parser.parse(statement);
    uint hv = computeHashU32(p.first);
    for (auto entry : cache_map[hv]) {
      if (entry->compareEqual(p.first)) {
        last_hit = entry;
        ++count_hit;
        return std::make_pair<>(entry->result, p.first);
      }
    }
    return std::make_pair<>(-1, p.first);
  }

  std::pair<int, std::string> put(std::string statement, int result) {
    LiteralCacheEntry* e = new LiteralCacheEntry();
    auto p = parser.parse(statement);
    e->statement = p.first;
    uint hv = computeHashU32(e->statement);
    e->result = result;
    cache_map[hv].push_back(e);
    last_hit = e;
    pushToFile(e);
    return std::make_pair<>(1, p.first);
  }
};

#endif