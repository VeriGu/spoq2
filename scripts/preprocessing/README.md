# Usage

## Build

Run `./build-passes.sh` to configure and build every pass against LLVM 23
(`/usr/lib/llvm-23` by default; pass a different install dir as the first
argument). It also refreshes each pass's `llvm` symlink, which is what the
per-pass `CMakeLists.txt` defaults to.

The passes are New Pass Manager plugins. LLVM 17 removed the legacy pass manager
from `opt`, so run them as:

```
opt-23 --load-pass-plugin=cleaner/lib/libcleaner.so -passes=cleaner ...
```

rather than the old `opt -enable-new-pm=0 -load ... --cleaner` form.

`pv_ir_outliner` has not been ported past LLVM 15 and `build-passes.sh` skips it;
see the note in its `CMakeLists.txt`.

The wrapper scripts (`extract-info.sh`, `rename_with_suffix.sh`, `opt.sh`) call
`opt-23`; set `OPT=/path/to/opt` to use an LLVM 23 that is not on `PATH`.

## Get IR and its JSON version

Under any directory, run `get-ir.sh /path/to/the/container/project/root` will 
- compile the container project if necessary (no `rmm.linked.bc` file found)
- run opt.sh for preprocessing passes that may change the IR: cleaner, mymergefunc, remove-opt-none, and O1 passes.
- run IR2Json to generate the JSON version of IR (if IR2Json exists)

For example, under the `rcsm-rmm/verification` directory, run `veriframe/preprocessing/get-ir.sh ..`.

## Run passes separately

Alternatively, one can run `opt.sh` command separately to run all passes at one click.

``opt.sh /path/to/input.ll /path/to/output.ll``

## Get generated datatypes and machine model

Under any directory, run `extract-info.sh /path/to/IR`. 

Two files will be generated under the current working directory. The datatype file (ready for `gen-layer.py`) and the machine file (requiring manual modifications).

## Generate layer config

Under any directory, run 

``python3 gen-layer.py /path/to/json/version/ir /path/to/top/bottom/config [list of file]``

For example. to generate a config for the container, run

``python3 gen-layer.py rmm-opt.linked.ir2json.json top-bottom.json coq/datatype.pure.v coq/machine.pure.v``

under the rcsm-rmm/verification directory.

(See rcsm-rmm/verification/README.md for a step-by-step guide to generate layer config for the container.)