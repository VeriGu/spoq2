#pragma once
#include <nodes.h>
#include <SpoqIR.h>

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

	class Shortcut {
	public:

	  inline static std::string replace_dot(std::string str) {
		std::replace(str.begin(), str.end(), '.', '_');
		return str;
	  }

	  static unique_ptr<SpecNode> _Let_u(unique_ptr<SpecNode> sym, unique_ptr<SpecNode> val, unique_ptr<SpecNode> body);
	  /**
	   * @brief The unique_ptr version of shortcut _Tuple.
	   * 
	   * @param vec 
	   * @return unique_ptr<SpecNode> 
	   */
	  static unique_ptr<SpecNode> _Tuple_u(unique_ptr<vector<unique_ptr<SpecNode>>> vec);

	  /**
	   * @brief The unique_ptr version of shortcut _Tuple
	   * 
	   * @param val 
	   * @return unique_ptr<SpecNode> 
	   */
	  static unique_ptr<SpecNode> _Some_u(unique_ptr<SpecNode> val);

	  /**
	   * @brief the unique_ptr version of shortcut _When. Note the 'None' is without type.
	   * 
	   * @param pat 
	   * @param val 
	   * @param body 
	   * @return unique_ptr<SpecNode> 
	   */
	  static unique_ptr<SpecNode> _When_u(unique_ptr<SpecNode> pat, unique_ptr<SpecNode> val, unique_ptr<SpecNode> body);

	  /**
	   * @brief The unique_ptr version of shortcut dyn_cast for SpoqIR.
	   * 
	   * @tparam T 
	   * @param ptr 
	   * @return true 
	   * @return false 
	   */
	  template <typename T>
	  static inline T* dyn_cast_u(const std::unique_ptr<SpoqInst>& ptr) {
		return dynamic_cast<T*>(ptr.get());
	  }

	  static unique_ptr<SpecNode> _field_u(unique_ptr<SpecNode> val, string field) {
		auto record = make_unique<vector<unique_ptr<SpecNode>>>();

		record->push_back(std::move(val));
		record->push_back(make_unique<Symbol>(field));
	
		return make_unique<Expr>(Expr::RecordGet, std::move(record));
	  }

	};
}