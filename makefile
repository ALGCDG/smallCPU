cpu: main.v memory.v ALU.v
	iverilog $^ -o cpu

testbench: testbench.v main.v memory.v ALU.v
	iverilog $^ -o testbench

test: testbench
	bash tests/testbench.sh

clean:
	rm -f cpu
	rm -f testbench
	rm -f program.dat
	rm -rf tmp
