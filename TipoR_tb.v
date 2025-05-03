//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module TipoR_tb;

    //Señales
	reg clk;
    reg [31:0] Inst_tb;
	
    //Instanciación
    TipoR TipoRPrueba (.clk(clk), .Inst(Inst_tb));
	
	always #50 clk = ~clk;
	
	//Pruebas
    initial begin
        //Inicializamos la instrucción en ceros
        clk = 0;
		Inst_tb = 32'd0;
        #100;

        //Instrucción 1: Sub $20 $15 $9
		//32'b000000_01111_01001_10100_00000_100010
        Inst_tb = 32'b00000001111010011010000000100010;
        #100;
		Inst_tb = 32'd0;
        #100;
		
		//Instrucción 2: Sub $15 $20 $9
		//32'b000000_10100_01001_00001_00000_100010 Sub $1 $20 $9
		//32'b000000_10100_01001_01111_00000_100010 Sub $15 $20 $9
        Inst_tb = 32'b00000010100010010111100000100010;
        #100;
        Inst_tb = 32'd0;
        #100;
		
		#100;
		$finish;
    end

endmodule
