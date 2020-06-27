module register(in, out, clk, write_en);
	parameter N = 16; // setting words size as 16, can be changed
	input [N-1:0] in
	input clk, write_en
	output [N-1:0] out
	reg [N-1:0] value
	always @ (posedge clk)
		if (write_en) value <= in
		out <= value
endmodule
