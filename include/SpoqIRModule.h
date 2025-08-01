#pragma once
#include <string>
#include <irtypes.h>
#include <irvalues.h>
#include <utils.h>
#include <stdio.h>
#include <unordered_set>
#include <stack>

#include "SpoqIR.h"
#include "inline_asm.h"
#include "llvm.h"
#include "nodes.h"
#include "shortcuts.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/LowerSwitch.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Scalar/SROA.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <llvm/Transforms/Utils/BasicBlockUtils.h>




namespace autov {

    class SpoqAbstractionLayout;
    class SpoqAbstraction {
    public:
        unique_ptr<SpecNode> get_raw_node() { return raw_expr->deep_copy_down(); }
        unique_ptr<SpecNode> get_abs_node() { return abs_expr->deep_copy_down(); }

        std::string raw_core_name = "raw";
        unique_ptr<Expr> raw_expr;
        std::string abs_core_name = "abs";
        unique_ptr<Expr> abs_expr;

        std::string raw_spec_name;
        std::string abs_spec_name;

        bool constant_assumption = false;
        std::string abs_wrapper_name;
        unsigned long mem_start; 
        unsigned long mem_size;

        std::set<std::string> in_any_map;
        std::function<std::unique_ptr<SpecNode>(std::map<std::string, unique_ptr<SpecNode>>&)> any_map;
    };

    class SpoqAbstractionLayout {
    public:
        std::string struct_name;
        std::vector<std::pair<std::string, std::pair<int, int>>> fields;

        std::map<std::string, std::string> rich_fields;

        std::vector<SpoqAbstraction> smart_configs;

        void compute_smart_configs(std::unordered_map<string, shared_ptr<SpecType>>& types, bool force_compute = false);
        void compute_and_mask();
        void compute_and_mask_eq();
        void compute_upgrade_or();
        void compute_or();

        // Return is_rich, spec node pair
        std::pair<bool, unique_ptr<SpecNode>> get_elem_as_Z(unique_ptr<SpecNode> record, std::string field);
    };



    class SpoqAbstractionContext {
      public:
        SpoqAbstractionContext(SpoqAbstraction& abs) : abs(abs) {}

        SpoqAbstraction& abs;

        std::map<std::string, unique_ptr<SpecNode>> core_map;

        std::stack<unique_ptr<SpecNode>> stack;

        bool is_raw_core(std::string name) {
            return name == abs.raw_core_name;
        }

        bool is_abs_core(std::string name) {
            return name == abs.abs_core_name;
        }

        bool add_core_map(const Symbol* symbol, unique_ptr<SpecNode>& value) {
            if (core_map.find(symbol->text) != core_map.end()) {
                if (core_map[symbol->text] != value) {
                    return false;
                }
                return true;
            }
            core_map[symbol->text] = value->deep_copy();
            return true;
        }

        unique_ptr<SpecNode> get_cache(std::string name) {
            if (name == abs.abs_core_name) name = abs.raw_core_name;
            else assert(false && "only support abs_core_name");
            if (core_map.find(name) != core_map.end()) {
                return core_map[name]->deep_copy();
            }
            assert(false && "missing core map");
            return nullptr;
        }


    };


    class SpoqAsmProcedure {
      public:
        string name;
        string origin;
        string objdump;
        string body;
    
        SpoqAsmProcedure() = delete;
        SpoqAsmProcedure(string name, string origin, string objdump, string body)
            : name(name), origin(origin), objdump(objdump), body(body) {}
    
        string to_coq() const { return body; }
    };

    class SpoqLoopContext {
        // jump from the loop preheader to the loop guard
        public:
        SpoqLoopContext() = default;
        inline llvm::BasicBlock* get_start() { return preheader; }
        inline llvm::BasicBlock* get_preheader() { if (step_count < 0) return nullptr; return preheader; }
        inline llvm::BasicBlock* get_postheader() { if (step_count < 0) return nullptr; return postheader; }
        inline llvm::BasicBlock* get_loopheader() { if (step_count < 0) return nullptr; return loopheader; }

        void debug_jump() {
            for(auto &pair: jump) {
                llvm::errs() << "jump from: " << *pair.first << "\njump to: " << *pair.second << "\n";
                llvm::errs() << "pass in: ";
                for (auto &bb: pass_in[pair.first]) {
                    llvm::errs() << *bb << " ";
                }
                llvm::errs() << "pass out: ";
                for (auto &bb: pass_out[pair.first]) {
                    llvm::errs() << *bb << " ";
                }
            }
        }

        /**
         * @brief Return if this context is currently in a loop. We can use `context.init() while(context.step())` to iterate the top-layer program and all loops.
         * The loops visited are NOT guarenteed to be in any order. 
         */
        inline bool context_in_loop() { return step_count >= 0; }
        

        inline bool postheader_with_phi(llvm::BasicBlock* bb) {
            for(auto &pair: jump) {
                if( bb == pair.second ) return true;
            }
            return false;
        }

