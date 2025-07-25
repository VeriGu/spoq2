
#include <nodes.h>
#include <values.h>
#include <z3++.h>

#include <chrono>
#include <profile.h>
#include <cmd.h>

namespace autov
{

bool __PROFILE_ON = true;


#define PROFILE_VAR_INIT_VAL(label) \
    int label##_cnt = 0; \
    int label##_cnt_meta = 0; \
    std::chrono::duration<double> label##_accumulative_time; \
    std::chrono::duration<double> label##_accumulative_time_meta



#define PROFILE_PRINT_RULE(label) \
	LOG_DEBUG << "\"" #label "_cnt\"" << label##_cnt; \
	LOG_DEBUG << "\"" #label "_cnt_meta\"" << label##_cnt_meta; \
	LOG_DEBUG << "\"" #label "_accumulative_time\"" << label##_accumulative_time.count(); \
	LOG_DEBUG << "\"" #label "_accumulative_time_meta\"" << label##_accumulative_time_meta.count()



#define PROFILE_CLEAR_RULE_EPOCH(label) \
	label##_cnt = 0; \
	label##_accumulative_time = std::chrono::duration<double>(0);

PROFILE_VAR_INIT_VAL(coi);
PROFILE_VAR_INIT_VAL(relate_secure);
PROFILE_VAR_INIT_VAL(simulation_det);
PROFILE_VAR_INIT_VAL(simulation_non_det);
PROFILE_VAR_INIT_VAL(decom_simulation);
PROFILE_VAR_INIT_VAL(eliminate_rely);
PROFILE_VAR_INIT_VAL(move_when);
PROFILE_VAR_INIT_VAL(eliminate_move_rely);
PROFILE_VAR_INIT_VAL(move_if_out_match);
PROFILE_VAR_INIT_VAL(eliminate_match);
PROFILE_VAR_INIT_VAL(eliminate_let);
PROFILE_VAR_INIT_VAL(eliminate_if);
PROFILE_VAR_INIT_VAL(move_if_out_expr);
PROFILE_VAR_INIT_VAL(move_match_out_expr);
PROFILE_VAR_INIT_VAL(eliminate_am);
PROFILE_VAR_INIT_VAL(unfold);
PROFILE_VAR_INIT_VAL(simplify_getset);
PROFILE_VAR_INIT_VAL(simplify_expr);
PROFILE_VAR_INIT_VAL(simplify_built_in);
// Z3 profiling
// z3_eval: (double)each z3_eval,
// eval_check: (double)z3_check inside z3_eval
// norm_rule_check: (double)check inside normal rules
// z3_rule_check: (double)check inside z3 rules
std::chrono::duration<double> z3_eval_accumulative_time;
std::chrono::duration<double> eval_check_accumulative_time;
std::chrono::duration<double> z3_rule_check_accumulative_time;

int z3_eval_cnt = 0;
int eval_check_cnt = 0;
int z3_rule_check_cnt = 0;

// profile check inside rules
std::chrono::duration<double> rely_rule_check_accumulative_time;
std::chrono::duration<double> if_rule_check_accumulative_time;
std::chrono::duration<double> match_rule_check_accumulative_time;
std::chrono::duration<double> expr_rule_check_accumulative_time;

int rely_rule_check_cnt = 0;
int if_rule_check_cnt = 0;
int match_rule_check_cnt = 0;
int expr_rule_check_cnt = 0;

int rely_rule_check_hit = 0;
int if_rule_check_hit = 0;
int match_rule_check_hit = 0;
int expr_rule_check_hit = 0;

// profile check inside z3_eval
std::chrono::duration<double> rely_eval_check_accumulative_time;
std::chrono::duration<double> if_eval_check_accumulative_time;
std::chrono::duration<double> match_eval_check_accumulative_time;
std::chrono::duration<double> expr_eval_check_accumulative_time;

int rely_eval_check_cnt = 0;
int if_eval_check_cnt = 0;
int match_eval_check_cnt = 0;
int expr_eval_check_cnt = 0;

int rely_eval_check_hit = 0;
int if_eval_check_hit = 0;
int match_eval_check_hit = 0;
int expr_eval_check_hit = 0;

/** Meta data: (double)*/
std::chrono::duration<double> z3_eval_accumulative_time_meta;
std::chrono::duration<double> eval_check_accumulative_time_meta;
std::chrono::duration<double> z3_rule_check_accumulative_time_meta;

int z3_eval_cnt_meta = 0;
int eval_check_cnt_meta = 0;
int z3_rule_check_cnt_meta = 0;

// profile check inside rules
std::chrono::duration<double> rely_rule_check_accumulative_time_meta;
std::chrono::duration<double> if_rule_check_accumulative_time_meta;
std::chrono::duration<double> match_rule_check_accumulative_time_meta;
std::chrono::duration<double> expr_rule_check_accumulative_time_meta;

int rely_rule_check_cnt_meta = 0;
int if_rule_check_cnt_meta = 0;
int match_rule_check_cnt_meta = 0;
int expr_rule_check_cnt_meta = 0;

int rely_rule_check_hit_meta = 0;
int if_rule_check_hit_meta = 0;
int match_rule_check_hit_meta = 0;
int expr_rule_check_hit_meta = 0;

// profile check inside z3_eval
std::chrono::duration<double> rely_eval_check_accumulative_time_meta;
std::chrono::duration<double> if_eval_check_accumulative_time_meta;
std::chrono::duration<double> match_eval_check_accumulative_time_meta;
std::chrono::duration<double> expr_eval_check_accumulative_time_meta;

int rely_eval_check_cnt_meta = 0;
int if_eval_check_cnt_meta = 0;
int match_eval_check_cnt_meta = 0;
int expr_eval_check_cnt_meta = 0;

int rely_eval_check_hit_meta = 0;
int if_eval_check_hit_meta = 0;
int match_eval_check_hit_meta = 0;
int expr_eval_check_hit_meta = 0;

/** parameterize the epoch */
struct profile_stat_t {
	std::vector<string> solved_if_branch;
	std::vector<string> solved_match_src;
	std::vector<string> solved_rely_cond;
	std::vector<string> solved_expr;

	std::vector<string> unsolved_if_branch;
	std::vector<string> unsolved_match_src;
	std::vector<string> unsolved_rely_cond;
	std::vector<string> unsolved_expr;

	std::chrono::duration<double> check_if_cost;
	std::chrono::duration<double> check_match_cost;
	std::chrono::duration<double> check_rely_cost;
	std::chrono::duration<double> check_expr_cost;

	double if_solve_rate() {
		return ((solved_if_branch.size() + unsolved_if_branch.size()) == 0) ? 0.0 : ((double) solved_if_branch.size() / ((double) solved_if_branch.size() + unsolved_if_branch.size()));
	}
	double match_solve_rate() {
		return ((solved_match_src.size() + unsolved_match_src.size()) == 0) ? 0.0 : ((double) solved_match_src.size() / ((double) solved_match_src.size() + unsolved_match_src.size()));
	}
	double rely_solve_rate() {
		return ((solved_rely_cond.size() + unsolved_rely_cond.size()) == 0) ? 0.0 : ((double) solved_rely_cond.size() / ((double) solved_rely_cond.size() + unsolved_rely_cond.size()));
	}
	double expr_solve_rate() {
		return ((solved_expr.size() + unsolved_expr.size()) == 0) ? 0.0 : ((double) solved_expr.size() / ((double) solved_expr.size() + unsolved_expr.size()));
	}
};

/** z3_rule-related stats */
std::vector<profile_stat_t> rule_stats;
/** z3_eval-related stats */
std::vector<profile_stat_t> eval_stats;


void profile_clear()
{
	if (!__PROFILE_ON) return;
	rule_stats.clear();
	eval_stats.clear();

    z3_eval_accumulative_time_meta = std::chrono::duration<double>(0);
    eval_check_accumulative_time_meta = std::chrono::duration<double>(0);
    z3_rule_check_accumulative_time_meta = std::chrono::duration<double>(0);

    rely_rule_check_accumulative_time_meta = std::chrono::duration<double>(0);
    if_rule_check_accumulative_time_meta = std::chrono::duration<double>(0);
    match_rule_check_accumulative_time_meta = std::chrono::duration<double>(0);
    expr_rule_check_accumulative_time_meta = std::chrono::duration<double>(0);

    rely_rule_check_cnt_meta = 0;
    if_rule_check_cnt_meta = 0;
    match_rule_check_cnt_meta = 0;
    expr_rule_check_cnt_meta = 0;

    rely_rule_check_hit_meta = 0;
    if_rule_check_hit_meta = 0;
    match_rule_check_hit_meta = 0;
    expr_rule_check_hit_meta = 0;

    rely_eval_check_accumulative_time_meta = std::chrono::duration<double>(0);
    if_eval_check_accumulative_time_meta = std::chrono::duration<double>(0);
    match_eval_check_accumulative_time_meta = std::chrono::duration<double>(0);
    expr_eval_check_accumulative_time_meta = std::chrono::duration<double>(0);

    rely_eval_check_cnt_meta = 0;
    if_eval_check_cnt_meta = 0;
    match_eval_check_cnt_meta = 0;
    expr_eval_check_cnt_meta = 0;

    rely_eval_check_hit_meta = 0;
    if_eval_check_hit_meta = 0;
    match_eval_check_hit_meta = 0;
    expr_eval_check_hit_meta = 0;
}

void profile_clear_epoch()
{
	// create a new stat for next epoch
	rule_stats.push_back(profile_stat_t());
	eval_stats.push_back(profile_stat_t());
	
	// clean current stat
    z3_eval_accumulative_time = std::chrono::duration<double>(0);
    eval_check_accumulative_time = std::chrono::duration<double>(0);
    z3_rule_check_accumulative_time = std::chrono::duration<double>(0);

    rely_rule_check_accumulative_time = std::chrono::duration<double>(0);
    if_rule_check_accumulative_time = std::chrono::duration<double>(0);
    match_rule_check_accumulative_time = std::chrono::duration<double>(0);
    expr_rule_check_accumulative_time = std::chrono::duration<double>(0);

    rely_rule_check_cnt = 0;
    if_rule_check_cnt = 0;
    match_rule_check_cnt = 0;
    expr_rule_check_cnt = 0;

    rely_rule_check_hit = 0;
    if_rule_check_hit = 0;
    match_rule_check_hit = 0;
    expr_rule_check_hit = 0;

    rely_eval_check_accumulative_time = std::chrono::duration<double>(0);
    if_eval_check_accumulative_time = std::chrono::duration<double>(0);
    match_eval_check_accumulative_time = std::chrono::duration<double>(0);
    expr_eval_check_accumulative_time = std::chrono::duration<double>(0);

    rely_eval_check_cnt = 0;
    if_eval_check_cnt = 0;
    match_eval_check_cnt = 0;
    expr_eval_check_cnt = 0;

    rely_eval_check_hit = 0;
    if_eval_check_hit = 0;
    match_eval_check_hit = 0;
    expr_eval_check_hit = 0;


	PROFILE_CLEAR_RULE_EPOCH(eliminate_rely);
	PROFILE_CLEAR_RULE_EPOCH(move_when);
	PROFILE_CLEAR_RULE_EPOCH(eliminate_move_rely);
	PROFILE_CLEAR_RULE_EPOCH(move_if_out_match);
	PROFILE_CLEAR_RULE_EPOCH(eliminate_match);
	PROFILE_CLEAR_RULE_EPOCH(eliminate_let);
	PROFILE_CLEAR_RULE_EPOCH(eliminate_if);
	PROFILE_CLEAR_RULE_EPOCH(move_if_out_expr);
	PROFILE_CLEAR_RULE_EPOCH(move_match_out_expr);
	PROFILE_CLEAR_RULE_EPOCH(eliminate_am);
	PROFILE_CLEAR_RULE_EPOCH(unfold);
	PROFILE_CLEAR_RULE_EPOCH(simplify_getset);
	PROFILE_CLEAR_RULE_EPOCH(simplify_expr);
}

void profile_print_transrule() {
	if (!__PROFILE_ON) return;
	PROFILE_PRINT_RULE(eliminate_rely);
	PROFILE_PRINT_RULE(move_when);
	PROFILE_PRINT_RULE(eliminate_move_rely);
	PROFILE_PRINT_RULE(move_if_out_match);
	PROFILE_PRINT_RULE(eliminate_match);
	PROFILE_PRINT_RULE(eliminate_let);
	PROFILE_PRINT_RULE(eliminate_if);
	PROFILE_PRINT_RULE(move_if_out_expr);
	PROFILE_PRINT_RULE(move_match_out_expr);
	PROFILE_PRINT_RULE(eliminate_am);
	PROFILE_PRINT_RULE(unfold);
	PROFILE_PRINT_RULE(simplify_getset);
	PROFILE_PRINT_RULE(simplify_expr);
	PROFILE_PRINT_RULE(if_rule_check);
	PROFILE_PRINT_RULE(z3_rule_check);
}

void profile_print()
{
	if (!__PROFILE_ON) return;

	LOG_INFO << "=========== Meta Report ===========";
    LOG_INFO << "z3_eval accumulative time: " << z3_eval_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "Z3 check in [z3_eval] accumulative time: " << eval_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "Z3 check in [z3 rule] accumulative time: " << z3_rule_check_accumulative_time_meta.count() << " (s)";

    LOG_INFO << "====== z3_rule check profile ======";

    LOG_INFO << "Rely rule check accumulative time: " << rely_rule_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "If rule check accumulative time: " << if_rule_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "Match rule check accumulative time: " << match_rule_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "Expr rule check accumulative time: " << expr_rule_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "===================================";

    LOG_INFO << "Rely rule check count: " << rely_rule_check_cnt_meta;
    LOG_INFO << "If rule check count: " << if_rule_check_cnt_meta;
    LOG_INFO << "Match rule check count: " << match_rule_check_cnt_meta;
    LOG_INFO << "Expr rule check count: " << expr_rule_check_cnt_meta;
    LOG_INFO << "===================================";

    LOG_INFO << "Rely rule check solve: " << rely_rule_check_hit_meta;
    LOG_INFO << "If rule check solve: " << if_rule_check_hit_meta;
    LOG_INFO << "Match rule check solve: " << match_rule_check_hit_meta;
    LOG_INFO << "Expr rule check solve: " << expr_rule_check_hit_meta;
    LOG_INFO << "===================================";

    LOG_INFO << "Rely rule check solve rate: " << (double)(rely_rule_check_cnt_meta == 0 ? 0.0 : (double)rely_rule_check_hit_meta / (double)rely_rule_check_cnt_meta);
    LOG_INFO << "If rule check solve rate: " << (double)(if_rule_check_cnt_meta == 0 ? 0.0 : (double)if_rule_check_hit_meta / (double)if_rule_check_cnt_meta);
    LOG_INFO << "Match rule check solve rate: " << (double)(match_rule_check_cnt_meta == 0 ? 0.0 : (double)match_rule_check_hit_meta / (double)match_rule_check_cnt_meta);
    LOG_INFO << "Expr rule check solve rate: " << (double)(expr_rule_check_cnt_meta == 0 ? 0.0 : (double)expr_rule_check_hit_meta / (double)expr_rule_check_cnt_meta);

    LOG_INFO << "====== z3_eval check time ======";
    LOG_INFO << "Rely eval check accumulative time: " << rely_eval_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "If eval check accumulative time: " << if_eval_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "Match eval check accumulative time: " << match_eval_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "Expr eval check accumulative time: " << expr_eval_check_accumulative_time_meta.count() << " (s)";
    LOG_INFO << "===================================";

    LOG_INFO << "Rely eval check count: " << rely_eval_check_cnt_meta;
    LOG_INFO << "If eval check count: " << if_eval_check_cnt_meta;
    LOG_INFO << "Match eval check count: " << match_eval_check_cnt_meta;
    LOG_INFO << "Expr eval check count: " << expr_eval_check_cnt_meta;
    LOG_INFO << "===================================";

    LOG_INFO << "Rely eval check solve: " << rely_eval_check_hit_meta;
    LOG_INFO << "If eval check solve: " << if_eval_check_hit_meta;
    LOG_INFO << "Match eval check solve: " << match_eval_check_hit_meta;
    LOG_INFO << "Expr eval check solve: " << expr_eval_check_hit_meta;
    LOG_INFO << "===================================";

	profile_print_transrule();

	
}

void profile_update_epoch() {
	//LOG_INFO << "NEW EPOCH! Number " << rule_stats.size() << " " << eval_stats.size();
	auto &rule_state = rule_stats.back();
	auto &eval_state = eval_stats.back();
	rule_state.check_if_cost = if_rule_check_accumulative_time;
	rule_state.check_match_cost = match_rule_check_accumulative_time;
	rule_state.check_rely_cost = rely_rule_check_accumulative_time;
	rule_state.check_expr_cost = expr_rule_check_accumulative_time;

	eval_state.check_if_cost = if_eval_check_accumulative_time;
	eval_state.check_match_cost = match_eval_check_accumulative_time;
	eval_state.check_rely_cost = rely_eval_check_accumulative_time;
	eval_state.check_expr_cost = expr_eval_check_accumulative_time;
}

void profile_print_simulation() {
	if (!__PROFILE_ON) return;
	PROFILE_PRINT_RULE(decom_simulation);
	PROFILE_PRINT_RULE(simulation_det);
	PROFILE_PRINT_RULE(simulation_non_det);
	PROFILE_PRINT_RULE(relate_secure);
	PROFILE_PRINT_RULE(coi);
}

void profile_print_epoch()
{
	LOG_INFO << "=========== Epoch Report ===========";
    LOG_INFO << "z3_eval accumulative time: " << z3_eval_accumulative_time.count() << " (s)";
    LOG_INFO << "Z3 check in [z3_eval] accumulative time: " << eval_check_accumulative_time.count() << " (s)";
    LOG_INFO << "Z3 check in [z3 rule] accumulative time: " << z3_rule_check_accumulative_time.count() << " (s)";

    LOG_INFO << "====== z3_rule check profile ======";

    LOG_INFO << "Rely rule check accumulative time: " << rely_rule_check_accumulative_time.count() << " (s)";
    LOG_INFO << "If rule check accumulative time: " << if_rule_check_accumulative_time.count() << " (s)";
    LOG_INFO << "Match rule check accumulative time: " << match_rule_check_accumulative_time.count() << " (s)";
    LOG_INFO << "Expr rule check accumulative time: " << expr_rule_check_accumulative_time.count() << " (s)";
    LOG_INFO << "===================================";

    LOG_INFO << "Rely rule check count: " << rely_rule_check_cnt;
    LOG_INFO << "If rule check count: " << if_rule_check_cnt;
    LOG_INFO << "Match rule check count: " << match_rule_check_cnt;
    LOG_INFO << "Expr rule check count: " << expr_rule_check_cnt;
    LOG_INFO << "===================================";

    LOG_INFO << "Rely rule check solve: " << rely_rule_check_hit;
    LOG_INFO << "If rule check solve: " << if_rule_check_hit;
    LOG_INFO << "Match rule check solve: " << match_rule_check_hit;
    LOG_INFO << "Expr rule check solve: " << expr_rule_check_hit;
    LOG_INFO << "===================================";

	LOG_INFO << "Rely rule check solve rate: " << rule_stats.back().rely_solve_rate();
	LOG_INFO << "If rule check solve rate: " << rule_stats.back().if_solve_rate();
	LOG_INFO << "Match rule check solve rate: " << rule_stats.back().match_solve_rate();
	LOG_INFO << "Expr rule check solve rate: " << rule_stats.back().expr_solve_rate();

    LOG_INFO << "====== z3_eval check time ======";
    LOG_INFO << "Rely eval check accumulative time: " << rely_eval_check_accumulative_time.count() << " (s)";
    LOG_INFO << "If eval check accumulative time: " << if_eval_check_accumulative_time.count() << " (s)";
    LOG_INFO << "Match eval check accumulative time: " << match_eval_check_accumulative_time.count() << " (s)";
    LOG_INFO << "Expr eval check accumulative time: " << expr_eval_check_accumulative_time.count() << " (s)";
    LOG_INFO << "===================================";

	LOG_INFO << "Rely eval check solve rate: " << eval_stats.back().rely_solve_rate();
	LOG_INFO << "If eval check solve rate: " << eval_stats.back().if_solve_rate();
	LOG_INFO << "Match eval check solve rate: " << eval_stats.back().match_solve_rate();
	LOG_INFO << "Expr eval check solve rate: " << eval_stats.back().expr_solve_rate();

}

void profile_finalize() {
	if (!__PROFILE_ON) return;

	LOG_INFO << "=========== Rule Report ===========";
	// LOG_INFO << "Rely rule check time:";
	for (auto &stat : rule_stats) {
		std::cout << stat.check_rely_cost.count() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "If rule check time:";
	for (auto &stat : rule_stats) {
		std::cout << stat.check_if_cost.count() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Match rule check time:";
	for (auto &stat : rule_stats) {
		std::cout << stat.check_match_cost.count() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Expr rule check time:";
	for (auto &stat : rule_stats) {
		std::cout << stat.check_expr_cost.count() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Rely rule check count:";
	for (auto &stat : rule_stats) {
		std::cout << stat.solved_rely_cond.size() + stat.unsolved_rely_cond.size() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "If rule check count:";
	for (auto &stat : rule_stats) {
		std::cout << stat.solved_if_branch.size() + stat.unsolved_if_branch.size() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "Match rule check count:";
	for (auto &stat : rule_stats) {
		std::cout << stat.solved_match_src.size() + stat.unsolved_match_src.size() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "Expr rule check count:";
	for (auto &stat : rule_stats) {
		std::cout << stat.solved_expr.size() + stat.unsolved_expr.size() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Rely rule check solve rate:";
	for (auto &stat : rule_stats) {
		std::cout << stat.rely_solve_rate() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "If rule check solve rate:";
	for (auto &stat : rule_stats) {
		std::cout << stat.if_solve_rate() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "Match rule check solve rate:";
	for (auto &stat : rule_stats) {
		std::cout << stat.match_solve_rate() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "Expr rule check solve rate:";
	for (auto &stat : rule_stats) {
		std::cout << stat.expr_solve_rate() << ", ";
	}
	std::cout << std::endl;

	// eval stats
	LOG_INFO << "=========== Eval Report ===========";
	// LOG_INFO << "Rely eval check time:";
	for (auto &stat : eval_stats) {
		std::cout << stat.check_rely_cost.count() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "If eval check time:";
	for (auto &stat : eval_stats) {
		std::cout << stat.check_if_cost.count() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "Match eval check time:";
	for (auto &stat : eval_stats) {
		std::cout << stat.check_match_cost.count() << ", ";
	}
	std::cout << std::endl;
	// LOG_INFO << "Expr eval check time:";
	for (auto &stat : eval_stats) {
		std::cout << stat.check_expr_cost.count() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Rely eval check count:";
	for (auto &stat : eval_stats) {
		std::cout << stat.solved_rely_cond.size() + stat.unsolved_rely_cond.size() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "If eval check count:";
	for (auto &stat : eval_stats) {
		std::cout << stat.solved_if_branch.size() + stat.unsolved_if_branch.size() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Match eval check count:";
	for (auto &stat : eval_stats) {
		std::cout << stat.solved_match_src.size() + stat.unsolved_match_src.size() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Expr eval check count:";
	for (auto &stat : eval_stats) {
		std::cout << stat.solved_expr.size() + stat.unsolved_expr.size() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Rely eval check solve rate:";
	for (auto &stat : eval_stats) {
		std::cout << stat.rely_solve_rate() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "If eval check solve rate:";
	for (auto &stat : eval_stats) {
		std::cout << stat.if_solve_rate() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Match eval check solve rate:";
	for (auto &stat : eval_stats) {
		std::cout << stat.match_solve_rate() << ", ";
	}
	std::cout << std::endl;

	// LOG_INFO << "Expr eval check solve rate:";
	for (auto &stat : eval_stats) {
		std::cout << stat.expr_solve_rate() << ", ";
	}
	std::cout << std::endl;
	int i = 0;
	LOG_INFO << "[z3_eval] Unsolved IF branch: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].unsolved_if_branch) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}		
	}
	LOG_INFO << "[z3_eval] Unsolved MATCH src: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].unsolved_match_src) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_eval] Unsolved RELY cond: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].unsolved_rely_cond) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_eval] Unsolved EXPR: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].unsolved_expr) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}

	LOG_INFO << "[z3_eval] Solved IF branch: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].solved_if_branch) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_eval] Solved MATCH src: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].solved_match_src) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_eval] Solved RELY cond: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].solved_rely_cond) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_eval] Solved EXPR: ";
	for (i = 0 ; i < eval_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : eval_stats[i].solved_expr) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}

	LOG_INFO << "[z3_rule] Unsolved IF branch: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i  << std::endl;
		for (auto &msg : rule_stats[i].unsolved_if_branch) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_rule] Unsolved MATCH src: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : rule_stats[i].unsolved_match_src) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_rule] Unsolved RELY cond: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : rule_stats[i].unsolved_rely_cond) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_rule] Unsolved EXPR: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : rule_stats[i].unsolved_expr) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}

	LOG_INFO << "[z3_rule] Solved IF branch: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : rule_stats[i].solved_if_branch) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_rule] Solved MATCH src: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : rule_stats[i].solved_match_src) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	LOG_INFO << "[z3_rule] Solved RELY cond: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : rule_stats[i].solved_rely_cond) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}

	LOG_INFO << "[z3_rule] Solved EXPR: ";
	for (i = 0 ; i < rule_stats.size(); i++) {
		LOG_INFO << "Epoch " << i << std::endl;
		for (auto &msg : rule_stats[i].solved_expr) {
			std::cout << "\t\t" << msg << std::endl;
			std::cout << "--------------" << std::endl;
		}
	}
	
}

void profile_log_rule_if_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().solved_if_branch.push_back(msg);
}

void profile_log_rule_match_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().solved_match_src.push_back(msg);
}

void profile_log_rule_rely_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().solved_rely_cond.push_back(msg);
}

void profile_log_rule_expr_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().solved_expr.push_back(msg);
}

void profile_log_rule_if_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().unsolved_if_branch.push_back(msg);
}

void profile_log_rule_match_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().unsolved_match_src.push_back(msg);
}

void profile_log_rule_rely_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().unsolved_rely_cond.push_back(msg);
}

void profile_log_rule_expr_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	rule_stats.back().unsolved_expr.push_back(msg);
}

void profile_log_eval_if_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().solved_if_branch.push_back(msg);
}

void profile_log_eval_match_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().solved_match_src.push_back(msg);
}

void profile_log_eval_rely_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().solved_rely_cond.push_back(msg);
}

void profile_log_eval_expr_solved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().solved_expr.push_back(msg);
}

void profile_log_eval_if_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().unsolved_if_branch.push_back(msg);
}

void profile_log_eval_match_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().unsolved_match_src.push_back(msg);
}

void profile_log_eval_rely_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().unsolved_rely_cond.push_back(msg);
}

void profile_log_eval_expr_unsolved(const string &msg) {
	if (!__PROFILE_ON) return;
	eval_stats.back().unsolved_expr.push_back(msg);
}
}
