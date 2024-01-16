#include <string>
#include <irtypes.h>
#include <irvalues.h>


namespace autov::IRLoader {
using std::string;
using std::to_string;
using autov::IRLoader::IRType;
using autov::IRLoader::IRValue;
using autov::IRLoader::Op;
using autov::IRLoader::Ordering;
using autov::IRLoader::TVoid;

class IRInst{
	public:
		virtual string to_coq(void) const { return "UNKNOWN_INSTRUCTION"; }
	
};

class IAlloc:IRInst {
	public:
		string fname;
		shared_ptr<IRType> typ;
		string assign;
		int align;

		IAlloc() = delete;

		IAlloc(string fname, shared_ptr<IRType> typ, string assign, int align) : 
		fname(fname), typ(typ), assign(assign), align(align) {
			
		};

		string to_coq(void) const override {
			return "(IAlloca " + fname + " " + (*typ).to_coq() + " " + to_string(align) + ")";
		}

		IRType get_type() {
			return *typ;
		}
};


class IAtomicRMW : IRInst {
	public:
		shared_ptr<IRType> typ;
		string assign;
		Op op;
		IRValue ptr;
		IRValue val;
		Ordering order;
		int align;

		IAtomicRMW() = delete;

		IAtomicRMW(shared_ptr<IRType> typ, string assign, Op op, IRValue ptr, IRValue val) :
		 typ(typ), op(op), val(val), order(order), align(align) {
			this->assign = to_coq_name(assign);
		 };
		

        string to_coq(void) const override {
			return "(IAtomicRMW " + (*typ).to_coq() + " " + assign + " " + op.to_coq() + " "
			 + ptr.to_coq() + " " + val.to_coq() + " " + order.to_coq() + " " + to_string(align) + ")";
		}
};


class IBinOp : IRInst {
	public:
		shared_ptr<IRType> typ;
		string assign;
		Op op;
		IRValue a;
		IRValue b;
		IBinOp() = delete;
		IBinOp(shared_ptr<IRType> typ, string assign, Op op, IRValue a, IRValue b) :
		typ(typ), op(op), a(a), b(b) {
			this->assign = to_coq_name(assign);
		};

		string to_coq(void) const override {
			return "(IBinOp " + (*typ).to_coq() + " " + assign + " " + 
			op.to_coq() + " " + a.to_coq() + " " + b.to_coq() + ")";
		}
};


class IBranch : IRInst {
	public:
		long lineno;
		IRInst succ;

		IBranch() = delete;
		IBranch(IRInst succ, long lineno = 0) :
			succ(succ), lineno(lineno) {};
		

		string to_coq(void) const override {
			return "(IBranch " + succ.to_coq() + ")";
		}
};


class ICall : public IRInst {
	public:
		long lineno;
		shared_ptr<IRType> typ;
		string assign;
		IRValue func;
		shared_ptr<vector<shared_ptr<IRValue>>> args;

		ICall() = delete;
		ICall(shared_ptr<IRType> typ, string assign, IRValue func, shared_ptr<vector<shared_ptr<IRValue>>> args) :
		  typ(typ), assign(assign), func(func), args(args) {};

		string to_coq() const override {
			if(typeid(*typ) == typeid(TVoid)) {
				return "(ICall " + (*typ).to_coq() + " None " + func.to_coq() + to_coq_value_list(args.get()) + ")";
			} else {
				return "(ICall " + (*typ).to_coq() + " (Some " + assign + ") " + func.to_coq() + to_coq_value_list(args.get()) + ")";
			}
		}
};


class ICmpXchg : IRInst {
	public:
		unique_ptr<IRType> typ;
		string assign;
		IRValue ptr;
		IRValue cmp;
		IRValue val;
		Ordering succ_order;
		Ordering fail_order;
		int align;