        /**
         * @brief Fix PHI nodes in loop headers and post headers. This must be called if a in-loop basic block is cloned.
         * 
         * @param src The source block
         * @param cloned 
         * @param value_map 
         */
        void fix_headers(llvm::BasicBlock* src, llvm::BasicBlock* cloned, llvm::ValueToValueMapTy &value_map) {
            if(loopheader) {
                for(auto& phi: loopheader->phis()) {
                    for(int i = 0; i < phi.getNumIncomingValues(); i++) {
                        if(phi.getIncomingBlock(i) == src) {
                            auto val = phi.getIncomingValue(i);
                            if (value_map[val] != nullptr ) val = value_map[val];
                            phi.addIncoming(val, cloned);
                        }
                    }
                }
            }
            if(postheader) {
                for(auto& phi: postheader->phis()) {
                    for(int i = 0; i < phi.getNumIncomingValues(); i++) {
                        if(phi.getIncomingBlock(i) == src) {
                            auto val = phi.getIncomingValue(i);
                            if (value_map[val] != nullptr ) val = value_map[val];
                            phi.addIncoming(val, cloned);
                        }
                    }
                }
            }
        }

        /**
         * @brief Check whether this block may changes during control_flow_conversion
         * 
         * @param bb 
         * @param header The current loop (or the top-level function) under revising
         * @return true The basic block is in the current processing loop (or top-level function) and should be revised.
         * @return false 
         */
        inline bool require_fix(llvm::BasicBlock* bb, llvm::BasicBlock* header) {
            if (step_count == -1) return header_map[bb] == nullptr;
            else {
                if (header_map[bb] != header) return false;
                if (bb == postheader || bb == loopheader ) return false;
                return true;
            }
        }

        inline bool require_fix(llvm::BasicBlock* bb) {
            return require_fix(bb, this->preheader);
        }

        /**
         * @brief Check if a basicblock requires clone in the current step context. Note that preheader, loopheader and postheader should never be cloned. This helper function is used to determine whether a successor of a cloned basic block required clone as well.
         * 
         * @param bb 
         * @return true 
         * @return false 
         */
        inline bool require_clone(llvm::BasicBlock* bb) {
            if( bb == preheader || bb == postheader) return false;
            // TODO: Fix me. Use other ways to find the loop header.
            if (step_count >= 0 && preheader->getUniqueSuccessor() == bb) return false;
            assert(header_map[bb] || step_count == -1);
            return true;
        }

        /**
         * @brief Check if a basicblock requires to be spilt into two. Preheader, postheader and loopheader should never split. Any other basicblocks with at least two predesssors should be split into two blocks. And its direct and indirect successors should be cloned.
         * 
         * @param bb 
         * @return true 
         * @return false 
         */
        inline bool require_split(llvm::BasicBlock* bb) {
            if (bb == preheader || bb == postheader) return false;
            // TODO: Fix me. Use other ways to find the loop header.
            if (step_count >= 0 && preheader->getUniqueSuccessor() == bb) return false;
            return llvm::pred_size(bb) >= 2;
        }

        /**
         * @brief Return the target basic block pointer if bb is a preheader, and bb is not the preheader of the visiting loop. This is only valid in a `while(context.step())` context. Use `require_jump_no_step` otehrwise.
         * 
         * @param bb 
         * @return llvm::BasicBlock* 
         */
        inline llvm::BasicBlock* require_jump(llvm::BasicBlock* bb) {
            if(step_count >= 0 && bb == preheader) return nullptr;
            if(jump.find(bb) != jump.end()) return jump[bb];
            return nullptr;
        }

        /**
         * @brief Check if this bb is a preheader for some loop.
         * 
         * @param bb 
         * @return llvm::BasicBlock* 
         */
        inline llvm::BasicBlock* require_jump_no_step(llvm::BasicBlock* bb) {
            if(jump.find(bb) != jump.end()) return jump[bb];
            return nullptr;
        }

        /**
         * @brief After a set of basic blocks are cloned, update the jump map in case any loop get cloned as well.
         * 
         * @param value_map 
         */
        inline void update_jump(llvm::ValueToValueMapTy &value_map) {
            std::vector<std::pair<llvm::BasicBlock*, llvm::BasicBlock*>> records;
            for (auto &pair: jump) {
                auto v1 = llvm::dyn_cast_or_null<llvm::BasicBlock>(value_map[pair.first]);
                auto v2 = llvm::dyn_cast_or_null<llvm::BasicBlock>(value_map[pair.second]);
                assert(((!v1)== (!v2)) && "only one of the jump start and target is duplicated");
                if (v1 && v2) {
                    records.push_back(std::make_pair(v1, v2));
                } 
            }
            for (auto &pair: records) {
                jump[pair.first] = pair.second;
            }
            for (auto &pair: records) {
                steps.push_back(pair.first);
            }
            travel_all();
        }

