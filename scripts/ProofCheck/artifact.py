import os
import shutil

# List of spec names
VERIFY_SPEC_NAMES = {
    # "smc_system_interface_version_spec",
    # "smc_read_feature_register_spec",
    # "smc_granule_delegate_spec",
    # "smc_granule_undelegate_spec",
    # "smc_realm_create_spec",
    # "smc_realm_destroy_spec",
    # "smc_rc_rtt_read_entry_spec",
    "smc_rtt_read_entry_spec",
    # "smc_rec_enter_spec",
    # "smc_realm_activate_spec",
    # "smc_rec_create_spec",
    # "smc_rec_destroy_spec",
    # "smc_rtt_read_entry_spec",
    "smc_data_create_spec",
    "rsi_data_create_unknown_s1_spec",
    # "map_unmap_ns_s1_spec",
    # "rsi_data_destroy_spec",
    "rsi_rtt_create_spec",
    "rsi_rtt_destroy_spec",
    # "rsi_rtt_set_ripas_spec",
    # "rsi_data_map_extra_spec",
    # "handle_rsi_realm_get_attest_token_spec",
    "rsi_set_ttbr0_spec",
    # "rsi_data_map_extra_spec",
    # "rsi_data_set_attrs_spec",
}

# Define source and destination base paths
source_base_path = os.path.expanduser("~/spoq3/container/z3_queries")
dest_base_path = os.path.expanduser("~/spoq3-artifacts/rcsm/z3_queries")

def copy_v_files():
    for spec_name in VERIFY_SPEC_NAMES:
        # Define source and destination directories for the rtt_map_data folder
        source_dir = os.path.join(source_base_path, spec_name, "rtt_map_data")
        dest_dir = os.path.join(dest_base_path, spec_name, "rtt_map_data")
        
        # Check if the source directory exists
        if not os.path.exists(source_dir):
            print(f"Skipping {spec_name}: Source directory does not exist.")
            continue
        
        # Walk through the source directory tree
        for root, dirs, files in os.walk(source_dir):
            # Compute the relative path to preserve folder structure
            rel_dir = os.path.relpath(root, source_dir)
            for file in files:
                if file.endswith(".v"):
                    source_file = os.path.join(root, file)
                    dest_file = os.path.join(dest_dir, rel_dir, file)
                    # Ensure the destination directory exists
                    os.makedirs(os.path.dirname(dest_file), exist_ok=True)
                    shutil.copy2(source_file, dest_file)
                    print(f"Copied {source_file} -> {dest_file}")

if __name__ == "__main__":
    copy_v_files()