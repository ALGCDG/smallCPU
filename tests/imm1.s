# trying a negative immediate value
imm -1
move stack acc
jump 0 # we expect the accumulator to hold value 3
#Stack Pointer: 10