        /**
         * @brief Travel the function to update the header_map. A basic block is mapped to its inner loop. Preheaders, loopheaders and postheaders have their
         `header_map ` set to the loop's preheader. But some of their instructions may belong to the outter loop after translation.
         * 
         * @param pre 
         * @param post 
         */
        void travel(llvm::BasicBlock* pre, llvm::BasicBlock* post) {
            std::queue<llvm::BasicBlock*> q;
            std::map<llvm::BasicBlock*, bool> visited;
            q.push(pre);
            while (!q.empty()) {
                auto cur = q.front(); q.pop();
                visited[cur] = true;
                if (cur == post) continue;

                auto last = cur->getTerminator();
                if (auto br = llvm::dyn_cast<llvm::BranchInst>(last)) {
                    for (int i = 0; i < br->getNumSuccessors(); i++) {
                        auto succ = br->getSuccessor(i);
                        if (visited[succ]) continue;
                        if (jump.find(succ) != jump.end()) {
                            succ = jump[succ];
                        }
                        else {
                            header_map[succ] = pre;
                        }
                        q.push(succ);
                    }
                }
            }
            header_map[pre] = pre;
        }

        void travel_all() {
            header_map.clear();
            for(auto &pair: jump) {
                travel(pair.first, pair.second);
            }
        }


        /**
         * @brief A preheader and postheader should not be removed by any control flow conversion.
         * 
         * @param bb 
         * @return true 
         * @return false 
         */
        inline bool can_remove(llvm::BasicBlock* bb) {
            for(auto &pair: jump) {
                if(pair.first == bb) return false;
                if(pair.second == bb) return false;
            }
            return true;
        }


        inline void set_jump(llvm::BasicBlock* pre, llvm::BasicBlock* post) {
            jump[pre] = post;
            steps.push_back(pre);
            travel(pre, post);
        }

        spoq_inst_vec_t& get_loop_inst_for_jump(llvm::BasicBlock* jump_start) {
            assert(loop_insts.find(jump_start) != loop_insts.end() && "loop_insts does not contain the jump start");
            return *loop_insts[jump_start];
        }

        spoq_inst_vec_t& get_loop_inst_for_jump() {
            return get_loop_inst_for_jump(preheader);
        }

        bool has_loop_inst_for_jump(llvm::BasicBlock* jump_start) {
            return loop_insts.find(jump_start) != loop_insts.end();
        }

        void set_loop_inst_for_jump(llvm::BasicBlock* jump_start, spoq_inst_vec_t& loop_inst_vec) {
            loop_insts[jump_start] = &loop_inst_vec;
        }

        /**
         * @brief With `context.step()`, it provides a way to iterate all loops and the top-level program in a function.
         * 
         * @param func 
         */
        void init(llvm::Function* func) {
            step_count = -2;
            preheader = &func->getEntryBlock();
            postheader = nullptr;
        }

        /**
         * @brief The step in operation used when converting CFG.
         */
        bool step() {
            ++step_count;
            if (step_count == -1) return true; // Top level function
            if (step_count < steps.size()) {
                preheader = steps[step_count];
                loopheader = preheader->getUniqueSuccessor();
                assert(loopheader && "loopheader does not exist");
                postheader = jump[preheader];
                return true;
            }
            return false;
        }

        inline void add_header_phi(llvm::PHINode* phi) {
            assert(step_count >= 0 && preheader && "A in-loop phi node does not have a header");
            header_phi[preheader].push_back(phi);
        }

        inline void add_postheader_phi(llvm::PHINode* phi) {
            assert(step_count >= 0 && preheader && "A in-loop phi node does not have a header");
            postheader_phi[preheader].push_back(phi);
        }

        /**
         * @brief This versioned is used in a context.step() context. We are walking on the simple form of loop. (See LLVM documentation). We require a preheader and exists and it has a unique 
         successor (the loopheader). Any predecessors of the loopheader is either the preheader or a latch block.
         * 
         * @param src 
         * @param dst 
         * @return We 
         */
        inline bool is_backward(llvm::BasicBlock* src, llvm::BasicBlock* dst) {
            if (step_count < 0) return false;
            if (src != preheader && dst == loopheader) return true;
            return false;
        }

        inline bool is_backward(llvm::BasicBlock* src, llvm::BasicBlock* dst, llvm::BasicBlock* current_preheader) {
            if (src != current_preheader && dst == current_preheader->getUniqueSuccessor()) return true;
            return false;
        }

        /**
         * @brief After exiting preprocessing, any exiting block must first jump to the postheader. Thus, a block is exiting if and only if it jumps to the postheader.
         * 
         * @param src 
         * @param dst 
         * @return true 
         * @return false 
         */
        inline bool is_exiting(llvm::BasicBlock* src, llvm::BasicBlock* dst) {
            if (step_count < 0) return false;
            if (dst == postheader) return true;
            return false;
        }

        // A map from preheader -> PHI nodes in loop header
        std::map<llvm::BasicBlock*, std::vector<llvm::PHINode*>> header_phi;

        // A map from preheader -> PHI nodes in post header
        std::map<llvm::BasicBlock*, std::vector<llvm::PHINode*>> postheader_phi;

