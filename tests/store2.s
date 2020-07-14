# checking negative relative memory addressing
# try writing and reading from address 99
imm 100
move off acc
imm 11
store -1
load -1
move stack acc
jump -100
#Stack Pointer: 11