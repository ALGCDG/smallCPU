// stack based

// instructions
00 - add - adds two top addresses
01 - xor - xors two top addresses
02 - and - ands two top addresses
03 - or - ors two top addresses
04 - jump $a - jumps to address $a and pushes current pc to stack
05 - push $a - pushes value a to stack
06 - pop - removes top element from stack
07 - load $a - loads word from address $a and puts at top of stack
08 - store $a
09 - sload $a - loads a word from $a address from top of stack

// fibonarcci

fib:
sload 4
push 1
slt
condjump A
sload 8
push 1
sub

A:



// accumulator
An alternative is an accumulator architecture
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

## floating point
We have 4 more opcodes to use
fconv - converts between int and float
fadd

## succ
succ:
move stack off
store -4 # store return address
imm 1
add 4 # add argument (stored st sp+4) result is now in accumulator
store 0 # returned value is stored at stack pointer
imm 0
add -4 # load return address
move acc off
imm 1
ifjump 0 # jump to instruction after function call

main:
imm 3
move stack off
store 4 # store argument on stack
imm succ
move acc off
imm 1
ifjump 0
imm 0
move acc off # clearing offset after function call

// fibonarcci

fib:
\# if argument is 1 or 0, return 1
imm 1
slt arg
ifjump fib'
load arg
sub 0 1
store arg
jump fib
load arg
sub 0 2
store arg
jump fib
jump ret
fib-base:
imm 1
store ret
jump ret

(for reference, mips call is)
arguments
-- stack pointer
return address
frame pointer
saved registers