        /**
         * @brief Different from the basicblock-level phi nodes, the real_header is instruction-level and reflects where the value can be accessed in Spec. All branch instructions are not translated. All instructions in preheader and postheader are treated as in the OUTTER loop.
         * 
         * @param v1 
         * @return llvm::BasicBlock* 
         */
        inline llvm::BasicBlock* real_header(llvm::Instruction* v1) {
            auto bb = v1->getParent();
            if (header_map.find(bb) == header_map.end()) return nullptr;
            auto preh = header_map[bb];
            if (preh == nullptr) return nullptr;
            auto posth = jump[preh];

            // Preheader and postheader are computed in the outter loop.
            if (v1->getParent() == preh) return outter_loop_header[preh];
            if (v1->getParent() == posth) return outter_loop_header[preh];
            return preh;
        }

        /**
         * @brief update the `outter_loop_header` to maintain a loop order. This field is not updated until spec generation. We may need to advance this in the futrue.
         * 
         * @param in 
         * @param out 
         */
        void update_parent(llvm::BasicBlock* in, llvm::BasicBlock* out) {
            if (out == nullptr) return;
            outter_loop_header[in] = out;
        }

        /**
         * @brief Given the current (loop) stack, and a `val` used in block `def`, update the `pass_in` and `pass_out` for all related loops.  It finds the nearest common parent between the defintion and the current loop in the loop forest, then let `pass_in[parent....def] = val` and `pass_out[parent....currentloop] = val`. 
         * 
         * @param def 
         * @param vec 
         * @param val 
         */
        void recursive_update_pass(llvm::BasicBlock* def, std::vector<llvm::BasicBlock*>& vec, llvm::Value* val) {
            auto loop = def;
            std::vector<llvm::BasicBlock*>::reverse_iterator it = vec.rend();
            while (loop != nullptr) {
                bool found = false;
                for(it = vec.rbegin(); it != vec.rend(); it++) {
                    if (*it == loop) {
                        found = true;
                        break;
                    }
                }
                if (found) break;
                add_pass_out(loop, val);
                loop = outter_loop_header[loop];
            }
            auto common_parent = loop;
            for(auto rit = vec.rbegin(); rit != it; rit++) {
                if (*rit == common_parent) break;
                add_pass_in(*rit, val);
            }
        }

        // Add pass in value and handle duplicated cases.
        void add_pass_in(llvm::BasicBlock* bb, llvm::Value* v) {
            for (auto &val: pass_in[bb]) {
                if (val == v) return;
            }
            pass_in[bb].push_back(v);
        }

        // Add pass out value and handle duplicated cases.
        void add_pass_out(llvm::BasicBlock* bb, llvm::Value* v) {
            for (auto &val: pass_out[bb]) {
                if (val == v) return;
            }
            pass_out[bb].push_back(v);
        }

        std::map<llvm::BasicBlock*, std::vector<llvm::Value*>> pass_in;
        std::map<llvm::BasicBlock*, std::vector<llvm::Value*>> pass_out;
        std::map<llvm::BasicBlock*, llvm::BasicBlock*> outter_loop_header;



        private:
        llvm::BasicBlock* preheader = nullptr;
        llvm::BasicBlock* postheader = nullptr;
        llvm::BasicBlock* loopheader = nullptr;

        std::map<llvm::BasicBlock*, llvm::BasicBlock*> jump;
        std::map<llvm::BasicBlock*, llvm::BasicBlock*> header_map;
        std::map<llvm::BasicBlock*, spoq_inst_vec_t*> loop_insts;



        std::vector<llvm::BasicBlock*> steps;
        int step_count = -2;
    };

    class SpoqFunction {
    public:
        llvm::Function* llvm_func = nullptr;
        SpoqLoopContext loop_context;
        bool cfg_converted = false;

        spoq_inst_vec_t spoq_insts;
        bool spoq_insts_converted = false;
    };

     class SpoqIRContext {
    public:

        SpoqIRContext(SpoqFunction& spoq_func_, unique_ptr<Layer>& layer, int id, std::vector<SpoqAbstraction>& abs_config,
            std::vector<SpoqAbstractionLayout>& abs_layout) :  abs_config(abs_config), abs_layout(abs_layout), spoq_func(spoq_func_) {
            if(layer->ops["load"] != "") load_op_name = layer->ops["load"];
            if(layer->ops["store"] != "") store_op_name = layer->ops["store"];
            if(layer->ops["ptr2int"] != "") ptr2int_op_name = layer->ops["ptr2int"];
            if(layer->ops["int2ptr"] != "") int2ptr_op_name = layer->ops["int2ptr"];
            if(layer->ops["ptr_eqb"] != "") ptr_eqb_op_name = layer->ops["ptr_eqb"];
            if(layer->ops["ptr_ltb"] != "") ptr_ltb_op_name = layer->ops["ptr_ltb"];
            if(layer->ops["ptr_offset"] != "") ptr_off_op_name = layer->ops["ptr_offset"];
            if(layer->abs_data != nullptr) abs_data_type = layer->abs_data;
            else assert(false && "abs_data_type is nullptr");
            llvm_dl = &spoq_func.llvm_func->getParent()->getDataLayout();
            layer_id = id;
        }
        int counter = 0;

