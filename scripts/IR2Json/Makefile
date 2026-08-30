RM=rm -f

# Which LLVM 23 to build against.  Defaults to the local source build; override
# with `make LLVM_ROOT=/usr/lib/llvm-23` for a packaged install.
LLVM_ROOT?=$(HOME)/workspace/llvm-project/build
CC=$(LLVM_ROOT)/bin/clang
CXX=$(LLVM_ROOT)/bin/clang++
LLVM_CONFIG=$(LLVM_ROOT)/bin/llvm-config
LLVM_INCLUDE=$(shell $(LLVM_CONFIG) --includedir)

CPPFLAGS=-g -O2 -DLLVM_DISABLE_ABI_BREAKING_CHECKS_ENFORCING
CPPFLAGS+=$(shell $(LLVM_CONFIG) --cxxflags)
LDFLAGS=$(shell $(LLVM_CONFIG) --ldflags)
# Record the LLVM libdir so the binary works against a build tree or a prefix
# outside the loader's default search path, without needing LD_LIBRARY_PATH.
LDFLAGS+=-Wl,-rpath,$(shell $(LLVM_CONFIG) --libdir)
LDLIBS=$(shell $(LLVM_CONFIG) --libs) -lpthread -lm

INCLUDES=-I include
INCLUDES+=-I $(LLVM_INCLUDE)

SRCS=\
src/gen_constant.cpp\
src/gen_function.cpp\
src/gen_global_var.cpp\
src/gen_instruction.cpp\
src/gen_module.cpp\
src/gen_type.cpp\
src/gen_value.cpp\
src/ir2json.cpp\

OBJS=$(subst .cpp,.o,$(SRCS))

all: ir2json

ir2json: $(OBJS)
	$(CXX) $(INCLUDES) $(LDFLAGS) -o ir2json $(OBJS) $(LDLIBS)

%.o: %.cpp
	$(CXX) $(INCLUDES) $(CPPFLAGS) -c -o $@ $<

clean:
	$(RM) $(OBJS)

distclean: clean
	$(RM) ir2json
