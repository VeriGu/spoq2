set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")
#set(CMAKE_BUILD_TYPE Release)

#if (DEFINED ENV{VCPKG_ROOT})
#    message("import vcpkg packages")
#    message("$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
#    set(VCPKG_TARGET_TRIPLET x64-osx)
#    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
#    include("$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
#endif()

cmake_minimum_required(VERSION 3.10)
project(spoq)

# ------------------------------------------------------------------------------
# Basic setup
# ------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g -Wall -Wno-unused-function")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -Wall -Wno-unused-function")
set(CMAKE_CXX_STANDARD 17)

include_directories(include)
# DO NOT put z3 include directory here, it will cause conflict with the z3 library in the system PATH
# include_directories(include/z3)

# ------------------------------------------------------------------------------
# Boost
# ------------------------------------------------------------------------------
find_package(Boost REQUIRED COMPONENTS log program_options)
if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS})
endif()

# ------------------------------------------------------------------------------
# External libaries are always build in release mode
# ------------------------------------------------------------------------------
set(MAIN_CMAKE_BUILDTYPE ${CMAKE_BUILD_TYPE})
set(CMAKE_BUILD_TYPE "Release")

# ------------------------------------------------------------------------------
# ANTRL4 runtime
# ------------------------------------------------------------------------------
message("ANTLR4 build type: ${CMAKE_BUILD_TYPE}")
add_subdirectory(src/frontend/parser/antlr4/runtime/Cpp/)
#target_compile_options(antlr4_shared PRIVATE -Wno-unused-parameter -w -Wno-unused-variable)

# Include ANTLR4 runtime headers
include_directories(src/frontend/parser/antlr4/runtime/Cpp/runtime/src/)

# ------------------------------------------------------------------------------
# Z3
# ------------------------------------------------------------------------------
message("Z3 build type: ${CMAKE_BUILD_TYPE}")
FetchContent_Declare(z3
        GIT_REPOSITORY https://github.com/Z3Prover/z3
        GIT_TAG        z3-4.12.5
)
FetchContent_MakeAvailable(z3)
include_directories(${z3_SOURCE_DIR}/src/api)
include_directories(${z3_SOURCE_DIR}/src/api/c++)
#target_compile_options(libz3 PRIVATE -O3 -w -Wno-unused-variable)

# ------------------------------------------------------------------------------
# Restore the build type
# ------------------------------------------------------------------------------
set(CMAKE_BUILD_TYPE ${MAIN_CMAKE_BUILDTYPE})
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_definitions(-DDEBUG)
endif()

message("Spoq CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

# ------------------------------------------------------------------------------
# IRLoader is compiled as a shared library
# ------------------------------------------------------------------------------
set(IRLOADER_SOURCES
    src/frontend/IRLoader/coq.cpp
    src/frontend/IRLoader/irvalues.cpp
    src/frontend/IRLoader/instructions.cpp
    src/frontend/IRLoader/irtypes.cpp
    src/frontend/IRLoader/irloader.cpp
    src/frontend/IRLoader/control_flow.cpp
    src/frontend/IRLoader/inline_asm.cpp
    src/frontend/IRLoader/post_process.cpp
    src/libs/log.cpp
)

add_library(irloader SHARED ${IRLOADER_SOURCES})
if(Boost_FOUND)
    target_link_libraries(irloader ${Boost_LIBRARIES})
endif()

# ------------------------------------------------------------------------------
# json2coq is compiled as an independent executable
# ------------------------------------------------------------------------------
set(JSON2COQ_SOURCES
    src/frontend/IRLoader/json2coq.cpp
)

add_executable(json2coq ${JSON2COQ_SOURCES})
if(Boost_FOUND)
    target_link_libraries(json2coq ${Boost_LIBRARIES})
endif()
target_link_libraries(json2coq irloader)

# ------------------------------------------------------------------------------
# Parser is compiled as a shared library
# ------------------------------------------------------------------------------
set(PARSER_SOURCES
    src/frontend/parser/SpecLexer.cpp
    src/frontend/parser/SpecParser.cpp
    src/frontend/parser/parse.cpp
    src/frontend/parser/parse_light.cpp
)
add_library(parser SHARED ${PARSER_SOURCES})
if(Boost_FOUND)
    target_link_libraries(parser ${Boost_LIBRARIES})
endif()
target_compile_options(parser PRIVATE -O3 -UDEBUG)

# List all source files explicitly
set(SOURCES
    src/main.cpp
    src/libs/log.cpp
    src/libs/nodes.cpp
    src/libs/values.cpp
    src/libs/utils.cpp
    src/libs/project.cpp
    src/libs/shortcuts.cpp
    src/frontend/type_inference.cpp
    src/frontend/ir2spec.cpp
    src/optimizations/rules.cpp
    src/optimizations/projection.cpp
    src/optimizations/z3_rules.cpp
    src/optimizations/z3_utils.cpp
    src/optimizations/profile.cpp
    src/optimizations/symbolic.cpp
    src/backend/gen_coq/gen_code.cpp
    src/backend/gen_coq/gen_data.cpp
    src/backend/gen_coq/gen_high_proof.cpp
    src/backend/gen_coq/gen_high_spec.cpp
    src/backend/gen_coq/gen_low_proof.cpp
    src/backend/gen_coq/gen_low_spec.cpp
    src/backend/gen_coq/gen_layer.cpp
    src/backend/gen_coq/gen_project.cpp
)

# Specify the executable target and its source files
add_executable(spoq ${SOURCES})
# Link the shared library to the main executable
target_link_libraries(spoq irloader parser antlr4_shared libz3)

# Link the Boost libraries to the executable
if(Boost_FOUND)
    target_link_libraries(spoq ${Boost_LIBRARIES})
endif()

# Set the output directory for the executable
set_target_properties(spoq PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
