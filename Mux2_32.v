//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Mux2_32
(
	//Entradas
	input wire MemToReg,         //Permite guardar resultados en registro
	input wire [31:0] ReadMem,   //Dato de la memoria
	input wire [31:0] Result,    //Resultado de la operación
	
	//Salida
	output reg [31:0] DataOut    //Dato de salida
);

always @(*) begin
	case (MemToReg)
		1'b1: begin
			DataOut = ReadMem;
		end
		1'b0: begin
			DataOut = Result;
		end
	endcase
end

endmodule