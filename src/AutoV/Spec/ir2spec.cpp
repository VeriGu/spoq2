#include <ir2spec.h>
#include <nodes.h>
#include <any>
#include <irvalues.h>
#include <shortcuts.h>
#include <llvm.h>
#include <variant>
#include <unordered_set>
#include <log.h>

namespace autov {
using autov::IRLoader::IRType;
using autov::IRLoader::IRValue;
using autov::IRLoader::TInt;
using autov::IRLoader::TBool;
using autov::IRLoader::TVoid;
using autov::IRLoader::TFunction;
using autov::IRLoader::TPtr;
using autov::IRLoader::TNamedStruct;
using autov::IRLoader::TArray;
using autov::SpecType;
using autov::Int;
using autov::Bool;
using autov::Function;
using autov::Struct;
using autov::Int;
using autov::IntConst;
using autov::BoolConst;
using autov::Expr;
using autov::StringConst;
using autov::IRLoader::TStruct;
using autov::IRLoader::CFunction;
using autov::IRLoader::IReturn;
using autov::IRLoader::IRInst;
using autov::IRLoader::IAssign;
using autov::IRLoader::IBreak;


shared_ptr<SpecType> ir_type_to_spec(IRType* typ) {
	if(typeid(typ) == typeid(TInt*)) {
		return Int::INT;
	} else if (typeid(typ) == typeid(TBool*)) {
		return Bool::BOOL;
	} else if (typeid(typ) == typeid(TVoid*)) {
		return shared_ptr<SpecType>(new SpecType("Void"));
	} else if (typeid(typ) == typeid(TFunction)) {
		TFunction* func = dynamic_cast<TFunction*>(typ);
		vector<shared_ptr<SpecType>> *vec = new vector<shared_ptr<SpecType>>();
		for (auto t : *(func->arglist)) {
			vec->push_back(ir_type_to_spec(t.get()));
		}
		return shared_ptr<SpecType>(new Function(ir_type_to_spec(func->rettype.get()), shared_ptr<vector<shared_ptr<SpecType>>>(vec)));
	} else if (typeid(typ) == typeid(TPtr*)) {
		return Struct::Ptr;
	} else if (typeid(typ) == typeid(TNamedStruct*)) {
		TNamedStruct *ns = dynamic_cast<TNamedStruct*>(typ);
		return shared_ptr<SpecType>(new SpecType(ns->name));
	} else if (typeid(typ) == typeid(TArray*)) {
		TArray *array = dynamic_cast<TArray*>(typ);
		return shared_ptr<SpecType>(new Array(ir_type_to_spec(array->subtype.get())));
	} else {
		throw std::invalid_argument("invalid types");
	}
}


//return a raw pointer to give a flexibility of handler to deal with
// pointer, should be wrapped in a smart pointer
SpecNode* default_val(shared_ptr<SpecType> typ) {
	if(typeid(typ.get()) == typeid(Int*)) {
		return new IntConst(0);
	} else if (typeid(typ.get()) == typeid(Bool*)) {
		return new BoolConst(false);
	} else if (typeid(typ.get()) == typeid(Struct*) && typ->name == "Ptr") {
		vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
		vec->push_back(unique_ptr<SpecNode>(new StringConst("#")));
		vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
		return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
	} else if(typeid(typ.get()) == typeid(String*)) {
		return new StringConst("");
	} else {
		assert(false);
	}
}

SpecNode* ir_value_to_spec(Layer L, std::any v, vector<unique_ptr<SpecNode>> relies) {
	if(typeid(v) == typeid(int)) {
		return new IntConst(std::any_cast<int>(v));
	} else if(typeid(v) == typeid(bool)) {
		return new BoolConst(std::any_cast<bool>(v));
	} else if(typeid(v) == typeid(string)) {
		return new StringConst(std::any_cast<string>(v));
	} else if(typeid(v) == typeid(autov::IRLoader::VLocal)) {
		return new Symbol((std::any_cast<autov::IRLoader::VLocal>(v)).name);
	} else if(typeid(v) == typeid(autov::IRLoader::VGlobal)) {
		autov::IRLoader::VGlobal vg = std::any_cast<autov::IRLoader::VGlobal>(v);
		vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
		vec->push_back(unique_ptr<SpecNode>(new StringConst(vg.name)));
		vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
		return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
	} else if(typeid(v) == typeid(autov::IRLoader::VInt)) {
		unsigned long val = (std::any_cast<autov::IRLoader::VInt>(v)).val;
		return new IntConst(val);
	} else if(typeid(v) == typeid(autov::IRLoader::VBool)) {
		bool val = (std::any_cast<autov::IRLoader::VBool>(v)).val;
		if(val) {
			return new BoolConst(true);
		} else {
			return new BoolConst(false);
		}
	} else if(typeid(v) == typeid(IRLoader::VExpr)) {
		return nullptr;
	} else if(typeid(v) == typeid(IRLoader::VNull)) {
		vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
		vec->push_back(unique_ptr<SpecNode>(new StringConst("null")));
		vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
		return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
	} else if(typeid(v) == typeid(autov::IRLoader::VUndef)) {
		IRLoader::VUndef undef = std::any_cast<autov::IRLoader::VUndef>(v);
		if(typeid((undef.type)) == typeid(IRLoader::TPtr*)) {
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst("null")));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		} else if(typeid(undef.type) == typeid(IRLoader::TBool*)) {
			return new BoolConst(false);
		} else if(typeid(undef.type) == typeid(IRLoader::TInt*)) {
			return new IntConst(0);
		} else {
			unordered_map<string, shared_ptr<SpecType>> *map = new unordered_map<string, shared_ptr<SpecType>>();
			return autov::_name("UNDEF", map);
		}
	} else {
		unordered_map<string, shared_ptr<SpecType>> *map = new unordered_map<string, shared_ptr<SpecType>>();
		return autov::_name("UNKNOWN_VALUE", map);
	}
}


