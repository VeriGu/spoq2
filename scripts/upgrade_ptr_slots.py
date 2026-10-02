#!/usr/bin/env python3
"""Rewrite a generated .main.v to the pointer-valued memory model.

Applies the changes extractpointers and main_v_suffix_common.v made when
stack slots started holding Ptr values:

  - PtrVal holds a Ptr; load_stack/store_stack convert at a pointer slot.
  - load_stack_ptr/store_stack_ptr are added, and the four stack accessors
    move after ptr_to_int, which they use.
  - ptr_to_int of a heap or stack pointer is the uninterpreted
    ptr_to_int_other instead of -1.
  - load_RData_ptr/store_RData_ptr and their bypass forms follow
    load_stack_bypass.
  - int_to_ptr is defined: -1 is the poison pointer, [0, MIN_GLOBAL) are
    null-based pointers, the global range is decoded by global_to_ptr, and the
    uninterpreted int_to_ptr_other covers the rest; ptr_to_int of a null-based
    pointer below MIN_GLOBAL is its offset; the assumptions on
    ptr_to_int_other and int_to_ptr_other follow ptr_to_int.

Usage: upgrade_ptr_slots.py FILE...  (rewrites in place; a file that is not in
the generated layout, or is already upgraded, is reported and left alone).
"""
import re
import sys

SUFFIX = '''(* Pointer-valued accesses.  A stack slot keeps a stored Ptr, base included;
   other memory holds the pointer as ptr_to_int. *)
Definition load_RData_ptr (sz: intSizeT) (p: Ptr) (st: RData) : (option Ptr) :=
  if (is_stack_ptr p) then load_stack_ptr sz p st.(stack)
  else match (load_RData sz p st) with
    | Some v => Some (int_to_ptr v)
    | None => None
  end.
Definition store_RData_ptr (sz: intSizeT) (p: Ptr) (v: Ptr) (st: RData) : option RData :=
  if (is_stack_ptr p) then
  match (store_stack_ptr sz p v st.(stack)) with
    | Some new_stack => Some(st.[stack] :< new_stack)
    | None => None
  end
  else store_RData sz p (ptr_to_int v) st.
Hint DelayUnfold load_RData_ptr.
Hint DelayUnfold store_RData_ptr.
Definition store_stack_ptr_bypass (sz: intSizeT) (p: Ptr) (v: Ptr) (st: RData) : option RData :=
  match (store_stack_ptr sz p v st.(stack)) with
    | Some new_stack => Some(st.[stack] :< new_stack)
    | None => None
  end.
Definition load_stack_ptr_bypass (sz: intSizeT) (p: Ptr) (st: RData) : (option Ptr) :=
  load_stack_ptr sz p st.(stack).
'''
BYPASS = '''Definition load_stack_bypass (sz: intSizeT) (p: Ptr) (st: RData) : (option int64) :=
  load_stack sz p st.(stack).
'''
INT_TO_PTR = '''Parameter int_to_ptr_other : (intSizeT -> (Ptr)).
Definition int_to_ptr (v: intSizeT) : Ptr := 
 if (v =? (0 - 1)) then (mkPtr "null" (0 - 1)) else
 if ((0 <=? v) && (v <? MIN_GLOBAL)) then (mkPtr "null" v) else
 if ((MIN_GLOBAL <=? v) && (v <? MAX_GLOBAL)) then (global_to_ptr v) else
    (int_to_ptr_other v).
'''
ASSUMPTIONS = (
    'Definition ptr_to_int_other_outside_globals : Prop := forall (p: Ptr), '
    '(((ptr_to_int_other p) <? MIN_GLOBAL) \\/ (MAX_GLOBAL <=? (ptr_to_int_other p))).\n'
    'Definition ptr_to_int_other_not_null : Prop := forall (p: Ptr), '
    '(((ptr_to_int_other p) <? (0 - 1)) \\/ (MIN_GLOBAL <=? (ptr_to_int_other p))).\n'
    'Definition int_to_ptr_other_inverse : Prop := forall (p: Ptr), '
    '((int_to_ptr_other (ptr_to_int_other p)) = p).\n'
    'Definition ptr_to_int_other_inverse : Prop := forall (v: intSizeT), '
    '((((v <? (0 - 1)) \\/ (MAX_GLOBAL <=? v))) -> ((ptr_to_int_other (int_to_ptr_other v)) = v)).\n')
NULL_ARM = (' if (p.(pbase) =s "null") then 0 else\n',
            ' if (p.(pbase) =s "null") then (if (p.(poffset) <? MIN_GLOBAL) then p.(poffset) else (ptr_to_int_other p)) else\n')
