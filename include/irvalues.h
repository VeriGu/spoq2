#pragma once

#include <string>
#include <vector>
#include <tuple>
#include <memory>
#include <unordered_map>
#include <map>
#include <algorithm>

#include <coq.h>
#include <irtypes.h>

namespace autov::IRLoader {
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

    string to_coq(void) const {
        return opToString.at(op);
    }
};

class IRValue {
public:
    shared_ptr<IRType> type;

    IRValue() {
        type = make_shared<IRType>();
    }

    virtual string to_coq(void) const { return "UNSUPPORTED_VALUE"; };
};

class VNull : public IRValue {
public:
    VNull() {
        throw std::runtime_error("VNull must have a type.");
    }

    VNull(shared_ptr<IRType> type) {
        this->type = type;
    }

    string to_coq(void) const override {
        return "VNull";
    }
};

class VUndef : public IRValue {
public:
    VUndef() {
        throw std::runtime_error("VUndef must have a type.");
    }

    VUndef(shared_ptr<IRType> type) {
        this->type = type;
    }

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
    VAggZero() {
        throw std::runtime_error("VAggZero must have a type.");
    }

    VAggZero(shared_ptr<IRType> type) {
        this->type = type;
    }

    string to_coq(void) const override {
        return "VAggZero";
    }
};

class VGlobal : public IRValue {
public:
    string name;

    VGlobal() {
        throw std::runtime_error("VGlobal must have a type.");
    }

    VGlobal(shared_ptr<IRType> type, string name) {
        this->type = type;
        std::replace(name.begin(), name.end(), '.', '_');
        this->name = name;
    }

    string to_coq(void) const override {
        return "(VGlobal \"" + name + "\")";
    }
};
} // namespace autov::IRLoader