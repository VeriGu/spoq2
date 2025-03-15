#pragma once

#include <z3++.h>
#include <nodes.h>
#include <values.h>

#include <chrono>

namespace autov {

// Z3 profiling
// z3_eval: each z3_eval, 
// eval_check: z3_check inside z3_eval
// norm_rule_check: check inside normal rules

/** Epoch data: */
// z3_rule_check: check inside z3 rules
extern std::chrono::duration<double> z3_eval_accumulative_time;
extern std::chrono::duration<double> eval_check_accumulative_time;
extern std::chrono::duration<double> z3_rule_check_accumulative_time;
extern bool __PROFILE_ON;
extern int z3_eval_cnt;
extern int eval_check_cnt;
extern int z3_rule_check_cnt;

// profile check inside rules
extern std::chrono::duration<double> rely_rule_check_accumulative_time;
extern std::chrono::duration<double> if_rule_check_accumulative_time;
extern std::chrono::duration<double> match_rule_check_accumulative_time;
extern std::chrono::duration<double> expr_rule_check_accumulative_time;

extern int rely_rule_check_cnt;
extern int if_rule_check_cnt;
extern int match_rule_check_cnt;
extern int expr_rule_check_cnt;

extern int rely_rule_check_hit;
extern int if_rule_check_hit;
extern int match_rule_check_hit;
extern int expr_rule_check_hit;

// profile check inside z3_eval
extern std::chrono::duration<double> rely_eval_check_accumulative_time;
extern std::chrono::duration<double> if_eval_check_accumulative_time;
extern std::chrono::duration<double> match_eval_check_accumulative_time;
extern std::chrono::duration<double> expr_eval_check_accumulative_time;

extern int rely_eval_check_cnt;
extern int if_eval_check_cnt;
extern int match_eval_check_cnt;
extern int expr_eval_check_cnt;

extern int rely_eval_check_hit;
extern int if_eval_check_hit;
extern int match_eval_check_hit;
extern int expr_eval_check_hit;

/** Meta data: */
extern std::chrono::duration<double> z3_eval_accumulative_time_meta;
extern std::chrono::duration<double> eval_check_accumulative_time_meta;
extern std::chrono::duration<double> z3_rule_check_accumulative_time_meta;

extern int z3_eval_cnt_meta;
extern int eval_check_cnt_meta;
extern int z3_rule_check_cnt_meta;

// profile check inside rules
extern std::chrono::duration<double> rely_rule_check_accumulative_time_meta;
extern std::chrono::duration<double> if_rule_check_accumulative_time_meta;
extern std::chrono::duration<double> match_rule_check_accumulative_time_meta;
extern std::chrono::duration<double> expr_rule_check_accumulative_time_meta;

extern int rely_rule_check_cnt_meta;
extern int if_rule_check_cnt_meta;
extern int match_rule_check_cnt_meta;
extern int expr_rule_check_cnt_meta;

extern int rely_rule_check_hit_meta;
extern int if_rule_check_hit_meta;
extern int match_rule_check_hit_meta;
extern int expr_rule_check_hit_meta;

// profile check inside z3_eval
extern std::chrono::duration<double> rely_eval_check_accumulative_time_meta;
extern std::chrono::duration<double> if_eval_check_accumulative_time_meta;
extern std::chrono::duration<double> match_eval_check_accumulative_time_meta;
extern std::chrono::duration<double> expr_eval_check_accumulative_time_meta;

extern int rely_eval_check_cnt_meta;
extern int if_eval_check_cnt_meta;
extern int match_eval_check_cnt_meta;
extern int expr_eval_check_cnt_meta;

extern int rely_eval_check_hit_meta;
extern int if_eval_check_hit_meta;
extern int match_eval_check_hit_meta;
extern int expr_eval_check_hit_meta;



extern int eliminate_rely_cnt;
extern int eliminate_rely_cnt_meta;
extern std::chrono::duration<double> eliminate_rely_accumulative_time;

#define PROFILE_VAR_INIT(label) \
    extern int label##_cnt; \
    extern int label##_cnt_meta; \
    extern std::chrono::duration<double> label##_accumulative_time; \
    extern std::chrono::duration<double> label##_accumulative_time_meta;



PROFILE_VAR_INIT(eliminate_rely);
PROFILE_VAR_INIT(move_when);
PROFILE_VAR_INIT(eliminate_move_rely);
PROFILE_VAR_INIT(move_if_out_match);
PROFILE_VAR_INIT(eliminate_match);
PROFILE_VAR_INIT(eliminate_let);
PROFILE_VAR_INIT(eliminate_if);
PROFILE_VAR_INIT(move_if_out_expr);
PROFILE_VAR_INIT(move_match_out_expr);
PROFILE_VAR_INIT(eliminate_am);
PROFILE_VAR_INIT(unfold);
PROFILE_VAR_INIT(simplify_getset);
PROFILE_VAR_INIT(simplify_expr);
PROFILE_VAR_INIT(simplify_built_in);

/** Functions: */

#define PROFILE_START(label) \
    label##_cnt++; \
    label##_cnt_meta++; \
    auto label##_start = std::chrono::high_resolution_clock::now()

#define PROFILE_HIT(label) \
    label##_hit++; \
    label##_hit_meta++
    // LOG_INFO << "[PROFILE] " << #label << " hit"

#define PROFILE_END(label) \
    auto label##_end = std::chrono::high_resolution_clock::now(); \
    label##_accumulative_time += std::chrono::duration<double>(label##_end - label##_start); \
    label##_accumulative_time_meta += std::chrono::duration<double>(label##_end - label##_start)

void profile_clear();
void profile_print();
void profile_print_transrule();

void profile_finalize();
void profile_clear_epoch();
void profile_update_epoch();
void profile_print_epoch();

void profile_log_rule_if_solved(const string &msg);
void profile_log_rule_match_solved(const string &msg);
void profile_log_rule_rely_solved(const string &msg);
void profile_log_rule_expr_solved(const string &msg);

void profile_log_rule_if_unsolved(const string &msg);
void profile_log_rule_match_unsolved(const string &msg);
void profile_log_rule_rely_unsolved(const string &msg);
void profile_log_rule_expr_unsolved(const string &msg);

void profile_log_eval_if_solved(const string &msg);
void profile_log_eval_match_solved(const string &msg);
void profile_log_eval_rely_solved(const string &msg);
void profile_log_eval_expr_solved(const string &msg);

void profile_log_eval_if_unsolved(const string &msg);
void profile_log_eval_match_unsolved(const string &msg);
void profile_log_eval_rely_unsolved(const string &msg);
void profile_log_eval_expr_unsolved(const string &msg);

}