        std::vector<SpoqAbstraction>& abs_config;
        std::vector<SpoqAbstractionLayout>& abs_layout;
        std::vector<unique_ptr<Expr>> abs_rely;
        std::map<unsigned int, bool> abs_const_checked;
        const std::string abs_data_name = "st";
        shared_ptr<SpecType> abs_data_type = nullptr;
        std::string load_op_name = "load_RData";
        std::string store_op_name = "store_RData";
        std::string ptr2int_op_name = "ptr_to_int";
        std::string int2ptr_op_name = "int_to_ptr";
        std::string ptr_eqb_op_name = "ptr_eqb";
        std::string ptr_ltb_op_name = "ptr_ltb";
        std::string ptr_off_op_name = "ptr_offset";

        vector<Definition> defs;
        vector<string> args;
        int current;
        int layer_id = 0;
        std::string suffix;
        bool in_loop;
        bool final_return;
        SpoqFunction& spoq_func;

        const llvm::DataLayout* llvm_dl;

        std::string fname() { return spoq_func.llvm_func->getName().str(); }


        shared_ptr<SpecType> rettype = make_shared<SpecType>("Void");

        std::map<llvm::Value*, std::string> value_map;
        std::map<llvm::Value*, shared_ptr<SpecType>> type_map;
        std::map<llvm::Value*, shared_ptr<SpecType>> abs_type_map;

        std::map<llvm::Value*, std::unique_ptr<SpecNode>> value_cache;

        std::string arg_require_abstraction(llvm::Function* func, int arg) {
            if (func == nullptr) return "";
            auto arg_name = "arg_" + std::to_string(arg);
            auto metanode = func->getMetadata(arg_name);
            if (metanode == nullptr) return "";
            if (auto metastr = llvm::dyn_cast_or_null<llvm::MDString>(metanode->getOperand(0))) {
                auto str = metastr->getString();
                return str.str();
            }
            return "";
        }

        std::string ret_require_abstraction(llvm::Function* func, int arg) {
            if (func == nullptr) return "";
            auto arg_name = "ret_" + std::to_string(arg);
            auto metanode = func->getMetadata(arg_name);
            if (metanode == nullptr) return "";
            if (auto metastr = llvm::dyn_cast_or_null<llvm::MDString>(metanode->getOperand(0))) {
                auto str = metastr->getString();
                return str.str();
            }
            return "";
        }

        std::string symbol_require_abstraction(llvm::Function* func, std::string name) {
            if (func == nullptr) return "";
            auto metanode = func->getMetadata(name);
            if (metanode == nullptr) return "";
            if (auto metastr = llvm::dyn_cast_or_null<llvm::MDString>(metanode->getOperand(0))) {
                auto str = metastr->getString();
                return str.str();
            }
            return "";
        }

        std::unique_ptr<SpecNode> is_ptr_to_int(llvm::Value* value) {
            if (auto expr = llvm::dyn_cast<llvm::ConstantExpr>(value)) {
                if (expr->getOpcode() == llvm::Instruction::PtrToInt) {
                    return get_llvm_value_spec(value);
                }
                return nullptr;
            } 
            else if (auto inst = llvm::dyn_cast<llvm::PtrToIntInst>(value)) {
                auto operands = std::make_unique<vector<unique_ptr<SpecNode>>>();
                operands->push_back(get_llvm_value_spec(inst->getPointerOperand()));
                return std::make_unique<Expr>(ptr2int_op_name, std::move(operands));
            } 
            else if (auto inst = llvm::dyn_cast<llvm::CastInst>(value)) {
                return is_ptr_to_int(inst->getOperand(0));
            }
            return nullptr;
        }

        std::unique_ptr<SpecNode> ptr2int_to_field(unique_ptr<SpecNode>& ptr, std::string field) {
            auto ptr2int = dynamic_cast<Expr*>(ptr.get());
            assert(ptr2int && ptr2int->elems->size() == 1 && "ptr2int has <>1 element");
            auto record = ptr2int->elems->at(0)->deep_copy();
            return Shortcut::_field_u(std::move(record), field);
        }

        SpoqLoopContext& get_loop_context() {
            return spoq_func.loop_context;
        }

        inline std::string get_llvm_value_name(llvm::Value* value) {
            if(value_map[value] != "") return value_map[value];
            auto name = value->getName().str();
            name = Shortcut::replace_dot(name);
            if(name == "") name = "v_" + std::to_string(counter++);
            value_map[value] = name;
            return name;
        }

        inline unique_ptr<SpecNode> get_abs_data() {
            assert(abs_data_type != nullptr && "abs_data_type is nullptr");
            return std::make_unique<Symbol>(abs_data_name, abs_data_type);
        }

        // This function gives a temporary name for the middle value in case a pointer is read from memory directly.
        inline unique_ptr<SpecNode> get_llvm_value_spec_ptr_in_Z(llvm::Value* value) {
            auto name = get_llvm_value_name(value) + "_ptr_in_Z";
            return std::make_unique<Symbol>(name, Int::INT);
        }

        /**
         * @brief Get the llvm value spec unique_ptr object. 
         * 
         * @param value 
         * @return unique_ptr<SpecNode> 
         */
        unique_ptr<SpecNode> get_llvm_value_spec(llvm::Value* value, llvm::Type* force_sym_type = nullptr, bool abstraction = true);

