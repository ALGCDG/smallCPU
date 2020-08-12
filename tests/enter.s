ENTER:
imm M # where N is 
move stack acc
call function

GETCHAR:
store -1
imm 0
move off acc
load GCs
store 0
load -1
jump 0

ROUNDROBBIN: