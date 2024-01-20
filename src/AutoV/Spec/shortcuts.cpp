#include <shortcuts.h>

namespace autov {
	static SpecNode* _Let(string name, SpecNode* val, SpecNode* body) {
		auto vec = new vector<unique_ptr<PatternMatch>>();
		vec->push_back(unique_ptr<PatternMatch>(new PatternMatch(unique_ptr<SpecNode>(new Symbol(name)), unique_ptr<SpecNode>(body))));
		return new Match(unique_ptr<SpecNode>(val), unique_ptr<vector<unique_ptr<PatternMatch>>>(vec));
	}

	static SpecNode* _When(SpecNode* pat, SpecNode* val, SpecNode* body) {
		auto somepat = new vector<unique_ptr<SpecNode>>();
		somepat->push_back(unique_ptr<SpecNode>(pat));
		PatternMatch *some = new PatternMatch(unique_ptr<SpecNode>(new Expr("Some", unique_ptr<vector<unique_ptr<SpecNode>>>(somepat))), unique_ptr<SpecNode>(body));
	    PatternMatch *none = new PatternMatch(unique_ptr<SpecNode>(new Symbol("None")), unique_ptr<SpecNode>(new Symbol("None")));

		auto pats = new vector<unique_ptr<PatternMatch>>();
		pats->push_back(unique_ptr<PatternMatch>(some));
		pats->push_back(unique_ptr<PatternMatch>(none));
		return new Match(unique_ptr<SpecNode>(val), unique_ptr<vector<unique_ptr<PatternMatch>>>(pats));
	}

	static SpecNode* _Some(SpecNode* val) {
		auto vec = new vector<unique_ptr<SpecNode>>();
		vec->push_back(unique_ptr<SpecNode>(val));
		return new Expr("Some", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
	}

	static SpecNode* _Tuple(vector<unique_ptr<SpecNode>> *vec) {
		return new Expr("Tuple", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
	}

	static SpecNode* _List(vector<unique_ptr<SpecNode>> *vec) {
		return new Expr("List", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
	}

	static SpecNode* _st(shared_ptr<SpecType> abs_data) {
		return new Symbol("st", abs_data);
	}

	static SpecNode* _init_st(shared_ptr<SpecType> abs_data) {
		return new Symbol("st", abs_data);
	}

	static SpecNode* _name(string name, unordered_map<string, shared_ptr<SpecType>> *types) {
		if(types->find(name) != types->end()) {
			return new Symbol(name, (*types)[name]);
		} else {
			return new Symbol(name, autov::SpecType::UNKNOWN_TYPE);
		}
	}
}