        /**
         * @brief Get the llvm value type. TODO: use pointer abstraction here
         * 
         * @param value 
         * @param context 
         * @return shared_ptr<SpecType> 
        */
        shared_ptr<SpecType> get_llvm_value_type(llvm::Value* value);

        /**
         * @brief Compute the return type of the loop spec and the brea kinstruction. The abs_data is included. It should be type of Opton<Tuple<t1,t2,...,abs_data_type>> or Option<abs_data_type>
         * 
         * @param preheader 
         * @return shared_ptr<SpecType> 
         */
        shared_ptr<SpecType> compute_loop_return_type(llvm::BasicBlock* preheader) {
            std::shared_ptr<std::vector<std::shared_ptr<SpecType>>> ret = std::make_shared<std::vector<std::shared_ptr<SpecType>>>();
            for(auto &val: spoq_func.loop_context.pass_in[preheader]) {
                ret->push_back(get_llvm_value_type(val));
            }
            for(auto &val: spoq_func.loop_context.header_phi[preheader]) {
                ret->push_back(get_llvm_value_type(val));
            }
            for(auto &phi: spoq_func.loop_context.pass_out[preheader]) {
                ret->push_back(get_llvm_value_type(phi));
            }
            for(auto &phi: spoq_func.loop_context.postheader_phi[preheader]) {
                ret->push_back(get_llvm_value_type(phi));
            }
            if (ret->size() == 0) return std::make_shared<Option>(abs_data_type);
            else ret->push_back(abs_data_type);
            return std::make_shared<Option>(std::make_shared<Tuple>(ret));
        }

        /**
         * @brief Update the return list as if encountering a break instruction. This function is used in the loop conversion.
         * Note we need a quick dominator tree check here. A value may only dominates some of the exiting blocks. After constructing the postheader, this may cause a conflicts where a non-dominating value is requried to be returned, but will never be used outside of the loop for the returning branch. An undefined value is returned to pass type check. It should be optimized out in the final spec generation.
         * 
         * @param exiting 
         */
        void update_loop_break_return_list(llvm::BasicBlock* exiting) {
            assert(!pass_stack.empty() && "pass_stack is empty, break but not in loop");
            auto preheader = pass_stack.top();
            // TODO: stop reconstructing FAM every time
            llvm::FunctionAnalysisManager FAM;
            llvm::PassBuilder PB;
            PB.registerFunctionAnalyses(FAM);
            llvm::DominatorTree& dt = FAM.getResult<llvm::DominatorTreeAnalysis>(*preheader->getParent());
            for(auto &val: spoq_func.loop_context.pass_in[preheader]) {
                return_list.push_back(val);
            }
            for(auto &val: spoq_func.loop_context.header_phi[preheader]) {
                return_list.push_back(val);
            }
            for(auto &phi: spoq_func.loop_context.pass_out[preheader]) {
                if (auto inst = llvm::dyn_cast<llvm::Instruction>(phi)) {
                   if (!dt.dominates(inst, exiting) && inst->getParent() != exiting) {
                        return_list.push_back(llvm::UndefValue::get(phi->getType()));
                        continue;
                    }
                } 
                return_list.push_back(phi);
            }
            for(auto &phi: spoq_func.loop_context.postheader_phi[preheader]) {
                auto val = phi->getIncomingValueForBlock(exiting);
                return_list.push_back(val);
            }
            return;
        }

        /**
         * @brief Compute the actual return SpecNode list of a loop break instruction
         * 
         * @param preheader 
         * @return std::unique_ptr<std::vector<std::unique_ptr<SpecNode>>> 
         */
        std::unique_ptr<std::vector<std::unique_ptr<SpecNode>>> compute_loop_break_return_list(llvm::BasicBlock* preheader) {
            auto ret = std::make_unique<std::vector<std::unique_ptr<SpecNode>>>();
            for(auto &val: spoq_func.loop_context.pass_in[preheader]) {
                ret->push_back(std::make_unique<Symbol>(get_llvm_value_name(val) + "_after", get_llvm_value_type(val)));
            }
            for(auto &val: spoq_func.loop_context.header_phi[preheader]) {
                ret->push_back(std::make_unique<Symbol>(get_llvm_value_name(val) + "_after", get_llvm_value_type(val)));
            }
            for(auto &phi: spoq_func.loop_context.pass_out[preheader]) {
                ret->push_back(get_llvm_value_spec(phi));
            }
            for(auto &phi: spoq_func.loop_context.postheader_phi[preheader]) {
                ret->push_back(get_llvm_value_spec(phi));
            }
            ret->push_back(get_abs_data());
            return ret;
        }

