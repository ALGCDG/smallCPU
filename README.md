tinyCPU is a simple accumulator CPU, implemented in verilog.

The work as presented is meant to work with Icarus Verilog compilation and simulation.

##Instructions
###Arithmetic
00 add \$a
01 xor \$a
02 or \$a
03 and \$a
04 seq \$a
05 slt \$a
06 sl \$a
07 sr \$a
08 imm \$a - loads immediate 
###Control
09 ifjump \$a - if accumulator register is nonzero, stack pointer is set to address \$a, stores PC+4 in accumulator (NB there is no unconditional jump, must first imm 1 in order to achieve same result)
###Memory
10 store \$a - stores word from accumulator to address \$a
11 move \$a1 \$a2- moves between stack register, accumulator register and memory offset register

##Macros
###load \$a
imm 0
add $a
###jump \$a
\# an unconditional jump
imm 1
ifjump \$a
###call \$a 
\#calls a function, assuming arguments have been placed on stack (transparent appart from offset after call)
imm \$a
move acc off
imm 1
ifjump 0
imm 0
move acc off
###inv
\# takes no argument, inverts bits in accumulator register
###sub \$a
\# subtracts value in $a from accumulator