# A null arm without the MIN_GLOBAL bound, from an interim upgrade.
INTERIM_NULL_ARM = ' if (p.(pbase) =s "null") then p.(poffset) else\n'
# The int_to_ptr definition and assumptions of an earlier upgrade: 0 and -1
# null, no null-based range.
EARLIER_INT_TO_PTR = INT_TO_PTR.replace(
    ' if (v =? (0 - 1)) then (mkPtr "null" (0 - 1)) else\n if ((0 <=? v) && (v <? MIN_GLOBAL)) then (mkPtr "null" v) else\n',
    ' if (v =? 0) then (mkPtr "null" 0) else\n if (v =? (0 - 1)) then (mkPtr "null" (0 - 1)) else\n')
EARLIER_ASSUMPTIONS = (
    'Definition ptr_to_int_other_outside_globals : Prop := forall (p: Ptr), '
    '(((ptr_to_int_other p) <? MIN_GLOBAL) \\/ (MAX_GLOBAL <=? (ptr_to_int_other p))).\n'
    'Definition int_to_ptr_other_inverse : Prop := forall (p: Ptr), '
    '((int_to_ptr_other (ptr_to_int_other p)) = p).\n'
    'Definition ptr_to_int_other_inverse : Prop := forall (v: intSizeT), '
    '((((v <? MIN_GLOBAL) \\/ (MAX_GLOBAL <=? v))) -> ((ptr_to_int_other (int_to_ptr_other v)) = v)).\n')
OLD_INT_TO_PTR = '''Parameter int_to_ptr: (intSizeT -> (Ptr)).
'''
AXIOMS = '''  Definition int_to_ptr_zero : Prop := (int_to_ptr 0) = (mkPtr "null" 0).
  Definition int_to_ptr_neg_one : Prop := (int_to_ptr (0 - 1)) = (mkPtr "null" (0 - 1)).
'''
AXIOMS_NOTE = "  (* int_to_ptr_zero and int_to_ptr_neg_one follow from int_to_ptr's definition. *)\n"
HEAD = '\tmatch (stack_map @ p.(pbase)) with\n\t\t| Some sv => match sv with\n'
TAIL = '\t\tend\n\t| None => None\nend.'


def accessor(text, name):
    """The definition of [name] with its trailing marker comment, and its arms."""
    m = re.search(r'Definition ' + name + r' \(.*?' + re.escape(TAIL) + r' \(\* ' + name + r' \*\)\n',
                  text, re.S)
    if not m:
        return None, None
    body = m.group(0)
    start = body.index(HEAD) + len(HEAD)
    end = body.rindex(TAIL)
    arms = re.split(r'(?=^\t\t\t\| )', body[start:end], flags=re.M)
    return m, [a for a in arms if a]


def ctor(arm):
    return re.match(r'\t\t\t\| (\S+) ', arm).group(1)


def convert_load(arm, f):
    """The arm with its result wrapped in (f ...)."""
    if '\t\t\t\twhen ' in arm:  # struct: Some(ret)
        return re.sub(r'Some\((\w+)\)\n$', r'Some((' + f + r' \1))\n', arm)
    return re.sub(r'Some (\w+)\n$', r'Some (' + f + r' \1)\n', arm)


def convert_store(arm, value):
    """The arm with the stored v replaced by [value]."""
    if '\t\t\t\twhen ' in arm:  # struct: store_S sz p.(poffset) v ...
        return re.sub(r'(== store_\w+ sz p\.\(poffset\)) v ', r'\1 ' + value + ' ', arm)
    return re.sub(r'Some\((\w+) v\)\)\n$', r'Some(\1 ' + value + '))\n', arm)


def uninterpreted_ptr_to_int(text):
    """ptr_to_int of a heap or stack pointer is ptr_to_int_other, not -1."""
    p2i = re.search(r'Definition ptr_to_int \(p: Ptr\) : intSizeT := ?\n.*?\n    \(-1\)\.\n', text, re.S)
    if not p2i:
        return text
    new = ('Parameter ptr_to_int_other : (Ptr -> (intSizeT)).\n' +
           p2i.group(0)[:-len('    (-1).\n')] + '    (ptr_to_int_other p).\n')
    return text[:p2i.start()] + new + text[p2i.end():]


def null_based_addresses(text):
    """Stage 3, from an earlier stage 2: null-based pointers have addresses."""
    if INT_TO_PTR in text and ASSUMPTIONS in text and NULL_ARM[1] in text:
        return None, 'already upgraded'
    for old, new in [(EARLIER_INT_TO_PTR, INT_TO_PTR), (EARLIER_ASSUMPTIONS, ASSUMPTIONS), NULL_ARM,
                     (INTERIM_NULL_ARM, NULL_ARM[1])]:
        text = text.replace(old, new)
    if text.count(INT_TO_PTR) != 1 or text.count(ASSUMPTIONS) != 1 or text.count(NULL_ARM[1]) != 1:
        return None, 'not in the generated layout'
    return text, None


