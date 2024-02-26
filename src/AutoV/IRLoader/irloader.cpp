#include <irloader.h>
#include <control_flow.h>
#include <post_process.h>
#include <set>
#include <cassert>
#include <variant>
#include <map>
#include <iterator>

#include <fstream>
#include <iostream>

namespace autov::IRLoader
{
using boost::property_tree::ptree;
using std::string;
using std::variant;
using std::map;

map<string, shared_ptr<IRType>> structs_info;

static unsigned long size_of_unnamed_struct(const vector<shared_ptr<IRType>> &st) {
    unsigned long ofs = 0;
    unsigned long default_align = 8;
    unsigned long sz = 0;

    for (const auto &elem : st) {
        unsigned long padding = default_align - (ofs % default_align);

        if (dynamic_cast<TInt *>(elem.get()) != nullptr ||
            dynamic_cast<TBool *>(elem.get()) != nullptr ||
            dynamic_cast<TPtr *>(elem.get()) != nullptr) {
                if (ofs % default_align != 0) {
                    ofs += padding;
                    sz += padding + elem->szof();
                } else {
                    ofs += elem->szof();
                    sz += elem->szof();
                }
        } else
            return 0;
    }

    if (sz % default_align != 0)
        sz += default_align - (sz % default_align);

    return sz;
}

static shared_ptr<IRType> parse_type(const ptree &typ) {
    static const map<string, shared_ptr<IRType>> irtype_map = {
        {"i1", TBool::TBOOL},
        {"i8", TInt::TI8},
        {"i16", TInt::TI16},
        {"i32", TInt::TI32},
        {"i64", TInt::TI64},
        {"i128", TInt::TI128},
        {"void", TVoid::TVOID},
        {"label", TLabel::TLABEL},
    };
    string type = typ.get<string>("type");

    if (irtype_map.find(type) != irtype_map.end()) {
        return irtype_map.at(type);
    } else if (type == "function") {
        auto rettype = parse_type(typ.get_child("return"));
        auto arglist = make_unique<vector<shared_ptr<IRType>>>();

        for (const auto &arg : typ.get_child("arguments")) {
            arglist->push_back(parse_type(arg.second));
        }

        return make_shared<TFunction>(std::move(arglist), rettype);
    } else if (type == "pointer") {
        auto subtype = parse_type(typ.get_child("subtype"));

        return make_shared<TPtr>(subtype);
    } else if (type == "named_struct") {
        string struct_name = typ.get<string>("name");

        return make_shared<TNamedStruct>(struct_name, &structs_info);
    } else if (type == "unnamed_struct") {
        auto elems = make_unique<vector<shared_ptr<TStructElem>>>();
        auto elem_types = vector<shared_ptr<IRType>>();

        for (const auto &elem : typ.get_child("struct")) {
            auto elem_type = parse_type(elem.second);

            elems->push_back(make_shared<TStructElem>(elem_type));
            elem_types.push_back(elem_type);
        }

        return make_shared<TStruct>(std::move(elems), size_of_unnamed_struct(elem_types));
    } else if (type == "array") {
        auto subtype = parse_type(typ.get_child("subtype"));
        auto size = typ.get<coq_sz_t>("length");

        return make_shared<TArray>(subtype, size);
    } else if (type == "fixedvector") {
        auto subtype = parse_type(typ.get_child("subtype"));
        auto length = typ.get<coq_sz_t>("length");

        return make_shared<TFixedVector>(subtype, length);
    } else if (type == "scalevector") {
        auto subtype = parse_type(typ.get_child("subtype"));

        return make_shared<TScaleVector>(subtype);
    } else {
        return make_shared<IRType>();
    }
}

static Op parse_op(const string &op) {
    static const map<string, Op::_Op> op_map = {
        {"slt", Op::Cslt},
        {"sle", Op::Csle},
        {"ult", Op::Cult},
        {"ule", Op::Cule},
        {"eq", Op::Ceq},
        {"ne", Op::Cne},
        {"sgt", Op::Csgt},
        {"sge", Op::Csge},
        {"ugt", Op::Cugt},
        {"uge", Op::Cuge},
        {"add", Op::OAdd},
        {"and", Op::OAnd},
        {"ashr", Op::OAshr},
        {"fadd", Op::OFadd},
        {"fdiv", Op::OFdiv},
        {"fmul", Op::OFmul},
        {"fsub", Op::OFsub},
        {"lshr", Op::OLshr},
        {"mul", Op::OMul},
        {"or", Op::OOr},
        {"sdiv", Op::OSdiv},
        {"srem", Op::OSrem},
        {"shl", Op::OShl},
        {"sub", Op::OSub},
        {"udiv", Op::OUdiv},
        {"urem", Op::OUrem},
        {"xor", Op::OXor},
        {"bitcast", Op::OBitCast},
        {"fpext", Op::OFPExt},
        {"fptosi", Op::OFPToSI},
        {"fptoui", Op::OFPToUI},
        {"fptrunc", Op::OFPTrunc},
        {"fneg", Op::OFneg},
        {"inttoptr", Op::OIntToPtr},
        {"ptrtoint", Op::OPtrToInt},
        {"sext", Op::OSExt},
        {"sitofp", Op::OSIToFP},
        {"trunc", Op::OTrunc},
        {"uitofp", Op::OUIToFP},
        {"zext", Op::OZExt},
        {"getelementptr", Op::OGetElementPtr},
        {"xchg", Op::OXchg},
        {"select", Op::OSelect},
    };

    return Op(op_map.at(op));
}

static Ordering parse_ordering(const string &order) {
    static const map<string, Ordering::_Ordering> order_map = {
        {"NotAtomic", Ordering::NotAtomic},
        {"Unordered", Ordering::Unordered},
        {"Monotonic", Ordering::Monotonic},
        {"Acquire", Ordering::Acquire},
        {"Release", Ordering::Release},
        {"AcquireRelease", Ordering::AcquireRelease},
        {"SequentiallyConsistent", Ordering::SequentiallyConsistent},
    };

    return Ordering(order_map.at(order));
}

static unique_ptr<IRValue> parse_value(const ptree &val) {
    auto typ = parse_type(val.get_child("type"));
    string src = val.get<string>("source");

    if (src == "constant") {
        auto value = val.get_child("value");

        if (value.empty()) {
            // If the value is a string, it is a literal
            auto value = val.get<string>("value");

            if (value == "UndefValue")
                return make_unique<VUndef>(typ);
            else if (value == "ConstantPointerNull")
                return make_unique<VNull>(typ);
            else if (value == "ConstantAggregateZero")
                return make_unique<VAggZero>(typ);
            else if (dynamic_cast<TInt *>(typ.get()) != nullptr)
                return make_unique<VInt>(typ, std::stoull(value));
            else if (dynamic_cast<TBool *>(typ.get()) != nullptr)
                return make_unique<VBool>(value != "0");
            else
                return make_unique<IRValue>();
        } else {
            string val_type = value.get<string>("type");
            static std::set<string> array_type = {"array", "data_array", "vector", "data_vector"};

            if (val_type == "expression") {
                string op_str = value.get<string>("op");
                Op op;
                auto operands = make_unique<vector<unique_ptr<IRValue>>>();

                if (op_str == "icmp")
                    op = parse_op(value.get<string>("predicate"));
                else
                    op = parse_op(op_str);

                for (const auto &opr : value.get_child("operands")) {
                    operands->push_back(parse_value(opr.second));
                }

                return make_unique<VExpr>(typ, op, std::move(operands));
            } else if (val_type == "global") {
                return make_unique<VGlobal>(typ, value.get<string>("value").substr(1));
            } else if (array_type.find(val_type) != array_type.end()) {
                auto values = make_unique<vector<unique_ptr<IRValue>>>();

                for (const auto &v : value.get_child("values")) {
                    values->push_back(parse_value(v.second));
                }

                return make_unique<VStruct>(typ, std::move(values));
            } else if (array_type.find(val_type) != array_type.end()) {
                auto values = make_unique<vector<unique_ptr<IRValue>>>();

                for (const auto &v : value.get_child("value")) {
                    values->push_back(parse_value(v.second));
                }

                return make_unique<VStruct>(typ, std::move(values));
            } else
                return make_unique<IRValue>();
        }
    } else if (src == "argument" || src == "instruction") {
        return make_unique<VLocal>(typ, val.get<string>("value"));
    } else if (src == "basic_block") {
        return make_unique<VLabel>(val.get<string>("value"));
    } else if (src == "inline_asm") {
       auto iasm_val = val.get_child("value");

         return make_unique<VInlineAsm>(typ, iasm_val.get<string>("asm"), iasm_val.get<string>("side_effect") == "true",
                                          iasm_val.get<string>("constraints"));
    } else {
        return make_unique<IRValue>();
    }

    return nullptr;
}

static unique_ptr<vector<unique_ptr<IRValue>>> parse_val_list(const ptree &lst) {
    auto values = make_unique<vector<unique_ptr<IRValue>>>();

    for (const auto &val : lst) {
        values->push_back(parse_value(val.second));
    }

    return values;
}

static unique_ptr<IRInst> parse_instruction(const ptree &inst, string fname) {
    auto lineno_opt = inst.get_optional<long>("lineno");
    int lineno;
    string inst_type = inst.get<string>("type");

    if (lineno_opt)
        lineno = lineno_opt.get();
    else
        lineno = 0;

    if (inst_type == "AllocaInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IAlloc>(fname, parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                   inst.get<coq_sz_t>("align"));
    } else if (inst_type == "AtomicRMWInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IAtomicRMW>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                       parse_op(inst.get<string>("op")), parse_value(inst.get_child("ptr")),
                                       parse_value(inst.get_child("val")), parse_ordering(inst.get<string>("ordering")),
                                       inst.get<coq_sz_t>("align"));
    } else if (inst_type == "BinaryOperator") {
        auto inst_assign = inst.get_child("assign");
        auto ops = inst.get_child("operands");

        return make_unique<IBinOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                   parse_op(inst.get<string>("operator")), parse_value(ops.front().second),
                                   parse_value(ops.back().second));
    } else if (inst_type == "BitCastInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OBitCast), parse_value(inst.get_child("src")));
    } else if (inst_type == "BranchInst") {
        bool conditional = inst.get<bool>("conditional");

        if (conditional) {
            return make_unique<ICondBranch>(parse_value(inst.get_child("condition")),
                                            parse_value(inst.get_child("true_br")),
                                            parse_value(inst.get_child("false_br")), lineno);
        } else {
            return make_unique<IBranch>(parse_value(inst.get_child("true_br")), lineno);
        }
    } else if (inst_type == "CallInst") {
        auto args = make_unique<vector<unique_ptr<IRValue>>>();
        auto args_node = inst.get_child("arguments");
        auto inst_assign = inst.get_child("assign");
        unique_ptr<IRValue> func;

        for (auto it = args_node.begin(); it != std::prev(args_node.end()); it++) {
            args->push_back(parse_value(it->second));
        }
        func = parse_value(args_node.back().second);

        return make_unique<ICall>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                  std::move(func), std::move(args), lineno);
    } else if (inst_type == "CallBrInst") {
        // XXX: This branch doesn't seem to be used.
        //      In the original python code, this branch returns a list of ICall.
#if 0
        auto args = vector<unique_ptr<IRValue>>();
        auto default_br = parse_value(inst.get_child("default"));
        auto indirect = vector<unique_ptr<IRValue>>();
        auto inst_assign = inst.get_child("assign");

        for (const auto &arg : inst.get_child("arguments")) {
            args.push_back(std::move(parse_value(arg.second)));
        }

        for (const auto &ind : inst.get_child("indirect")) {
            indirect.push_back(std::move(parse_value(ind.second)));
        }

        assert(parse_type(inst_assign.get_child("type")) == TVoid::TVOID);
        assert(indirect.size() == 1);
#endif
    } else if (inst_type == "CmpXchgInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<ICmpXchg>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     parse_value(inst.get_child("ptr")), parse_value(inst.get_child("cmp")),
                                     parse_value(inst.get_child("new")), parse_ordering(inst.get<string>("succ_ordering")),
                                     parse_ordering(inst.get<string>("failure_ordering")), inst.get<coq_sz_t>("align"));
    } else if (inst_type == "ExtractValueInst") {
        auto inst_assign = inst.get_child("assign");
        auto indices = make_unique<vector<int>>();

        for (const auto &idx : inst.get_child("indices")) {
            indices->push_back(idx.second.get_value<int>());
        }

        return make_unique<IExtractValue>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                          parse_value(inst.get_child("src")), std::move(indices));
    } else if (inst_type == "FCmpInst") {
        return make_unique<IRInst>();
    } else if (inst_type == "FPExtInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OFPExt), parse_value(inst.get_child("src")));
    } else if (inst_type == "FPToSIInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OFPToSI), parse_value(inst.get_child("src")));
    } else if (inst_type == "FPToUIInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OFPToUI), parse_value(inst.get_child("src")));
    } else if (inst_type == "FPTruncInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OFPTrunc), parse_value(inst.get_child("src")));
    } else if (inst_type == "FenceInst") {
        return make_unique<IFence>(parse_ordering(inst.get<string>("ordering")));
    } else if (inst_type == "FreezeInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IFreeze>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                    parse_value(inst.get_child("src")));
    } else if (inst_type == "GetElementPtrInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IGetElemPtr>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                        parse_value(inst.get_child("src")), parse_val_list(inst.get_child("indices")));
    } else if (inst_type == "ICmpInst") {
        auto op = parse_op(inst.get<string>("predicate"));
        auto inst_op = inst.get_child("operands");
        auto op0 = parse_value(inst_op.begin()->second);
        auto op1 = parse_value(std::next(inst_op.begin())->second);
        auto inst_assign = inst.get_child("assign");

        return make_unique<IBinOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                   op, std::move(op0), std::move(op1));
    } else if (inst_type == "InsertElementInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IInsertElem>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                        parse_value(inst.get_child("target")), parse_value(inst.get_child("value")),
                                        parse_value(inst.get_child("index")));
    } else if (inst_type == "InsertValueInst") {
        auto inst_assign = inst.get_child("assign");
        auto indices = make_unique<vector<int>>();

        for (const auto &idx : inst.get_child("indices")) {
            indices->push_back(idx.second.get_value<int>());
        }

        return make_unique<IInsertValue>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                         parse_value(inst.get_child("target")), parse_value(inst.get_child("value")),
                                         std::move(indices));
    } else if (inst_type == "IntToPtrInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OIntToPtr), parse_value(inst.get_child("src")));
    } else if (inst_type == "LoadInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<ILoad>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                  parse_value(inst.get_child("src")), inst.get<int>("align"));
    } else if (inst_type == "PHINode") {
        auto values = make_unique<vector<unique_ptr<IRValue>>>();
        auto blocks = make_unique<vector<unique_ptr<IRValue>>>();
        auto inst_incoming_list = inst.get_child("incoming_list");
        auto inst_assign = inst.get_child("assign");

        for (const auto &incoming : inst_incoming_list) {
            values->push_back(parse_value(incoming.second.get_child("value")));
            blocks->push_back(parse_value(incoming.second.get_child("block")));
        }

        return make_unique<IPHI>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                 std::move(values), std::move(blocks));
    } else if (inst_type == "PtrToIntInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OPtrToInt), parse_value(inst.get_child("src")));
    } else if (inst_type == "ReturnInst") {
        auto opt_return_value = inst.get_child_optional("return_value");

        if (opt_return_value) {
            return make_unique<IReturn>(parse_type(inst.get_child("return_type")), parse_value(opt_return_value.get()));
        } else {
            return make_unique<IReturn>(parse_type(inst.get_child("return_type")));
        }
    } else if (inst_type == "SExtInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OSExt), parse_value(inst.get_child("src")));
    } else if (inst_type == "SIToFPInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OSIToFP), parse_value(inst.get_child("src")));
    } else if (inst_type == "SelectInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<ISelect>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                    parse_value(inst.get_child("condition")), parse_value(inst.get_child("true_value")),
                                    parse_value(inst.get_child("false_value")));
    } else if (inst_type == "ShuffleVectorInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IShuffleVec>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                        parse_val_list(inst.get_child("operands")));
    } else if (inst_type == "StoreInst") {
        return make_unique<IStore>(parse_value(inst.get_child("target")), parse_value(inst.get_child("src")),
                                   inst.get<coq_sz_t>("align"));
    } else if (inst_type == "SwitchInst") {
        auto values = make_unique<vector<unique_ptr<IRValue>>>();
        auto blocks = make_unique<vector<unique_ptr<IRValue>>>();

        for (const auto &case_val : inst.get_child("cases")) {
            values->push_back(parse_value(case_val.second.get_child("value")));
            blocks->push_back(parse_value(case_val.second.get_child("succ")));
        }

        return make_unique<ISwitch>(parse_value(inst.get_child("condition")), parse_value(inst.get_child("default_succ")),
                                    std::move(values), std::move(blocks));
    } else if (inst_type == "TruncInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OTrunc), parse_value(inst.get_child("src")));
    } else if (inst_type == "UIToFPInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OUIToFP), parse_value(inst.get_child("src")));
    } else if (inst_type == "UnaryOperator") {
        auto inst_assign = inst.get_child("assign");
        auto ops = inst.get_child("operands");
        auto op0 = parse_value(ops.begin()->second);

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     parse_op(inst.get<string>("operator")), std::move(op0));
    } else if (inst_type == "Unreachable" || inst_type == "UnreachableInst") {
        return make_unique<IUnreachable>();
    } else if (inst_type == "ZExtInst") {
        auto inst_assign = inst.get_child("assign");

        return make_unique<IUnaryOp>(parse_type(inst_assign.get_child("type")), inst_assign.get<string>("value"),
                                     Op(Op::OZExt), parse_value(inst.get_child("src")));
    }

    throw std::runtime_error("Unknown instruction type: " + inst_type);
    return make_unique<IRInst>();
}

