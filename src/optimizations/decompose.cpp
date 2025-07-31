
#include <coi.h>
#include <decompose.h>
#include <simulate.h>
#include <symbolic.h>

namespace autov
{


//decompose_procedure: should decompose all the identity relation separated with
//other relations. Group share's identity relations, local's identity relations.
bool decompose(Project* proj, Definition* def, string secret) {
    static set<string> public_fields_rm_list_sec = {
        "g_norm", "e_umem", "e_shadow_vcpu_ctxt"
    };
    static set<string> public_fields_rm_list = {
        "meta_PA", "meta_type", "meta_pmd_flag", "page_offset",
        "pa_val", "meta_af", "meta_sh", "meta_ns",
        "meta_desc_type", "meta_granule_offset", "meta_mem_attr", "meta_ripas",
        "pbase", "poffset"
    };
    set<field_t> public_fields;
    set<field_t> public_ret;
    for(auto &r : proj->relations) {
        auto def = proj->defs[r].get();
        analyze_invariant_fields(proj, def->body.get(), public_fields);
    }
    for (auto pub: public_fields) {
        if(pub.empty() || public_fields_rm_list_sec.find(pub.front()) != public_fields_rm_list_sec.end()) {
            continue;
        }
        LOG_DEBUG << "public: " << pub.front();
        public_ret.insert(pub);
    }
    set<string>& target_relation = proj->relations;
    if(proj->end_relations.size() > 0) {
        target_relation = proj->end_relations;
    }
    for (auto &r : target_relation) {
        auto rel = proj->defs[r].get();
        PROFILE_START(coi);
        auto coi_fields = analyze_cone_of_influence(proj, def, rel->body.get());
        PROFILE_END(coi);
        std::set<string> coi = {};
        for (auto &c : coi_fields) {
            if (!c.empty() && public_fields_rm_list.find(c.front()) == public_fields_rm_list.end()) {
                coi.insert(c.front());
            }
        }

        LOG_DEBUG << def->name << ":";
        for(auto c: coi) { 
            LOG_DEBUG << def->name << ":" << r << "_coi:" << c;
        }
        
        
        for(auto coi_field: coi_fields) {
            if(coi_field.empty() || public_fields_rm_list.find(coi_field.front()) != public_fields_rm_list.end()) {
                continue;
            }
            auto contain = false;
            for(auto public_field : public_ret) {
                if(contains_field(coi_field, public_field)) {
                    // proj->unverified_relations.insert(r);
                    
                    // LOG_DEBUG << def->name << 
                    // goto middle;
                    contain = true;
                    break;
                }
            }
            if(!contain) {
                LOG_DEBUG << "coi field: " << coi_field.front() << "not in public fields";
                LOG_DEBUG << def->name << ": " << r << " can not be skipped";
                proj->unverified_relations.insert(r);
                break;
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
        if(proj->unverified_relations.find(r) == proj->unverified_relations.end())
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