set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")

cmake_minimum_required(VERSION 3.10)
project(spoq)

# ------------------------------------------------------------------------------
# Basic setup
# ------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g -gdwarf-4 -Wall -Wno-unused-function")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -Wall -Wno-unused-function")
set(CMAKE_CXX_STANDARD 17)

include_directories(include)

# ------------------------------------------------------------------------------
# Z3
# ------------------------------------------------------------------------------
find_package(Z3 4.12.5 REQUIRED CONFIG)
include_directories(${Z3_CXX_INCLUDE_DIRS})
message(STATUS "Found Z3 ${Z3_VERSION_STRING}")
message(STATUS "Using Z3Config.cmake in: ${Z3_DIR}")


# ------------------------------------------------------------------------------
# LLVM
# ------------------------------------------------------------------------------
find_package(LLVM 14.0.0 REQUIRED CONFIG)
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
llvm_map_components_to_libnames(LLVM_LIBRARIES support core irreader analysis passes)


# ------------------------------------------------------------------------------
# Boost
# ------------------------------------------------------------------------------
find_package(Boost REQUIRED COMPONENTS log program_options)
include_directories(${Boost_INCLUDE_DIRS})

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
target_link_libraries(irloader ${Boost_LIBRARIES})
target_link_libraries(irloader ${LLVM_LIBRARIES})
target_link_libraries(irloader ${Z3_LIBRARIES})


# ------------------------------------------------------------------------------
# json2coq is compiled as an independent executable
# ------------------------------------------------------------------------------
set(JSON2COQ_SOURCES
    src/frontend/IRLoader/json2coq.cpp
)

add_executable(json2coq ${JSON2COQ_SOURCES})
target_link_libraries(json2coq ${Boost_LIBRARIES})
target_link_libraries(json2coq irloader)
target_link_libraries(json2coq ${LLVM_LIBRARIES})
target_link_libraries(json2coq ${Z3_LIBRARIES})
 
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
target_link_libraries(parser ${Boost_LIBRARIES})
target_link_libraries(parser ${Z3_LIBRARIES})
target_compile_options(parser PRIVATE -O3 -UDEBUG)
 
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
    src/frontend/SpoqIRLoader.cpp
    src/frontend/SpoqIRModule.cpp
    src/frontend/SpoqIRCFG.cpp
    src/frontend/SpoqIRTranslator.cpp
    src/frontend/SpoqIRInlineAsm.cpp
    src/frontend/SpoqIRPostProcess.cpp
    src/optimizations/coi.cpp
    src/optimizations/rules.cpp
    src/optimizations/projection.cpp
    src/optimizations/z3_rules.cpp
    src/optimizations/z3_utils.cpp
    src/optimizations/profile.cpp
    src/optimizations/simulate.cpp
    src/optimizations/symbolic.cpp
    src/optimizations/decompose.cpp
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

target_link_libraries(spoq irloader parser antlr4_shared)
target_link_libraries(spoq ${LLVM_LIBRARIES})
target_link_libraries(spoq ${Z3_LIBRARIES})
target_link_libraries(spoq ${Boost_LIBRARIES})
 
set_target_properties(spoq PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")