		ICmpXchg() = delete;
		ICmpXchg(unique_ptr<IRType> typ, string assign, IRValue ptr, IRValue cmp, IRValue val, Ordering succ_order, Ordering fail_order, int align) :
		typ(std::move(typ)), ptr(ptr), cmp(cmp), succ_order(succ_order), fail_order(fail_order) {
			this->assign = to_coq_name(assign);
		};

		string to_coq() const override {
			return "(ICmpXchg " + (*typ).to_coq() + " " + assign + " " +
			ptr.to_coq() + " " + cmp.to_coq() + " " + val.to_coq() + " " +
			succ_order.to_coq() + " " + fail_order.to_coq() + " " + to_string(align) + ")";
		}
};


class ICondBranch: IRInst {
	public:
		int lineno;
		IRValue cond;
	    IRValue true_succ;
		IRValue false_succ;

		ICondBranch() = delete;
		ICondBranch(IRValue cond, IRValue true_succ, IRValue false_succ) 
		: cond(cond), true_succ(true_succ), false_succ(false_succ)
		{ };

		string to_coq() const override {
			return "(ICondBranch " + cond.to_coq() + " " + true_succ.to_coq() + " " + false_succ.to_coq() + ")";
		}
};


class IExtractElem : IRInst {
	public:
		shared_ptr<IRType> typ;
		string assign;
		IRValue val;
		IRValue index;

		IExtractElem() = delete;
		IExtractElem(shared_ptr<IRType> typ, string assign, IRValue val, IRValue index) : 
		typ(typ), val(val), index(index)
		{
			this->assign = to_coq_name(assign);
		};

		string to_coq() const override {
			return "(IExtractElem " + (*typ).to_coq() + " " + assign + " " + val.to_coq() + " " + index.to_coq() + ")";
		}
};


class IExtractValue : IRInst {
	public:
		shared_ptr<IRType> typ;
		string assign;
		IRValue val;
		vector<shared_ptr<string>> *index;

		IExtractValue() = delete;
		IExtractValue(shared_ptr<IRType> typ, string assign, IRValue val, vector<shared_ptr<string>> *index) : 
		typ(typ), val(val), index(index)
		{
			this->assign = to_coq_name(assign);
		};

		string to_coq() const override {
			return "(IExtractElem " + (*typ).to_coq() + " " + assign + " " + val.to_coq() + " " + to_list(index) + ")";
		}
};


class IFence : IRInst {
	public:
		IFence() = delete;
		IFence(Ordering order) : order(order) {
		};

		Ordering order;
		string to_coq() const override {
			return "(IFence " + order.to_coq() + ")";
		}
};


class IFreeze : IRInst {
	public:
		shared_ptr<IRType> typ;
		string assign;
		IRValue val;

		IFreeze() = delete;
		IFreeze(unique_ptr<IRType> typ, string assign, IRValue val) : 
		 typ(std::move(typ)), assign(to_coq_name(assign)), val(val)
		{
		};

		string to_coq() const override {
			return "(IFreeze " + (*typ).to_coq() + " " + assign + " " + val.to_coq() +  ")";
		}
};


class IGetElemPtr : IRInst {
	public:
		shared_ptr<IRType> typ;
		string assign;
		shared_ptr<IRValue> val;
		shared_ptr<IRValue> index;

		IGetElemPtr() = delete;
		IGetElemPtr(shared_ptr<IRType> typ, string assign, shared_ptr<IRValue> val, shared_ptr<IRValue> index) 
		: typ(typ), assign(to_coq_name(assign)), val(val), index(index)
		{}

		string to_coq() const override {
			return "(IGetElemPtr " + (*typ).to_coq() + " " + assign + " " + (*(*val).type).to_coq() + " " +
			(*val).to_coq() + " " + (*index).to_coq() + ")";
		}
};


class IInsertElem : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	shared_ptr<IRValue> target;
	shared_ptr<IRValue> val;
	shared_ptr<IRValue> idx;

