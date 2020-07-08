#!/bin/bash

# create tmp folder
mkdir -p tmp
# for each file in tests folder
for t in ./tests/* ; do
    # find expected value for test (stored as comment on last line of test file)
    tail -n 1 $t | cut -c1- > tmp/expect.txt
    # assemble dat file from source to dat
    printf "Assembling test: "
    echo $t
    python3 assembler.py $t program.dat
    # run vvp testbench
    vvp testbench > tmp/out.txt
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