module ALU(A, B, out, opcode, clk);
	input [7:0] A, B;
	input [3:0] opcode;
	output reg [7:0] out;

	// uses onehot encodiung for simplicity
	parameter ADD = 4'b0001;
	parameter OR = 4'b0010;
	parameter AND = 4'b0100;
	parameter XOR = 4'b1000;
	always @ (posedge clk)
		switch (control) begin
			ADD: out <= A + B;
			OR: out <= A | B;
			AND: out <= A & B;
			XOR: out <= A ^ B;
			default: ; // if OP is not defined as parameter, do nothing
		end
endmodule
