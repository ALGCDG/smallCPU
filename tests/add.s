# move offset stack
imm 1
store 1
imm 2
add 1 
move stack acc
jump 0 # we expect the stack to hold value 3
#Stack Pointer: 3