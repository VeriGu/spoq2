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

    Op() = default;
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

    IRValue(const IRValue& other) {
        type = other.type;
    }

    virtual IRValue *clone(void) const {
        return new IRValue(*this);
    }

    virtual string to_coq(void) const { return "UNSUPPORTED_VALUE"; };
};

class VNull : public IRValue {
public:
    VNull() = delete;

    VNull(shared_ptr<IRType> type) : IRValue(type) {}

    VNull *clone(void) const override {
        return new VNull(*this);
    }

    string to_coq(void) const override {
        return "VNull";
    }
};

class VUndef : public IRValue {
public:
    VUndef() = delete;

    VUndef(shared_ptr<IRType> type) : IRValue(type) {}

    VUndef *clone(void) const override {
        return new VUndef(*this);
    }

    string to_coq(void) const override {
        if (std::dynamic_pointer_cast<TInt>(type)) {
            return "(VInt 0)";
        } else if (std::dynamic_pointer_cast<TPtr>(type)) {
            return VNull(type).to_coq();
        } else if (std::dynamic_pointer_cast<TBool>(type)) {
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

    VAggZero *clone(void) const override {
        return new VAggZero(*this);
    }

    string to_coq(void) const override {
        return "VAggZero";
    }
};

class _VSymbol : public IRValue {
public:
    string name;

    _VSymbol() = delete;

    _VSymbol(shared_ptr<IRType> type) : IRValue(type) {}

    virtual _VSymbol *clone(void) const override {
        return new _VSymbol(*this);
    }
};

class VGlobal : public _VSymbol {
public:
    VGlobal() = delete;

    VGlobal(shared_ptr<IRType> type, string name) : _VSymbol(type) {
        std::replace(name.begin(), name.end(), '.', '_');
        this->name = name;
    }

    VGlobal *clone(void) const override {
        return new VGlobal(*this);
    }

    string to_coq(void) const override {
        return "(VGlobal \"" + name + "\")";
    }
};

class VLocal : public _VSymbol {
public:
    VLocal() = delete;
    VLocal(shared_ptr<IRType> type, string name);

    VLocal *clone(void) const override {
        return new VLocal(*this);
    }

    string to_coq(void) const override {
        return "(VLocal \"" + name + "\")";
    }
};

class VInt : public IRValue {
public:
    unsigned long val;

    VInt() = delete;

    VInt(shared_ptr<IRType> type, unsigned long val) : IRValue(type) {
        // unsigned long max = 1 << (type->szof() * 8);

        // if (val > max - std::min(256UL, max / 32UL)) {
        //     val = val - max;
        // }

        this->val = val;
    }

    VInt *clone(void) const override {
        return new VInt(*this);
    }

    string to_coq(void) const override {
        return "(VInt (" + std::to_string((signed long)val) + "))";
    }
};

class VBool : public IRValue {
public:
    bool val;

    VBool() = delete;

    VBool(bool val) : IRValue(TBool::TBOOL), val(val) {}

    VBool *clone(void) const override {
        return new VBool(*this);
    }

    string to_coq(void) const override {
        string str = val ? "true" : "false";
        return "(VBool " + str + ")";
    }
};

class VPtr : public IRValue {
public:
    unique_ptr<IRValue> val;

    VPtr() = delete;

    VPtr(shared_ptr<IRType> type, unique_ptr<IRValue> val) : IRValue(type), val(std::move(val)) {}

    VPtr(const VPtr& other) {
        type = other.type;

        if (other.val != nullptr)
            val = unique_ptr<IRValue>(other.val->clone());
        else
            val = nullptr;
    }

    VPtr *clone(void) const override {
        return new VPtr(*this);
    }

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

    // Copy constructor
    VExpr(const VExpr& other) : op(other.op) {
        type = other.type;
        //op = Op(other.op);

        if (other.operands) {
            operands = std::make_unique<vector<unique_ptr<IRValue>>>();
            for (const auto& operand : *other.operands) {
                operands->push_back(std::unique_ptr<IRValue>(operand->clone()));
            }
        } else {
            operands = nullptr;
        }
    }

    VExpr *clone(void) const override {
        return new VExpr(*this);
    }

    string to_coq(void) const override;
};

class VStruct : public IRValue {
public:
    unique_ptr<vector<unique_ptr<IRValue>>> contents;

    VStruct() = delete;
    VStruct(shared_ptr<IRType> type, unique_ptr<vector<unique_ptr<IRValue>>> contents) :
        IRValue(type), contents(std::move(contents)) {}

    // Copy constructor
    VStruct(const VStruct& other) {
        type = other.type;

        if (other.contents) {
            contents = std::make_unique<vector<unique_ptr<IRValue>>>();
            for (const auto& content : *other.contents) {
                contents->push_back(std::unique_ptr<IRValue>(content->clone()));
            }
        } else {
            contents = nullptr;
        }
    }

    VStruct *clone(void) const override {
        return new VStruct(*this);
    }

    string to_coq(void) const override;
};

class VLabel : public IRValue {
public:
    string name;

    VLabel() = delete;
    VLabel(string name) : IRValue(TLabel::TLABEL), name(name) {}

    VLabel *clone(void) const override {
        return new VLabel(*this);
    }

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

    VInlineAsm *clone(void) const override {
        return new VInlineAsm(*this);
    }

    string to_coq(void) const override {
        return "(VLocal \"INLINE_ASM\")";
    }
};

} // namespace autov::IRLoader