def define_int_to_ptr(text):
    """Stage 2: int_to_ptr defined, and the address assumptions."""
    if 'Definition int_to_ptr ' in text:
        return null_based_addresses(text)
    text = uninterpreted_ptr_to_int(text)
    g2p = re.search(r'Definition global_to_ptr \(v: intSizeT\) : Ptr := ?\n.*?\n   \(mkPtr "null" 0\)\.\n', text, re.S)
    other = '    (ptr_to_int_other p).\n'
    maxg = re.search(r'^Definition MAX_GLOBAL : intSizeT := \d+\.\n', text, re.M)
    if (not g2p or text.count(other) != 1 or not maxg or text.count(OLD_INT_TO_PTR) != 1 or
            text.count(AXIOMS) != 1 or text.count(NULL_ARM[0]) != 1):
        return None, 'not in the generated layout'
    text = text.replace(*NULL_ARM)
    text = text.replace(other, other + ASSUMPTIONS)
    text = text[:g2p.end()] + INT_TO_PTR + text[g2p.end():]
    text = text.replace(maxg.group(0), 'Definition MIN_GLOBAL : intSizeT := 67108864.\n' + maxg.group(0))
    text = text.replace(OLD_INT_TO_PTR, '')
    text = text.replace(AXIOMS, AXIOMS_NOTE + AXIOMS)
    return text, None


def upgrade(text):
    if 'Definition load_stack_ptr' in text:
        return define_int_to_ptr(text)
    load, load_arms = accessor(text, 'load_stack')
    store, store_arms = accessor(text, 'store_stack')
    p2i = re.search(r'Definition ptr_to_int \(p: Ptr\) : intSizeT := ?\n.*?\n    \(-1\)\.\n', text, re.S)
    if not load or not store or not p2i or text.count(BYPASS) != 1:
        return None, 'not in the generated layout'
    if [ctor(a) for a in load_arms] != [ctor(a) for a in store_arms]:
        return None, 'load_stack and store_stack arms differ'

    int_load, int_store, ptr_load, ptr_store = [], [], [], []
    for la, sa in zip(load_arms, store_arms):
        if ctor(la) == 'PtrVal':
            int_load.append(convert_load(la, 'ptr_to_int'))
            int_store.append(convert_store(sa, '(int_to_ptr v)'))
            ptr_load.append(la)
            ptr_store.append(sa)
        else:
            int_load.append(la)
            int_store.append(sa)
            ptr_load.append(convert_load(la, 'int_to_ptr'))
            ptr_store.append(convert_store(sa, '(ptr_to_int v)'))

    def define(header, arms, name):
        return header + HEAD + ''.join(arms) + TAIL + ' (* ' + name + ' *)\n'

    load_header = load.group(0)[:load.group(0).index(HEAD)]
    store_header = store.group(0)[:store.group(0).index(HEAD)]
    accessors = ('\n' + define(load_header, int_load, 'load_stack') +
                 define(store_header, int_store, 'store_stack') +
                 define('Definition load_stack_ptr (sz: intSizeT) (p: Ptr) (stack_map: STACK): (option Ptr) := \n',
                        ptr_load, 'load_stack_ptr') +
                 define('Definition store_stack_ptr (sz: intSizeT) (p: Ptr) (v: Ptr) (stack_map: STACK): '
                        '(option STACK) := \n', ptr_store, 'store_stack_ptr'))

    # The old accessors were emitted as "\n" + load + store; drop them there.
    old = '\n' + load.group(0) + store.group(0)
    if text.count(old) != 1:
        return None, 'stack accessors not adjacent'
    text = text.replace(old, '')
    p2i = re.search(r'Definition ptr_to_int \(p: Ptr\) : intSizeT := ?\n.*?\n    \(-1\)\.\n', text, re.S)
    text = text[:p2i.end()] + accessors + text[p2i.end():]
    text = uninterpreted_ptr_to_int(text)
    text = text.replace('| PtrVal (PtrValConstr: intSizeT)', '| PtrVal (PtrValConstr: Ptr)')
    text = text.replace(BYPASS, BYPASS + SUFFIX)
    return define_int_to_ptr(text)


def main():
    for path in sys.argv[1:]:
        with open(path) as f:
            new, why = upgrade(f.read())
        if new is None:
            print(f'{path}: skipped, {why}')
            continue
        with open(path, 'w') as f:
            f.write(new)
        print(f'{path}: upgraded')
    return 0


if __name__ == '__main__':
    sys.exit(main())
