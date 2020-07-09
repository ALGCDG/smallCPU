def str2int(s):
    if not s:
        return 0
    else:
        return (2**(len(s)-1))*(s[0] == '1') + str2int(s[1:])

def bitstring(i, l):
    """
    converts a number to a string of binary symbols (big endian)
    """
    def int2str(i):
        if not i:
            return ''
        else:
            return int2str(i>>1) + ('1' if i&1 else '0')
    sig = int2str(i)
    return '0'*(l-len(sig)) + sig
    
opcodes = {
    'add': 0,
    'xor': 1,
    'or': 2,
    'and': 3,
    'seq': 4,
    'slt': 5,
    'sl': 6,
    'sr': 7,
    'imm': 8,
    'ifjump': 9,
    'store': 10,
    'move': 11
}

moveArgs = {
    'acc': 0,
    'stack': 3,
    'off': 1,
    'offset': 1
}

N = 16
pc = 0
labels = {}


#
def opcode(instr): return instr[0]
def arg(instr): return instr[1]

# def process(line): 
def removeComment(line): return line.split('#')[0]
def parse(line): return [ p for p in line.strip().split(" ") if p != '' ]
def isLabel(line): return removeComment(line).find(':') != -1

# macros
def macro(line):
    """
    inserts macros
    """
    def load(a):
        return [["imm", "0"],["add", a]]
    def jump(a):
        return [["imm", "1"], ["ifjump", a]]
    def call(a):
        return [["imm", a], ["move", "acc", "off"], ["imm", "1"], ["ifjump", "0"], ["imm", "0"], ["move", "acc", "off"]]
    arg = parse(removeComment(line))
    if arg == []: return arg
    if arg[0] == "load": return load(arg[1])
    elif arg[0] == "jump": return jump(arg[1])
    elif arg[0] == "call": return call(arg[1])
    else: return [arg]

def arg(s):
    if s in labels: return labels[s]
    else: return eval(s)

def instruction(instr):
    """
    returns the binary representation of an instruction
    """
    op = opcode(instr)
    opField = bitstring(opcodes[op], 4)
    binary = ""
    if len(instr)==2:
        assert op!="move", "move instruction takes two arguments"
        argField = bitstring(arg(instr[1]), N-4) # will evaluate all forms (decimal)
        binary = opField+argField
    elif len(instr)==3:
        assert op == "move", "move instruction takes two arguments"
        argAField = bitstring(eval(instr[1]) if instr[1] not in moveArgs else moveArgs[instr[1]], 2)
        argBField = bitstring(eval(instr[2]) if instr[2] not in moveArgs else moveArgs[instr[2]], 2)
        binary = opField+('0'*(N-8))+argAField+argBField
    return binary

def chunksof(n):
    def _chunksof(l): return (l[:n], _chunksof(l[n:])) if len(l) > n else l
    return _chunksof

# MAIN
import sys

# process command line arguments
assert len(sys.argv)>=2, "Source file must be specified"
sourceName = sys.argv[1]
targetName = sys.argv[2] if len(sys.argv) >= 3 else "a.out"

# read source file
with open(sourceName) as source:
    instructions = map(lambda x: removeComment(x.lower()).strip(), source.readlines())

# convert macro instructions to atomic instructions
import itertools
atomic = itertools.chain.from_iterable(map(macro, instructions))

# convert atomic instructions to binary representation
binary = "0"*N+'\n'
for i in atomic:
    if opcode(i).find(':') != -1:
        labels[opcode(i).split(':')[0]] = pc
    else:
        binary += instruction(i) + '\n'
        pc += 4

# write binary file
with open(targetName, 'w') as target:
    target.writelines(binary)
