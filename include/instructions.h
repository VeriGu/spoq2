#pragma once

#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <unordered_set>

namespace autov::IRLoader {
using std::string;
using std::to_string;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;

using autov::IRLoader::IRType;
using autov::IRLoader::IRValue;
using autov::IRLoader::Op;
using autov::IRLoader::Ordering;
using autov::IRLoader::TVoid;

class IRInst{
public:
	unique_ptr<vector<std::unordered_set<shared_ptr<string>>>> input;
	unique_ptr<vector<std::unordered_set<shared_ptr<string>>>> output;
    virtual string to_coq(void) const { return "UNKNOWN_INSTRUCTION"; }
};

class IAlloc : public IRInst {
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
        return "(IAlloca " + fname + " " + typ->to_coq() + " " + to_string(align) + ")";
    }

    IRType get_type() {
        return *typ;
    }
};


class IAtomicRMW : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    Op op;
    unique_ptr<IRValue> ptr;
    unique_ptr<IRValue> val;
    Ordering order;
    int align;

    IAtomicRMW() = delete;

    IAtomicRMW(shared_ptr<IRType> typ, string assign, Op op, unique_ptr<IRValue> ptr,
               unique_ptr<IRValue> val, Ordering order, int align);

    string to_coq(void) const override {
        return "(IAtomicRMW " + typ->to_coq() + " " + assign + " " + op.to_coq() + " "
                + ptr->to_coq() + " " + val->to_coq() + " " + order.to_coq() + " " + to_string(align) + ")";
    }
};

class IBinOp : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    Op op;
    unique_ptr<IRValue> a;
    unique_ptr<IRValue> b;

    IBinOp() = delete;
    IBinOp(shared_ptr<IRType> typ, string assign, Op op, unique_ptr<IRValue> a, unique_ptr<IRValue> b);

    string to_coq(void) const override {
        return "(IBinOp " + typ->to_coq() + " " + assign + " " +
                op.to_coq() + " " + a->to_coq() + " " + b->to_coq() + ")";
    }
};

class IBranch : public IRInst {
public:
    long lineno;
    unique_ptr<IRInst> succ;

    IBranch() = delete;
    IBranch(unique_ptr<IRInst> succ, long lineno = 0) :
    succ(std::move(succ)), lineno(lineno) {};

    string to_coq(void) const override {
        return "(IBranch " + succ->to_coq() + ")";
    }
};

class ICall : public IRInst {
public:
    long lineno;
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> func;
    unique_ptr<vector<unique_ptr<IRValue>>> args;

    ICall() = delete;
    ICall(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> func,
          unique_ptr<vector<unique_ptr<IRValue>>> args, long lineno);

    string to_coq() const override;
};

class ICmpXchg : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> ptr;
    unique_ptr<IRValue> cmp;
    unique_ptr<IRValue> val;
    Ordering succ_order;
    Ordering fail_order;
    int align;

    ICmpXchg() = delete;
    ICmpXchg(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> ptr, unique_ptr<IRValue> cmp,
                   unique_ptr<IRValue> val, Ordering succ_order, Ordering fail_order, int align);

    string to_coq() const override {
        return "(ICmpXchg " + (*typ).to_coq() + " " + assign + " " +
        ptr->to_coq() + " " + cmp->to_coq() + " " + val->to_coq() + " " +
        succ_order.to_coq() + " " + fail_order.to_coq() + " " + to_string(align) + ")";
    }
};

class ICondBranch: public IRInst {
public:
    int lineno;
    unique_ptr<IRValue> cond;
    unique_ptr<IRValue> true_succ;
    unique_ptr<IRValue> false_succ;

    ICondBranch() = delete;
    ICondBranch(unique_ptr<IRValue> cond, unique_ptr<IRValue> true_succ, unique_ptr<IRValue> false_succ)
    : cond(std::move(cond)), true_succ(std::move(true_succ)), false_succ(std::move(false_succ)) {};

    string to_coq() const override {
        return "(ICondBranch " + (*cond).to_coq() + " " + (*true_succ).to_coq() + " " + false_succ->to_coq() + ")";
    }
};

class IExtractElem : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> val;
    unique_ptr<IRValue> index;

    IExtractElem() = delete;
    IExtractElem(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val, unique_ptr<IRValue> index);

    string to_coq() const override {
        return "(IExtractElem " + (*typ).to_coq() + " " + assign + " " + val->to_coq() + " " + index->to_coq() + ")";
    }
};

class IExtractValue : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> val;
    unique_ptr<vector<int>> index;

    IExtractValue() = delete;
    IExtractValue(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val, unique_ptr<vector<int>> index);

    string to_coq() const override;
};


class IFence : public IRInst {
public:
    IFence() = delete;
    IFence(Ordering order) : order(order) {
    };

    Ordering order;
    string to_coq() const override {
        return "(IFence " + order.to_coq() + ")";
    }
};

class IFreeze : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> val;

    IFreeze() = delete;
    IFreeze(unique_ptr<IRType> typ, string assign, unique_ptr<IRValue> val);

    string to_coq() const override {
        return "(IFreeze " + typ->to_coq() + " " + assign + " " + val->to_coq() +  ")";
    }
};


class IGetElemPtr : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> val;
    unique_ptr<IRValue> index;

    IGetElemPtr() = delete;
    IGetElemPtr(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val, unique_ptr<IRValue> index);

    string to_coq() const override {
        return "(IGetElemPtr " + typ->to_coq() + " " + assign + " " + val->type->to_coq() + " " +
                val->to_coq() + " " + index->to_coq() + ")";
    }
};

