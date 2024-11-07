#include "llvm/IR/Type.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DebugInfo.h"
#include <utility>
#include <string>
#include <vector>
#include <queue>
#include <map>
#include <fstream>
#include <filesystem>

// using namespace llvm;
// static cl::opt<bool> MergeFunctionsPDI("mymergefunc-preserve-debug-info",
// cl::Hidden, cl::init(false), cl::desc("Preserve debug info in thunk when
// mergefunc "
//  "transformations are made."));

class ExtractBasicsPass : public llvm::ModulePass {
 public:
  static char ID;

  std::string file;
  std::ofstream fout;
  const llvm::DataLayout* dl;
  llvm::LLVMContext* context;
  std::map<std::string, std::map<int, std::string> > field_names;
  std::map<std::string, int> parsed_type;
  std::map<std::string, llvm::StructType*> used_id;
  std::map<llvm::StructType*, std::vector<llvm::Type*>> generated_types;
  ExtractBasicsPass() : ModulePass(ID) {
  }
  bool isUnion(llvm::StructType* ty);
  int getSizeForType(llvm::Type* ty);
  bool parseDebugInfo(llvm::DIType* type, std::string name, int);
  std::string getStructTypeIdentifier(llvm::StructType*);
  std::string getFieldIdentifier(llvm::StructType*, int);
  void runStruct(llvm::StructType *);
  bool expandType(llvm::Type*, std::vector<llvm::Type*>&);
  std::string getTypeName(llvm::Type*);
  std::string generateLoadZMapField(std::string obj, int offset, std::string field, llvm::ArrayType* ty);
  std::string generateLoadZField(std::string obj, int offset, std::string field);
  std::string generateLoadStructField(std::string obj, int offset, std::string field, llvm::StructType* ty);
  std::string generateLoad(llvm::StructType*);
  std::string generateStoreZMapField(std::string obj, int offset, std::string field, llvm::ArrayType* ty);
  std::string generateStoreZField(std::string obj, int offset, std::string field);
  std::string generateStoreStructField(std::string obj, int offset, std::string field, llvm::StructType* ty);
  std::string generateStore(llvm::StructType*);
  std::string generateField(llvm::Type*);
  std::vector<llvm::StructType*> sortTypes(std::vector<llvm::StructType*>);
  void generateRecordForStruct(llvm::Module &M);
  bool runOnModule(llvm::Module &M) override { 
    context = &M.getContext();
    dl = &M.getDataLayout();
    generateRecordForStruct(M);
    return false; 
  }
};

bool ExtractBasicsPass::isUnion(llvm::StructType* ty) {
  return ty->getName().startswith("union.");
}

std::string ExtractBasicsPass::generateStoreStructField(std::string obj, int offset, std::string field, llvm::StructType* ty) {
  if(ty == nullptr) return "";
  int size = dl->getTypeStoreSize(ty);
  std::string result =  "  if (ofs >=? " + std::to_string(offset) + ") && (ofs <? " + std::to_string(offset + size) + ") then (\n";
  result += "    let elem_ofs := ofs - " + std::to_string(offset) + " in\n";
  result += "    when ret == store_" + getStructTypeIdentifier(ty) + " sz elem_ofs v " + obj + ".(" + field + ");\n";
  result += "    Some (" + obj + ".[" + field + "] :< ret)) else ";
  return result;
}

std::string ExtractBasicsPass::generateStoreZMapField(std::string obj, int offset, std::string field, llvm::ArrayType* ty) {
  if(ty == nullptr) return "";
  auto ety = ty->getElementType();
  std::string result;
  int size = dl->getTypeStoreSize(ty);
  int element_size = dl->getTypeAllocSize(ety);
  result =  "  if (ofs >=? " + std::to_string(offset) + ") && (ofs <? " + std::to_string(offset + size) + ") then (\n";
  result += "    let idx := (ofs - " + std::to_string(offset) + ") / " + std::to_string(element_size) + " in\n";
  if( ety->isIntegerTy() ) {
    result += "    Some (" + obj + ".[" + field + "] :< (st.(" + field + ") # idx == v))) else";
  } else if(auto sty = llvm::dyn_cast<llvm::StructType>(ety)){
    result += "    let elem_ofs := (ofs - " + std::to_string(offset) + ") mod " + std::to_string(element_size) + " in\n";
    result += "    when ret == store_" + getStructTypeIdentifier(sty) + " sz elem_ofs v (" + obj + ".(" + field + ") @ idx);\n";
    result += "    Some (" + obj + ".[" + field + "] :< (st.(" + field +") # idx == ret))) else ";
  } else {
    result += "    None. (* nested vector not supported *)";
  }
  return result;
}


