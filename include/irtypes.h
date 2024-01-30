#pragma once
#include <string>
#include <tuple>
#include <vector>
#include <typeinfo>
#include <stdexcept>
#include <memory>
#include <map>
#include <unordered_map>
#include <algorithm>

namespace autov::IRLoader {
using std::string;
using std::tuple;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

using coq_sz_t = unsigned long;

class IRType {
public:
    IRType () = default;

    virtual string to_coq(void) const { return "UNKNOWN_TYPE"; }
    virtual coq_sz_t szof(void) const { return 0; }
    virtual tuple<coq_sz_t, coq_sz_t> szof_verbose(void) const { return {0, 0}; }
    virtual bool operator==(const IRType &other) const {
        if (typeid(*this) != typeid(other))
            return false;
        return this->to_coq() == other.to_coq();
    }
    virtual string get_name() const { return ""; }
};

class IntType: public IRType {
public:
    enum _IntType {
        TI8 = 0,
        TI16,
        TI32,
        TI64,
        TI128,
    };

    _IntType type;

    IntType() = default;
    IntType(_IntType type) : type(type) {};

    string to_coq(void) const override {
        switch (type) {
        case TI8:
            return "TI8";
        case TI16:
            return "TI16";
        case TI32:
            return "TI32";
        case TI64:
            return "TI64";
        case TI128:
            return "TI128";
        default:
            throw std::runtime_error("Unknown IntType");
        }
    }

    coq_sz_t szof(void) const override {
        return 1 << type;
    }
};

class Ordering: public IRType {
    public:
    enum _Ordering {
        NotAtomic = 0,
        Unordered,
        Monotonic,
        Acquire,
        Release,
        AcquireRelease,
        SequentiallyConsistent,
    };

    _Ordering ordering;

    Ordering() = delete;
    Ordering(_Ordering ordering) : ordering(ordering) {};

    string to_coq(void) const override {
        string ret = "Od";
        switch (ordering) {
        case NotAtomic:
            ret += "NotAtomic";
            break;
        case Unordered:
            ret += "Unordered";
            break;
        case Monotonic:
            ret += "Monotonic";
            break;
        case Acquire:
            ret += "Acquire";
            break;
        case Release:
            ret += "Release";
            break;
        case AcquireRelease:
            ret += "AcquireRelease";
            break;
        case SequentiallyConsistent:
            ret += "SequentiallyConsistent";
            break;
        default:
            throw std::runtime_error("Unknown Ordering");
        }

        return ret;
    }
};

class TBool : public IRType {
public:
    static shared_ptr<TBool> TBOOL;
    IntType type;

    TBool() {
        type.type = IntType::TI8;
    }

    string to_coq(void) const override {
        return "TBool";
    }

    coq_sz_t szof(void) const override {
        return type.szof();
    }
};

class TInt : public IRType {
public:
    static shared_ptr<TInt> TI8;
    static shared_ptr<TInt> TI16;
    static shared_ptr<TInt> TI32;
    static shared_ptr<TInt> TI64;
    static shared_ptr<TInt> TI128;

    IntType type;

    TInt() = delete;

    TInt(IntType type) : type(type) {};
    TInt(IntType:: _IntType type) : type(type) {};

    string to_coq(void) const override {
        return "(TInt " + type.to_coq() + ")";
    }

    coq_sz_t szof(void) const override {
        return type.szof();
    }
};

class TVoid : public IRType {
public:
    static shared_ptr<TVoid> TVOID;

    string to_coq(void) const override {
        return "TVoid";
    }

    coq_sz_t szof(void) const override {
        return 0;
    }
};

class TLabel : public IRType {
public:
    static shared_ptr<TLabel> TLABEL;

    string to_coq(void) const override {
        return "TLabel";
    }

    coq_sz_t szof(void) const override {
        return 0;
    }
};

class TFunction : public IRType {
public:
    unique_ptr<vector<shared_ptr<IRType>>> arglist;
    shared_ptr<IRType> rettype;

    TFunction() {
        throw std::runtime_error("TFunction must have an arglist and a return type.");
    }

    TFunction(unique_ptr<vector<shared_ptr<IRType>>> arglist, shared_ptr<IRType> ret) :
        arglist(std::move(arglist)), rettype(ret) {};

