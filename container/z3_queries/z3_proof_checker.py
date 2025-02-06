#!/usr/bin/env python3

import os
import sys
from z3 import Solver, parse_smt2_file, unsat

def check_smt2_file(file_path):
    """Check an SMT2 file using Z3 and return the result."""
    solver = Solver()
    constraints = parse_smt2_file(file_path)
    solver.add(constraints)
    return solver.check()

def check_invariants():
    current_dir = os.getcwd()

    # Iterate over all subdirectories (./spec_name)
    for spec_name in os.listdir(current_dir):
        spec_path = os.path.join(current_dir, spec_name)

        if not os.path.isdir(spec_path):
            continue

        print(f"Checking Invariant for {spec_name}")

        # Iterate over invariant subdirectories (./spec_name/inv_name)
        for inv_name in os.listdir(spec_path):
            inv_path = os.path.join(spec_path, inv_name)

            if not os.path.isdir(inv_path):
                continue

            print(f"Checking Invariant \"{inv_name}\" for \"{spec_name}\"")

            all_unsat = True  # Assume all files are unsat unless proven otherwise

            # Check all .smt2 files in ./spec_name/inv_name/
            for file_name in os.listdir(inv_path):
                if file_name.endswith(".smt2"):
                    print(f"Checking file {file_name}")
                    file_path = os.path.join(inv_path, file_name)
                    result = check_smt2_file(file_path)

                    if result != unsat:
                        all_unsat = False  # If any file is not unsat, mark as failed

            # Output success message if all SMT2 files were unsat
            if all_unsat:
                print(f"Checking Invariant \"{inv_name}\" for \"{spec_name}\" success!")

if __name__ == "__main__":
    check_invariants()
