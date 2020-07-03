module memory(address, in, out, write_en, clk);
	input clk, write_en;
	input [7:0] address;
	input [7:0] in;
	output reg [7:0] out;
	reg [7:0] mem [1023:0]; // defining a 1kx8 block
	always @ (posedge clk)
		if (write_en) mem[address] <= in;
		if (address == 0) out <= 0;
		else out <= mem[address]
endmodule
