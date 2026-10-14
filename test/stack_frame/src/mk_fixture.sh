#!/usr/bin/env bash
# mk_fixture.sh <case.ll>
#
# Writes <case>.main.v next to <case>.ll the way the patchverification pipeline
# assembles build/%.main.v, for a module that defines f_vuln and f_patch and
# declares the external functions they call.  PV_PIPELINE is the pipeline's
# script directory (examples/pipeline in the patchverification repository).
set -euo pipefail

ll=$(realpath "$1")
stem=$(basename "$ll" .ll)
dir=$(dirname "$ll")
spoq=$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)
pre="$spoq/scripts/preprocessing"
pipe=${PV_PIPELINE:?set PV_PIPELINE to the patchverification examples/pipeline directory}
export LD_LIBRARY_PATH="${LLVM_LIB:-$HOME/workspace/llvm-project/build/lib}${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
cp "$ll" "$work/$stem.ll"
(cd "$pre" && ./extract-info.sh "$work/$stem.ll" > /dev/null 2>&1)
(cd "$pre/../IR2Json" && ./ir2json "$work/$stem.ll" > "$work/$stem.ll.json" 2> /dev/null)

externs=$(grep -oE '^declare [^@]*@[A-Za-z_][A-Za-z0-9_.]*' "$ll" | sed 's/.*@//' | grep -v '^llvm\.' | jq -R . | jq -s -c .)
echo "{\"top\": [\"f_vuln\", \"f_patch\"], \"bottom\": $externs}" > "$work/$stem.top_bottom.json"
(cd "$work" && python "$pre/gen-layer.py" "$stem.ll.json" "$stem.top_bottom.json" --dump-funcs > /dev/null 2>&1)
python "$pipe/layers_from_json.py" "$work/$stem.ll.gen.default-config.json" "$work/$stem.ll.declarations.v" \
    "$work/$stem.ll.memtypes.json" "$pipe/main_v_suffix_common.v" > "$work/$stem.ll.layers.v"
python "$pipe/filter_machine.py" "$work/$stem.ll.machine.v" "$work/$stem.ll.layers.v" > "$work/$stem.ll.processed.machine.v"
python "$pipe/preconditions.py" "$work/$stem.ll.processed.machine.v" "$work/$stem.ll.memtypes.json" \
    "$work/$stem.ll.gen.default-config.json" --ll="$work/$stem.ll" --stack-vars="$work/$stem.ll.machine.v" \
    --entry=f > "$work/$stem.ll.preconditions.v"

out="$dir/$stem.main.v"
sed -n '/SPOQ START/,/SPOQ STOP/p' "$pipe/main_v_prefix.v" | grep -v "SPOQ IGNORE" > "$out"
{
    echo "Definition PROJ_NAME: string := \"$stem\"."
    echo "Definition PROJ_BASE: string := \"$stem\"."
    echo "Definition PROJ_BC_PATH: string := \"$stem.bc\"."
    echo
    cat "$work/$stem.ll.datatype.v"
    echo
    cat "$work/$stem.ll.machine.v"
    cat <<'EOF'
Definition patch_correct_postcondition (st: RData) (st_sim: RData): Prop :=
st = st_sim.
Definition patch_correct_precondition (st: RData) (st_sim: RData): Prop :=
st = st_sim.

Hint Refines f_vuln_spec f_patch_spec patch_correct_precondition patch_correct_postcondition (vuln_ret = patch_ret).
EOF
    echo
    cat "$work/$stem.ll.layers.v"
    cat "$work/$stem.ll.preconditions.v"
    cat "$pipe/main_v_suffix_common.v"
    echo
} >> "$out"
perl -0777 -i -pe 's/;(\n[\t ]+)}/\1}/g' "$out"
for n in $(grep -oE '^Definition [A-Za-z_0-9]+' "$pipe/main_v_suffix_common.v" | cut -d' ' -f2); do
    sed -i "/^Parameter $n :/d" "$out"
done
# <case>.defs.v next to <case>.ll: Definitions that replace the Parameters of
# the same names, so a fixture can state an external function's spec.
defs="$dir/$stem.defs.v"
if [ -f "$defs" ]; then
    for n in $(grep -oE '^Definition [A-Za-z_0-9]+' "$defs" | cut -d' ' -f2); do
        sed -i "/^Parameter $n :/d" "$out"
    done
    python3 - "$out" "$defs" <<'PY'
import sys
out, defs = sys.argv[1], sys.argv[2]
s = open(out).read()
d = open(defs).read()
i = s.index("Section Bottom.")
open(out, "w").write(s[:i] + d + "\n" + s[i:])
PY
fi
