set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")
#set(CMAKE_BUILD_TYPE Release)

if (DEFINED ENV{VCPKG_ROOT})
    message("import vcpkg packages")
    message("$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
    set(VCPKG_TARGET_TRIPLET x64-osx)
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
    include("$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
endif()

cmake_minimum_required(VERSION 3.10)
project(spoq)

# Set the compiler flags for the Debug build type
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
# Set the compiler flags for the Debug build type
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)


# Add the 'include' directory to the include paths
include_directories(include)
include_directories(include/z3)

# Find the Boost library
find_package(Boost REQUIRED COMPONENTS log)

# If Boost was found, include and link directories
if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS})
endif()

set(MAIN_CMAKE_BUILDTYPE ${CMAKE_BUILD_TYPE})
set(CMAKE_BUILD_TYPE "Release")
# Add ANTLR4 runtime
add_subdirectory(src/AutoV/Spec/Parser/antlr4/runtime/Cpp/)

set(CMAKE_BUILD_TYPE ${MAIN_CMAKE_BUILDTYPE})
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_definitions(-DDEBUG)
endif()
# Include ANTLR4 runtime headers
include_directories(src/AutoV/Spec/Parser/antlr4/runtime/Cpp/runtime/src/)

# include_directories(${ANTLR4_INCLUDE_DIRS})

# IRLoader source files
set(IRLOADER_SOURCES
    src/AutoV/IRLoader/coq.cpp
    src/AutoV/IRLoader/irvalues.cpp
    src/AutoV/IRLoader/instructions.cpp
    src/AutoV/IRLoader/irtypes.cpp
    src/AutoV/IRLoader/irloader.cpp
    src/AutoV/IRLoader/control_flow.cpp
    src/AutoV/IRLoader/inline_asm.cpp
    src/AutoV/IRLoader/post_process.cpp
    src/AutoV/log.cpp
)

# Build IRLoader as a shared library
add_library(irloader SHARED ${IRLOADER_SOURCES})
if(Boost_FOUND)
    target_link_libraries(irloader ${Boost_LIBRARIES})
endif()

# List source files for the json2coq executable
set(JSON2COQ_SOURCES
    src/AutoV/IRLoader/json2coq.cpp
)

# Specify the json2coq executable target and its source files
add_executable(json2coq ${JSON2COQ_SOURCES})
if(Boost_FOUND)
    target_link_libraries(json2coq ${Boost_LIBRARIES})
endif()
target_link_libraries(json2coq irloader)

# Parser source files
set(PARSER_SOURCES
    src/AutoV/Spec/Parser/SpecLexer.cpp
    src/AutoV/Spec/Parser/SpecParser.cpp
    src/AutoV/Spec/Parser/parse.cpp
    src/AutoV/Spec/Parser/parse_light.cpp
)
# Build IRLoader as a shared library
add_library(parser SHARED ${PARSER_SOURCES})
if(Boost_FOUND)
    target_link_libraries(parser ${Boost_LIBRARIES})
endif()
target_compile_options(parser PRIVATE -O3 -UDEBUG)

# List all source files explicitly
set(SOURCES
    src/AutoV/main.cpp
    src/AutoV/log.cpp
    src/AutoV/Spec/nodes.cpp
    src/AutoV/Spec/values.cpp
    src/AutoV/Spec/utils.cpp
    src/AutoV/Spec/project.cpp
    src/AutoV/Spec/type_inference.cpp
    # src/AutoV/Spec/Parser/SpecLexer.cpp
    # src/AutoV/Spec/Parser/SpecParser.cpp
    # src/AutoV/Spec/Parser/parse.cpp
    src/AutoV/Spec/ir2spec.cpp
    src/AutoV/Spec/shortcuts.cpp
    src/AutoV/Spec/projection/rules.cpp
    src/AutoV/Spec/projection/projection.cpp
    # Add other source files here

    src/AutoV/GenCoq/gen_code.cpp
    src/AutoV/GenCoq/gen_data.cpp
    src/AutoV/GenCoq/gen_high_proof.cpp
    src/AutoV/GenCoq/gen_high_spec.cpp
    src/AutoV/GenCoq/gen_low_proof.cpp
    src/AutoV/GenCoq/gen_low_spec.cpp
    src/AutoV/GenCoq/gen_layer.cpp
    src/AutoV/GenCoq/gen_project.cpp
)

# Specify the executable target and its source files
add_executable(spoq ${SOURCES})
# Link the shared library to the main executable
target_link_libraries(spoq irloader parser z3)

# Link the Boost libraries to the executable
if(Boost_FOUND)
    target_link_libraries(spoq ${Boost_LIBRARIES} antlr4_shared z3)
endif()

# Set the output directory for the executable
set_target_properties(spoq PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
