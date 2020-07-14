# a basic example of a program in tinyISP
# add 1
# xor 2
# xor 11
# # hello:
# # ifjump hello
# load 10
imm 10
move stack acc
jump 0 # we expect the accumulator to hold value 3
#Stack Pointer: 10