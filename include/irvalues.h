#pragma once

#include <string>
#include <vector>
#include <tuple>
#include <memory>
#include <unordered_map>
#include <map>
#include <algorithm>
#include <set>

#include <irtypes.h>

namespace autov::IRLoader {
using std::string;

// Op is small enough to be passed by value instead of constructing a unique_ptr
class Op {
public:
    enum _Op {
        // Cmp Op
        Cslt,
        Csle,
        Cult,
        Cule,
        Ceq,
        Cne,
        Csgt,
        Csge,
        Cugt,
        Cuge,
        // Binary Op
        OAdd,
        OAnd,
        OAshr,
        OFadd,
        OFdiv,
        OFmul,
        OFsub,
        OLshr,
        OMul,
        OOr,
        OSdiv,
        OSrem,
        OShl,
        OSub,
        OUdiv,
        OUrem,
        OXor,
        OBitCast,
        OFPExt,
        OFPToSI,
        OFPToUI,
        OFPTrunc,
        OFneg,
        OIntToPtr,
        OPtrToInt,
        OSExt,
        OSIToFP,
        OTrunc,
        OUIToFP,
        OZExt,
        OGetElementPtr,
        OXchg,
        OSelect,
    };

    const static std::unordered_map<_Op, std::string> opToString;

    _Op op;

    Op(_Op op): op(op) {}

    bool operator==(const Op& other) const {
        return op == other.op;
    }

    string to_coq(IRType *ty = nullptr) const {
        static const std::set<_Op> typed_op = {
            OBitCast,
            OFPExt,
            OFPToSI,
            OFPToUI,
            OFPTrunc,
            OIntToPtr,
            OSExt,
            OSIToFP,
            OTrunc,
            OUIToFP,
            OZExt,
            OGetElementPtr,
        };

        if (typed_op.find(op) != typed_op.end()) {
            if (ty == nullptr) {
                throw std::runtime_error("Typed op requires type");
            }
            return "(" + opToString.at(op) + " " + ty->to_coq() + ")";
        }

        return opToString.at(op);
    }
};

class IRValue {
public:
    shared_ptr<IRType> type;

    IRValue() {
        type = make_shared<IRType>();
    }

    IRValue(shared_ptr<IRType> type) : type(type) {}

    virtual string to_coq(void) const { return "UNSUPPORTED_VALUE"; };
};

class VNull : public IRValue {
public:
    VNull() = delete;

    VNull(shared_ptr<IRType> type) : IRValue(type) {}

    string to_coq(void) const override {
        return "VNull";
    }
};

class VUndef : public IRValue {
public:
    VUndef() = delete;

    VUndef(shared_ptr<IRType> type) : IRValue(type) {}

    string to_coq(void) const override {
        if (typeid(type.get()) == typeid(TInt *)) {
            return "(VInt 0)";
        } else if (typeid(type.get()) == typeid(TPtr *)) {
            return VNull(type).to_coq();
        } else if (typeid(type.get()) == typeid(TBool *)) {
            return "(VBool false)";
        } else {
            return "VUndef";
        }
    }
};

class VAggZero : public IRValue {
public:
    VAggZero() = delete;

    VAggZero(shared_ptr<IRType> type) : IRValue(type) {}

    string to_coq(void) const override {
        return "VAggZero";
    }
};

class VGlobal : public IRValue {
public:
    string name;

    VGlobal() = delete;

    VGlobal(shared_ptr<IRType> type, string name) : IRValue(type) {
        std::replace(name.begin(), name.end(), '.', '_');
        this->name = name;
    }

    string to_coq(void) const override {
        return "(VGlobal \"" + name + "\")";
    }
};

class VLocal : public IRValue {
public:
    string name;

    VLocal() = delete;
    VLocal(shared_ptr<IRType> type, string name);

    string to_coq(void) const override {
        return "(VLocal \"" + name + "\")";
    }
};

class VInt : public IRValue {
public:
    unsigned long val;

    VInt() = delete;

    VInt(shared_ptr<IRType> type, unsigned long val) : IRValue(type) {
        unsigned long max = 1 << (type->szof() * 8);

        if (val > max - std::min(256UL, max / 32UL)) {
            val = val - max;
        }

        this->val = val;
    }

    string to_coq(void) const override {
        return "(VInt " + std::to_string(val) + ")";
    }
};

class VBool : public IRValue {
public:
    bool val;

    VBool() = delete;

    VBool(bool val) : IRValue(TBool::TBOOL), val(val) {}

    string to_coq(void) const override {
        return "(VBool " + std::to_string(val) + ")";
    }
};

class VPtr : public IRValue {
public:
    unique_ptr<IRValue> val;

    VPtr() = delete;

    VPtr(shared_ptr<IRType> type, unique_ptr<IRValue> val) : IRValue(type), val(std::move(val)) {}

    string to_coq(void) const override {
        return "(VPtr " + val->to_coq() + ")";
    }
};

class VExpr : public IRValue {
public:
    Op op;
    unique_ptr<vector<unique_ptr<IRValue>>> operands;

    VExpr() = delete;
    VExpr(shared_ptr<IRType> type, Op op, unique_ptr<vector<unique_ptr<IRValue>>> operands) :
        IRValue(type), op(op), operands(std::move(operands)) {}

    string to_coq(void) const override;
};

class VStruct : public IRValue {
public:
    unique_ptr<vector<unique_ptr<IRValue>>> contens;

    VStruct() = delete;
    VStruct(shared_ptr<IRType> type, unique_ptr<vector<unique_ptr<IRValue>>> contens) :
        IRValue(type), contens(std::move(contens)) {}

    string to_coq(void) const override;
};

class VLabel : public IRValue {
public:
    string name;

    VLabel() = delete;
    VLabel(string name) : IRValue(TLabel::TLABEL), name(name) {}

    string to_coq(void) const override {
        return "(VLabel \"" + name + "\")";
    }
};

class VInlineAsm : public IRValue {
public:
    string asm_string;
    bool side_effects;
    string constraints;

    VInlineAsm() = delete;
    VInlineAsm(shared_ptr<IRType> type, string asm_string, bool side_effects, string constraints) :
        IRValue(type), asm_string(asm_string), side_effects(side_effects), constraints(constraints) {}

    string to_coq(void) const override {
        return "(VLocal \"VInlineAsm\")";
    }
};

} // namespace autov::IRLoader