    IInsertElem() = delete;
	IInsertElem(shared_ptr<IRType> typ, string assign, shared_ptr<IRValue> target, shared_ptr<IRValue> val, shared_ptr<IRValue> index) :
	typ(typ), assign(to_coq_name(assign)), target(target), val(val), idx(idx)
	{};

};

class IInsertValue : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	shared_ptr<IRValue> target;
	shared_ptr<IRValue> val;
	shared_ptr<vector<string>> idx;

	IInsertValue() = delete;
	IInsertValue(shared_ptr<IRType> typ, string assign, shared_ptr<IRValue> target, shared_ptr<IRValue> val, shared_ptr<vector<string>> index) :
	typ(typ), assign(to_coq_name(assign)), target(target), val(val), idx(idx)
	{};
};


class ILoad : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	shared_ptr<IRValue> ptr;
	int align;

	ILoad() = delete;
	ILoad(shared_ptr<IRType> typ, string assign, shared_ptr<IRValue> ptr, int align) :
	typ(typ), assign(to_coq_name(assign)), ptr(ptr), align(align) {
	}
};


class IPHI : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	shared_ptr<vector<IRValue>> values;
	shared_ptr<vector<IRInst>> blocks;
};


class IUnaryOp : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	Op op;
	shared_ptr<IRValue> a;
};

class IReturn : IRInst {
	public:
	shared_ptr<IRType> typ;
	shared_ptr<IRValue> val;
};


class ISelect : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	shared_ptr<IRValue> cond;
	shared_ptr<IRValue> t_val;
	shared_ptr<IRValue> f_val;
};

class IShuffleVec : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	shared_ptr<vector<IRValue>> operands;
};

class IStore : IRInst {
	public:
	shared_ptr<IRValue> ptr;
	shared_ptr<IRValue> val;
	int align;
};


class ISwitch : IRInst {
	public:
	shared_ptr<IRValue> cond;
	shared_ptr<IRValue> def;
	unique_ptr<vector<IRValue>> val_list;
	unique_ptr<vector<IRValue>> succ_list;
};


class IUnreachable : IRInst {
	public:
		string to_coq() const override {
			return "IUnreachable";
		}
};

class IAssign : IRInst {
	public:
	shared_ptr<IRType> typ;
	string assign;
	shared_ptr<IRValue> val;

	IAssign() = delete;
	IAssign (shared_ptr<IRType> typ, string assign, shared_ptr<IRValue> val) 
	: typ(typ), assign(to_coq_name(assign)), val(val) {
	}


	string to_coq() const override {
		return "(IAssign " + (*typ).to_coq() + " " + assign + " " + (*val).to_coq() + ")";
	}
};


class IIf : IRInst {
	public:
	shared_ptr<IRValue> cond;
	shared_ptr<vector<shared_ptr<IRInst>>> true_body;
	shared_ptr<vector<shared_ptr<IRInst>>> false_body;
   
    IIf () = delete;

	IIf (shared_ptr<IRValue> cond, shared_ptr<vector<shared_ptr<IRInst>>> t_b, shared_ptr<vector<shared_ptr<IRInst>>> f_b)
	: cond(cond), true_body(t_b), false_body(f_b) {};

	string to_coq() const override {
		string true_block = to_coq_code_block(true_body.get());
		string false_block = to_coq_code_block(false_body.get());
		
		return "(IIf " + (*cond).to_coq() + add_indent(true_block, 5) + "\n" +
		add_indent(false_block, 5) +  ")";
	}
};

class ILoop : IRInst {
	public:
	int lineno;
	shared_ptr<vector<shared_ptr<IRInst>>> body;

	string to_coq() const override {
		string block = to_coq_code_block(body.get());
		return "(ILoop\n" + add_indent(block, 7) + ")";
	}
};

class IContinue : IRInst {
	public:
	string to_coq() const override {
		return "IContinue";
	}
};

class IBreak : IRInst {
	public:

	string to_coq() const override {
		return "IBreak";
	}
};
}