#include "SpoqIR.h"
#include "SpoqIRModule.h"
#include "log.h"
#include "nodes.h"
#include "project.h"
#include "shortcuts.h"
#include <unordered_map>
#include <values.h>

namespace autov {


std::pair<bool, unique_ptr<SpecNode>> SpoqAbstractionLayout::get_elem_as_Z(unique_ptr<SpecNode> record, std::string field) {
    if (rich_fields.find(field) != rich_fields.end()) {
        auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
        vec->push_back(Shortcut::_field_u(std::move(record), field));
        return {true, std::make_unique<Expr>(rich_fields[field] + "_to_Z", std::move(vec))};
    } else {
        return {false, Shortcut::_field_u(std::move(record), field)};
    }
}

void SpoqAbstractionLayout::compute_and_mask() {
    // (ABS_to_Z raw) & MASK
    smart_configs.push_back(SpoqAbstraction());
    auto &abs = smart_configs.back();
    auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::make_unique<Symbol>(abs.raw_core_name));
    abs.raw_expr = std::make_unique<Expr>(struct_name + "_to_Z", std::move(vec));
    vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::move(abs.raw_expr));
    vec->push_back(std::make_unique<Symbol>("any_mask"));
    abs.raw_expr = std::make_unique<Expr>(Expr::binops::BITAND, std::move(vec));

    abs.in_any_map.insert("any_mask");

    auto that = this;
    auto name = abs.abs_core_name;
    abs.any_map = [that, name](std::map<std::string, unique_ptr<SpecNode>>& core_map) -> std::unique_ptr<SpecNode> {
        if (auto int_con = dynamic_cast<IntConst *>(core_map["any_mask"].get())) {
            std::vector<unique_ptr<SpecNode>> components;
            for (auto &field : that->fields) {
                auto flag = ((1LL << (field.second.second - field.second.first + 1)) - 1) << field.second.first;
                // std::cout << "flag: " << flag << " field: " << field.first
                        //   << " " << field.second.first << " "
                        //   << field.second.second << std::endl;
                auto [rich, elem] = that->get_elem_as_Z(std::make_unique<Symbol>(name), field.first);
                if ((int_con->get_value() & flag) == flag) {
                    if (field.second.first > 0 && !rich) {
                        auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                        vec->push_back(std::move(elem));
                        vec->push_back(std::make_unique<IntConst>(1LL << field.second.first));
                        components.push_back(std::make_unique<Expr>(Expr::binops::MULT, std::move(vec)));
                    } else {
                        components.push_back(std::move(elem));
                    }
                } else if ((int_con->get_value() & flag) == 0) {
                    continue;
                } else {
                    // Partial and
                    if ( field.second.first == 0 ) {
                        auto ones = __builtin_popcount(int_con->get_value());
                        if (ones < field.second.second && ((1LL << ones) - 1) == int_con->get_value()) {
                            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                            vec->push_back(std::move(elem));
                            vec->push_back(std::make_unique<IntConst>(1LL << ones));
                            return std::make_unique<Expr>(Expr::binops::MOD, std::move(vec));
                        } else {
                            auto rev_val = ~(int_con->get_value());
                            auto ones = __builtin_popcount(rev_val);
                            if (ones < field.second.second && ((1LL << ones) - 1) == rev_val) {
                                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                                vec->push_back(std::move(elem));
                                vec->push_back(std::make_unique<IntConst>(1LL << ones));
                                auto expr = std::make_unique<Expr>(Expr::binops::DIV, std::move(vec));
                                vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                                vec->push_back(std::move(elem));
                                vec->push_back(std::make_unique<IntConst>(1LL << ones));
                                return std::make_unique<Expr>(Expr::binops::MULT, std::move(vec));
                            }
                        }
                        return nullptr;
                    } else return nullptr;
                }
            }
            if (components.empty())
                return nullptr;
            for (int i = 1; i < components.size(); i++) {
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::move(components[0]));
                vec->push_back(std::move(components[i]));
                components[0] =
                    std::make_unique<Expr>(Expr::binops::ADD, std::move(vec));
            }
            // std::cout << "return: " << string(*components[0].get()) << std::endl;
            return std::move(components[0]);
        };
        return nullptr;
    };
}

