#pragma once
#include <nodes.h>

namespace autov {
	using autov::SpecNode;

	SpecNode* _Let(string name, SpecNode* val, SpecNode* body);
	SpecNode* _When(SpecNode* pat, SpecNode* val, SpecNode* body);
	SpecNode* _Some(SpecNode* val);
	SpecNode* _Tuple(vector<unique_ptr<SpecNode>> *vec);
	SpecNode* _List(vector<unique_ptr<SpecNode>> *vec);
	SpecNode* _st(shared_ptr<SpecType> abs_data);
	SpecNode* _init_st(shared_ptr<SpecType> abs_data);
	SpecNode* _name(string name, unordered_map<string, shared_ptr<SpecType>> *types);
}