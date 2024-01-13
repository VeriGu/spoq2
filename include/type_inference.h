#pragma once

#include <nodes.h>
#include <log.h>
#include <values.h>
#include <utils.h>
#include <project.h>
#include <unordered_map>

namespace autov::type_inference {
using std::string;
using std::vector;
using std::unique_ptr;
using std::make_unique;
using std::shared_ptr;
using std::make_shared;
using std::unordered_map;

// `known_types` needs to be pushed to a vector and thus it must be a pointer instead of a pointer.
void infer_type(Project &proj, SpecNode *spec, shared_ptr<unordered_map<string, shared_ptr<SpecType>>> known_types,
                shared_ptr<SpecType>final_type = nullptr);
bool check_well_typed(Project &proj, SpecNode *spec, std::set<string> &vars);
}