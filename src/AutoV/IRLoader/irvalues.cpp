#include <irvalues.h>

namespace autov::IRLoader {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::tuple;
using std::unordered_map;

const unordered_map<Op::_Op, std::string> Op::opToString = {
    {_Op::Cslt, "Cslt"},
    {_Op::Csle, "Csle"},
    {_Op::Cult, "Cult"},
    {_Op::Cule, "Cule"},
    {_Op::Ceq, "Ceq"},
    {_Op::Cne, "Cne"},
    {_Op::Csgt, "Csgt"},
    {_Op::Csge, "Csge"},
    {_Op::Cugt, "Cugt"},
    {_Op::Cuge, "Cuge"},
    {_Op::OAdd, "OAdd"},
    {_Op::OAnd, "OAnd"},
    {_Op::OAshr, "OAshr"},
    {_Op::OFadd, "OFadd"},
    {_Op::OFdiv, "OFdiv"},
    {_Op::OFmul, "OFmul"},
    {_Op::OFsub, "OFsub"},
    {_Op::OLshr, "OLshr"},
    {_Op::OMul, "OMul"},
    {_Op::OOr, "OOr"},
    {_Op::OSdiv, "OSdiv"},
    {_Op::OSrem, "OSrem"},
    {_Op::OShl, "OShl"},
    {_Op::OSub, "OSub"},
    {_Op::OUdiv, "OUdiv"},
    {_Op::OUrem, "OUrem"},
    {_Op::OXor, "OXor"},
    {_Op::OBitCast, "OBitCast"},
    {_Op::OFPExt, "OFPExt"},
    {_Op::OFPToSI, "OFPToSI"},
    {_Op::OFPToUI, "OFPToUI"},
    {_Op::OFPTrunc, "OFPTrunc"},
    {_Op::OFneg, "OFneg"},
    {_Op::OIntToPtr, "OIntToPtr"},
    {_Op::OPtrToInt, "OPtrToInt"},
    {_Op::OSExt, "OSExt"},
    {_Op::OSIToFP, "OSIToFP"},
    {_Op::OTrunc, "OTrunc"},
    {_Op::OUIToFP, "OUIToFP"},
    {_Op::OZExt, "OZExt"},
    {_Op::OGetElementPtr, "OGetElementPtr"},
    {_Op::OXchg, "OXchg"},
    {_Op::OSelect, "OSelect"},
};
} // namespace autov::IRLoader