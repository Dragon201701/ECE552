module IFIDreg (clk, rst, flush, stall, PC_inc, PC, IFID_PC_inc, IFID_PC, instr, IFID_instr);
	input clk, rst, flush, stall;
	input	[15:0]	PC_inc, PC, instr;
	output	[15:0]	IFID_PC_inc, IFID_PC, IFID_instr;
	reg16 IFID_PC_inc_reg(.clk(clk), .rst(rst|flush), .en(~stall), .D(PC_inc), .Q(IFID_PC_inc));
	reg16 IFID_PC_reg(.clk(clk), .rst(rst|flush), .en(~stall), .D(PC), .Q(IFID_PC));
	reg16 IFID_instr_reg(.clk(clk), .rst(rst|flush), .en(~stall), .D(instr), .Q(IFID_instr));

endmodule