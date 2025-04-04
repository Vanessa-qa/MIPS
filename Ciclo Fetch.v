module CicloFetch(
	input clk,
	output wire [31:0] INST
);

wire [31:0] WIn, WOut;

PC PcInst(.data_in(WIn), .data_out(WOut), .CLK(clk));
Sumador suma(.data_in(WOut), .data_out(WIn));
MemI memoria(.Dir(WOut), .Inst(INST));

endmodule

module CF_TB();

reg clk;
wire [31:0] Inst;

CicloFetch testbench(.clk(clk), .INST(Inst));

initial begin
    clk = 0;
    forever #100 clk = ~clk;
end

initial
begin
    #1000

    $stop;
end
endmodule
	