        /**
         * @brief Compute the Arg used for in the continue-translated tail recursive call.
         * 
         * @param preheader 
         * @return std::unique_ptr<std::vector<std::shared_ptr<Arg>>> 
         */
        std::unique_ptr<std::vector<std::shared_ptr<Arg>>> 
        compute_loop_spec_arg(llvm::BasicBlock* preheader) { 
            auto arg_list = std::make_unique<std::vector<std::shared_ptr<Arg>>>();
            for (auto &val: spoq_func.loop_context.pass_in[preheader]) {
                arg_list->push_back(std::make_shared<Arg>(get_llvm_value_name(val), get_llvm_value_type(val)));
            }
            for(auto &val: spoq_func.loop_context.header_phi[preheader]) {
                arg_list->push_back(std::make_shared<Arg>(get_llvm_value_name(val), get_llvm_value_type(val)));
            }
            int i = 0;
            for(auto &out: spoq_func.loop_context.pass_out[preheader]) {
                arg_list->push_back(std::make_shared<Arg>("arg_dummy" + std::to_string(i), get_llvm_value_type(out)));
                ++i;
            }
            for(auto &out: spoq_func.loop_context.postheader_phi[preheader]) {
                arg_list->push_back(std::make_shared<Arg>("arg_dummy" + std::to_string(i), get_llvm_value_type(out)));
                ++i;
            }
            arg_list->push_back(std::make_shared<Arg>(abs_data_name, abs_data_type));
            return arg_list;
        }

        /**
         * @brief Compute the continue return arg list for the loop. This function is used in the loop conversion.
         * 
         * @param latch 
         * @param preheader 
         * @return std::vector<llvm::Value*> 
         */
        std::vector<llvm::Value*> compute_loop_continue_arg_list(llvm::BasicBlock* latch, llvm::BasicBlock* preheader = nullptr, int *guard = nullptr) {
            std::vector<llvm::Value*> arg_list;
            if (!preheader) {
                assert(!pass_stack.empty() && "pass_stack is empty, break but not in loop");
                preheader = pass_stack.top();
            }
            for (auto &val: spoq_func.loop_context.pass_in[preheader]) {
                arg_list.push_back(val);
            }
            for(auto &phi: spoq_func.loop_context.header_phi[preheader]) {
                auto val = phi->getIncomingValueForBlock(latch);
                arg_list.push_back(val);
            }
            for(auto &out: spoq_func.loop_context.pass_out[preheader]) {
                arg_list.push_back(llvm::UndefValue::get(out->getType()));
            }
            for(auto &out: spoq_func.loop_context.postheader_phi[preheader]) {
                arg_list.push_back(llvm::UndefValue::get(out->getType()));
            }
            if (guard) *guard = spoq_func.loop_context.pass_in[preheader].size() + spoq_func.loop_context.header_phi[preheader].size();
            return arg_list;
        }

        std::string get_loop_spec_name(llvm::BasicBlock* bb = nullptr) {
            if (bb == nullptr) {
                assert(!pass_stack.empty() && "pass_stack is empty, not in loop but want a name");
                bb = pass_stack.top();
            }
            if (loop_spec_name.find(bb) != loop_spec_name.end()) {
                return loop_spec_name[bb];
            }
            auto size = (loop_spec_name.size());
            loop_spec_name[bb] = spoq_func.llvm_func->getName().str() + "_loop_" + std::to_string(size) + "_low";
            return loop_spec_name[bb];
        }

        // The current loop we are in
        std::stack< llvm::BasicBlock* > pass_stack;
        std::map<llvm::BasicBlock*, std::string> loop_spec_name;

        // A preheader -> SpecNode map for all loop_spec
        // std::map<llvm::BasicBlock*, unique_ptr<SpecNode>> loop_spec;

        bool return_none = false;
        std::vector<llvm::Value*> return_list;

        std::unique_ptr<SpecNode> continue_return;

        bool check_abstraction_pattern(unique_ptr<SpecNode>& value, unique_ptr<SpecNode>& raw, SpoqAbstractionContext& abs_context);

        unique_ptr<SpecNode> construct_abstraction_pattern(unique_ptr<SpecNode> raw, SpoqAbstractionContext& abs_context); 

        unique_ptr<SpecNode> apply_abstraction(unique_ptr<SpecNode> spec);

        std::map<std::string, unique_ptr<SpecNode>> let_cache;

        bool try_add_cache(std::string value, unique_ptr<SpecNode>& spec) {
            if (let_cache.find(value) != let_cache.end()) return false;
            let_cache[value] = spec->deep_copy();
            return true;
        }

        void add_cache(std::string value, unique_ptr<SpecNode>& spec) {
            let_cache[value] = spec->deep_copy();
        }

        void add_cache(std::string value, unique_ptr<Expr>& spec) {
            let_cache[value] = spec->deep_copy();
        }

        unique_ptr<SpecNode> get_cache(std::string value) {
            if (let_cache.find(value) == let_cache.end()) return nullptr;
            return let_cache[value]->deep_copy();
        }

        unique_ptr<SpecNode> get_unique_cache(std::string value) {
            if (let_cache.find(value) == let_cache.end()) return nullptr;
            return std::move(let_cache[value]);
        }




    };



    class SpoqIRModule { 
    public:
        int iasm_count = 0;
        llvm::LLVMContext llvm_context;
        unique_ptr<llvm::Module> llvm_module;
        std::map<std::string, SpoqFunction> spoq_funcs;