std::string ExtractBasicsPass::generateStoreZField(std::string obj, int offset, std::string field) {
  return "  if (ofs =? " + std::to_string(offset) + ") " \
    "then Some (" + obj + ".[" + field + "] :< v) else";
}

std::string ExtractBasicsPass::generateStore(llvm::StructType* sty) {
  auto ty_name = getStructTypeIdentifier(sty);
  std::string definition = 
    "Definition store_" + ty_name + " (sz: Z) (ofs:Z) (v:Z) " \
    " (st: " + ty_name + ") : option " + ty_name + " := \n";
  int n = sty->getNumElements();

  auto layout = dl->getStructLayout(sty);
  for(int i = 0; i < n; i++) {
    int offset = layout->getElementOffset(i);
    llvm::Type* e = sty->getTypeAtIndex(i);
    if(e->getTypeID() == llvm::Type::TypeID::IntegerTyID || e->getTypeID() == llvm::Type::TypeID::PointerTyID ) {
      definition += generateStoreZField("st", offset, getFieldIdentifier(sty, i));
      definition += "\n";
    } else if (e->getTypeID() == llvm::Type::TypeID::ArrayTyID ) {
      definition += generateStoreZMapField("st", offset, getFieldIdentifier(sty, i), llvm::dyn_cast<llvm::ArrayType>(e));
      definition += "\n";
    } else if(e->getTypeID() == llvm::Type::TypeID::StructTyID ) {
      definition += generateStoreStructField("st", offset, getFieldIdentifier(sty, i), llvm::dyn_cast<llvm::StructType>(e));
      definition += "\n";
    }
    // llvm::errs() << "offset:" << offset << "\n";
    // offset += layout->getElementOffset(i);
    // llvm::errs() << "offset:" << offset << "\n";
    // llvm::ConstantInt::get(context, layout.getElementOFfset(i));
  }
  definition += "  None.\n\n";
  return definition;
}


std::string ExtractBasicsPass::generateLoadStructField(std::string obj, int offset, std::string field, llvm::StructType* ty) {
  if(ty == nullptr) return "";
  int size = dl->getTypeStoreSize(ty);
  std::string result =  "  if (ofs >=? " + std::to_string(offset) + ") && (ofs <? " + std::to_string(offset + size) + ") then (\n";
  result += "    let elem_ofs := ofs - " + std::to_string(offset) + " in\n";
  result += "    load_"+ getStructTypeIdentifier(ty) +" sz elem_ofs (" + obj + ".(" + field + "))) else";
  return result;
}

std::string ExtractBasicsPass::generateLoad(llvm::StructType* sty) {
  auto ty_name = getStructTypeIdentifier(sty);
  std::string definition = 
    "Definition load_" + ty_name + " (sz: Z) (ofs:Z) " \
    " (st: " + ty_name + ") : option Z := \n";
  int n = sty->getNumElements();
  auto layout = dl->getStructLayout(sty);
  for(int i = 0; i < n; i++) {
    int offset = layout->getElementOffset(i);
    llvm::Type* e = sty->getTypeAtIndex(i);
    if(e->getTypeID() == llvm::Type::TypeID::IntegerTyID || e->getTypeID() == llvm::Type::TypeID::PointerTyID ) {
      definition += generateLoadZField("st", offset, getFieldIdentifier(sty, i));
      definition += "\n";
    } else if (e->getTypeID() == llvm::Type::TypeID::ArrayTyID ) {
      definition += generateLoadZMapField("st", offset, getFieldIdentifier(sty, i), llvm::dyn_cast<llvm::ArrayType>(e));
      definition += "\n";
    } else if(e->getTypeID() == llvm::Type::TypeID::StructTyID ) {
      definition += generateLoadStructField("st", offset, getFieldIdentifier(sty, i), llvm::dyn_cast<llvm::StructType>(e));
      definition += "\n";
    }
    // llvm::errs() << "offset:" << offset << "\n";
    // offset += layout->getElementOffset(i);
    // llvm::errs() << "offset:" << offset << "\n";
    // llvm::ConstantInt::get(context, layout.getElementOFfset(i));
  }
  definition += "  None.\n\n";
  return definition;
}