void SpoqAbstractionLayout::compute_and_mask_eq() {
    // // (ABS_to_Z raw) & MASK
    smart_configs.push_back(SpoqAbstraction());
    auto &abs = smart_configs.back();
    auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::make_unique<Symbol>(abs.raw_core_name));
    abs.raw_expr = std::make_unique<Expr>(struct_name + "_to_Z", std::move(vec));
    vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::move(abs.raw_expr));
    vec->push_back(std::make_unique<Symbol>("any_mask"));
    abs.raw_expr = std::make_unique<Expr>(Expr::binops::BITAND, std::move(vec));
    vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::move(abs.raw_expr));
    vec->push_back(std::make_unique<Symbol>("any_mask_result"));
    abs.raw_expr = std::make_unique<Expr>(Expr::binops::BEQ, std::move(vec));

    abs.in_any_map.insert("any_mask");
    abs.in_any_map.insert("any_mask_result");

    auto that = this;
    auto name = abs.abs_core_name;
    abs.any_map = [that, name](std::map<std::string, unique_ptr<SpecNode>>& core_map) -> std::unique_ptr<SpecNode> {
        if (!core_map["any_mask"] || !core_map["any_mask_result"]) {
            return nullptr;
        }
        auto mask = dynamic_cast<IntConst *>(core_map["any_mask"].get());
        auto mask_result = dynamic_cast<IntConst *>(core_map["any_mask_result"].get());
        std::vector<unique_ptr<SpecNode>> components;
        if (mask_result) {
          for (auto &field : that->fields) {
              auto flag = ((1LL << (field.second.second - field.second.first + 1)) - 1) << field.second.first;
            //   std::cout << "flag: " << flag << " field: " << field.first << " " << field.second.first << " " << field.second.second << std::endl;

              auto [rich, elem] = that->get_elem_as_Z(std::make_unique<Symbol>(name), field.first);
              if ((mask->get_value() & flag) == flag) {
                  auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                  vec->push_back(std::move(elem));
                  if (!rich)
                    vec->push_back(std::make_unique<IntConst>( (mask_result->get_value() & flag) >> field.second.first));
                  else 
                    vec->push_back(std::make_unique<IntConst>( (mask_result->get_value() & flag)));
                  components.push_back(std::make_unique<Expr>(Expr::binops::BEQ, std::move(vec)));
              }
          }
        } else {
          // Go with an aggresive method
          for (auto &field : that->fields) {
              auto flag = ((1LL << (field.second.second - field.second.first + 1)) - 1) << field.second.first;
            //   std::cout << "flag: " << flag << " field: " << field.first << " " << field.second.first << " " << field.second.second << std::endl;

              auto [rich, elem] = that->get_elem_as_Z(std::make_unique<Symbol>(name), field.first);
              if ((mask->get_value() & flag) == flag) {
                  auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                  std::unique_ptr<SpecNode> expr;
                  if (!rich) {
                    vec->push_back(core_map["any_mask_result"]->deep_copy());
                    vec->push_back(std::make_unique<IntConst>(1LL << field.second.first));
                    expr = std::make_unique<Expr>(Expr::binops::DIV, std::move(vec));

                    vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                    vec->push_back(std::move(expr));
                    vec->push_back(std::make_unique<IntConst>(1LL << (field.second.second - field.second.first + 1)));
                    expr = std::make_unique<Expr>(Expr::binops::MOD, std::move(vec));

                    vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                  } else {
                    vec->push_back(core_map["any_mask_result"]->deep_copy());
                    vec->push_back(std::make_unique<IntConst>(1LL << (field.second.second + 1)));
                    expr = std::make_unique<Expr>(Expr::binops::MOD, std::move(vec));
                  }
                  vec->push_back(std::move(elem));
                  vec->push_back(std::move(expr));
                  components.push_back(std::make_unique<Expr>(Expr::binops::BEQ, std::move(vec)));
              }
          }
        }
        if (components.empty()) return nullptr;
        // componenst.push_back( mask | flag == flag )
        for (int i = 1; i < components.size(); i++) {
            auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec->push_back(std::move(components[0]));
            vec->push_back(std::move(components[i]));
            components[0] = std::make_unique<Expr>(Expr::binops::AND, std::move(vec));
        }
        // std::cout << "return: " << string(*components[0].get()) << std::endl;
        return std::move(components[0]);
    };
}

