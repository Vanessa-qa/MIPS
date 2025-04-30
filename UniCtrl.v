//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module UniCtrl
(
	//Entrada
	input wire [5:0] Op,     //Tipo de instrucción
	
	//Salidas
	output reg MemToReg,     //Permite guardar resultados en registro
	output reg MemToWrite,   //Permite escribir en la memoria de datos
	output reg [1:0] AluOp,  //Le señala a la AluCtrl la opcion a elegir
	output reg RegToWrite    //Permite escribir en el banco de registros
);

always @(*) begin
	case (Op)
		6'b000000: begin     //instrucción de tipo R
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b10;
			RegToWrite = 1'b1;
		end
	endcase
end

endmodule
