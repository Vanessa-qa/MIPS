
module MemI(
	input [31:0] Dir,
	output reg [31:0] Inst
);

reg [7:0]mem[0:999]; //Memoria

initial
begin  
	#50;
	$readmemb("datos_instrucciones", mem); 
end 

always @(*)
begin
	Inst[7:0] = mem[Dir];
	Inst[15:8] = mem[Dir+1];
	Inst[23:16] = mem[Dir+2];
	Inst[31:24] = mem[Dir+3];
end
endmodule