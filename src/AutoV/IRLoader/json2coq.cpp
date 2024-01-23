#include <irloader.h>
#include <cassert>
#include <string>
#include <boost/property_tree/ptree.hpp>
#include <log.h>

using std::string;
using boost::property_tree::ptree;
using autov::IRLoader::parse_module;

void usage(char *argv[])
{
    std::cout << "Usage: " << string(argv[0]) << " <input_file>\n";
}

void process_tree(const boost::property_tree::ptree& input, boost::property_tree::ptree& output) {
    for (auto& kv : input) {
        std::string key = kv.first;
        // Replace dot in key with underscore (or any other character)
        std::replace(key.begin(), key.end(), '.', '!');
        // If it's a subtree, process recursively
        if (!kv.second.empty()) {
            //boost::property_tree::ptree subtree;
            //process_tree(kv.second, subtree);
            output.add_child(key, kv.second);
        } else {
            // Copy the value
            output.put(key, kv.second.data());
        }
    }
}

int main(int argc, char *argv[])
{
    string input_file;
    string output_file;
    ptree pt;

    autov::log::init();
    autov::log::set_logging_level();

    if (argc != 2) {
        usage(argv);
        return 1;
    }

    input_file = string(argv[1]);
    assert(input_file.substr(input_file.find_last_of(".") + 1) == "json");

    output_file = input_file.substr(0, input_file.find_last_of(".")) + ".v";

    try {
        boost::property_tree::ptree modified_subtree;
        read_json(input_file, pt);
        boost::property_tree::ptree subtree = pt.get_child("struct_types");
        process_tree(subtree, modified_subtree);
        pt.put_child("struct_types", modified_subtree);
        //write_json(std::cout, pt.get_child("struct_types"));
    } catch (const boost::property_tree::json_parser::json_parser_error& e) {
        std::cerr << "Failed to parse " << e.filename() << ": " << e.message() << "\n";
        return 1;
    }

    //write_json(std::cout, pt);
    parse_module(pt);

    return 0;
}