module control(opcode, arg1, arg2, data_wen, acc_wen, offset_wen, stack_wen);
	input [1:0] arg1, arg2; // arguments for move instructions
	always @ (posedge clk)
		case (opcode) begin
			ADD, OR, XOR, AND, SEQ, SLT, SL, SR, IMM:
				offset_wen = 0;
				stack_wen = 0;
				data_wn = 0;
				acc_wen = 1;
			STORE:
				data_wen = 1;
			MOVE:
			default:
				offset_wen = 0;
				stack_wen = 0;
				data_wn = 0;
				acc_wen = 0;
		endcase
