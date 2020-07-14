#!/bin/bash

# create tmp folder
mkdir -p tmp
# for each file in tests folder
for t in ./tests/*.s ; do
    # find expected value for test (stored as comment on last line of test file)
    tail -n 1 $t | cut -c2- > tmp/expect.txt
    # assemble dat file from source to dat
    printf "Assembling test: "
    printf $t
    printf " => "
    python3 assembler.py $t program.dat
    # run vvp testbench
    vvp testbench | tail -n 1 | grep -o '\<Stack Pointer: .*\>' > tmp/out.txt
    # compare result and 
    diff tmp/out.txt tmp/expect.txt
    if [[ $? == 0 ]] ; then
        echo "PASS"
    else
        echo "FAIL"
    fi
done
rm program.dat
# rm -rf tmp