static unsigned long count_ir_loc(const ptree &func) {
    unsigned long loc = 0;

    for (const auto &block : func.get_child("blocks")) {
        loc += block.second.size();
    }

    return loc;
}

static unsigned long count_cir_loc(vector<unique_ptr<IRInst>> *body) {
    unsigned long loc = 0;

    for (const auto &inst : *body) {
        if (dynamic_cast<IIf *>(inst.get())) {
            auto if_inst = dynamic_cast<IIf *>(inst.get());

            loc += count_cir_loc(if_inst->true_body.get());
            loc += count_cir_loc(if_inst->false_body.get());
        } else if (dynamic_cast<ILoop *>(inst.get())) {
            auto loop_inst = dynamic_cast<ILoop *>(inst.get());

            loc += count_cir_loc(loop_inst->body.get());
        } else {
            loc += 1;
        }
    }

    return loc;
}

static shared_ptr<CFunction> parse_function(const ptree &func) {
    string fname = func.get<string>("fname");
    auto rettype = parse_type(func.get_child("rettype"));
    auto args = make_unique<vector<unique_ptr<FuncArg>>>();
    bool is_decl = func.get<bool>("is_declaration");
    unique_ptr<IRFunction> irfunc;
    shared_ptr<CFunction> cfunc;

    std::replace(fname.begin(), fname.end(), '.', '_');
    LOG_DEBUG << "parse IR function: " << fname << std::endl;

    for (const auto &arg : func.get_child("args")) {
        args->push_back(make_unique<FuncArg>(arg.second.get<string>("name"), parse_type(arg.second.get_child("type"))));
    }

    if (is_decl)
        irfunc = make_unique<IRFunction>(fname, rettype, std::move(args), is_decl);
    else {
        string entry = func.get<string>("entry");
        auto blocks = make_unique<ir_blocks_t>();

        for (const auto &block : func.get_child("blocks")) {
            auto insts = make_unique<vector<unique_ptr<IRInst>>>();

            for (const auto &inst: block.second) {
                insts->push_back(parse_instruction(inst.second, fname));
            }

            blocks->first.emplace(block.first, std::move(insts));
            blocks->second.push_back(block.first);
        }

        irfunc = make_unique<IRFunction>(fname, rettype, std::move(args), is_decl, entry, std::move(blocks));
    }

    if (!is_decl) {
        auto body = control_flow_conversion(irfunc->blocks.get(), false);

        cfunc = make_shared<CFunction>(fname, rettype, std::move(irfunc->args), is_decl, std::move(body));

        /*
         * Uncomment the following to output Coq AST to file.
         * Note the file will be appended to, so you may want to delete it first.
         */

        // std::ofstream file("coqast-cpp.txt", std::ios_base::app); // Open the file in append mode
        // if (file.is_open()) {
        //     file << cfunc->to_coq() << std::endl;
        //     file.close();
        // } else {
        //     std::cerr << "Unable to open file";
        // }

    } else {
        cfunc = make_shared<CFunction>(fname, rettype, std::move(irfunc->args), is_decl, nullptr);
    }

    return cfunc;
}

