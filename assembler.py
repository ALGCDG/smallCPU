
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

N = 16
pc = 0
labels = {}

def arg(s):
    if s in labels: return labels[s]
    else: return eval(s)

def instruction(s):
    """
    returns the binary representation of an instruction
    """
    noComment = s.split('#')[0]
    instr = [x for x in noComment.split(" ") if x != '']
    op = instr[0].lower()
    opField = bitstring(opcodes[op], 4)
    binary = ""
    if len(instr)==2:
        assert(op!="move")
        argField = bitstring(arg(instr[1]), N-4) # will evaluate all forms (decimal)
        binary = opField+argField
    elif len(instr)==3:
        assert(op=="move")
        argAField = bitstring(eval(instr[1]), 2)
        argBField = bitstring(eval(instr[2]), 2)
        binary = opField+('0'*(N-8))+argAField+argBField
    return binary

while True:
    line = input()
    noComm = line.split('#')[0]
    if noComm.find(':') != -1:
        labels[noComm.split(':')[0]] = pc
        print(labels)
    else:
        print(instruction(line))
        pc += 4
        
