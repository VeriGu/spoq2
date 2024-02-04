#pragma once

#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <stdio.h>
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
    shared_ptr<vector<string>> input;
    shared_ptr<vector<string>> output;
    long lineno = 0;

    virtual string to_coq(void) const { return "UNKNOWN_INSTRUCTION"; }
    virtual IRInst *clone() const { return new IRInst(*this); }
    virtual shared_ptr<IRType> get_type() const { throw std::runtime_error("IRInst: get_type() not implemented"); }
};

class IAlloc : public IRInst {
public:
    string fname;
    shared_ptr<IRType> typ;
    string assign;
    int align;

    IAlloc() = delete;

    IAlloc(string fname, shared_ptr<IRType> typ, string assign, int align);
    IAlloc(const IAlloc &other) : fname(other.fname), typ(other.typ), assign(other.assign), align(other.align) {}

    IAlloc *clone() const override {
        return new IAlloc(*this);
    }

    string to_coq(void) const override {
        return "(IAlloca \"" + fname + "\" " + typ->to_coq() + " \"" + assign + "\" " + to_string(align) + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
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

    IAtomicRMW(const IAtomicRMW &other) :
      typ(other.typ), assign(other.assign), op(other.op), ptr(unique_ptr<IRValue>(other.ptr->clone())),
      val(unique_ptr<IRValue>(other.val->clone())), order(other.order), align(other.align)  {}

    IAtomicRMW *clone() const override {
        return new IAtomicRMW(*this);
    }

    string to_coq(void) const override {
        return "(IAtomicRMW " + typ->to_coq() + " " + assign + " " + op.to_coq() + " "
                + ptr->to_coq() + " " + val->to_coq() + " " + order.to_coq() + " " + to_string(align) + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
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

    IBinOp(const IBinOp &other) :
        typ(other.typ), assign(other.assign), op(other.op),
        a(unique_ptr<IRValue>(other.a->clone())), b(unique_ptr<IRValue>(other.b->clone())) {}

    IBinOp *clone() const override {
        return new IBinOp(*this);
    }

    string to_coq(void) const override {
        return "(IBinOp " + typ->to_coq() + " \"" + assign + "\" " +
                op.to_coq() + " " + a->to_coq() + " " + b->to_coq() + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};

class IBranch : public IRInst {
public:
    unique_ptr<VLabel> succ;

    IBranch() = delete;
    IBranch(unique_ptr<IRValue> succ, long lineno = 0) {
        VLabel *vlabel_ptr = dynamic_cast<VLabel*>(succ.release());
        if (vlabel_ptr) {
            this->succ = unique_ptr<VLabel>(vlabel_ptr);
        } else {
            throw std::runtime_error("IBranch: succ is not a VLabel");
        }

        this->lineno = lineno;
    };
    IBranch(unique_ptr<VLabel> succ, long lineno = 0) : succ(std::move(succ)) {
        this->lineno = lineno;
    };

    IBranch(const IBranch &other) : succ(unique_ptr<VLabel>(other.succ->clone())) {
        lineno = other.lineno;
    }

    IBranch *clone() const override {
        return new IBranch(*this);
    }

    string to_coq(void) const override {
        return "(IBranch " + succ->to_coq() + ")";
    }
};

class ICall : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> func;
    unique_ptr<vector<unique_ptr<IRValue>>> args;

    ICall() = delete;
    ICall(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> func,
          unique_ptr<vector<unique_ptr<IRValue>>> args, long lineno);

    ICall(const ICall &other) :
        typ(other.typ), assign(other.assign), func(unique_ptr<IRValue>(other.func->clone())),
        args(unique_ptr<vector<unique_ptr<IRValue>>>(new vector<unique_ptr<IRValue>>())) {
        for (auto &arg : *other.args) {
            args->push_back(unique_ptr<IRValue>(arg->clone()));
        }
        lineno = other.lineno;
    }

    ICall *clone() const override {
        return new ICall(*this);
    }

    string to_coq() const override;

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
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

    ICmpXchg(const ICmpXchg &other) :
        typ(other.typ), assign(other.assign), ptr(unique_ptr<IRValue>(other.ptr->clone())),
        cmp(unique_ptr<IRValue>(other.cmp->clone())), val(unique_ptr<IRValue>(other.val->clone())),
         succ_order(other.succ_order), fail_order(other.fail_order), align(other.align) {}

    ICmpXchg *clone() const override {
        return new ICmpXchg(*this);
    }

    string to_coq() const override {
        return "(ICmpXchg " + (*typ).to_coq() + " " + assign + " " +
        ptr->to_coq() + " " + cmp->to_coq() + " " + val->to_coq() + " " +
        succ_order.to_coq() + " " + fail_order.to_coq() + " " + to_string(align) + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};

class ICondBranch: public IRInst {
public:
    unique_ptr<IRValue> cond;
    unique_ptr<VLabel> true_succ;
    unique_ptr<VLabel> false_succ;

    ICondBranch() = delete;
    ICondBranch(unique_ptr<IRValue> cond, unique_ptr<IRValue> true_succ, unique_ptr<IRValue> false_succ, int lineno)
    : cond(std::move(cond)) {
        VLabel *true_vlabel_ptr = dynamic_cast<VLabel *>(true_succ.get());
        VLabel *false_vlabel_ptr = dynamic_cast<VLabel *>(false_succ.get());

        if (true_vlabel_ptr && false_vlabel_ptr) {
            this->true_succ = unique_ptr<VLabel>(true_vlabel_ptr);
            this->false_succ = unique_ptr<VLabel>(false_vlabel_ptr);
            true_succ.release();
            false_succ.release();
        } else {
            throw std::runtime_error("ICondBranch: succ is not a VLabel");
        }

        this->lineno = lineno;
    };
    ICondBranch(unique_ptr<IRValue> cond, unique_ptr<VLabel> true_succ, unique_ptr<VLabel> false_succ, int lineno)
    : cond(std::move(cond)), true_succ(std::move(true_succ)), false_succ(std::move(false_succ)) {
        this->lineno = lineno;
    };


    ICondBranch(const ICondBranch &other) :
        cond(unique_ptr<IRValue>(other.cond->clone())),
        true_succ(unique_ptr<VLabel>(other.true_succ->clone())),
        false_succ(unique_ptr<VLabel>(other.false_succ->clone())) {
        lineno = other.lineno;
    }

    ICondBranch *clone() const override {
        return new ICondBranch(*this);
    }

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

    IExtractElem(const IExtractElem &other) :
        typ(other.typ), assign(other.assign), val(unique_ptr<IRValue>(other.val->clone())),
        index(unique_ptr<IRValue>(other.index->clone())) {}

    IExtractElem *clone() const override {
        return new IExtractElem(*this);
    }

    string to_coq() const override {
        return "(IExtractElem " + (*typ).to_coq() + " " + assign + " " + val->to_coq() + " " + index->to_coq() + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
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

    IExtractValue(const IExtractValue &other) :
        typ(other.typ), assign(other.assign), val(unique_ptr<IRValue>(other.val->clone())),
        index(unique_ptr<vector<int>>(new vector<int>(*other.index))) {}

    IExtractValue *clone() const override {
        return new IExtractValue(*this);
    }

    string to_coq() const override;

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};


class IFence : public IRInst {
public:
    Ordering order;

    IFence() = delete;
    IFence(Ordering order) : order(order) {
    };

    IFence(const IFence &other) : order(other.order) {}

    IFence *clone() const override {
        return new IFence(*this);
    }

    string to_coq() const override {
        return "(IFence " + order.to_coq() + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return make_shared<TVoid>();
    }
};

class IFreeze : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> val;

    IFreeze() = delete;
    IFreeze(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val);

    IFreeze(const IFreeze &other) : typ(other.typ), assign(other.assign), val(unique_ptr<IRValue>(other.val->clone())) {}

    IFreeze *clone() const override {
        return new IFreeze(*this);
    }

    string to_coq() const override {
        return "(IFreeze " + typ->to_coq() + " " + assign + " " + val->to_coq() +  ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};


class IGetElemPtr : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> val;
    unique_ptr<vector<unique_ptr<IRValue>>> index;

    IGetElemPtr() = delete;
    IGetElemPtr(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> val, unique_ptr<vector<unique_ptr<IRValue>>> index);

    IGetElemPtr(const IGetElemPtr &other) :
        typ(other.typ), assign(other.assign), val(unique_ptr<IRValue>(other.val->clone())),
        index(unique_ptr<vector<unique_ptr<IRValue>>>(new vector<unique_ptr<IRValue>>())) {
        for (auto &idx : *other.index) {
            index->push_back(unique_ptr<IRValue>(idx->clone()));
        }
    }

    IGetElemPtr *clone() const override {
        return new IGetElemPtr(*this);
    }

    string to_coq() const override;

    shared_ptr<IRType> get_type() const override {
        return typ;
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

    IInsertElem(const IInsertElem &other) :
        typ(other.typ), assign(other.assign), target(unique_ptr<IRValue>(other.target->clone())),
        val(unique_ptr<IRValue>(other.val->clone())), idx(unique_ptr<IRValue>(other.idx->clone())) {}

    IInsertElem *clone() const override {
        return new IInsertElem(*this);
    }

    string to_coq() const override {
        return "(IInsertElem " + typ->to_coq() + " " + assign + " " + target->to_coq() + " " + val->to_coq() + " " + idx->to_coq() + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
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

    IInsertValue(const IInsertValue &other) :
        typ(other.typ), assign(other.assign), target(unique_ptr<IRValue>(other.target->clone())),
        val(unique_ptr<IRValue>(other.val->clone())), idx(unique_ptr<vector<int>>(new vector<int>(*other.idx))) {}

    IInsertValue *clone() const override {
        return new IInsertValue(*this);
    }

    string to_coq() const override;

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};


class ILoad : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<IRValue> ptr;
    int align;

    ILoad() = delete;
    ILoad(shared_ptr<IRType> typ, string assign, unique_ptr<IRValue> ptr, int align);

    ILoad(const ILoad &other) :
        typ(other.typ), assign(other.assign), ptr(unique_ptr<IRValue>(other.ptr->clone())), align(other.align) {}

    ILoad *clone() const override {
        return new ILoad(*this);
    }

    string to_coq() const override {
        return "(ILoad " + typ->to_coq() + " \"" + assign + "\" " + ptr->to_coq() + " " + to_string(align) + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};


class IPHI : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<vector<unique_ptr<IRValue>>> values;
    unique_ptr<vector<unique_ptr<VLabel>>> blocks;

    IPHI() = delete;
    IPHI(shared_ptr<IRType> typ, string assign, unique_ptr<vector<unique_ptr<IRValue>>> values, unique_ptr<vector<unique_ptr<IRValue>>> blocks) :
        typ(typ), assign(assign), values(std::move(values)) {
        this->blocks = unique_ptr<vector<unique_ptr<VLabel>>>(new vector<unique_ptr<VLabel>>());
        for (auto &block : *blocks) {
            VLabel *vlabel_ptr = dynamic_cast<VLabel *>(block.get());
            if (vlabel_ptr) {
                this->blocks->push_back(unique_ptr<VLabel>(vlabel_ptr));
                block.release();
            } else {
                throw std::runtime_error("IPHI: block is not a VLabel");
            }
        }
    };
    IPHI(shared_ptr<IRType> typ, string assign, unique_ptr<vector<unique_ptr<IRValue>>> values, unique_ptr<vector<unique_ptr<VLabel>>> blocks) :
        typ(typ), assign(assign), values(std::move(values)), blocks(std::move(blocks)) {};


    IPHI(const IPHI &other) : typ(other.typ), assign(other.assign),
        values(unique_ptr<vector<unique_ptr<IRValue>>>(new vector<unique_ptr<IRValue>>())),
        blocks(unique_ptr<vector<unique_ptr<VLabel>>>(new vector<unique_ptr<VLabel>>())) {
        for (auto &val : *other.values) {
            values->push_back(unique_ptr<IRValue>(val->clone()));
        }

        for (auto &block : *other.blocks) {
            blocks->push_back(unique_ptr<VLabel>(block->clone()));
        }
    }

    IPHI *clone() const override {
        return new IPHI(*this);
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};


class IUnaryOp : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    Op op;
    unique_ptr<IRValue> a;

    IUnaryOp() = delete;
    IUnaryOp(shared_ptr<IRType> typ, string assign, Op op, unique_ptr<IRValue> a);

    IUnaryOp(const IUnaryOp &other) :
        typ(other.typ), assign(other.assign), op(other.op), a(unique_ptr<IRValue>(other.a->clone())) {}

    IUnaryOp *clone() const override {
        return new IUnaryOp(*this);
    }

    string to_coq() const override {
        return "(IUnaryOp " + typ->to_coq() + " \"" + assign + "\" " + op.to_coq(typ.get()) + " " + a->to_coq() + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};

class IReturn : public IRInst {
public:
    shared_ptr<IRType> typ;
    unique_ptr<IRValue> val;

    IReturn() = delete;
    IReturn(shared_ptr<IRType> typ) : typ(typ), val(nullptr) {};
    IReturn(shared_ptr<IRType> typ, unique_ptr<IRValue> val) : typ(typ), val(std::move(val)) {};

    IReturn(const IReturn &other) : typ(other.typ) {
        if (other.val != nullptr)
            val = unique_ptr<IRValue>(other.val->clone());
        else
            val = nullptr;
    }

    IReturn *clone() const override {
        return new IReturn(*this);
    }

    string to_coq() const override {
        if (val != nullptr)
            return "(IReturn " + typ->to_coq() + " (Some " + val->to_coq() + "))";
        else
            return "(IReturn " + typ->to_coq() + " None)";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
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

    ISelect(const ISelect &other) :
        typ(other.typ), assign(other.assign), cond(unique_ptr<IRValue>(other.cond->clone())),
        true_val(unique_ptr<IRValue>(other.true_val->clone())), false_val(unique_ptr<IRValue>(other.false_val->clone())) {}

    ISelect *clone() const override {
        return new ISelect(*this);
    }

    string to_coq() const override {
        return "(ISelect " + typ->to_coq() + " \"" + assign + "\" " + cond->to_coq() + " " + true_val->to_coq() + " " + false_val->to_coq() + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};


class IShuffleVec : public IRInst {
public:
    shared_ptr<IRType> typ;
    string assign;
    unique_ptr<vector<unique_ptr<IRValue>>> operands;

    IShuffleVec() = delete;
    IShuffleVec(shared_ptr<IRType> typ, string assign, unique_ptr<vector<unique_ptr<IRValue>>>  operands);

    IShuffleVec(const IShuffleVec &other) :
        typ(other.typ), assign(other.assign), operands(unique_ptr<vector<unique_ptr<IRValue>>>(new vector<unique_ptr<IRValue>>())) {
        for (auto &operand : *other.operands) {
            operands->push_back(unique_ptr<IRValue>(operand->clone()));
        }
    }

    IShuffleVec *clone() const override {
        return new IShuffleVec(*this);
    }

    string to_coq() const override;

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};


class IStore : public IRInst {
public:
    unique_ptr<IRValue> ptr;
    unique_ptr<IRValue> val;
    int align;

    IStore() = delete;
    IStore(unique_ptr<IRValue> ptr, unique_ptr<IRValue> val, int align) :
        ptr(std::move(ptr)), val(std::move(val)), align(align) {};

    IStore(const IStore &other) :
        ptr(unique_ptr<IRValue>(other.ptr->clone())), val(unique_ptr<IRValue>(other.val->clone())),
        align(other.align) {}

    IStore *clone() const override {
        return new IStore(*this);
    }

    string to_coq() const override {
        return "(IStore " + val->type->to_coq() + " " + ptr->to_coq() + " " + val->to_coq() + " " + to_string(align) + ")";
    }
};

class ISwitch : public IRInst {
public:
    unique_ptr<IRValue> cond;
    unique_ptr<VLabel> def;
    unique_ptr<vector<unique_ptr<IRValue>>> val_list;
    unique_ptr<vector<unique_ptr<VLabel>>> succ_list;

    ISwitch() = delete;
    ISwitch(unique_ptr<IRValue> cond, unique_ptr<IRValue> def, unique_ptr<vector<unique_ptr<IRValue>>> val_list,
            unique_ptr<vector<unique_ptr<IRValue>>> succ_list) :
        cond(std::move(cond)), val_list(std::move(val_list)) {
        VLabel *vlabel_ptr = dynamic_cast<VLabel *>(def.get());
        if (vlabel_ptr) {
            this->def = unique_ptr<VLabel>(vlabel_ptr);
            def.release();

            this->succ_list = unique_ptr<vector<unique_ptr<VLabel>>>(new vector<unique_ptr<VLabel>>());
            for (auto &succ : *succ_list) {
                VLabel *succ_vlabel_ptr = dynamic_cast<VLabel *>(succ.get());
                if (succ_vlabel_ptr) {
                    this->succ_list->push_back(unique_ptr<VLabel>(succ_vlabel_ptr));
                    succ.release();
                } else {
                    throw std::runtime_error("ISwitch: succ is not a VLabel");
                }
            }
        } else {
            throw std::runtime_error("ISwitch: def is not a VLabel");
        }
    }

    ISwitch(unique_ptr<IRValue> cond, unique_ptr<VLabel> def, unique_ptr<vector<unique_ptr<IRValue>>> val_list,
            unique_ptr<vector<unique_ptr<VLabel>>> succ_list) :
        cond(std::move(cond)), def(std::move(def)), val_list(std::move(val_list)), succ_list(std::move(succ_list)) {};

    ISwitch(const ISwitch &other) :
        cond(unique_ptr<IRValue>(other.cond->clone())), def(unique_ptr<VLabel>(other.def->clone())),
        val_list(unique_ptr<vector<unique_ptr<IRValue>>>(new vector<unique_ptr<IRValue>>())),
        succ_list(unique_ptr<vector<unique_ptr<VLabel>>>(new vector<unique_ptr<VLabel>>())) {
        for (auto &val : *other.val_list) {
            val_list->push_back(unique_ptr<IRValue>(val->clone()));
        }

        for (auto &succ : *other.succ_list) {
            succ_list->push_back(unique_ptr<VLabel>(succ->clone()));
        }
    }

    ISwitch *clone() const override {
        return new ISwitch(*this);
    }
};

class IUnreachable : public IRInst {
public:
    IUnreachable() = default;
    IUnreachable(const IUnreachable &other) = default;

    IUnreachable *clone() const override {
        return new IUnreachable();
    }

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

    IAssign(const IAssign &other) :
        typ(other.typ), assign(other.assign), val(unique_ptr<IRValue>(other.val->clone())) {}

    IAssign *clone() const override {
        return new IAssign(*this);
    }

    string to_coq() const override {
        return "(IAssign " + typ->to_coq() + " \"" + assign + "\" " + val->to_coq() + ")";
    }

    shared_ptr<IRType> get_type() const override {
        return typ;
    }
};

class IIf : public IRInst {
public:
    unique_ptr<IRValue> cond;
    unique_ptr<vector<unique_ptr<IRInst>>> true_body;
    unique_ptr<vector<unique_ptr<IRInst>>> false_body;
	unique_ptr<vector<string>> need_init;

    IIf () = delete;
    IIf (unique_ptr<IRValue> cond, unique_ptr<vector<unique_ptr<IRInst>>> true_body, unique_ptr<vector<unique_ptr<IRInst>>> false_body) :
        cond(std::move(cond)), true_body(std::move(true_body)), false_body(std::move(false_body)) {
    };
    IIf (unique_ptr<IRValue> cond, unique_ptr<IRInst> true_body, unique_ptr<vector<unique_ptr<IRInst>>> false_body) :
        cond(std::move(cond)), false_body(std::move(false_body)) {
        this->true_body = unique_ptr<vector<unique_ptr<IRInst>>>(new vector<unique_ptr<IRInst>>());
        this->true_body->push_back(std::move(true_body));
    };
    IIf (unique_ptr<IRValue> cond, unique_ptr<vector<unique_ptr<IRInst>>> true_body, unique_ptr<IRInst> false_body) :
        cond(std::move(cond)), true_body(std::move(true_body)) {
        this->false_body = unique_ptr<vector<unique_ptr<IRInst>>>(new vector<unique_ptr<IRInst>>());
        this->false_body->push_back(std::move(false_body));
    };
    IIf (unique_ptr<IRValue> cond, unique_ptr<IRInst> true_body, unique_ptr<IRInst> false_body) :
        cond(std::move(cond)) {
        this->true_body = unique_ptr<vector<unique_ptr<IRInst>>>(new vector<unique_ptr<IRInst>>());
        this->false_body = unique_ptr<vector<unique_ptr<IRInst>>>(new vector<unique_ptr<IRInst>>());
        this->true_body->push_back(std::move(true_body));
        this->false_body->push_back(std::move(false_body));
    };

    IIf(const IIf &other) :
        cond(unique_ptr<IRValue>(other.cond->clone())),
        true_body(unique_ptr<vector<unique_ptr<IRInst>>>(new vector<unique_ptr<IRInst>>())),
        false_body(unique_ptr<vector<unique_ptr<IRInst>>>(new vector<unique_ptr<IRInst>>())) {
        for (auto &inst : *other.true_body) {
            true_body->push_back(unique_ptr<IRInst>(inst->clone()));
        }

        for (auto &inst : *other.false_body) {
            false_body->push_back(unique_ptr<IRInst>(inst->clone()));
        }
    }

    IIf *clone() const override {
        return new IIf(*this);
    }

    string to_coq() const override;
};

class ILoop : public IRInst {
public:
    unique_ptr<vector<unique_ptr<IRInst>>> body;

	//analyzed dynamically
	unique_ptr<vector<string>> loop_args;

    ILoop () = delete;
    ILoop (unique_ptr<vector<unique_ptr<IRInst>>> body, long lineno = 0) :
        body(std::move(body)) {
        this->lineno = lineno;
    };

    ILoop(const ILoop &other) :
        body(unique_ptr<vector<unique_ptr<IRInst>>>(new vector<unique_ptr<IRInst>>())) {
        for (auto &inst : *other.body) {
            body->push_back(unique_ptr<IRInst>(inst->clone()));
        }
        lineno = other.lineno;
    }

    ILoop *clone() const override {
        return new ILoop(*this);
    }

    string to_coq() const override;
};


class IContBreak : public IRInst {
public:
    shared_ptr<string> Loop;
    shared_ptr<string> After;
    IContBreak() {
        Loop = make_shared<string>("");
        After = make_shared<string>("");
    }
    //IContBreak(string Loop, string After) : Loop(Loop), After(After) {}
    IContBreak(const IContBreak &other) = delete;

    virtual void update_Loop(string new_loop) = 0;
    virtual void update_After(string new_after) = 0;
};

class IContinue : public IContBreak {
public:
    IContinue() : IContBreak() {}
    IContinue(IContinue &other) {
        Loop = other.Loop;
        After = other.After;
    }

    IContinue *clone() const override {
        auto ret = new IContinue();

        ret->Loop = Loop;
        ret->After = After;
        return ret;
    }

    string to_coq() const override {
        return "IContinue";
    }

    void update_Loop(string new_loop) override {
        *Loop = new_loop;
    }

    void update_After(string new_loop) override {
        *After = new_loop;
    }
};

class IBreak : public IContBreak {
public:
    IBreak() : IContBreak() {}
    IBreak(IBreak &other) {
        Loop = other.Loop;
        After = other.After;
    }

    IBreak *clone() const override {
        auto ret = new IBreak();

        ret->Loop = Loop;
        ret->After = After;
        return ret;
    }

    string to_coq() const override {
        return "IBreak";
    }

    void update_Loop(string new_loop) override {
        *Loop = new_loop;
    }

    void update_After(string new_after) override {
        *After = new_after;
    }
};

}