static ptree construct_struct(const ptree &metadata, const ptree &md, bool parse_elems=true) {
    static std::set<string> struct_tag = {"struct", "union", "member", "typedef", "array", "pointer"};
    ptree result;
    string name;
    coq_sz_t size;
    ptree elems;
    int i;

    if (md.get<string>("tag") == "base") {
        return md.get_child("name");
    }

    if (struct_tag.find(md.get<string>("tag")) == struct_tag.end()) {
        return md;
    }

    if (md.get<string>("tag") == "array" || md.get<string>("tag") == "pointer") {
        if (md.get<string>("base") == "-1") {
            result.put("tag", md.get<string>("tag"));
            result.put("subtype", "UNKNOWN");
            return result;
        }
        result.put("tag", md.get<string>("tag"));
        result.add_child("subtype", std::move(construct_struct(metadata, metadata.get_child(md.get<string>("base")))));
        return result;
    }


    if (md.find("base") != md.not_found()) {
        if (md.get<string>("base") == "-1") {
            result.put_value("UNKNOWN");
            return result;
        }

        return construct_struct(metadata, metadata.get_child(md.get<string>("base")));
    }

    if (parse_elems && md.get<string>("name") != "") {
        result.put_value(md.get<string>("tag") + "!" + md.get<string>("name"));
        return result;
    }

    name = md.get<string>("tag") + "!" + md.get<string>("name");
    size = md.get<coq_sz_t>("size");

    i = 0;
    for (const auto &elem : md.get_child("elements")) {
        auto elem_md = metadata.get_child(elem.second.data());
        ptree elem_result;

        if (elem_md.get<string>("name") == "") {
            elem_md.put(elem_md.get<string>("name"), md.get<string>("name") + "!" + std::to_string(i));
        }
        elem_result.put("name", elem_md.get<string>("name"));
        elem_result.put("offset", elem_md.get<coq_sz_t>("offset") / 8);
        elem_result.put("size", elem_md.get<coq_sz_t>("size") / 8);
        elem_result.add_child("type", construct_struct(metadata, elem_md));

        elems.push_back(std::make_pair("", std::move(elem_result)));
    }

    result.put("name", name);
    result.put("size", size / 8);
    result.add_child("elements", std::move(elems));

    //write_json(std::cout, result);

    return result;
}