void SpoqAbstractionLayout::compute_upgrade_or() {
    // (PA_to_Z raw) |' MASK --> new_type
    assert(rich_fields.size() <= 1 && "multiple rich fields do not support for now");
    for (auto rich: rich_fields) {
        // std::cout << "rich field: " << rich.first << " " << rich.second << std::endl;
        auto elem_name = rich.first;
        auto elem_ty_name = rich.second;

        smart_configs.push_back(SpoqAbstraction());
        auto &abs = smart_configs.back();
        auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
        vec->push_back(std::make_unique<Symbol>(abs.raw_core_name));
        abs.raw_expr = std::make_unique<Expr>(elem_ty_name + "_to_Z", std::move(vec));

        vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
        vec->push_back(std::move(abs.raw_expr));
        vec->push_back(std::make_unique<Symbol>("any_flag"));
        abs.raw_expr = std::make_unique<Expr>(Expr::binops::BITOR, std::move(vec));

        abs.in_any_map.insert("any_flag");

        auto that = this;
        auto name = abs.abs_core_name;
        abs.any_map = [that, name, elem_name](std::map<std::string, unique_ptr<SpecNode>> &core_map) -> std::unique_ptr<SpecNode> {
            if (!core_map["any_flag"]) { return nullptr; }

            auto mask_flag = dynamic_cast<IntConst *>(core_map["any_flag"].get());
            std::unique_ptr<std::vector<unique_ptr<SpecNode>>> components = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
            for (auto &field : that->fields) {
                if (field.first == elem_name) {
                    components->push_back(std::make_unique<Symbol>(name));
                } else {
                    if (mask_flag) {
                        auto flag = ((1LL << (field.second.second - field.second.first + 1)) - 1) << field.second.first;
                        components->push_back(std::make_unique<IntConst>( (mask_flag->get_value() & flag) >> field.second.first));
                    } else
                        return nullptr;
                }
            }
            auto expr = std::make_unique<Expr>("mk" + that->struct_name, std::move(components));
            auto vec2 = std::make_unique<vector<unique_ptr<SpecNode>>>();
            vec2->push_back(std::move(expr));
            return std::make_unique<Expr>(that->struct_name + "_to_Z", std::move(vec2));
        };
    }
}


