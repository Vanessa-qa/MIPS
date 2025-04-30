//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

//Memoria de datos
module MemDatos
( 
	//Entradas
	input wire [31:0] Addr,     //Dirección de escritura
	input wire [31:0] Data,     //Dato a escribir
	input wire MemWrite,        //Habilita la escritura
	
	//Salida
	output reg [31:0] MemRead  //Dato de lectura
);

    reg [31:0] Memdata [0:31];  //Memoria de datos

    always @(*) begin
        if (MemWrite)
            Memdata[Addr] = Data;   // Escritura
        else
            MemRead = Memdata[Addr]; // Lectura
    end

endmodule
