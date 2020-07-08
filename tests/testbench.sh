#!/bin/bash

# for each file in tests folder
for t in ./tests/* ; do
    # assemble dat file from source to dat
    printf "Assembling test: "
    echo $t
    python3 assembler.py $t program.dat
    # run vvp testbench
    vvp testbench
done
rm program.dat
