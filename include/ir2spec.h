#pragma once
#include <irtypes.h>
#include <values.h>

namespace autov {

using autov::IRLoader::IRType;
using autov::IRLoader::TInt;
using autov::IRLoader::TBool;
using autov::IRLoader::TVoid;
using autov::IRLoader::TFunction;
using autov::IRLoader::TPtr;
using autov::IRLoader::TNamedStruct;
using autov::IRLoader::TArray;
using autov::SpecType;
using autov::Int;
using autov::Bool;
using autov::Function;


static shared_ptr<SpecType> ir_type_to_spec(shared_ptr<IRType> typ);


}