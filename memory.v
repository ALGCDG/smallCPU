module memory #(parameter N = 16, parameter M = 1024) (address, in, out, write_en, clk);
	// parameter N = 16;
	input clk, write_en;
	input [N-1:0] address;
	input [N-1:0] in;
	// output reg [N-1:0] out;
	// initial out = 0;
	
	output [N-1:0] out;
	assign out = (address == 0) ? 0 : mem[address];
	
	reg [N-1:0] mem [M-1:0]; // defining a 1kxN block
	always @ (posedge clk)
	begin
		if (write_en) mem[address] <= in;
		// if (address == 0) out <= 0;
		// else out <= mem[address];
	end
	// load data file into memory
	initial
	begin
		$readmemb("program.dat", mem);
		$display("Memory initialised");
		$display("first word %b", mem[0]);
	end
endmodule