void SpoqAbstractionLayout::compute_or() {
    // (PA_to_Z raw) |' MASK --> new_type
    smart_configs.push_back(SpoqAbstraction());
    auto &abs = smart_configs.back();
    auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::make_unique<Symbol>(abs.raw_core_name));
    abs.raw_expr = std::make_unique<Expr>(struct_name + "_to_Z", std::move(vec));

    vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
    vec->push_back(std::move(abs.raw_expr));
    vec->push_back(std::make_unique<Symbol>("any_flag"));
    abs.raw_expr = std::make_unique<Expr>(Expr::binops::BITOR, std::move(vec));

    abs.in_any_map.insert("any_flag");

    auto that = this;
    auto name = abs.abs_core_name;
    abs.any_map = [that, name](std::map<std::string, unique_ptr<SpecNode>> &core_map) -> std::unique_ptr<SpecNode> {
        if (!core_map["any_flag"]) { return nullptr; }

        auto mask_flag = dynamic_cast<IntConst *>(core_map["any_flag"].get());
        std::unique_ptr<SpecNode> expr = std::make_unique<Symbol>(name);
        if (mask_flag) {
          std::unique_ptr<std::vector<unique_ptr<SpecNode>>> components = std::make_unique<std::vector<unique_ptr<SpecNode>>>();
          for (auto &field : that->fields) {
              auto [rich, elem] = that->get_elem_as_Z(std::make_unique<Symbol>(name), field.first);
              auto flag = ((1LL << (field.second.second - field.second.first + 1)) - 1) << field.second.first;
              if ((mask_flag->get_value() & flag)) {
                // TODO: partial update 
                auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
                vec->push_back(std::move(expr));
                vec->push_back(std::make_unique<Symbol>(field.first));
                vec->push_back(std::make_unique<IntConst>( (mask_flag->get_value() & flag) >> field.second.first));
                expr = std::make_unique<Expr>(Expr::RecordSet, std::move(vec));
                // std::cout << "set: " << string(*expr.get()) << std::endl;
              } else continue;
          }
          auto vec = std::make_unique<vector<unique_ptr<SpecNode>>>();
        //   std::cout << "expr: " << string(*expr.get()) << std::endl;
          vec->push_back(std::move(expr));
          return std::make_unique<Expr>(that->struct_name + "_to_Z", std::move(vec));
        }
        return nullptr;
    };
}


void SpoqAbstractionLayout::compute_smart_configs(std::unordered_map<string, shared_ptr<SpecType>>& types ,bool force_compute) {

    if (!force_compute && !smart_configs.empty()) return;

    compute_or();
    compute_upgrade_or();
    compute_and_mask_eq();
    compute_and_mask();

    return;
}

bool SpoqIRContext::check_abstraction_pattern(unique_ptr<SpecNode> &value,
                                              unique_ptr<SpecNode> &raw,
                                              SpoqAbstractionContext &context) {
    if (!value || !raw) {
        assert(false && "value and raw should not be nullptr");
    }
    // std::cout << "------------\n" ;
    // std::cout << "raw: " << string(*raw) << std::endl;
    // std::cout << "spec: " << string(*value) << std::endl;
    // std::cout << "------------\n" ;

    auto raw_raw = raw.get();
    if (auto symbol = dynamic_cast<Symbol *>(raw_raw)) {
        if (context.is_raw_core(symbol->text)) {
            // std::cout << "type: " << string(*value->get_type()) << " " <<
            // string(*symbol->type) << std::endl; if
            // (Shortcut::_type_eq(value->get_type(), symbol->type)) {
            return context.add_core_map(symbol, value);
            // }
            // return false;
        } else if (context.abs.in_any_map.find(symbol->text) !=
                   context.abs.in_any_map.end()) {
            std::cout << "add core map: " << symbol->text << " " << string(*value.get()) << std::endl;
            return context.add_core_map(symbol, value);
        } else {
            auto _symbol = dynamic_cast<Symbol *>(value.get());
            if (_symbol && symbol->text == _symbol->text) {
                return true;
            }
            return false;
        }
    } else if (auto con = dynamic_cast<Const *>(raw_raw)) {
        auto _con = dynamic_cast<Const *>(value.get());
        if (!_con)
            return false;
        return (*_con) == (*con);
    } else if (auto expr = dynamic_cast<Expr *>(raw_raw)) {
        if (auto symbol = dynamic_cast<Symbol *>(value.get())) {
            auto cache = get_cache(symbol->text);
            if (!cache)
                return false;
            return check_abstraction_pattern(cache, raw, context);
        } else if (auto _expr = dynamic_cast<Expr *>(value.get())) {
            if (expr->op != _expr->op)
                return false;
            if (expr->elems->size() != _expr->elems->size())
                return false;
            bool match = true;
            for (int i = 0; i < expr->elems->size(); i++) {
                match = match &&
                        check_abstraction_pattern(_expr->elems->at(i),
                                                  expr->elems->at(i), context);
                if (!match)
                    return false;
            }
            return match;
        } else if (std::holds_alternative<Expr::binops>(expr->op)) {
            // std::cout << "expr match: " << string(*raw.get()) << std::endl;
            if (std::get<Expr::binops>(expr->op) == Expr::binops::MINUS) {
                assert(expr->elems->size() == 1 &&
                       "Negation should have only one element");
                if (auto _expr_con =
                        dynamic_cast<IntConst *>(expr->elems->at(0).get())) {
                    // std::cout << "raw match: " << _expr_con->get_value() <<
                    // std::endl;
                    if (auto _value_con =
                            dynamic_cast<IntConst *>(value.get())) {
                        // std::cout << "Negation match: " <<
                        // _value_con->get_value() << std::endl;
                        if (-_value_con->get_value() ==
                            _expr_con->get_value()) {
                            return true;
                        }
                    }
                }
            }
        }
    } else {
        std::cout << string(*raw.get()) << std::endl;
        assert(false && "Abstraction pattern only support Symbol and Expr");
    }
    return false;
}

