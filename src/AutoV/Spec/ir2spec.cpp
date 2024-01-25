#include <ir2spec.h>
#include <nodes.h>
#include <any>
#include <irvalues.h>
#include <shortcuts.h>
#include <llvm.h>
#include <variant>
#include <unordered_set>
#include <log.h>
#include <boost/range/algorithm/set_algorithm.hpp>

namespace autov
{
	using autov::Bool;
	using autov::BoolConst;
	using autov::Expr;
	using autov::Function;
	using autov::Int;
	using autov::IntConst;
	using autov::SpecType;
	using autov::StringConst;
	using autov::Struct;
	using autov::IRLoader::CFunction;
	using autov::IRLoader::IAssign;
	using autov::IRLoader::IBreak;
	using autov::IRLoader::IReturn;
	using autov::IRLoader::IRInst;
	using autov::IRLoader::IRType;
	using autov::IRLoader::IRValue;
	using autov::IRLoader::TArray;
	using autov::IRLoader::TBool;
	using autov::IRLoader::TFunction;
	using autov::IRLoader::TInt;
	using autov::IRLoader::TNamedStruct;
	using autov::IRLoader::TPtr;
	using autov::IRLoader::TStruct;
	using autov::IRLoader::TVoid;
	using IRLoader::Op;

	typedef std::variant<IRValue, IRInst, CFunction> Inst;

	SpecNode *ir_expr_to_spec(Layer* l, IRLoader::Op op, vector<unique_ptr<IRValue>> *_args, vector<unique_ptr<SpecNode>> *relies);


	shared_ptr<SpecType> ir_type_to_spec(IRType *typ)
	{
		if (typeid(typ) == typeid(TInt *))
		{
			return Int::INT;
		}
		else if (typeid(typ) == typeid(TBool *))
		{
			return Bool::BOOL;
		}
		else if (typeid(typ) == typeid(TVoid *))
		{
			return shared_ptr<SpecType>(new SpecType("Void"));
		}
		else if (typeid(typ) == typeid(TFunction))
		{
			TFunction *func = dynamic_cast<TFunction *>(typ);
			vector<shared_ptr<SpecType>> *vec = new vector<shared_ptr<SpecType>>();
			for (auto t : *(func->arglist))
			{
				vec->push_back(ir_type_to_spec(t.get()));
			}
			return shared_ptr<SpecType>(new Function(ir_type_to_spec(func->rettype.get()), shared_ptr<vector<shared_ptr<SpecType>>>(vec)));
		}
		else if (typeid(typ) == typeid(TPtr *))
		{
			return Struct::Ptr;
		}
		else if (typeid(typ) == typeid(TNamedStruct *))
		{
			TNamedStruct *ns = dynamic_cast<TNamedStruct *>(typ);
			return shared_ptr<SpecType>(new SpecType(ns->name));
		}
		else if (typeid(typ) == typeid(TArray *))
		{
			TArray *array = dynamic_cast<TArray *>(typ);
			return shared_ptr<SpecType>(new Array(ir_type_to_spec(array->subtype.get())));
		}
		else
		{
			throw std::invalid_argument("invalid types");
		}
	}

