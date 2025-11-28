#pragma once
#include "llvm/IR/Type.h"
#include <string>

std::string anonStructFieldNameSegment(const llvm::Type* ty, 
    bool pointers_are_ptr);

  bool isUnion(const llvm::StructType* ty) {
    return ty->getName().startswith("union.");
  }
// For anonymous structs, we must build a name that's consistent 
// between generated load/store, record declarations, and spoq internals
// This function builds a string out of all the fields to try to get a
// unique struct name.
std::string anonStructName(const llvm::StructType* ty) {
    if (ty->hasName()){
        if (isUnion(ty)) {
            return "u_" + ty->getName().str();
        } else {
            return "s_" + ty->getName().str();
        }    
    }
    std::string result = "s_Anon";

    for (auto &ety: ty->elements()){
        result = result + "_" + anonStructFieldNameSegment(ety, false);
    }
      std::replace(result.begin(), result.end(), '.', '_');
  std::replace(result.begin(), result.end(), ':', '_');

    return result;
}

// When naming an anonymous struct this function
// generates the segment of the struct name
// corresponding to a given field.
std::string anonStructFieldNameSegment(const llvm::Type* ty, 
    bool pointers_are_ptr=false){
  switch(ty->getTypeID()) {
    case llvm::Type::TypeID::IntegerTyID: {
      return std::to_string(ty->getIntegerBitWidth()) + "Z";
    }
    case llvm::Type::TypeID::StructTyID: {
      auto sty = llvm::dyn_cast<llvm::StructType>(ty);
        return anonStructName(sty);
    }
    case llvm::Type::TypeID::PointerTyID: {
      if(pointers_are_ptr){
        return "Ptr";
      } else {
        return "Z";
      }
    }
    case llvm::Type::TypeID::ArrayTyID: {
      auto aty = llvm::dyn_cast<llvm::ArrayType>(ty);
      auto ety = aty->getElementType();
      if( ety->isIntegerTy() || ety->isPointerTy() ) {
      // TODO: assert Array is [constant x iXXX]
        return "ArrZ";
      } else if(ety->isStructTy()) {
        return "Arr" + anonStructName(static_cast<llvm::StructType*>(ety));
      } else {
        return "UnkArr";
      }
    }
    default: {
      return "Unk";
    }
  }

}