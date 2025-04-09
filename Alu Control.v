
module ALUCtrl(
	input [1:0] Op,
	input [5:0] Function,
	output reg [3:0] OPAlu
);
always @(*)begin
	case (Op)
		2'b10: begin
			case (Function)
				6'b100000: begin
					OPAlu = 4'b0010;
				end
			default OPAlu = 4'b0;
			endcase
		end
	endcase
end
endmodule

