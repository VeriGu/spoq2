#!/usr/bin/env python3

import os
from z3 import Solver, parse_smt2_file, unsat
from colorama import Fore, Style, init

VERIFY_SPEC_NAMES = {
    # "smc_system_interface_version_spec",
    # "smc_read_feature_register_spec",
    # "smc_granule_delegate_spec",
    # "smc_granule_undelegate_spec",
    # "smc_realm_create_spec",
    # "smc_realm_destroy_spec",
    # "smc_rec_enter_spec",
    # "smc_realm_activate_spec",
    # "smc_rec_create_spec",
    "smc_rec_destroy_spec",
    # "smc_data_create_spec",
    # "rsi_data_create_unknown_s1_spec",
    # "map_unmap_ns_s1_spec",
    # "rsi_data_destroy_spec",
    # "rsi_rtt_create_spec",
    # "rsi_rtt_destroy_spec",
    # "rsi_rtt_set_ripas_spec",
    # "rsi_data_map_extra_spec"
}

# Initialize colorama for colored output
init(autoreset=True)

def check_smt2_file(file_path):
    """Check an SMT2 file using Z3 and return the result."""
    solver = Solver()
    constraints = parse_smt2_file(file_path)
    # Increase or adjust the timeout as needed
    solver.set("timeout", 8000)  # 40 seconds
    solver.add(constraints)
    return solver.check()

def check_invariants():
    # Instead of current_dir, use ../container/z3_queries/
    script_dir = os.path.dirname(os.path.abspath(__file__))
    smt_base_dir = os.path.abspath(os.path.join(script_dir, "..", "..", "llvm.container", "z3_queries"))

    # Iterate over all subdirectories in ../container/z3_queries
    for spec_name in os.listdir(smt_base_dir):
        # Only check known specs
        if spec_name not in VERIFY_SPEC_NAMES:
            continue
        
        spec_path = os.path.join(smt_base_dir, spec_name)
        if not os.path.isdir(spec_path):
            continue

        # Section header for this spec
        print(f"\n{Fore.CYAN}{'='*40}")
        print(f"{Fore.BLUE}Checking Invariants for \"{spec_name}\"")
        print(f"{Fore.CYAN}{'='*40}")

        spec_success = True  # Track success for this spec_name

        # Iterate over potential invariant subdirectories in spec_name
        for inv_name in os.listdir(spec_path):
            inv_path = os.path.join(spec_path, inv_name)
            if not os.path.isdir(inv_path):
                continue

            # Check the invariant
            print(f"  {Fore.YELLOW}- Checking Invariant \"{inv_name}\"...", end=" ")
            all_unsat = True  # We'll assume unsat unless proven otherwise

            # Check all .smt2 files in each invariant folder
            for file_name in os.listdir(inv_path):
                if file_name.endswith(".smt2"):
                    file_path = os.path.join(inv_path, file_name)
                    result = check_smt2_file(file_path)

                    if result != unsat:
                        all_unsat = False

            if all_unsat:
                print(f"{Fore.GREEN}success!")
            else:
                print(f"{Fore.RED}failed!")
                spec_success = False

        # Summary for this spec_name
        if spec_success:
            print(f"{Fore.GREEN}[{spec_name}] verified!")
        else:
            print(f"{Fore.RED}Some invariants failed for \"{spec_name}\"")

if __name__ == "__main__":
    check_invariants()
