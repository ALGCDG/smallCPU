# making sure memory at address 0 is always zero (even if there is an attempt to store value)
imm 17
store 0
load 0
move stack acc
jump 0
#Stack Pointer: 0