//get the size of a IR Type, otherwise return -1
long load_store_typ(IRType *typ){
	if (TInt *i = dynamic_cast<TInt*>(typ)) {
		return i->szof();
	} else if (dynamic_cast<TPtr*>(typ)) {
		return 8;
	} else if (dynamic_cast<TBool*>(typ)) {
		return 1;
	} else if (TNamedStruct *ns = dynamic_cast<TNamedStruct*>(typ)) {
		return (*(ns->structs))[ns->name]->szof();
	} else if (TStruct *ts = dynamic_cast<TStruct*>(typ)) {
		return ts->szof();
	} else if (TArray *arr = dynamic_cast<TArray*>(typ)) {
		return arr->subtype->szof();
	} else {
		return -1;
	}
}


//modify the sets inputs and outputs directly
void get_input_output(IRValue* irval, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs) {
	if (auto f = dynamic_cast<IRLoader::VLocal*>(irval)) {
		if(dynamic_cast<TVoid*>(f->type.get())) {
			outputs.insert(f->name);
		} else {
			if(outputs.find(f->name) == outputs.end()) {
				inputs.insert(f->name);
			}
		}
	} else if (auto f = dynamic_cast<IRLoader::VExpr*>(irval)) {
		for(auto it = f->operands->begin(); it != f->operands->end(); ++it) {
			get_input_output(it->get(), inputs, outputs);
		}
	}
}

void get_input_output(CFunction* cf, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs) {
		for(auto arg = cf->args->begin(); arg != cf->args->end(); ++arg) {
				outputs.insert(arg->get()->name);
		}
}

void get_input_output(vector<unique_ptr<IRInst>>* vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs) {
	int i;
	for(auto it = vec->begin(); it != vec->end(); ++it, ++i) {
		if (auto f = dynamic_cast<IAssign*>(it->get())) {
			get_input_output(f->val.get(), inputs, outputs);
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IReturn*>(it->get())) {
			if(f->val != nullptr) {
				get_input_output(f->val.get(), inputs, outputs);
				outputs.insert("__retval__");
			}
 		} else if (auto f = dynamic_cast<IBreak*>(it->get())) {
			outputs.insert("__break__");
		} else if (auto f = dynamic_cast<IRLoader::IContinue*>(it->get())) {
			outputs.insert("__continue__");
		} else if (auto f = dynamic_cast<IRLoader::IUnaryOp*>(it->get())) {
			get_input_output(f->a.get(), inputs, outputs);
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IBinOp*>(it->get())) {
			get_input_output(f->a.get(), inputs, outputs);
			get_input_output(f->b.get(), inputs, outputs);
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::ISelect*>(it->get())) {
			get_input_output(f->cond.get(), inputs, outputs);
			get_input_output(f->true_val.get(), inputs, outputs);
			get_input_output(f->false_val.get(), inputs, outputs);
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::ICall*>(it->get())) {
			for(auto it = f->args->begin(); it != f->args->end(); it++) {
				get_input_output(it->get(), inputs, outputs);
			}
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IIf*>(it->get())) {
			get_input_output(f->cond.get(), inputs, outputs);
			get_input_output(f->true_body.get(), inputs, outputs);
			get_input_output(f->false_body.get(), inputs, outputs);
		} else if (auto f = dynamic_cast<IRLoader::ILoop*>(it->get())) {
			get_input_output(f->body.get(), inputs, outputs);
		} else if (auto f = dynamic_cast<IRLoader::IGetElemPtr*>(it->get())) {
			get_input_output(f->val.get(), inputs, outputs);
			get_input_output(f->index.get(), inputs, outputs);
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IExtractValue*>(it->get())) {
			get_input_output(f->val.get(), inputs, outputs);
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::ILoad*>(it->get())) {
			get_input_output(f->ptr.get(), inputs, outputs);
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IStore*>(it->get())) {
			get_input_output(f->ptr.get(), inputs, outputs);
			get_input_output(f->val.get(), inputs, outputs);
		} else if (auto f = dynamic_cast<IRLoader::IAlloc*>(it->get())) {
			outputs.insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IInsertValue*>(it->get())) {
			outputs.insert(f->assign);
		} else {
			LOG_DEBUG << "get_input_output not supported for this instruction";
			LOG_DEBUG << "current instruction:\n" + (*(*(it))).to_coq();
			assert(false);
		}
	}
}



