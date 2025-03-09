#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "nodes.h"
#include "project.h"
#include "shortcuts.h"
#include <values.h>


namespace autov {


    bool SpoqIRContext::check_abstraction_pattern(unique_ptr<SpecNode>& value, unique_ptr<SpecNode>& raw, SpoqAbstractionContext& context) {
        if (!value || !raw) { assert(false && "value and raw should not be nullptr"); }
        // std::cout << "------------\n" ;
        // std::cout << "raw: " << string(*raw) << std::endl;
        // std::cout << "spec: " << string(*value) << std::endl;
        // std::cout << "------------\n" ;

        auto raw_raw = raw.get();
        if (auto symbol = dynamic_cast<Symbol*>(raw_raw)) {
            if ( context.is_raw_core(symbol->text) ) {
                // std::cout << "type: " << string(*value->get_type()) << " " << string(*symbol->type) << std::endl;
                // if (Shortcut::_type_eq(value->get_type(), symbol->type)) {
                return context.add_core_map(symbol, value);
                // } 
                // return false;
            } else {
                auto _symbol = dynamic_cast<Symbol*>(value.get());
                if (_symbol && symbol->text == _symbol->text) {
                    return true;
                }
                return false;
            }
        } else if (auto con = dynamic_cast<Const*>(raw_raw)) {
            auto _con = dynamic_cast<Const*>(value.get());
            return (*_con) == (*con);
        } else if (auto expr = dynamic_cast<Expr*>(raw_raw)) {
            if (auto symbol = dynamic_cast<Symbol*>(value.get())) {
                auto cache = get_cache(symbol->text);
                if (!cache) return false;
                return check_abstraction_pattern(cache, raw, context);
            } else if (auto _expr = dynamic_cast<Expr*>(value.get())) {
                if (expr->op != _expr->op) return false;
                if (expr->elems->size() != _expr->elems->size()) return false;
                bool match = true;
                for (int i = 0; i < expr->elems->size(); i++) {
                    match = match && check_abstraction_pattern(_expr->elems->at(i), expr->elems->at(i), context);
                    if (!match) return false;
                }
                return match;
            } 
            return false;
        } else {
            std::cout << string(*raw.get()) << std::endl;
            assert(false && "Abstraction pattern only support Symbol and Expr");
        }
    }

    unique_ptr<SpecNode> SpoqIRContext::construct_abstraction_pattern(unique_ptr<SpecNode> abs, SpoqAbstractionContext& context) {
        auto raw_raw = abs.get();
        // std::cout << "construct_abstraction_pattern: " << string(*abs.get()) << std::endl;
        if (auto symbol = dynamic_cast<Symbol*>(raw_raw)) {
            if (context.is_abs_core(symbol->text)) {
                return context.get_cache(symbol->text);
            } else {
                return abs;
            }
        } else if (auto expr = dynamic_cast<Expr*>(raw_raw)) {
            auto elems = std::make_unique<vector<unique_ptr<SpecNode>>>();
            for (auto &elem: *expr->elems) {
                elems->push_back(construct_abstraction_pattern(std::move(elem), context));
            }
            auto op = expr->deep_copy_op();
            auto _expr = std::make_unique<Expr>(std::move(op), std::move(elems));
            _expr->type  = expr->type;
            return _expr;
        } else if (auto con = dynamic_cast<Const*>(raw_raw)) {
            return abs;
        } else {
            std::cout << "construct_abstraction_pattern: " << string(*abs.get()) << std::endl;
            assert(false && "Abstraction pattern only support Symbol and Expr");
        }
    }

    unique_ptr<SpecNode> SpoqIRContext::apply_abstraction(unique_ptr<SpecNode> spec) {
        for(auto &abstraction: abs_config) {
            auto raw = abstraction.get_raw_node();
            auto context = SpoqAbstractionContext(abstraction);
            // std::cout << "raw: " << string(*raw) << std::endl;
            // std::cout << "spec: " << string(*spec) << std::endl;
            auto ret = check_abstraction_pattern(spec, raw, context);
            // std::cout << "ret: " << ret << std::endl;
            if (ret) 
                return construct_abstraction_pattern(abstraction.get_abs_node(), context);
        }
        return spec;
    }

};