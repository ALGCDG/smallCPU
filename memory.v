module memory #(parameter N = 16) (address, in, out, write_en, clk);
	// parameter N = 16;
	input clk, write_en;
	input [N-1:0] address;
	input [N-1:0] in;
	output reg [N-1:0] out;
	reg [N-1:0] mem [1023:0]; // defining a 1kxN block
	always @ (posedge clk)
	begin
		if (write_en) mem[address] <= in;
		if (address == 0) out <= 0;
		else out <= mem[address];
	end
	// load data file into memory
	initial
	begin
		$readmemb("program.dat", mem);
	end
endmodule
