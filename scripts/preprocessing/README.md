# Usage

## Build

For each pass in this directory, link the llvm-14.0.0. For example:

```
link -s /path/to/llvm/14 cleaner/llvm
```

Then, compile each pass.

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