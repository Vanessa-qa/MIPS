module PC
(
	input CLK,              //Señales de reloj
	input [31:0]data_in,    //Dato de entrada
	output reg [31:0]data_out   //Dirección que se busca
);

	//Funcionamiento interno
	always @(posedge CLK) begin
		data_out = data_in;
	end
	
endmodule