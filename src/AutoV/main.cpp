#include <iostream>
#include <values.h>
#include <utils.h>
#include <nodes.h>
#include <log.h>
#include <parser.h>
#include <project.h>
#include <fstream>
#include <cstdlib>

using std::string;

const string base_file_dir = "testcase/";

int main(void)
{
    int cnt = 0;
    autov::log::init();
    autov::log::set_logging_level();

    LOG_DEBUG << "Hello world!";
    LOG_INFO << "Hello world!";
    LOG_WARNING << "Hello world!";
    LOG_ERROR << "Hello world!";

    std::unique_ptr<autov::Project> proj = std::make_unique<autov::Project>();

    autov::parser::parse(proj.get(), "testcase/proof_proj.v");

    proj->finalize_project();

#if 0
    for (const auto &layer: proj->layers) {
        string layer_name = layer->name;

        for (const auto &prim: layer->prims) {
            const auto def = proj->defs[prim + "_spec"].get();
            string def_str, base_file, base_spec, line;

            if (def == nullptr) {
                LOG_ERROR << "Cannot find definition for " << prim;
                continue;
            }

            //LOG_INFO << "Checking " << prim;

            def_str = string(*def) + "\n";

            base_file = base_file_dir + layer_name + "Spec.v";
            // Open base_file
            std::ifstream base_file_stream(base_file);
            if (!base_file_stream) {
                LOG_ERROR << "Cannot open file " << base_file;
                // assert(false);
                continue;
            }

            while (std::getline(base_file_stream, line)) {
                // if line begins with "Definition"
                if (line.find("Definition") == 0) {
                    // check if the second word of the line is the same as prim
                    std::istringstream iss(line);
                    std::string first_word, second_word;
                    iss >> first_word >> second_word;

                    if (second_word != prim + "_spec")
                        continue;

                    base_spec += line + "\n";
                    while (std::getline(base_file_stream, line)) {
                        if (line.empty())
                            break;
                        // strip last char if it is an empty space
                        if (line.back() == ' ')
                            line.pop_back();
                        base_spec += line + "\n";
                    }
                    cnt++;
                    if (base_spec != def_str) {
                        std::string fifoPath = string("/tmp/myfifo-") + prim;
                        std::ofstream fifo_base(fifoPath + "-base");
                        std::ofstream fifo_def(fifoPath + "-def");
                        std::string command = "python3 src/AutoV/Spec/show_diff.py " + fifoPath + "-base " + fifoPath + "-def";

                        fifo_base << base_spec;
                        fifo_base.close();
                        fifo_def << def_str;
                        fifo_def.close();

                        std::system(command.c_str());

                        unlink(fifoPath.c_str());
                        unlink((fifoPath + "-base").c_str());
                    }
                }
            }
        }
    }

    std::cout << cnt << " prims checked.\n";

    // for (const auto& kv : proj->defs) {
    //     const auto& key = kv.first;
    //     const auto& value = kv.second;

    //     std::cout << std::string(*value) << "\n";
    //     std::cout << "==================================\n";

    // }
#endif
    return 0;
}