        /**
         * @brief Contains the inline assembly cannot be automatically solved.
         */
        std::map<llvm::Value*, std::string> iasm2func;
        /**
         * @brief Contains the solved inline asm with a map objd -> function name
         * 
         */
        std::map<std::string, std::string> iasm_objd_cache;
        /**
         * @brief All assembly definition.
         * TODO: dump them somewhere
         */
        std::map<std::string, shared_ptr<SpoqAsmProcedure>> iasm_defs;

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
        static bool code_to_spec(Project* proj, string fname, int layer_id, std::vector<std::string> &low_specs, std::unordered_map<string, string> &name_map);

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
         * @brief Similar to Rule 2 in Spoq 1/2, merge any bridges on LLVM IR. This function will breaks 
         the header_map information and a context.travel_all() is required after this function.
         * 
         * @param bb the entry basic block
         * @param skip the set of basic blocks that should be skipped
         */
        static void control_flow_merge_bridge(llvm::BasicBlock* bb, std::set<llvm::BasicBlock*>& skip, SpoqLoopContext& context);

        /**
         * @brief Similar to Rule 4 and 4' in Spoq 1/2, clone and split the branches on LLVM IR by repeatedly 
         * (1) cloneing the basic block with multiple predecessors, and (2) duplicating all its (in)direct 
         * successors. The current version in only valid on DAG.
         * @return true 
         * @return false 
         */

        static bool control_flow_clone_and_split(llvm::BasicBlock* bb, SpoqLoopContext& );

        static bool control_flow_duplicate(llvm::BasicBlock* bb, llvm::BasicBlock* ori, llvm::ValueToValueMapTy &value_map, SpoqLoopContext& );

        /**
         * @brief Eliminate select instruction in the function. Replace the original
         basic block with [ inst_list :: br select_cond]  --> 
         [Block 0: v0 = s0]  [Block 1: v1 = s1] --> [ phi_node :: inst_list ]
         * 
         * @param func 
         * @return true The func is changed
         * @return false 
         */
        static bool control_flow_elinminate_select(llvm::Function* func);

        /**
         * @brief Convert DAG into a tree-like CFG on LLVM IR. 
         * 
         * @return true success
         * @return false 
         */
        static bool control_flow_conversion_DAG(Project* proj, string fname,  SpoqFunction& spoq_func, SpoqLoopContext& );

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
         * @brief convert llvm::Type into SpecType. This is a pure translation without 
         * using any pointer abstraction.
         * @param type SpecTYpe
         * @return shared_ptr<SpecType> 
         */
        static shared_ptr<SpecType> llvm_ir_type_to_spec_pure(llvm::Type* type);


        static void dfs_llvm_ir_to_spoq_inst_vec(llvm::BasicBlock* block, llvm::BasicBlock* parent, spoq_inst_vec_t& vec, SpoqLoopContext& context);

        static bool llvm_ir_to_spoq_ir(SpoqFunction &spoq_func);

        static unique_ptr<SpecNode> spoq_inst_to_spec(Project *proj, spoq_inst_vec_t&, int, SpoqIRContext& context);

        static std::pair<unique_ptr<SpecNode>, unique_ptr<SpecNode>> store_load_to_spec(llvm::Instruction* inst, SpoqIRContext& context);

        /** Handle both GEP expr and GEP inst*/
        static std::pair<unique_ptr<SpecNode>, unique_ptr<SpecNode>> gep_inst_to_spec(llvm::Value* gep_inst_or_expr, SpoqIRContext& context);

        static const std::unordered_map<llvm::Instruction::BinaryOps, Expr::binops> binops_lut;

        static const std::unordered_map<llvm::Instruction::BinaryOps, Expr::binops> bool_binops_lut;

        static const std::unordered_map<llvm::CmpInst::Predicate, Expr::binops> cmpops_lut;

        std::pair<int, int> extract_inline_asm(SpoqFunction& func);

        int find_inline_asm(spoq_inst_vec_t& inst_vec);

        static std::string llvm_ir_type_to_str(llvm::Type* type, bool input);

        /**
         * @brief A pass in and out ananlysis for loop. This is required for generating reasoning loop spec. See details in `recursive_update_pass`.
         */
        static void pass_analysis(llvm::BasicBlock* block, std::vector<llvm::BasicBlock*>& stack,  SpoqLoopContext& context);

        SpoqIRIASM parse_inline_asm(string fname, string asm_text, llvm::Type* rettype,
            vector<llvm::Type*> &arglist, string constraints);

        /**
         * @brief Preprocess the llvm module to fix function and global variable names. It runs LowerSwitchPass and SROA pass to simplify the llvm module. (Should we run SROA here?)
         * 
         */
        void preprocess_llvm_module();

        // Used for debug only.
        bool store_llvm_module(std::string code_path = "converted.ll") {
            std::error_code EC;
            llvm::raw_fd_ostream OS(code_path, EC, llvm::sys::fs::OF_Text);
            if (EC || !llvm_module) return false;
            llvm_module->print(OS, nullptr);
            OS.flush();
            return true;
        }

    };
}