void get_input_output(vector<unique_ptr<IRInst>>* vec, shared_ptr<std::unordered_set<string>> *inputs_arr, shared_ptr<std::unordered_set<string>> *outputs_arr) {
	int i;
	for(auto it = vec->begin(); it != vec->end(); ++it, ++i) {
		if (auto f = dynamic_cast<IAssign*>(it->get())) {
			get_input_output(f->val.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IReturn*>(it->get())) {
			if(f->val != nullptr) {
				get_input_output(f->val.get(), *(inputs_arr[i]), *(outputs_arr[i]));
				outputs_arr[i]->insert("__retval__");
			}
 		} else if (auto f = dynamic_cast<IBreak*>(it->get())) {
			outputs_arr[i]->insert("__break__");

		} else if (auto f = dynamic_cast<IRLoader::IContinue*>(it->get())) {
			outputs_arr[i]->insert("__continue__");
		} else if (auto f = dynamic_cast<IRLoader::IUnaryOp*>(it->get())) {
			get_input_output(f->a.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IBinOp*>(it->get())) {
			get_input_output(f->a.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			get_input_output(f->b.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::ISelect*>(it->get())) {
			get_input_output(f->cond.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			get_input_output(f->true_val.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			get_input_output(f->false_val.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::ICall*>(it->get())) {
			for(auto it = f->args->begin(); it != f->args->end(); it++) {
				get_input_output(it->get(), *(inputs_arr[i]), *(outputs_arr[i]));
			}

			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IIf*>(it->get())) {
			get_input_output(f->cond.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			get_input_output(f->true_body.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			get_input_output(f->false_body.get(), *(inputs_arr[i]), *(outputs_arr[i]));
		} else if (auto f = dynamic_cast<IRLoader::ILoop*>(it->get())) {
			get_input_output(f->body.get(), *(inputs_arr[i]), *(outputs_arr[i]));
		} else if (auto f = dynamic_cast<IRLoader::IGetElemPtr*>(it->get())) {
			get_input_output(f->val.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			get_input_output(f->index.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IExtractValue*>(it->get())) {
			get_input_output(f->val.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::ILoad*>(it->get())) {
			get_input_output(f->ptr.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IStore*>(it->get())) {
			get_input_output(f->ptr.get(), *(inputs_arr[i]), *(outputs_arr[i]));
			get_input_output(f->val.get(), *(inputs_arr[i]), *(outputs_arr[i]));
		} else if (auto f = dynamic_cast<IRLoader::IAlloc*>(it->get())) {
			outputs_arr[i]->insert(f->assign);
		} else if (auto f = dynamic_cast<IRLoader::IInsertValue*>(it->get())) {
			outputs_arr[i]->insert(f->assign);
		} else {
			LOG_DEBUG << "get_input_output not supported for this instruction";
			LOG_DEBUG << "current instruction:\n" + (*(*(it))).to_coq();
			assert(false);
		}
	}

	//get a prefix sum of sets so that we can extract any inputs/outputs from insts[0..i]
	for(auto i = 1; i < sizeof(inputs_arr); ++i) {
		inputs_arr[i]->insert(inputs_arr[i-1]->cbegin(), inputs_arr[i-1]->cend());
	}
}
}