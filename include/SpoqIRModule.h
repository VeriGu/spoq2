#pragma once

#include <llvm-14/llvm/IR/BasicBlock.h>
#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <stdio.h>
#include <unordered_set>
#include <llvm/IR/Instructions.h>
#include "llvm/Transforms/Utils/Cloning.h"
#include <llvm/Transforms/Utils/BasicBlockUtils.h>

#include "SpoqIR.h"

namespace autov {

    class SpoqFunction {
    public:
        llvm::Function* llvm_func = nullptr;
        bool cfg_converted = false;

        spoq_inst_vec_t spoq_insts;
        bool spoq_insts_converted = false;
    };

    class SpoqIRContext {
    public:
        vector<Definition> defs;
        vector<string> args;
        int current;
        std::string suffix;
        bool in_loop;
        bool final_return;
    };

    class SpoqIRModule { 
    public:
        llvm::LLVMContext llvm_context;
        unique_ptr<llvm::Module> llvm_module;
        std::map<std::string, SpoqFunction> spoq_funcs;

        /**
         * @brief load llvm module from llvm bitcode file, revise the function name if there is '.' in it.
         */
        bool load_llvm_module(std::string code_path);


        static std::set<string> get_func_dependencies(llvm::Function* func);

        /**
         * @brief generate the low spec for function `fname` in layer `layer_id`
         * 
         * @param proj 
         * @param fname 
         * @param layer_id 
         * @param low_specs the name for the generated low_specs
         */
        static bool code_to_spec(Project* proj, string fname, int layer_id, std::vector<std::string> &low_specs);

        /**
         * @brief Check if the SpoqFunction is ready for generating low spec.
         * 
         * @param proj 
         * @param fname The name of the function. Must has its definition in LLVM module.
         * @return true A converted SpoqFunc is in spoq_funcs[fname] with all its field set.
         * @return false 
         */
        static bool validate_for_gen_low_spec(Project* proj, string fname, int layer_id);

        /**
         * @brief Similar to Rule 2 in Spoq 1/2, merge any bridges on LLVM IR
         * 
         * @param bb the entry basic block
         * @param skip the set of basic blocks that should be skipped
         */
        static void control_flow_merge_bridge(llvm::BasicBlock* bb, std::set<llvm::BasicBlock*>& skip);

        /**
         * @brief Similar to Rule 4 and 4' in Spoq 1/2, clone and split the branches on LLVM IR by repeatedly 
         * (1) cloneing the basic block with multiple predecessors, and (2) duplicating all its (in)direct 
         * successors. The current version in only valid on DAG.
         * 
         * @param bb 
         * @param ori 
         * @param to_duplicate 
         * @param value_map 
         * @return true 
         * @return false 
         */

        static bool control_flow_clone_and_split(llvm::BasicBlock* bb, llvm::BasicBlock* ori, bool to_duplicate, llvm::ValueToValueMapTy &value_map);

        /**
         * @brief Convert DAG into a tree-like CFG on LLVM IR. 
         * 
         * @param proj 
         * @param fname 
         * @param spoq_func 
         * @return true success
         * @return false 
         */
        static bool control_flow_conversion_DAG(Project* proj, string fname,  SpoqFunction& spoq_func);

        /**
         * @brief Converr any CFG into a form that ready for spoq_inst translation. Set the ``spoq_func.cfg_converted`` to true if success. TODO: support loop.
         * 
         * @param proj 
         * @param fname function name
         * @param spoq_func The spoq_func to be converted. Its `llvm_func` should already be set.
         * @return true 
         * @return false 
         */
        static bool control_flow_conversion_v2(Project* proj, string fname, SpoqFunction& spoq_func);

        /**
         * @brief load all functions with definitions in the this->llvm_module and convert them into SpoqFunction.
         * 
         * @param proj 
         * @return true 
         * @return false 
         */
        bool load_function_and_convert_all(Project* proj);

        /**
         * @brief convert llvm::Type into SpecTYpe
         * 
         * @param type SpecTYpe
         * @return shared_ptr<SpecType> 
         */
        static shared_ptr<SpecType> llvm_ir_type_to_spec(llvm::Type* type);

        // static shared_ptr<SpecNode> spoq_ir_vec_to_spec(Project* proj, string fname, int layer_id,
            // spoq_inst_vec_t& body, SpoqIRContext& context);

    };
}