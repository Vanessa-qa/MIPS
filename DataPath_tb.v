//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Datapath_tb;

    //Señales
    reg [31:0] Inst_tb;
	
    //Instanciación
    Datapath datapath1 (.Inst(Inst_tb));

	//Pruebas
    initial begin
        //Inicializamos la instrucción en ceros
        Inst_tb = 32'd0;
        #100;

        //Instrucción 1: Sub $20 $15 $9
        Inst_tb = 32'b00000001111010011010000000100010;
        #100;
		//Instrucción 2: Sub $1 $20 $9
        Inst_tb = 32'b00000010100010010000100000100010;
        #100;
        //Instrucción 3: Add $16 $5 $15
        Inst_tb = 32'b00000000101011111000000000100000;
        #100;
        //Instrucción 4: Add $17 $9 $16
        Inst_tb = 32'b00000001001100001000100000100000;
        #100;
		//Instrucción 5: SLT $21 $1 $17
		Inst_tb = 32'b00000000001100011010100000101010;
		#100;
		
		#100;
		$finish;
    end

endmodule