static bool is_new_struct(const ptree &md, const ptree &structs) {
    string tag = md.get<string>("tag");

    return (tag == "struct" || tag == "union") && md.get<string>("name") != "" &&
            structs.find(md.get<string>("tag") + "!" + md.get<string>("name")) == structs.not_found();
}

static shared_ptr<ptree> parse_debug_info(const ptree &module) {
    ptree structs;
    ptree metadata;
    auto debug_info = make_shared<ptree>();
    bool parse_new_struct = false;

    for (const auto &md : module.get_child("mdtype")) {
        metadata.add_child(md.second.get<string>("mdid"), md.second);
    }

    while (true) {
        parse_new_struct = false;

        for (const auto &mdp : module.get_child("mdtype")) {
            auto &md = mdp.second;
            if (is_new_struct(md, structs)) {
                auto new_st =  construct_struct(metadata, md, false);

                structs.add_child(md.get<string>("tag") + "!" + md.get<string>("name"), std::move(new_st));
                parse_new_struct = true;
            }
        }

        if (!parse_new_struct)
            break;
    }

    debug_info->add_child("structs", std::move(structs));

    return debug_info;
}

static bool parse_struct(string name, ptree &module, ptree &sinfo, ptree &debug_info) {
    auto module_sinfo = module.get_child("struct_types").get_child(name);
    auto stype = module_sinfo.get_child("elems");
    bool is_union = sinfo.get<string>("name").compare(0, 6, "union!") == 0;
    coq_sz_t size = -1, npaddings = 0;
    auto elems = make_unique<vector<shared_ptr<TStructElem>>>();

    if (auto sz = sinfo.get_optional<coq_sz_t>("size"))
        size = sz.get();
    else if (auto sz = module_sinfo.get_optional<coq_sz_t>("size"))
        size = sz.get();

    assert(sinfo.get_child_optional("elements"));
    auto selems = sinfo.get_child_optional("elements").get();

    if (is_union) {
        int i = 0;

        for (auto it = stype.begin(); it != stype.end(); it++, i++) {
            auto elem = make_shared<TStructElem>(name + "." + std::to_string(i), parse_type(it->second), i, true);

            elems->push_back(elem);

            auto typ = elem->type;

            if (auto typ_named_struct = dynamic_cast<TNamedStruct *>(typ.get())) {
                auto selems_i = (*std::next(selems.begin(), i)).second;

                if (auto type_elem_type = selems_i.get_child_optional("type")) {
                    if (type_elem_type.get().empty())
                        continue;
                    auto typ_name = typ->get_name();

                    if (typ_name.compare(0, 6, "struct") == 0 || typ_name.compare(0, 5, "union") == 0) {
                        std::replace(typ_name.begin(), typ_name.end(), '.', '!');
                        if (!debug_info.get_child("structs").get_child_optional(typ_name)) {
                            type_elem_type.get().get_child("name").put_value(typ_name);
                            debug_info.get_child("structs").add_child(typ_name, type_elem_type.get());
                        }
                    }
                }
            }
        }
    } else {
        int i = 0;
        coq_sz_t type_ofs;

        for (auto it = selems.begin(); it != selems.end(); it++, i++) {
            auto info_ofs = it->second.get<coq_sz_t>("offset");
            auto &pad_type_elem = (*std::next(stype.begin(), i + npaddings)).second;

            if (i + npaddings >= stype.size())
                throw std::runtime_error("Too many elements in struct " + name + ", i + npaddings: " + std::to_string(i + npaddings) + ", stype.size(): " + std::to_string(stype.size()));
            else {
                if (auto sz = pad_type_elem.get_optional<coq_sz_t>("offset"))
                    type_ofs = sz.get();
                else
                    type_ofs = info_ofs;
            }

            // This loops seems never to be executed in the python implementation
            while (info_ofs != type_ofs) {
                throw std::runtime_error("Struct " + name + " has padding at offset " + std::to_string(info_ofs));
                elems->push_back(make_shared<TStructElem>("padding" + std::to_string(npaddings), parse_type(pad_type_elem), type_ofs, true));
                npaddings += 1;
                if (i + npaddings >= stype.size())
                    throw std::runtime_error("Too many elements in struct " + name + ", i + npaddings: " + std::to_string(i + npaddings) + ", stype.size(): " + std::to_string(stype.size()));
                type_ofs = (*std::next(stype.begin(), i + npaddings)).second.get<coq_sz_t>("offset");
            }

            auto new_elem =  make_shared<TStructElem>(it->second.get<string>("name"), parse_type(pad_type_elem), type_ofs, true);
            elems->push_back(new_elem);

            auto typ = new_elem->type;
            if (auto typ_named_struct = dynamic_cast<TNamedStruct *>(typ.get())) {
                if (auto type_elem_type = it->second.get_child_optional("type")) {
                    if (type_elem_type.get().empty())
                        continue;
                    auto typ_name = typ->get_name();

                    if (typ_name.compare(0, 6, "struct") == 0 || typ_name.compare(0, 5, "union") == 0) {
                        std::replace(typ_name.begin(), typ_name.end(), '.', '!');
                        if (!debug_info.get_child("structs").get_child_optional(typ_name)) {
                            it->second.get_child("type").get_child("name").put_value(typ_name);
                            debug_info.get_child("structs").add_child(typ_name, it->second.get_child("type"));
                        }
                    }
                }
            }
        }
    }

    //auto tmp = name;
    //std::replace(tmp.begin(), tmp.end(), '!', '.');
    //std::cout << tmp << std::endl;
    structs_info.emplace(name, make_shared<TStruct>(std::move(elems), size));
    return true;
}

