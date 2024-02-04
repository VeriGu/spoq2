#pragma once
#include <irtypes.h>
#include <values.h>
#include <nodes.h>

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


shared_ptr<SpecType> ir_type_to_spec(IRType* typ);
vector<unique_ptr<Definition>>* ir_to_spec(Project *proj, string fname, Layer *layer, string suffix = "");


}