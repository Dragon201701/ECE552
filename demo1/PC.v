module PC (next_pc, clk, rst, pc);
	input clk, rst;
	input	[15:0]	next_pc;
	output	[15:0]	pc;
	assign next_pc = rst? 16'h0000:next_pc;
	reg16 pcreg(.clk(clk),.rst(rst),.en(1'b1),.D(next_pc), .Q(pc));
endmodule