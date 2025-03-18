
#include <coi.h>
#include <decompose.h>
#include <simulate.h>

namespace autov
{


//decompose_procedure: should decompose all the identity relation separated with
//other relations. Group share's identity relations, local's identity relations.
bool decompose(Project* proj, Definition* def, string secret) {
    for (auto &r : proj->relations) {
        auto rel = proj->defs[r].get();
        auto coi = analyze_cone_of_influence(proj, def, rel->body.get());
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

    unique_ptr<SpecNode> relation = make_unique<BoolConst>(true);
    for (auto &r : proj->relations) {
        if(proj->verified_relations.find(r) != proj->verified_relations.end())
            continue;
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
        elems->push_back(proj->defs[r]->body->deep_copy());
        elems->push_back(std::move(relation));
        relation = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
	}
    if(!instance_of(relation.get(), BoolConst)) {
        if(!check_hprop_by_path(proj, std::move(relation), def)) {
            LOG_DEBUG << "secret interfere other fields";
            return false;
        }
    } else
        LOG_DEBUG << "Proof Skipped!, secret not interfere other fields";
        

    unique_ptr<SpecNode> sec_relation = make_unique<BoolConst>(true);
    for (auto &r : proj->sec_relations) {
        auto rel = proj->defs[r].get();
        auto coi = analyze_cone_of_influence(proj, def, rel->body.get());
        LOG_DEBUG << def->name << ":";
        for(auto c: coi) { 
            LOG_DEBUG << def->name << ":" << r << "_coi:" << c;
        }
        set<field_t> other_fields;
        analyze_invariant_fields(proj, relation.get(), other_fields);
        for(auto other_field : other_fields) {
            if(coi.find(other_field.front()) == coi.end()) {
                proj->verified_relations.insert(r);
                LOG_DEBUG << def->name << ": " << r << "proved!";
            }
        }
        if(proj->verified_relations.find(r) != proj->verified_relations.end())
            continue;
        auto elems = make_unique<vector<unique_ptr<SpecNode>>>();
        elems->push_back(proj->defs[r]->body->deep_copy());
        elems->push_back(std::move(sec_relation));
        sec_relation = make_unique<Expr>(Expr::AND, std::move(elems), Bool::BOOL);
	}

    if(!instance_of(relation.get(), BoolConst)) {
        if(!check_hprop_by_path(proj, std::move(sec_relation), def)) {
            LOG_DEBUG << "other fields interfere secret.";
            return false;
        } else {
            LOG_DEBUG << "other fields does not interfere secret.";
            return true;
        }
    } else
        LOG_DEBUG << "Prove Skipped! other fields does not interfere secret.";
        
    
    return true;
}

}