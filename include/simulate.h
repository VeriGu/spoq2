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
	inline string get_sim_name(const string& name) {
		return name + "_sim";
	}
	// verify the relational property by traversing the project
	bool check_hprop_by_path(Project *proj, Definition* rel, Definition *spec, Definition *impl = nullptr, bool det = true, Definition* endrel = nullptr);
	shared_ptr<SpecValue> formulate_relation(Project *proj, Definition *rel, SpecNode  const*st_spec, SpecNode  const*st_impl, const shared_ptr<ProveState>& state);
	
	class SimulateResult {
	public:
		bool verified;
		bool spec_has_ub;
		bool impl_eliminates_ub;
		bool impl_has_non_spec_ub;
		optional<double> z3_time;
		optional<double> analysis_time;
		optional<double> total_time;
		optional<size_t> vuln_leaves_before_transform;
		optional<size_t> vuln_leaves_after_transform;
		optional<size_t> patch_leaves_before_transform;
		optional<size_t> patch_leaves_after_transform;
		/// Whether some path the traversal did not prove unsat ends in a Some
		/// of the spec, and of the impl.  With neither, every path the check
		/// covered ends in None or is unreachable, and a verified refinement
		/// is vacuous.
		bool spec_reaches_some = false;
		bool impl_reaches_some = false;
		SimulateResult operator+(const SimulateResult& rhs) const
		{                           
			SimulateResult sum {
				this->verified && rhs.verified,
				this->spec_has_ub || rhs.spec_has_ub,
				this->impl_eliminates_ub || rhs.impl_eliminates_ub,
				this->impl_has_non_spec_ub || rhs.impl_has_non_spec_ub,
				std::nullopt,
				std::nullopt
			};
			sum.spec_reaches_some = this->spec_reaches_some || rhs.spec_reaches_some;
			sum.impl_reaches_some = this->impl_reaches_some || rhs.impl_reaches_some;
			return sum;
		}
	};
	std::ostream& operator<<(std::ostream& out, const SimulateResult& r);
    SimulateResult simulate_by_traverse(Project *proj, SpecNode *spec,
                                        SpecNode *impl, Definition *rel, Definition *ret_rel,
                                        const shared_ptr<ProveState>& state, const path_t& p,
                                        bool det);
    /// Forgets which demand-unfolding sites have been inlined; check_refines
    /// calls it before each check.
    void forget_unfolded_sites();
    /// Which branches of an If stay live, given the two checks
    /// check_branch_plausibility makes.  z3_check_unsat(state, x) is True when
    /// x holds on every path, so [true_check], its result on !cond, is True
    /// when the true branch is impossible, and [false_check], on cond, when
    /// the false branch is.  [undecided] is set when an unknown answer left a
    /// branch open, i.e. neither check was proven -- a branch pruned by one
    /// check is decided, whatever the other one answered.
    std::pair<bool,bool> branch_plausibility(Z3Result true_check, Z3Result false_check, bool &undecided);
    std::pair<bool,bool> check_branch_plausibility(autov::Project *proj,
                                   std::shared_ptr<autov::ProveState>  const&state,
                                   std::shared_ptr<autov::SpecValue>  const&cond,
                                   z3::model &model);
}