import difflib
import sys
from pathlib import Path

RED = "\u001b[31m"
GREEN = "\u001b[32m"
RESET = "\u001b[0m"

def show_diff(seqm):
    """
    Unify operations between two compared strings
    seqm is a difflib.SequenceMatcher instance whose a & b are strings
    """
    output= []
    for opcode, a0, a1, b0, b1 in seqm.get_opcodes():
        if opcode == 'equal':
            output.append(seqm.a[a0:a1])
        elif opcode == 'insert':
            output.append(GREEN + seqm.b[b0:b1] + RESET)
        elif opcode == 'delete':
            output.append(RED + seqm.a[a0:a1] + RESET)
        elif opcode == 'replace':
            # seqm.a[a0:a1] -> seqm.b[b0:b1]
            output.append(RED + seqm.a[a0:a1] + RESET)
            output.append(GREEN + seqm.b[b0:b1] + RESET)
        else:
            raise RuntimeError("unexpected opcode")
    return ''.join(output)

def colored_diff(s1, s2):
    lines1 = s1.splitlines()
    lines2 = s2.splitlines()

    d = difflib.Differ()
    diff = d.compare(lines1, lines2)

    result = []
    for line in diff:
        if line.startswith('- '):
            result.append('\033[31m' + line + '\033[0m')  # red for deletions
        elif line.startswith('+ '):
            result.append('\033[32m' + line + '\033[0m')  # green for insertions
        else:
            result.append(line)

    return '\n'.join(result)

# ...

def read_file(filepath):
    with open(filepath, 'r') as file:
        return file.read()

if __name__ == "__main__":
    str1 = read_file(sys.argv[1])
    str2 = read_file(sys.argv[2])
    result = colored_diff(str1, str2)
    print(result)