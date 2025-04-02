module SUM
(
	input [31:0]data_in,     //Dato de entrada
	output reg [31:0]data_out    //Resultado
);

	always @(*) begin
		data_out = data_in + 4;
	end
	
endmodule


