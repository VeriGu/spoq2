#include <ir2spec.h>
#include <nodes.h>
#include <any>
#include <irvalues.h>
#include <shortcuts.h>

namespace autov {
using autov::IRLoader::IRType;
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



static shared_ptr<SpecType> ir_type_to_spec(shared_ptr<IRType> typ) {
	if(typeid(*typ) == typeid(TInt)) {
		return Int::INT;
	} else if (typeid(*typ) == typeid(TBool)) {
		return Bool::BOOL;
	} else if (typeid(*typ) == typeid(TVoid)) {
		return shared_ptr<SpecType>(new SpecType("Void"));
	} else if (typeid(*typ) == typeid(TFunction)) {
		TFunction* func = dynamic_cast<TFunction*>(typ.get());
		vector<shared_ptr<SpecType>> *vec = new vector<shared_ptr<SpecType>>();
		for (auto t : *(func->arglist)) {
			vec->push_back(ir_type_to_spec(t));
		}
		return shared_ptr<SpecType>(new Function(ir_type_to_spec(func->rettype), shared_ptr<vector<shared_ptr<SpecType>>>(vec)));
	} else if (typeid(*typ) == typeid(TPtr)) {
		return Struct::Ptr;
	} else if (typeid(*typ) == typeid(TNamedStruct)) {
		TNamedStruct *ns = dynamic_cast<TNamedStruct*>(typ.get());
		return shared_ptr<SpecType>(new SpecType(ns->name));
	} else if (typeid(*typ) == typeid(TArray)) {
		TArray *array = dynamic_cast<TArray*>(typ.get());
		return shared_ptr<SpecType>(new Array(ir_type_to_spec(array->subtype)));
	} else {
		throw std::invalid_argument("invalid types");
	}
}


//return a raw pointer to give a flexibility of handler to deal with
// pointer, should be wrapped in a smart pointer
static SpecNode* default_val(shared_ptr<SpecType> typ) {
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


static SpecNode* ir_value_to_spec(Layer L, std::any v, vector<unique_ptr<SpecNode>> relies) {
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
		if(typeid(*(undef.type)) == typeid(IRLoader::TPtr)) {
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst("null")));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		} else if(typeid(*(undef.type)) == typeid(IRLoader::TBool)) {
			return new BoolConst(false);
		} else if(typeid(*(undef.type)) == typeid(IRLoader::TInt)) {
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
static long load_store_typ(IRType *typ){
	if(typeid(typ) == typeid(TInt*)) {
		TInt *i = dynamic_cast<TInt*>(typ);
		return i->szof();
	} else if (typeid(typ) == typeid(TPtr*)) {
		return 8;
	} else if (typeid(typ) == typeid(TBool*)) {
		return 1;
	} else if (typeid(typ) == typeid(TNamedStruct*)) {
		TNamedStruct *ns = dynamic_cast<TNamedStruct*>(typ);
		return (*(ns->structs))[ns->name]->szof();
	} else if (typeid(typ) == typeid(TStruct*)) {
		TStruct *ts = dynamic_cast<TStruct*>(typ);
		return ts->szof();
	} else if (typeid(typ) == typeid(TArray*)) {
		TArray *arr = dynamic_cast<TArray*>(typ);
		return arr->subtype->szof();
	} else {
		return -1;
	}
}






}