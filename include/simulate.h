#pragma once

#include <nodes.h>
#include <values.h>
#include <utils.h>
#include <shortcuts.h>
#include <project.h>
#include <cassert>
#include <utility>
#include <rules.h>
#include <z3_rules.h>
#include <cmd.h>

namespace autov 
{
	inline string get_sim_name(string name) {
		return name + "_sim";
	}
	// verify the relational property by traversing the project
	bool check_hprop_by_path(Project *proj, Definition* rel, Definition *spec, Definition *impl = nullptr);
}