// postprocess default value is true
shared_ptr<IRModule> parse_module(ptree &module, bool postprocess) {
    auto debug_info = parse_debug_info(module);
    auto globvars = make_shared<map<string, shared_ptr<GlobalVar>>>();
    auto funcs = make_shared<map<string, shared_ptr<CFunction>>>();

    while (true) {
        bool parse_new_struct = false;
        for (auto &struct_node : debug_info->get_child("structs")) {
            auto struct_key = struct_node.first;

            if (structs_info.find(struct_key) != structs_info.end())
                continue;

            if (auto s = module.get_child("struct_types").get_child_optional(struct_key)) {
                parse_struct(struct_key, module, debug_info->get_child("structs").get_child(struct_key), *debug_info);
                parse_new_struct = true;
            }
        }

        if (!parse_new_struct)
            break;
    }

    for (auto &st: module.get_child("struct_types")) {
        auto name = st.first;

        if (structs_info.find(name) != structs_info.end())
            continue;

        auto st_json = st.second;
        auto elems = make_unique<vector<shared_ptr<TStructElem>>>();
        for (auto &elem: st_json.get_child("elems")) {
            elems->push_back(make_shared<TStructElem>("", parse_type(elem.second), 0, true));
        }

        coq_sz_t sz;
        auto sz_opt = st_json.get_optional<coq_sz_t>("size");

        if (sz_opt)
            sz = sz_opt.get();
        else
            sz = 0;
        structs_info.emplace(name, make_shared<TStruct>(std::move(elems), sz));
    }

    for (auto gvar: module.get_child("global_variables")) {
        auto vname = gvar.first;
        auto var = gvar.second;
        auto vtype = parse_type(var.get_child("type"));
        auto vconst = var.get<bool>("constant");
        auto valign = var.get<coq_sz_t>("align");
        unique_ptr<IRValue> vvalue;

        if (auto val = var.get_child_optional("value")) {
            vvalue = parse_value(val.get());
        } else {
            vvalue = nullptr;
        }

        std::replace(vname.begin(), vname.end(), '.', '_');
        globvars->emplace(vname, make_shared<GlobalVar>(vname, vtype, vconst, std::move(vvalue), valign));
    }

    for (const auto &func : module.get_child("functions")) {
        auto f = parse_function(func.second);

        if (f) {
            auto fname = func.first;

            std::replace(fname.begin(), fname.end(), '.', '_');

            funcs->emplace(fname, f);
        }
    }

    if (postprocess) {
        return post_process(make_shared<IRModule>(&structs_info, globvars, funcs, std::move(debug_info)));
    }

    return make_shared<IRModule>(&structs_info, globvars, funcs, std::move(debug_info));
}

} // namespace autov::IRLoader