class IInsertElem : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> target;
    unique_ptr<IRValue> val;
    unique_ptr<IRValue> idx;

    IInsertElem() = delete;
    IInsertElem(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> target, unique_ptr<IRValue> val, unique_ptr<IRValue> idx);

    string to_coq() const override {
        return "(IInsertElem " + typ->to_coq() + " " + assign + " " + target->to_coq() + " " + val->to_coq() + " " + idx->to_coq() + ")";
    }
};


class IInsertValue : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> target;
    unique_ptr<IRValue> val;
    unique_ptr<vector<int>> idx;

    IInsertValue() = delete;
    IInsertValue(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> target, unique_ptr<IRValue> val, unique_ptr<vector<int>> idx);

    string to_coq() const override;
};


class ILoad : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> ptr;
    int align;

    ILoad() = delete;
    ILoad(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> ptr, int align);

    string to_coq() const override {
        return "(ILoad " + typ->to_coq() + " " + assign + " " + ptr->to_coq() + " " + to_string(align) + ")";
    }
};

#if 0
class IPHI : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    shared_ptr<vector<IRValue>> values;
    shared_ptr<vector<IRInst>> blocks;
};
#endif

class IUnaryOp : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    Op op;
    unique_ptr<IRValue> a;

    IUnaryOp() = delete;
    IUnaryOp(shared_ptr<IRType> typ, string assign, Op op, unique_ptr<IRValue> a);

    string to_coq() const override {
        return "(IUnaryOp " + typ->to_coq() + " " + assign + " " + op.to_coq() + " " + a->to_coq() + ")";
    }
};

class IReturn : public IRInst {
public:
    shared_ptr<IRType> typ;
    unique_ptr<IRValue> val;

    IReturn() = delete;
    IReturn(shared_ptr<IRType> typ, unique_ptr<IRValue> val) : typ(typ), val(std::move(val)) {};

    string to_coq() const override {
        if (val != nullptr)
            return "(IReturn " + typ->to_coq() + " (Some " + val->to_coq() + "))";
        else
            return "(IReturn " + typ->to_coq() + "  None)";
    }
};

class ISelect : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> cond;
    unique_ptr<IRValue> true_val;
    unique_ptr<IRValue> false_val;

    ISelect() = delete;
    ISelect(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> cond, unique_ptr<IRValue> true_val, unique_ptr<IRValue> false_val);

    string to_coq() const override {
        return "(ISelect " + typ->to_coq() + " " + assign + " " + cond->to_coq() + " " + true_val->to_coq() + " " + false_val->to_coq() + ")";
    }
};


class IShuffleVec : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<vector<unique_ptr<IRValue>>> operands;

    IShuffleVec() = delete;
    IShuffleVec(shared_ptr<IRType> typ, string assign, unique_ptr<vector<unique_ptr<IRValue>>>  operands);

    string to_coq() const override;
};


class IStore : public IRInst {
public:
    unique_ptr<IRValue> ptr;
    unique_ptr<IRValue> val;
    int align;

    IStore() = delete;
    IStore(unique_ptr<IRValue> ptr, unique_ptr<IRValue> val, int align) :
        ptr(std::move(ptr)), val(std::move(val)), align(align) {};

    string to_coq() const override {
        return "(IStore " + ptr->to_coq() + " " + val->to_coq() + " " + to_string(align) + ")";
    }
};


#if 0
class ISwitch : public IRInst {
public:
    unique_ptr<IRValue> cond;
    unique_ptr<IRValue> def;
    unique_ptr<vector<IRValue>> val_list;
    unique_ptr<vector<IRValue>> succ_list;

    ISwitch() = delete;
    ISwitch(unique_ptr<IRValue> cond, unique_ptr<IRValue> def, unique_ptr<vector<IRValue>> val_list, unique_ptr<vector<IRValue>> succ_list) :
        cond(std::move(cond)), def(std::move(def)), val_list(std::move(val_list)), succ_list(std::move(succ_list)) {};
};
#endif

class IUnreachable : public IRInst {
public:
    string to_coq() const override {
        return "IUnreachable";
    }
};


class IAssign : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> val;

    IAssign() = delete;
    IAssign (shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val);

    string to_coq() const override {
        return "(IAssign " + typ->to_coq() + " " + assign + " " + val->to_coq() + ")";
    }
};

class IIf : public IRInst {
public:
    unique_ptr<IRValue> cond;
    unique_ptr<vector<unique_ptr<IRInst>>> true_body;
    unique_ptr<vector<unique_ptr<IRInst>>> false_body;

    IIf () = delete;
    IIf (unique_ptr<IRValue> cond, unique_ptr<vector<unique_ptr<IRInst>>> true_body, unique_ptr<vector<unique_ptr<IRInst>>> false_body) :
        cond(std::move(cond)), true_body(std::move(true_body)), false_body(std::move(false_body)) {};

    string to_coq() const override;
};

class ILoop : public IRInst {
public:
    int lineno;
    unique_ptr<vector<unique_ptr<IRInst>>> body;

    ILoop () = delete;
    ILoop (unique_ptr<vector<unique_ptr<IRInst>>> body, int lineno = 0) :
        body(std::move(body)), lineno(lineno) {};

    string to_coq() const override;
};


class IContinue : public IRInst {
public:
    string to_coq() const override {
    return "IContinue";
    }
};

class IBreak : public IRInst {
public:
    string to_coq() const override {
        return "IBreak";
    }
};

}