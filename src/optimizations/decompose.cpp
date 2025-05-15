
#include <coi.h>
#include <decompose.h>
#include <simulate.h>
#include <symbolic.h>

namespace autov
{


//decompose_procedure: should decompose all the identity relation separated with
//other relations. Group share's identity relations, local's identity relations.
bool decompose(Project* proj, Definition* def, string secret) {
    for (auto &r : proj->relations) {
        auto rel = proj->defs[r].get();
        auto coi_fields = analyze_cone_of_influence(proj, def, rel->body.get());
        std::set<string> coi = {};
        for (auto &c : coi_fields) {
            if (!c.empty()) {
                coi.insert(c.front());
            }
        }

        LOG_DEBUG << def->name << ":";
        for(auto c: coi) { 
            LOG_DEBUG << def->name << ":" << r << "_coi:" << c;
        }
        set<field_t> secret_fields;
        for(auto &sec_r : proj->sec_relations) {
            auto sec_def = proj->defs[sec_r].get();
            analyze_invariant_fields(proj, sec_def->body.get(), secret_fields);
        }
        for(auto secret_field : secret_fields) {
            if(coi.find(secret_field.front()) == coi.end()) {
                proj->verified_relations.insert(r);
                LOG_DEBUG << def->name << ": " << r << "proved!";
            }
        }
    }
    unique_ptr<SpecNode> origin_relation = make_unique<BoolConst>(true);
    unique_ptr<SpecNode> relation = make_unique<BoolConst>(true);
    for (auto &r : proj->relations) {
        auto orin_elems = make_unique<vector<unique_ptr<SpecNode>>>();
        orin_elems->push_back(proj->defs[r]->body->deep_copy());
        orin_elems->push_back(std::move(origin_relation));
        origin_relation = make_unique<Expr>(Expr::AND, std::move(orin_elems), Bool::BOOL);
        if(proj->verified_relations.find(r) != proj->verified_relations.end())
            continue;
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
        elems->push_back(proj->defs[r]->body->deep_copy());
        elems->push_back(std::move(relation));
        relation = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
	}
    if(!instance_of(relation.get(), BoolConst)) {
        auto rel = proj->defs[*proj->relations.begin()].get();
        auto rel_def = make_unique<Definition>("_relate",rel->rettype, make_unique<vector<shared_ptr<Arg>>>(*rel->args), relation->deep_copy());
        auto orin_rel_def = make_unique<Definition>("_relate",rel->rettype, make_unique<vector<shared_ptr<Arg>>>(*rel->args), origin_relation->deep_copy());
        proj->query_saver = QueryInfo(query_saver_dir(def->name, "relate_RData"));

        if(!check_hprop_by_path(proj, orin_rel_def.get(), def, nullptr, true, rel_def.get())) {
            LOG_DEBUG << "secret interfere other fields";
            return false;
        }
    } else
        LOG_DEBUG << "Proof Skipped!, secret not interfere other fields";
        

    // unique_ptr<SpecNode> sec_relation = make_unique<BoolConst>(true);
    // for (auto &r : proj->sec_relations) {
    //     auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
    //     elems->push_back(proj->defs[r]->body->deep_copy());
    //     elems->push_back(std::move(sec_relation));
    //     sec_relation = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
	// }

    
    // auto rel = proj->defs[*proj->sec_relations.begin()].get();
    // auto rel_def = make_unique<Definition>("_relate_sec",rel->rettype, make_unique<vector<shared_ptr<Arg>>>(*rel->args), sec_relation->deep_copy());
    // proj->query_saver =  QueryInfo(query_saver_dir(def->name, "relate_secure"));

    // if(!check_hprop_by_path(proj, rel_def.get(), def, nullptr, false)) {
    //     LOG_DEBUG << "other fields interfere secret.";
    //     return false;
    // } else {
    //     LOG_DEBUG << "other fields does not interfere secret.";
    //     return true;
    // }

    return true;
}

}