#pragma once

// One traversal of an LLVM type, shared by everything that has to name it in
// Coq.
//
// There were three copies: ExtractBasics::generateField, ExtractPointers::
// generateField and spoq's llvm_ir_type_to_spec_pure.  Each ended in its own
// `default:`, and they disagreed -- the first two answered "UnknownType" for a
// vector, a name nothing defines, which is what took snd001 and snd014 down.
// A type kind that nobody handles is now one missing case here instead of three
// that drift apart silently.
//
// Header-only, and LLVM plus the standard library only: the preprocessing
// passes are `opt` plugins built by scripts/preprocessing/build-passes.sh
// against LLVM alone, so they cannot link against spoq.  Nothing here needs
// C++ RTTI either, since those plugins inherit -fno-rtti from an LLVM built
// without it.
//
// What each consumer renders is its own business -- a pointer is `Ptr` in a
// function signature and `Z` in a record field, an array carries its length in
// one and not in the other.  Those choices live in the Builder, where they are
// visible, rather than in a switch that has been copied.

#include <cstdint>

#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Type.h"

namespace autov {
namespace coqty {

/// Dispatch [ty] to [b].
///
/// A Builder supplies a `result_t` and one method per kind:
///
///     result_t boolean()                        i1
///     result_t integer(unsigned bits)           every other integer width
///     result_t pointer()
///     result_t floating(llvm::Type *ty)         float, double, and the rest
///     result_t array(llvm::Type *elem, uint64_t n)
///     result_t vector(llvm::Type *elem, uint64_t n)
///     result_t structure(llvm::StructType *sty)
///     result_t voidty()
///     result_t metadata()
///     result_t unsupported(llvm::Type *ty)      nothing above fits
///
/// Aggregates hand back the element type rather than a built element, so a
/// Builder that only handles one level of nesting can say so.
template <class Builder>
typename Builder::result_t of_type(llvm::Type *ty, Builder &b) {
    if (ty->isIntegerTy(1)) return b.boolean();
    if (ty->isIntegerTy()) return b.integer(ty->getIntegerBitWidth());
    if (ty->isPointerTy()) return b.pointer();
    if (ty->isFloatingPointTy()) return b.floating(ty);
    if (ty->isVoidTy()) return b.voidty();
    if (ty->isMetadataTy()) return b.metadata();

    if (auto *aty = llvm::dyn_cast<llvm::ArrayType>(ty))
        return b.array(aty->getElementType(), aty->getNumElements());

    // Scalable vectors have no element count; report the minimum, which is what
    // a consumer that models a vector as a map of its elements can use.
    if (auto *vty = llvm::dyn_cast<llvm::FixedVectorType>(ty))
        return b.vector(vty->getElementType(), vty->getNumElements());
    if (auto *vty = llvm::dyn_cast<llvm::VectorType>(ty))
        return b.vector(vty->getElementType(), vty->getElementCount().getKnownMinValue());

    if (auto *sty = llvm::dyn_cast<llvm::StructType>(ty)) return b.structure(sty);

    return b.unsupported(ty);
}

}  // namespace coqty
}  // namespace autov