std::string ExtractBasicsPass::generateLoadZMapField(std::string obj, int offset, std::string field, llvm::ArrayType* ty) {
  if(ty == nullptr) return "";
  auto ety = ty->getElementType();
  std::string result;
  int size = dl->getTypeStoreSize(ty);
  int element_size = dl->getTypeAllocSize(ety);
  result =  "  if (ofs >=? " + std::to_string(offset) + ") && (ofs <? " + std::to_string(offset + size) + ") then (\n";
  result += "    let idx := (ofs - " + std::to_string(offset) + ") / " + std::to_string(element_size) + " in\n";
  if( ety->isIntegerTy() ) {
    result += "    Some (" + obj + ".(" + field + ") @ idx)) else";
  } else if(auto sty = llvm::dyn_cast<llvm::StructType>(ety)){
    result += "    let elem_ofs := (ofs - " + std::to_string(offset) + ") mod " + std::to_string(element_size) + " in\n";
    result += "    load_"+ getStructTypeIdentifier(sty) +" sz elem_ofs (" + obj + ".(" + field + ") @ idx)) else";
  } else {
    result += "    None. (* nested vector not supported *)";
  }
  return result;
}


std::string ExtractBasicsPass::generateLoadZField(std::string obj, int offset, std::string field) {
  return "  if (ofs =? " + std::to_string(offset) + ") " \
    "then Some (" + obj + ".(" + field + ")) else";
}

std::string ExtractBasicsPass::getFieldIdentifier(llvm::StructType* sty, int count) {
  std::string tyname = sty->getName().str();
  if(isUnion(sty)) tyname = tyname.substr(6);
  else tyname = tyname.substr(7);
  std::string name = field_names[tyname][count];
  if(name == "") name = getStructTypeIdentifier(sty) + "_" + std::to_string(count);
  else if(!used_id[name]){
    used_id[name] = sty;
  }
  else if(used_id[name] != sty) {
    field_names[tyname][count] += "_" + getStructTypeIdentifier(sty);
    name = field_names[tyname][count];
  } 
  return "e_" + name;
}

std::string ExtractBasicsPass::getStructTypeIdentifier(llvm::StructType* sty) {
  std::string name;
  if(isUnion(sty)) 
    name = "u_" + sty->getName().str().substr(6);
  else
    name = "s_" + sty->getName().str().substr(7);
  std::replace(name.begin(), name.end(), '.', '_');
  std::replace(name.begin(), name.end(), ':', '_');
  return name;
}

std::string ExtractBasicsPass::generateField(llvm::Type* ty) {
  switch(ty->getTypeID()) {
    case llvm::Type::TypeID::IntegerTyID: {
      return "Z";
    }
    case llvm::Type::TypeID::StructTyID: {
      auto sty = llvm::dyn_cast<llvm::StructType>(ty);
      return getStructTypeIdentifier(sty); // remove struct.
    }
    case llvm::Type::TypeID::PointerTyID: {
      return "Z";
    }
    case llvm::Type::TypeID::ArrayTyID: {
      auto aty = llvm::dyn_cast<llvm::ArrayType>(ty);
      auto ety = aty->getElementType();
      if( ety->isIntegerTy() ) {
      // TODO: assert Array is [constant x iXXX]
        return "(ZMap.t Z)";
      } else if(ety->isStructTy()) {
        return "(ZMap.t " + getStructTypeIdentifier(llvm::dyn_cast<llvm::StructType>(ety)) + ")";
      } else {
        return "None";
      }
    }
    default: {
      return "None";
    }
  }
}

bool ExtractBasicsPass::expandType(llvm::Type* ty, std::vector<llvm::Type*>& vec) {
  bool success = true;
  switch(ty->getTypeID()) {
    case llvm::Type::TypeID::IntegerTyID: {
      vec.push_back(ty);
      return true;
    }
    case llvm::Type::TypeID::StructTyID: {
      auto sty = llvm::dyn_cast<llvm::StructType>(ty);
      for(auto &e: sty->elements()) {
        success &= expandType(e, vec);
      }
      return success;
    }
    default: {
      // llvm::errs() << "[warning] unhandled type: " << getTypeName(ty) << "\n";
      return false;
    }
  }
}

std::string ExtractBasicsPass::getTypeName(llvm::Type* ty) {
  std::string name;
  llvm::raw_string_ostream rso(name);
  ty->print(rso);
  return name;
}

