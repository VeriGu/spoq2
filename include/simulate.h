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
	extern int Z3_SIM_TIMEOUT;
	inline string get_sim_name(string name) {
		return name + "_sim";
	}
	// verify the relational property by traversing the project
	bool check_hprop_by_path(Project *proj, Definition* rel, Definition *spec, Definition *impl = nullptr, bool det = true, Definition* endrel = nullptr);
	shared_ptr<SpecValue> formulate_relation(Project *proj, Definition *rel, SpecNode *st_spec, SpecNode *st_impl, shared_ptr<ProveState> state);
	
	class SimulateResult {
	public:
		bool verified;
		bool spec_has_ub;
		bool impl_eliminates_ub;
		bool impl_has_non_spec_ub;
		SimulateResult operator+(const SimulateResult& rhs)
		{                           
			return SimulateResult {
				this->verified && rhs.verified,
				this->spec_has_ub || rhs.spec_has_ub,
				this->impl_eliminates_ub || rhs.impl_eliminates_ub,
				this->impl_has_non_spec_ub || rhs.impl_has_non_spec_ub
			};
		}
	};
	std::ostream& operator<<(std::ostream& out, const SimulateResult& r);
	SimulateResult simulate_by_traverse(Project *proj, SpecNode *spec, SpecNode *impl, Definition *rel, shared_ptr<ProveState> state, path_t p, bool det);
}