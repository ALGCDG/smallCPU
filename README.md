tinyCPU is a simple accumulator CPU, implemented in verilog.

The work as presented is meant to work with Icarus Verilog compilation and simulation.

## Instructions
### Arithmetic
00 add \$a - acc := mem[a] + acc\
01 xor \$a - acc := mem[a] ^ acc\
02 or \$a - acc := mem[a] | acc\
03 and \$a - acc := mem[a] & acc\
04 seq \$a - acc := acc = mem[a]\
05 slt \$a - acc := acc < mem[a]\
06 sl \$a - acc := acc << mem[a]\
07 sr \$a - acc := acc >>> mem[a]\
08 imm \$a - acc := a\
### Control
09 ifjump \$a - pc := a if acc else pc + 1
if accumulator register is nonzero, stack pointer is set to address \$a, stores PC+4 in accumulator (NB there is no unconditional jump, must first imm 1 in order to achieve same result)
### Memory
10 store \$a - mem[a] := acc\
 stores word from accumulator to address \$a
11 move \$a1 \$a2- moves between stack register, accumulator register and memory offset register

## Macros
### load \$a
imm 0
add $a
### jump \$a
\# an unconditional jump
imm 1
ifjump \$a
### call \$a 
\#calls a function, assuming arguments have been placed on stack (transparent appart from offset after call)
imm \$a
move acc off
imm 1
ifjump 0
imm 0
move acc off
### inv
\# takes no argument, inverts bits in accumulator register
### sub \$a
\# subtracts value in $a from accumulator

## Structure

Seperate instruction and data memory.
Accumulator Architecture.

## Simulation
To simulate the processor, icarus Verilog is required.

To build the simulation
`make cpu`

To run the simulation
`vvp cpu`

the instruction memory can be specified using a plain text file "program.dat" storing character representations of the binary

to test the processor

`make testbench`
`make test`

## Assembler

The assembler is a python3 script, assembler.py, which takes two arguments

`python3 assembler.py sourcefile.s program.dat`
