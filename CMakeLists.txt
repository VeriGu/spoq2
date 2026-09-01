cmake_minimum_required(VERSION 3.10)
project(spoq)

# ------------------------------------------------------------------------------
# Basic setup
# ------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g -g3 -gdwarf-4 -Wall -Wno-unused-function")
# GCC encodes variadic templates with DW_TAG_GNU_{formal,template}_parameter_pack,
# which lldb's Clang-based DWARF parser cannot represent -- it then reports
# "DW_TAG_member '_M_t' refers to type 0x... which was unable to be parsed" for
# anything held in a unique_ptr/shared_ptr/tuple.  gdb reads GCC's DWARF fine; for
# lldb, configure a build with -DCMAKE_CXX_COMPILER=clang++, which also gets the
# complete type info that -fstandalone-debug asks for.
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fstandalone-debug")
endif()
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -Wall -Wno-unused-function")
set(CMAKE_CXX_STANDARD 17)
include_directories(include)
set(ANTLR_BUILD_CPP_TESTS OFF)
# ------------------------------------------------------------------------------
# Z3
# ------------------------------------------------------------------------------
set(Z3_DIR "~/workspace/VeriFrame/build/_deps/z3-build")
find_package(Z3 4.12.5 REQUIRED CONFIG)
include_directories(${Z3_CXX_INCLUDE_DIRS})
message(STATUS "Found Z3 ${Z3_VERSION_STRING}")
message(STATUS "Using Z3Config.cmake in: ${Z3_DIR}")


# ------------------------------------------------------------------------------
# LLVM
# ------------------------------------------------------------------------------
# Which LLVM 23 to build against.  Defaults to the local source build; override
# with -DLLVM_ROOT=<prefix-or-build-tree>, -DLLVM_DIR=<...>/lib/cmake/llvm, or by
# exporting LLVM_ROOT.  A packaged install would be LLVM_ROOT=/usr/lib/llvm-23.
if(NOT DEFINED LLVM_ROOT)
  if(DEFINED ENV{LLVM_ROOT})
    set(LLVM_ROOT "$ENV{LLVM_ROOT}")
  else()
    set(LLVM_ROOT "$ENV{HOME}/workspace/llvm-project/build")
  endif()
endif()
if(NOT DEFINED LLVM_DIR)
  set(LLVM_DIR "${LLVM_ROOT}/lib/cmake/llvm")
endif()

# LLVMConfigVersion.cmake only accepts an exact major.minor match, so asking for
# "23" would reject 23.1.  Find whatever is configured and assert the major here.
find_package(LLVM REQUIRED CONFIG)
if(NOT LLVM_VERSION_MAJOR EQUAL 23)
  message(FATAL_ERROR
    "Found LLVM ${LLVM_PACKAGE_VERSION} via ${LLVM_DIR}, but spoq needs LLVM 23. "
    "Set -DLLVM_ROOT=<prefix-or-build-tree>.")
endif()

# spoq uses C++ RTTI throughout (typeid in irtypes.h, dynamic_cast in values.h,
# and Boost.Log requires it), so it cannot be compiled -fno-rtti.  Linking it
# against an LLVM built with LLVM_ENABLE_RTTI=OFF fails with missing typeinfo for
# LLVM's polymorphic classes (e.g. llvm::CallbackVH, via llvm::ValueMap).  Say so
# here instead of at link time.  LLVM defaults to RTTI off; distro packages
# enable it.
if(NOT LLVM_ENABLE_RTTI)
  message(FATAL_ERROR
    "The LLVM at ${LLVM_DIR} was built with LLVM_ENABLE_RTTI=OFF; spoq requires "
    "an RTTI-enabled LLVM.  Rebuild it with -DLLVM_ENABLE_RTTI=ON, or point "
    "-DLLVM_ROOT at an RTTI-enabled LLVM 23 (distro llvm-23 packages qualify).")
endif()
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
llvm_map_components_to_libnames(LLVM_LIBRARIES support core irreader analysis passes bitwriter)
# set(NO_RTTI "-fno-rtti")
# add_definitions(${NO_RTTI})


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
# if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    # set(CMAKE_POSITION_INDEPENDENT_CODE OFF)
    # add_definitions(-DDEBUG)
# endif()
# ------------------------------------------------------------------------------
# ANTRL4 runtime
# ------------------------------------------------------------------------------

message("ANTLR4 build type: ${CMAKE_BUILD_TYPE}")
add_subdirectory(src/frontend/parser/antlr4/runtime/Cpp/)

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
    src/libs/visitors.cpp
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
    src/frontend/SpoqIRAbstraction.cpp
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
# target_link_options(spoq PUBLIC -fsanitize=address)
# target_link_options(spoq PUBLIC -fsanitize=address -fno-pie -fno-PIE)
# target_link_options(json2coq PUBLIC -fno-pie -fno-PIE)
# target_link_options(irloader PUBLIC -fno-pie -fno-PIE)
# target_link_options(antlr4_shared PUBLIC -fno-pie -fno-PIE)
# target_link_options(parser PUBLIC -fno-pie -fno-PIE)
# set_target_properties(spoq PROPERTIES POSITION_INDEPENDENT_CODE FALSE)

target_link_libraries(spoq irloader parser antlr4_shared)
target_link_libraries(spoq ${LLVM_LIBRARIES})
target_link_libraries(spoq ${Z3_LIBRARIES})
target_link_libraries(spoq ${Boost_LIBRARIES})
# target_link_libraries(spoq libtcmalloc_and_profiler.so)

set_target_properties(spoq PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")

# ------------------------------------------------------------------------------
# SpoqTest -- GoogleTest driver for test/
# ------------------------------------------------------------------------------
# Built as part of `all` and made to depend on spoq, so running the tests always
# exercises the executable that was just built.  The spoq path and the test tree
# are baked in, so the driver never picks up a stale binary from $PATH.
find_package(GTest REQUIRED)
enable_testing()

add_executable(SpoqTest test/SpoqTest.cpp)
add_dependencies(SpoqTest spoq)
target_compile_definitions(SpoqTest PRIVATE
    SPOQ_BINARY="$<TARGET_FILE:spoq>"
    SPOQ_TEST_DIR="${CMAKE_CURRENT_SOURCE_DIR}/test")
target_link_libraries(SpoqTest GTest::gtest ${LLVM_LIBRARIES} ${Boost_LIBRARIES})
set_target_properties(SpoqTest PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")

# One ctest entry per case, so `ctest -R <name>` and parallel runs work.  The
# glob only names the tests; the driver rediscovers them at run time, so adding
# a triple of files needs no build-system change (just a re-configure to get its
# own ctest entry).
file(GLOB_RECURSE SPOQ_TEST_EXPECTED
     RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/test"
     "${CMAKE_CURRENT_SOURCE_DIR}/test/*.expected.json")
foreach(expected ${SPOQ_TEST_EXPECTED})
    get_filename_component(case_name "${expected}" NAME)
    string(REGEX REPLACE "\\.expected\\.json$" "" case_name "${case_name}")
    add_test(NAME ${case_name}
             COMMAND SpoqTest --gtest_filter=Spoq.${case_name})
endforeach()
