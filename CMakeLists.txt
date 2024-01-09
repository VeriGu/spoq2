set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")
#set(CMAKE_BUILD_TYPE Release)

cmake_minimum_required(VERSION 3.10)
project(spoq)

# Set the compiler flags for the Debug build type
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_definitions(-DDEBUG)
endif()

# Set the compiler flags for the Debug build type
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)

# Add the 'include' directory to the include paths
include_directories(include)

# Find the Boost library
find_package(Boost REQUIRED COMPONENTS log)

# If Boost was found, include and link directories
if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS})
endif()

# Add ANTLR4 runtime
add_subdirectory(src/AutoV/Spec/Parser/antlr4/runtime/Cpp/)

# Include ANTLR4 runtime headers
include_directories(src/AutoV/Spec/Parser/antlr4/runtime/Cpp/runtime/src/)

# include_directories(${ANTLR4_INCLUDE_DIRS})

# List all source files explicitly
set(SOURCES
    src/AutoV/main.cpp
    src/AutoV/log.cpp
    src/AutoV/IRLoader/coq.cpp
    src/AutoV/IRLoader/irvalues.cpp
    src/AutoV/Spec/nodes.cpp
    src/AutoV/Spec/values.cpp
    src/AutoV/Spec/utils.cpp
    src/AutoV/Spec/project.cpp
    src/AutoV/Spec/type_inference.cpp
    src/AutoV/Spec/Parser/SpecLexer.cpp
    src/AutoV/Spec/Parser/SpecParser.cpp
    src/AutoV/Spec/Parser/parse.cpp
    # Add other source files here
)

# Specify the executable target and its source files
add_executable(spoq ${SOURCES})

# Link the Boost libraries to the executable
if(Boost_FOUND)
    target_link_libraries(spoq ${Boost_LIBRARIES} antlr4_shared)
endif()

# Set the output directory for the executable
set_target_properties(spoq PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/build")
