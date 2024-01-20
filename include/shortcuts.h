#pragma once
#include <nodes.h>

namespace autov {
	using autov::SpecNode;

	static SpecNode* _Let(string name, SpecNode* val, SpecNode* body);
	static SpecNode* _When(SpecNode* pat, SpecNode* val, SpecNode* body);
	static SpecNode* _Some(SpecNode* val);
	static SpecNode* _Tuple(vector<unique_ptr<SpecNode>> *vec);
	static SpecNode* _List(vector<unique_ptr<SpecNode>> *vec);
	static SpecNode* _st(SpecType* abs_data);
	static SpecNode* _init_st(SpecType* abs_data);
	static SpecNode* _name(string name, unordered_map<string, shared_ptr<SpecType>> *types);
}