    string to_coq(void) const override;

    coq_sz_t szof(void) const override {
        return 0;
    }
};

class TPtr: public IRType {
public:
    shared_ptr<IRType> subtype;

    TPtr() {
        throw std::runtime_error("TPtr must have a type.");
    }

    TPtr(shared_ptr<IRType> type) : subtype(type) {};

    string to_coq(void) const override {
        return "(TPtr " + subtype->to_coq() + ")";
    }

    coq_sz_t szof(void) const override {
        return 8;
    }
};

class TNamedStruct: public IRType {
public:
    string name;
    unordered_map<string, shared_ptr<IRType>> *structs;

    TNamedStruct() {
        throw std::runtime_error("TNamedStruct must have a name and the constructor.");
    }

    TNamedStruct(string name, unordered_map<string, shared_ptr<IRType>> *structs) :
        name(name), structs(structs) {};

    string to_coq(void) const override {
        return "(TNamedStruct \"" + name + "\" " + std::to_string(this->szof()) + ")";
    }

    coq_sz_t szof(void) const override {
        string name = this->name;

        std::replace(name.begin(), name.end(), '.', '!');
        return structs->at(name)->szof();
    }

    string get_name() const override {
        return name;
    }
};

class TStructElem {
public:
    string name;
    shared_ptr<IRType> type;
    coq_sz_t offset;
    bool is_decl = false;

    TStructElem() {
        throw std::runtime_error("TStructElem must have a name, a type and an offset.");
    }

    TStructElem(shared_ptr<IRType> type) : name(""), type(type), offset(0) {}

    TStructElem(string name, shared_ptr<IRType> type, coq_sz_t offset) :
        name(name), type(type), offset(offset) {}

    TStructElem(string name, shared_ptr<IRType> type, coq_sz_t offset, bool is_decl) :
        name(name), type(type), offset(offset), is_decl(is_decl) {}

    string to_coq(void) const {

        if (is_decl)
            return "(TElem \"" + name + "\" " + type->to_coq() + " " + std::to_string(offset) + ")";

        return type->to_coq();
    }
};

class TStruct : public IRType {
public:
    unique_ptr<vector<shared_ptr<TStructElem>>> elems;
    coq_sz_t size;

    TStruct() {
        throw std::runtime_error("TStruct must have a list of elements and a size.");
    }

    TStruct(unique_ptr<vector<shared_ptr<TStructElem>>> elems, coq_sz_t size) :
        elems(std::move(elems)), size(size) {};

    string to_coq(void) const override;

    coq_sz_t szof(void) const override {
        return size;
    }
};

class TArray : public IRType {
public:
    shared_ptr<IRType> subtype;
    coq_sz_t length;

    TArray() {
        throw std::runtime_error("TArray must have an element type and a size.");
    }

    TArray(shared_ptr<IRType> elem_type, coq_sz_t size) :
        subtype(elem_type), length(size) {};

    string to_coq(void) const override {
        return "(TArray " + subtype->to_coq() + " " + std::to_string(length) + ")";
    }

    coq_sz_t szof(void) const override {
        return subtype->szof() * length;
    }

    tuple<coq_sz_t, coq_sz_t> szof_verbose(void) const override {
        return {subtype->szof(), length};
    }
};

class TFixedVector : public TArray {
public:
    TFixedVector() {
        throw std::runtime_error("TFixVector must have an element type and a size.");
    }

    TFixedVector(shared_ptr<IRType> elem_type, coq_sz_t size) :
        TArray(elem_type, size) {};

    string to_coq(void) const override {
        return "(TFixVector " + subtype->to_coq() + " " + std::to_string(length) + ")";
    }
};

class TScaleVector : public IRType {
public:
    shared_ptr<IRType> subtype;

    TScaleVector() {
        throw std::runtime_error("TScaleVector must have an element type and a size.");
    }

    TScaleVector(shared_ptr<IRType> elem_type) :
        subtype(elem_type) {};

    string to_coq(void) const override {
        return "(TScaleVector " + subtype->to_coq() + ")";
    }

    coq_sz_t szof(void) const override {
        return 0;
    }
};

} // namespace autov::IRLoader