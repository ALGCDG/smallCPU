# implementing a loop which counts from 0 to 9
imm 0
store 1
imm 1
store 2
imm 10
store 3
looptop:
load 1
add 2
store 1
slt 3
ifjump looptop
jump 0
#Stack Pointer: 9