	// return a raw pointer to give a flexibility of handler to deal with
	//  pointer, should be wrapped in a smart pointer
	SpecNode *default_val(shared_ptr<SpecType> typ)
	{
		if (typeid(typ.get()) == typeid(Int *))
		{
			return new IntConst(0);
		}
		else if (typeid(typ.get()) == typeid(Bool *))
		{
			return new BoolConst(false);
		}
		else if (typeid(typ.get()) == typeid(Struct *) && typ->name == "Ptr")
		{
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst("#")));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		}
		else if (typeid(typ.get()) == typeid(String *))
		{
			return new StringConst("");
		}
		else
		{
			assert(false);
		}
	}

	SpecNode *ir_value_to_spec(Layer* L, std::any v, vector<unique_ptr<SpecNode>> *relies)
	{
		if (typeid(v) == typeid(int))
		{
			return new IntConst(std::any_cast<int>(v));
		}
		else if (typeid(v) == typeid(bool))
		{
			return new BoolConst(std::any_cast<bool>(v));
		}
		else if (typeid(v) == typeid(string))
		{
			return new StringConst(std::any_cast<string>(v));
		}
		else if (typeid(v) == typeid(autov::IRLoader::VLocal))
		{
			return new Symbol((std::any_cast<autov::IRLoader::VLocal>(v)).name);
		}
		else if (typeid(v) == typeid(autov::IRLoader::VGlobal))
		{
			autov::IRLoader::VGlobal vg = std::any_cast<autov::IRLoader::VGlobal>(v);
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst(vg.name)));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		}
		else if (typeid(v) == typeid(autov::IRLoader::VInt))
		{
			unsigned long val = (std::any_cast<autov::IRLoader::VInt>(v)).val;
			return new IntConst(val);
		}
		else if (typeid(v) == typeid(autov::IRLoader::VBool))
		{
			bool val = (std::any_cast<autov::IRLoader::VBool>(v)).val;
			if (val)
			{
				return new BoolConst(true);
			}
			else
			{
				return new BoolConst(false);
			}
		}
		else if (typeid(v) == typeid(IRLoader::VExpr))
		{
			IRLoader::VExpr v = (std::any_cast<autov::IRLoader::VExpr>(v));
			return ir_expr_to_spec(L, v.op, v.operands.get(), relies);
		}
		else if (typeid(v) == typeid(IRLoader::VNull))
		{
			vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
			vec->push_back(unique_ptr<SpecNode>(new StringConst("null")));
			vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
			return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
		}
		else if (typeid(v) == typeid(autov::IRLoader::VUndef))
		{
			IRLoader::VUndef undef = std::any_cast<autov::IRLoader::VUndef>(v);
			if (typeid((undef.type)) == typeid(IRLoader::TPtr *))
			{
				vector<unique_ptr<SpecNode>> *vec = new vector<unique_ptr<SpecNode>>();
				vec->push_back(unique_ptr<SpecNode>(new StringConst("null")));
				vec->push_back(unique_ptr<SpecNode>(new IntConst(0)));
				return new Expr("mkPtr", unique_ptr<vector<unique_ptr<SpecNode>>>(vec));
			}
			else if (typeid(undef.type) == typeid(IRLoader::TBool *))
			{
				return new BoolConst(false);
			}
			else if (typeid(undef.type) == typeid(IRLoader::TInt *))
			{
				return new IntConst(0);
			}
			else
			{
				unordered_map<string, shared_ptr<SpecType>> *map = new unordered_map<string, shared_ptr<SpecType>>();
				return autov::_name("UNDEF", map);
			}
		}
		else
		{
			unordered_map<string, shared_ptr<SpecType>> *map = new unordered_map<string, shared_ptr<SpecType>>();
			return autov::_name("UNKNOWN_VALUE", map);
		}
	}

	SpecNode *ir_expr_to_spec(Layer* l, IRLoader::Op op, vector<unique_ptr<IRValue>> *_args, vector<unique_ptr<SpecNode>> *relies)
	{
		auto args = unique_ptr<vector<unique_ptr<SpecNode>>>(new vector<unique_ptr<SpecNode>>());
		for(auto & arg : *_args) {
			args->push_back(unique_ptr<SpecNode>(ir_value_to_spec(l, *arg, relies)));
		}

		switch(op.op) {
			case Op::OBitCast:
				return args->at(0).get();
			case Op::OSExt:
				return args->at(0).get();
			case Op::OTrunc:
				return args->at(0).get();
			case Op::OZExt:
				if(dynamic_cast<TBool*>(_args->at(0)->type.get())) {
					return new Expr("bool_to_int", std::move(args));
				} else {
					return args->at(0).get();
				}
			case Op::OPtrToInt:
				return new Expr(l->ops["ptr2int"], std::move(args));
			case Op::OIntToPtr:
				return new Expr(l->ops["int2ptr"], std::move(args));
			case Op::OGetElementPtr:
				//TODO
				return nullptr;
			case Op::Cslt:
				return new Expr("<?", std::move(args));
		  case Op::Csle:
				return new Expr("<=?", std::move(args));
			case Op::Cult:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr("<?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					return new Expr(l->ops["ptr_ltb"], std::move(args));
				}
			case Op::Cule:
				return new Expr("<=?", std::move(args));
			case Op::Ceq:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr("=?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					return new Expr(l->ops["ptr_eqb"], std::move(args));
				}
				assert(false);
			case Op::Cne:
			  if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr("<>?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					
					return new Expr("!", std::move(args));
				}
				assert(false);
			case Op::Csgt:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr(">?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
				
					return new Expr(l->ops["ptr_gtb"], std::move(args));
				}	
			case Op::Csge:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr(">=?", std::move(args));
				} else {
					assert(false);
				}
			case Op::Cugt:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr(">?", std::move(args));
				} else if (dynamic_cast<TPtr*>(_args->at(0)->type.get())){
					return new Expr(l->ops["ptr_gtb"], std::move(args));
				}
			case Op::Cuge:
				
				return new Expr(">?", std::move(args));
			case Op::OAdd:
				
				return new Expr("+", std::move(args));
			case Op::OAnd:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
					
				  return new Expr("&", std::move(args));
				} else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){
					
					return new Expr("&&", std::move(args));
				}
			case Op::OAshr:
				return new Expr(">>", std::move(args));
			case Op::OLshr:
				return new Expr("<<", std::move(args));
			case Op::OMul:
				return new Expr("*", std::move(args));
			case Op::OOr:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr("|\'", std::move(args));
				} else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){
					return new Expr("||", std::move(args));
				}
			case Op::OSdiv:
				return new Expr("/", std::move(args));
			case Op::OSrem:
				return new Expr("mod", std::move(args));
			case Op::OShl:
				return new Expr("<<", std::move(args));
			case Op::OSub:
				return new Expr("-", std::move(args));
			case Op::OUdiv:
				return new Expr("/", std::move(args));
			case Op::OUrem:
				return new Expr("mod", std::move(args));
			case Op::OXor:
				if(dynamic_cast<TInt*>(_args->at(0)->type.get())) {
				  return new Expr("Z.lxor", std::move(args));
				} else if (dynamic_cast<TBool*>(_args->at(0)->type.get())){
					return new Expr("xorb", std::move(args));
				}
			default:
				assert(false);
		}
		return nullptr;
	}

	SpecNode *ir_op_to_spec(Layer *l, IRLoader::IRInst *inst, SpecNode *remain_spec)
	{
		auto relies = new vector<unique_ptr<SpecNode>>();
		auto args = new vector<unique_ptr<IRValue>>();
		SpecNode *expr;
		SpecNode *stmt;
		if (auto f = dynamic_cast<IRLoader::IUnaryOp *>(inst))
		{
		  args->push_back(unique_ptr<IRValue>(f->a->clone()));
			expr = ir_expr_to_spec(l, f->op, args, relies);
			stmt = autov::_Let(f->assign, expr, remain_spec);
		}
		else if (auto f = dynamic_cast<IRLoader::IBinOp *>(inst))
		{
			args->push_back(unique_ptr<IRValue>(f->a->clone()));
			args->push_back(unique_ptr<IRValue>(f->b->clone()));
			expr = ir_expr_to_spec(l, f->op, args, relies);
			stmt = autov::_Let(f->assign, expr, remain_spec);
		}
		for(auto &rely: *relies) {
			stmt = new Rely(std::move(rely), unique_ptr<SpecNode>(stmt));
		}

		return stmt;
	}

	// get the size of a IR Type, otherwise return -1
	long load_store_typ(IRType *typ)
	{
		if (TInt *i = dynamic_cast<TInt *>(typ))
		{
			return i->szof();
		}
		else if (dynamic_cast<TPtr *>(typ))
		{
			return 8;
		}
		else if (dynamic_cast<TBool *>(typ))
		{
			return 1;
		}
		else if (TNamedStruct *ns = dynamic_cast<TNamedStruct *>(typ))
		{
			return (*(ns->structs))[ns->name]->szof();
		}
		else if (TStruct *ts = dynamic_cast<TStruct *>(typ))
		{
			return ts->szof();
		}
		else if (TArray *arr = dynamic_cast<TArray *>(typ))
		{
			return arr->subtype->szof();
		}
		else
		{
			return -1;
		}
	}

	// modify the sets inputs and outputs directly
	void get_input_output(IRValue *irval, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		if (auto f = dynamic_cast<IRLoader::VLocal *>(irval))
		{
			if (dynamic_cast<TVoid *>(f->type.get()))
			{
				outputs.insert(f->name);
			}
			else
			{
				if (outputs.find(f->name) == outputs.end())
				{
					inputs.insert(f->name);
				}
			}
		}
		else if (auto f = dynamic_cast<IRLoader::VExpr *>(irval))
		{
			for (auto it = f->operands->begin(); it != f->operands->end(); ++it)
			{
				get_input_output(it->get(), inputs, outputs);
			}
		}
	}

	void get_input_output(vector<unique_ptr<IRValue>> *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto it = vec->begin(); it != vec->end(); ++it)
		{
			get_input_output(it->get(), inputs, outputs);
		}
	}

	void get_input_output(CFunction *cf, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto arg = cf->args->begin(); arg != cf->args->end(); ++arg)
		{
			outputs.insert(arg->get()->name);
		}
	}

	void get_input_output(IRInst *it, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs);

	void get_input_output(vector<unique_ptr<IRInst>> *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto it = vec->begin(); it != vec->end(); ++it)
		{
			get_input_output(it->get(), inputs, outputs);
		}
	}

	void get_input_output(IRInst *it, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		if (auto f = dynamic_cast<IAssign *>(it))
		{
			get_input_output(f->val.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IReturn *>(it))
		{
			if (f->val != nullptr)
			{
				get_input_output(f->val.get(), inputs, outputs);
				outputs.insert("__retval__");
			}
		}
		else if (auto f = dynamic_cast<IBreak *>(it))
		{
			outputs.insert("__break__");
		}
		else if (auto f = dynamic_cast<IRLoader::IContinue *>(it))
		{
			outputs.insert("__continue__");
		}
		else if (auto f = dynamic_cast<IRLoader::IUnaryOp *>(it))
		{
			get_input_output(f->a.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IBinOp *>(it))
		{
			get_input_output(f->a.get(), inputs, outputs);
			get_input_output(f->b.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::ISelect *>(it))
		{
			get_input_output(f->cond.get(), inputs, outputs);
			get_input_output(f->true_val.get(), inputs, outputs);
			get_input_output(f->false_val.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::ICall *>(it))
		{
			for (auto it = f->args->begin(); it != f->args->end(); it++)
			{
				get_input_output(it->get(), inputs, outputs);
			}
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IIf *>(it))
		{
			get_input_output(f->cond.get(), inputs, outputs);
			get_input_output(f->true_body.get(), inputs, outputs);
			get_input_output(f->false_body.get(), inputs, outputs);
		}
		else if (auto f = dynamic_cast<IRLoader::ILoop *>(it))
		{
			get_input_output(f->body.get(), inputs, outputs);
		}
		else if (auto f = dynamic_cast<IRLoader::IGetElemPtr *>(it))
		{
			get_input_output(f->val.get(), inputs, outputs);
			get_input_output(f->index.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IExtractValue *>(it))
		{
			get_input_output(f->val.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::ILoad *>(it))
		{
			get_input_output(f->ptr.get(), inputs, outputs);
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IStore *>(it))
		{
			get_input_output(f->ptr.get(), inputs, outputs);
			get_input_output(f->val.get(), inputs, outputs);
		}
		else if (auto f = dynamic_cast<IRLoader::IAlloc *>(it))
		{
			outputs.insert(f->assign);
		}
		else if (auto f = dynamic_cast<IRLoader::IInsertValue *>(it))
		{
			outputs.insert(f->assign);
		}
		else
		{
			LOG_DEBUG << "get_input_output not supported for this instruction";
			LOG_DEBUG << "current instruction:\n" + it->to_coq();
			assert(false);
		}
	}

	void get_input_output(vector<unique_ptr<IRInst>> *vec, shared_ptr<std::unordered_set<string>> *inputs_arr, shared_ptr<std::unordered_set<string>> *outputs_arr)
	{
		int i;
		for (auto it = vec->begin(); it != vec->end(); ++it, ++i)
		{
			get_input_output(it->get(), *(inputs_arr[i]), *(outputs_arr[i]));
		}

		// get a prefix sum of sets so that we can extract any inputs/outputs from insts[0..i]
		for (auto i = 1; i < sizeof(inputs_arr); ++i)
		{
			inputs_arr[i]->insert(inputs_arr[i - 1]->cbegin(), inputs_arr[i - 1]->cend());
		}
	}

	void get_input_output(Inst *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		if (std::holds_alternative<CFunction>(*vec))
		{
			auto &f = std::get<CFunction>(*vec);
			get_input_output(&f, inputs, outputs);
		}
		else if (std::holds_alternative<IRValue>(*vec))
		{
			auto &f = std::get<IRValue>(*vec);
			get_input_output(&f, inputs, outputs);
		}
		else if (std::holds_alternative<IRInst>(*vec))
		{
			auto &f = std::get<IRInst>(*vec);
			get_input_output(&f, inputs, outputs);
		}
	}

	void get_input_output(vector<shared_ptr<Inst>> *vec, shared_ptr<std::unordered_set<string>> *inputs_arr, shared_ptr<std::unordered_set<string>> *outputs_arr)
	{
		int i;
		for (auto it = vec->begin(); it != vec->end(); ++it, ++i)
		{
			get_input_output(it->get(), *(inputs_arr[i]), *(outputs_arr[i]));
		}
	}

	void get_input_output(vector<shared_ptr<Inst>> *vec, std::unordered_set<string> &inputs, std::unordered_set<string> &outputs)
	{
		for (auto it = vec->begin(); it != vec->end(); ++it)
		{
			get_input_output(it->get(), inputs, outputs);
		}
	}

	void analyze_input_output(vector<unique_ptr<IRInst>> *insts, vector<shared_ptr<Inst>> *before, vector<shared_ptr<Inst>> *after, bool in_loop)
	{
		auto input_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];
		auto output_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];

		get_input_output(insts, input_arr, output_arr);

		int i = 0;
		for (auto it = insts->begin(); it != insts->end(); ++it, ++i)
		{
			auto input = *(input_arr[i]);	// input from insts[0..i]
			auto output = *(output_arr[i]); // output from insts[0..i]

			std::unordered_set<string> input_i;
			std::unordered_set<string> output_i;
			std::unordered_set<string> before_output;
			std::unordered_set<string> before_input;
			std::unordered_set<string> after_output;
			std::unordered_set<string> after_input;

			std::unordered_set<string> before_before_input;
			std::unordered_set<string> before_before_output;
			std::unordered_set<string> after_after_input;
			std::unordered_set<string> after_after_output;

			if (before->size() > 0)
			{
				get_input_output(before, before_before_input, before_before_output);
			}

			if (after->size() > 0)
			{
				get_input_output(after, after_after_input, after_after_output);
			}

			if (i >= 1)
			{
				boost::set_union(*(output_arr[i - 1]), before_before_output, std::inserter(before_output, before_output.begin()));
				boost::set_union(*(input_arr[i - 1]), before_before_input, std::inserter(before_input, before_input.begin()));
				boost::set_difference(input, *(input_arr[i - 1]), std::inserter(input_i, input_i.begin()));
				boost::set_difference(output, *(output_arr[i - 1]), std::inserter(output_i, output_i.begin()));
			}
			else
			{
				input_i = input;
				output_i = output;
				before_input = before_before_input;
				before_output = before_before_output;
			}
			auto &inst = *it;
			auto *input_inst = new std::unordered_set<string>();
			boost::set_intersection(before_output, input_i, std::inserter(*input_inst, input_inst->begin()));
			inst->input = shared_ptr<std::unordered_set<string>>(input_inst);

			if (in_loop)
			{
				if (output_i.find("__break__") == output_i.end() && output_i.find("__continue__") == output_i.end())
				{
					boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
					boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
					after_input.insert(after_after_input.begin(), after_after_input.end());
					after_output.insert(after_after_output.begin(), after_after_output.end());
					auto *output_inst = new std::unordered_set<string>();
					boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
					inst->output = shared_ptr<std::unordered_set<string>>(output_inst);
				}
				else
				{
					inst->output = shared_ptr<std::unordered_set<string>>(new std::unordered_set<string>(output_i));
					if (output_i.find("__break__") != output_i.end())
					{
						inst->output->insert("__break__");
					}

					if (output_i.find("__continue__") != output_i.end())
					{
						inst->output->insert("__continue__");
					}
				}
			}
			else
			{
				boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
				boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
				after_input.insert(after_after_input.begin(), after_after_input.end());
				after_output.insert(after_after_output.begin(), after_after_output.end());
				auto *output_inst = new std::unordered_set<string>();
				boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
				inst->output = shared_ptr<std::unordered_set<string>>(output_inst);
			}

			if (output_i.find("__return__") != output_i.end())
			{
				inst->output->insert("__return__");
			}

			if (output_i.find("__retval__") != output_i.end())
			{
				inst->output->insert("__retval__");
			}

			// If case and ILoop case
			if (auto f = dynamic_cast<IRLoader::IIf *>(inst.get()))
			{
				// Recompute each branch inputs/outputs
				auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				vec_before->insert(vec_before->end(), before->begin(), before->end());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					auto shared = shared_ptr<Inst>(new Inst(*(it->get())));
					vec_before->push_back(shared);
				}

				auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					vec_after->push_back(shared_ptr<Inst>(new Inst(*(it->get()))));
				}
				vec_after->insert(vec_after->end(), after->begin(), after->end());

				analyze_input_output(f->true_body.get(), vec_before.get(), vec_after.get(), in_loop);
				analyze_input_output(f->false_body.get(), vec_before.get(), vec_after.get(), in_loop);
				std::unordered_set<string> *need_init = new std::unordered_set<string>();
				boost::set_difference(*(inst->output), before_output, std::inserter(*need_init, need_init->begin()));
				f->need_init = std::move(unique_ptr<std::unordered_set<string>>(need_init));
			}
			else if (auto f = dynamic_cast<IRLoader::ILoop *>(inst.get()))
			{
				// compute loop inputs and outputs
				auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				vec_before->insert(vec_before->end(), before->begin(), before->end());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					auto shared = shared_ptr<Inst>(new Inst(*(it->get())));
					vec_before->push_back(shared);
				}

				auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
				for (auto it = insts->begin(); it != insts->end(); it++)
				{
					vec_after->push_back(shared_ptr<Inst>(new Inst(*(it->get()))));
				}
				vec_after->insert(vec_before->end(), after->begin(), after->end());
				analyze_input_output(f->body.get(), vec_before.get(), vec_after.get(), true);
				std::unordered_set<string> in;
				std::unordered_set<string> out;
				get_input_output(f->body.get(), in, out);

				std::unordered_set<string> loop_output;
				boost::set_intersection(out, after_input, std::inserter(loop_output, loop_output.begin()));

				std::unordered_set<string> *loop_args = new std::unordered_set<string>();
				boost::set_intersection(out, after_input, std::inserter(*loop_args, loop_args->begin()));
				f->loop_args = std::move(unique_ptr<std::unordered_set<string>>(loop_args));

				if (output_i.find("__return__") != output_i.end())
				{
					f->loop_args->insert("__return__");
				}

				if (output_i.find("__break__") != output_i.end())
				{
					f->loop_args->insert("__break__");
				}

				if (output_i.find("__retval__") != output_i.end())
				{
					f->loop_args->insert("__retval__");
				}
			}
		}
	}
  

	void analyze_input_output(vector<shared_ptr<Inst>> *insts, vector<shared_ptr<Inst>> *before, vector<shared_ptr<Inst>> *after, bool in_loop)
	{
		auto input_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];
		auto output_arr = new shared_ptr<std::unordered_set<string>>[insts->size()];

		get_input_output(insts, input_arr, output_arr);

		int i = 0;
		for (auto it = insts->begin(); it != insts->end(); ++it, ++i)
		{
			if (std::holds_alternative<CFunction>(*(*it)))
			{
				continue;
			}
			if (std::holds_alternative<IRInst>(*(*it)))
			{
				auto input = *(input_arr[i]);	// input from insts[0..i]
				auto output = *(output_arr[i]); // output from insts[0..i]

				std::unordered_set<string> input_i;
				std::unordered_set<string> output_i;
				std::unordered_set<string> before_output;
				std::unordered_set<string> before_input;
				std::unordered_set<string> after_output;
				std::unordered_set<string> after_input;

				std::unordered_set<string> before_before_input;
				std::unordered_set<string> before_before_output;
				std::unordered_set<string> after_after_input;
				std::unordered_set<string> after_after_output;

				if (before->size() > 0)
				{
					get_input_output(before, before_before_input, before_before_output);
				}

				if (after->size() > 0)
				{
					get_input_output(after, after_after_input, after_after_output);
				}

				if (i >= 1)
				{
					boost::set_union(*(output_arr[i - 1]), before_before_output, std::inserter(before_output, before_output.begin()));
					boost::set_union(*(input_arr[i - 1]), before_before_input, std::inserter(before_input, before_input.begin()));
					boost::set_difference(input, *(input_arr[i - 1]), std::inserter(input_i, input_i.begin()));
					boost::set_difference(output, *(output_arr[i - 1]), std::inserter(output_i, output_i.begin()));
				}
				else
				{
					input_i = input;
					output_i = output;
					before_input = before_before_input;
					before_output = before_before_output;
				}
				auto &inst = std::get<IRInst>(*(*it));
				auto *input_inst = new std::unordered_set<string>();
				boost::set_intersection(before_output, input_i, std::inserter(*input_inst, input_inst->begin()));
				inst.input = shared_ptr<std::unordered_set<string>>(input_inst);

				if (in_loop)
				{
					if (output_i.find("__break__") == output_i.end() && output_i.find("__continue__") == output_i.end())
					{
						boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
						boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
						after_input.insert(after_after_input.begin(), after_after_input.end());
						after_output.insert(after_after_output.begin(), after_after_output.end());
						auto *output_inst = new std::unordered_set<string>();
						boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
						inst.output = shared_ptr<std::unordered_set<string>>(output_inst);
					}
					else
					{
						inst.output = shared_ptr<std::unordered_set<string>>(new std::unordered_set<string>(output_i));
						if (output_i.find("__break__") != output_i.end())
						{
							inst.output->insert("__break__");
						}

						if (output_i.find("__continue__") != output_i.end())
						{
							inst.output->insert("__continue__");
						}
					}
				}
				else
				{
					boost::set_difference(*(input_arr[insts->size() - 1]), *(input_arr[i]), std::inserter(after_input, after_input.begin()));
					boost::set_difference(*(output_arr[insts->size() - 1]), *(output_arr[i]), std::inserter(after_output, after_output.begin()));
					after_input.insert(after_after_input.begin(), after_after_input.end());
					after_output.insert(after_after_output.begin(), after_after_output.end());
					auto *output_inst = new std::unordered_set<string>();
					boost::set_intersection(output_i, after_input, std::inserter(*output_inst, output_inst->begin()));
					inst.output = shared_ptr<std::unordered_set<string>>(output_inst);
				}

				if (output_i.find("__return__") != output_i.end())
				{
					inst.output->insert("__return__");
				}

				if (output_i.find("__retval__") != output_i.end())
				{
					inst.output->insert("__retval__");
				}

				// If case and ILoop case
				if (auto f = dynamic_cast<IRLoader::IIf *>(&inst))
				{
					// Recompute each branch inputs/outputs
					auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_before->insert(vec_before->end(), before->begin(), before->end());
					vec_before->insert(vec_before->end(), insts->begin(), insts->end());

					auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_after->insert(vec_after->end(), insts->begin(), insts->end());
					vec_after->insert(vec_after->end(), after->begin(), after->end());
					analyze_input_output(f->true_body.get(), vec_before.get(), vec_after.get(), in_loop);
					analyze_input_output(f->false_body.get(), vec_before.get(), vec_after.get(), in_loop);

					std::unordered_set<string> *need_init = new std::unordered_set<string>();
					boost::set_difference(*(inst.output), before_output, std::inserter(*need_init, need_init->begin()));
					f->need_init = std::move(unique_ptr<std::unordered_set<string>>(need_init));
				}
				else if (auto f = dynamic_cast<IRLoader::ILoop *>(&inst))
				{
					// compute loop inputs and outputs
					auto vec_before = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_before->insert(vec_before->end(), before->begin(), before->end());
					vec_before->insert(vec_before->end(), insts->begin(), insts->end());

					auto vec_after = shared_ptr<vector<shared_ptr<Inst>>>(new vector<shared_ptr<Inst>>());
					vec_after->insert(vec_after->end(), insts->begin(), insts->end());
					vec_after->insert(vec_before->end(), after->begin(), after->end());
					analyze_input_output(f->body.get(), vec_before.get(), vec_after.get(), true);
					std::unordered_set<string> in;
					std::unordered_set<string> out;
					get_input_output(f->body.get(), in, out);

					std::unordered_set<string> loop_output;
					boost::set_intersection(out, after_input, std::inserter(loop_output, loop_output.begin()));

					std::unordered_set<string> *loop_args = new std::unordered_set<string>();
					boost::set_intersection(out, after_input, std::inserter(*loop_args, loop_args->begin()));
					f->loop_args = std::move(unique_ptr<std::unordered_set<string>>(loop_args));

					if (output_i.find("__return__") != output_i.end())
					{
						f->loop_args->insert("__return__");
					}

					if (output_i.find("__break__") != output_i.end())
					{
						f->loop_args->insert("__break__");
					}

					if (output_i.find("__retval__") != output_i.end())
					{
						f->loop_args->insert("__retval__");
					}
				}
			}
		}
	}
}