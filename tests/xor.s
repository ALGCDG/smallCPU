# implementing xor swap of values stored at 1 and 2
imm 5
store 1
imm 7
store 2
load 1
xor 2
store 1
load 2
xor 1
store 2
load 1
xor 2
store 1
load 1
move stack acc
jump 0
#Stack Pointer: 7