unique_ptr<SpecNode>
SpoqIRContext::construct_abstraction_pattern(unique_ptr<SpecNode> abs,
                                             SpoqAbstractionContext &context) {
    auto raw_raw = abs.get();
    std::cout << "construct_abstraction_pattern: " << string(*abs.get())
              << std::endl;
    if (auto symbol = dynamic_cast<Symbol *>(raw_raw)) {
        if (context.is_abs_core(symbol->text)) {
            return context.get_cache(symbol->text);
        } else {
            return abs;
        }
    } else if (auto expr = dynamic_cast<Expr *>(raw_raw)) {
        auto elems = std::make_unique<vector<unique_ptr<SpecNode>>>();
        for (auto &elem : *expr->elems) {
            elems->push_back(
                construct_abstraction_pattern(std::move(elem), context));
        }
        auto op = expr->deep_copy_op();
        auto _expr = std::make_unique<Expr>(std::move(op), std::move(elems));
        _expr->type = expr->type;
        return _expr;
    } else if (auto con = dynamic_cast<Const *>(raw_raw)) {
        return abs;
    } else {
        // std::cout << "construct_abstraction_pattern: " << string(*abs.get()) << std::endl;
        assert(false && "Abstraction pattern only support Symbol and Expr");
    }
}

unique_ptr<SpecNode>
SpoqIRContext::apply_abstraction(unique_ptr<SpecNode> spec) {
    for(auto &abstraction: abs_config) {
        auto raw = abstraction.get_raw_node();
        auto context = SpoqAbstractionContext(abstraction);
        // std::cout << "raw: " << string(*raw) << std::endl;
        // std::cout << "spec: " << string(*spec) << std::endl;
        auto ret = check_abstraction_pattern(spec, raw, context);
        // std::cout << "ret: " << ret << std::endl;
        if (ret)
        return construct_abstraction_pattern(abstraction.get_abs_node(),
        context);
    }
    // TODO: option for allow abs_layout or not
    for (auto &layout : abs_layout) {
        // std::cout << "enter: " << layout.struct_name << std::endl;
        for (auto &abstraction : layout.smart_configs) {
            auto raw = abstraction.get_raw_node();
            auto context = SpoqAbstractionContext(abstraction);
            // std::cout << "raw: " << string(*raw) << std::endl;
            // std::cout << "spec: " << string(*spec) << std::endl;
            auto ret = check_abstraction_pattern(spec, raw, context);
            // std::cout << "ret: " << ret << std::endl;
            if (ret) {
                auto expr = abstraction.any_map(context.core_map);
                if (expr)  
                    return construct_abstraction_pattern(std::move(expr), context);
            }
        }
    }
    return spec;
}

}; // namespace autov