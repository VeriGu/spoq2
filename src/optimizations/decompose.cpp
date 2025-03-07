
#include <coi.h>
#include <decompose.h>

namespace autov
{


void decompose(Project* proj, Definition* def) {
    auto& def_local = proj->defs["relate_local"];
    //auto& def_share = proj->defs["relate_share"];
    auto coi = analyze_cone_of_influence(proj, def, def_local->body.get());
    LOG_DEBUG << def->name << ":";
    for(auto c: coi) { 
        LOG_DEBUG << "coi: " << c;
    }
}

}