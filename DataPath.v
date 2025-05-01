//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Datapath 
(
    input wire [31:0] Inst
);

wire [5:0] OP, Funct;
wire [4:0] RS, RT, RD;

wire MtR, MtW, RtW;            //Salidas Unidad Ctrl
wire [1:0] ALUOP;

wire [31:0] DataBR, DATAREG1, DATAREG2;  //Banco de registro conexiones

wire [3:0] aluCtrlOP;   //Alu control

wire [31:0] ALUresult;  //ALU

wire [31:0] READMEM;

assign OP = Inst [31:26];
assign RS = Inst[25:21];
assign RT = Inst[20:16];
assign RD = Inst[15:11];
assign Funct = Inst[5:0];

UniCtrl Uni1(.Op(OP), .MemToReg(MtR), .MemToWrite(MtW), .AluOp(ALUOP), .RegToWrite(RtW));

BancoReg Banco1(.Reg1(RS), .Reg2(RT), .WriteAddr(RD), .Data(DataBR), .RegEn(RtW), .DataReg1(DATAREG1), .DataReg2(DATAREG2));

ALUCtrl AluCtrl(.Op(ALUOP), .Function(Funct), .OPAlu(aluCtrlOP));

Alu Alu1(.A(DATAREG1), .B(DATAREG2), .OP(aluCtrlOP), .Res(ALUresult));

MemDatos Mem1(.Addr(ALUresult), .Data(DATAREG2), .MemWrite(MtW), .MemRead(READMEM));

Mux2_32 Mux1(.MemToReg(MtR), .ReadMem(READMEM), .Result(ALUresult), .DataOut(DataBR));

endmodule