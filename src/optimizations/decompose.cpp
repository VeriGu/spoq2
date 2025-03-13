
#include <coi.h>
#include <decompose.h>
#include <simulate.h>

namespace autov
{


//decompose_procedure: should decompose all the identity relation separated with
//other relations. Group share's identity relations, local's identity relations.
void decompose(Project* proj, Definition* def) {
    auto& def_local = proj->defs["relate_local"];
    auto& def_share = proj->defs["relate_share_other"];
    auto& def_data = proj->defs["relate_non_data"];
    auto coi_local = analyze_cone_of_influence(proj, def, def_local->body.get());
    auto coi_share = analyze_cone_of_influence(proj, def, def_share->body.get());
    auto coi_data = analyze_cone_of_influence(proj, def, def_data->body.get());
    LOG_DEBUG << def->name << ":";
    for(auto c: coi_local) { 
        LOG_DEBUG << "coi local: " << c;
    }
    for(auto c: coi_share) { 
        LOG_DEBUG << "coi other share: " << c;
    }
    for(auto c: coi_data) { 
        LOG_DEBUG << "coi non data granule: " << c;
    }
    if(coi_local.find("g_norm") == coi_local.end()) {
        LOG_DEBUG << def->name << "relate_local proved";
    }
    if(coi_share.find("g_norm") == coi_share.end()) {
        LOG_DEBUG << def->name << "relate_share_other proved";
    }
    if(coi_data.find("g_norm") == coi_data.end()) {
        LOG_DEBUG << def->name << "relate_non_data proved";
    }


}
}