void ExtractBasicsPass::runStruct(llvm::StructType *ty) {
    // llvm::errs() << "\nStruct Type: " << ty->getName();

    std::string ty_name = getStructTypeIdentifier(ty); // "remove struct."
    auto elements = ty->elements();

    std::string record;
    record = "Record " + ty_name + " :=\n" \
      " mk" + ty_name + " {\n" ;

    int count = 0;
    for(auto e: elements) {
      record += "    " + getFieldIdentifier(ty, count) +" : " + generateField(e) + ";\n";
      generated_types[ty].push_back(e);
      count += 1;
    }
    record += " }.";
    auto load = generateLoad(ty);
    auto store = generateStore(ty);
    // llvm::errs() << "\n" << record << "\n\n" << load << store;
    fout << "\n" << record << "\n\n" << load << store;
}

std::vector<llvm::StructType*> ExtractBasicsPass::sortTypes(std::vector<llvm::StructType*> vec) {
  std::map<llvm::StructType*, int> predecessor;
  std::map<llvm::StructType*, std::vector<llvm::StructType*> > g;
  std::vector<llvm::StructType*> sorted;
  for(auto ty: vec) predecessor[ty] = 0; 
  for(auto ty: vec) {
    for(llvm::Type* e: ty->elements()) {
      if(llvm::StructType* se = llvm::dyn_cast<llvm::StructType>(e)) {
        predecessor[ty] += 1;
        g[se].push_back(ty);
      } else if(llvm::ArrayType* ae = llvm::dyn_cast<llvm::ArrayType>(e)) {
        if(llvm::StructType* se = llvm::dyn_cast<llvm::StructType>(ae->getElementType())){
          predecessor[ty] += 1;
          g[se].push_back(ty);
        }
      }
    }
  }
  std::queue<llvm::StructType*> q;
  for(auto ty: vec) {
    if(predecessor[ty] == 0)
      q.push(ty);
  }
  while(!q.empty()) {
    llvm::StructType* x = q.front(); q.pop();
    sorted.push_back(x);
    for(auto se: g[x]) {
        predecessor[se] -= 1;
        if( predecessor[se] == 0 ) {
          q.push(se);
        }
    }
  }
  return sorted;
}

bool ExtractBasicsPass::parseDebugInfo(llvm::DIType* ty, std::string name, int count = 0) {
  llvm::DICompositeType* ccty;
  if (name == "") {
    if (ty->getTag() == llvm::dwarf::Tag::DW_TAG_typedef) {
      if (auto dty = llvm::dyn_cast<llvm::DIDerivedType>(ty)) {
        if (!dty->getBaseType()) return false;
        if (auto cty = llvm::dyn_cast<llvm::DICompositeType>(dty->getBaseType())) {
          if (dty->getName().empty()) return false;
          name = dty->getName().str();
          if(parsed_type[name]) return false;
          parsed_type[name] = 1;
          ccty = cty;
        } else return false;
      }
    } else if(ty->getTag() == llvm::dwarf::Tag::DW_TAG_structure_type) {
      if(auto cty = llvm::dyn_cast<llvm::DICompositeType>(ty) ) {
        if(cty->getName().empty()) {
          return false;
        }
        else name = cty->getName().str();
        if(parsed_type[name]) return false;
        parsed_type[name] = 1;
        ccty = cty;
      } else return false;
    } else return false;

    int i = 0;
    for(auto element: ccty->getElements()) {
      if( auto ety = llvm::dyn_cast<llvm::DIType>(element) ) {
        parseDebugInfo(ety, name, i); 
      }
      ++i;
    }

  } else {
    std::string ename;
    if (ty->getName().empty())
      ename = std::to_string(count);
    else
      ename = ty->getName().str();
    field_names[name][count] = ename;
  }
  return true;
}

void ExtractBasicsPass::generateRecordForStruct(llvm::Module &M) {
  file = M.getName().str() + ".datatype.v";
  fout.open(file, std::ios::out | std::ios::trunc);

  llvm::DebugInfoFinder finder;
  finder.processModule(M);
  std::vector<llvm::DICompositeType*> composites;
  std::map<llvm::DIType*, int> visited;

  for (auto ty : finder.types()) {
    parseDebugInfo(ty, "");
  }

  std::vector<llvm::StructType*> s = sortTypes(M.getIdentifiedStructTypes());
  for (llvm::StructType *structType : s) {
    runStruct(structType);
  }

  fout.close();
  std::filesystem::path abs_path = std::filesystem::absolute(file);
  llvm::errs() << "datatype info dumped into:" << abs_path.string() << "\n";
  return;
}  


char ExtractBasicsPass::ID = 0;

static llvm::RegisterPass<ExtractBasicsPass> X(
    "extractbasics", "Extract datatype and global objects",
    false,  // This pass doesn't modify the CFG => true
    false   // This pass is not a pure analysis pass => false
);
