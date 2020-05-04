module IFIDreg (clk, rst, stall, PC_inc, PC,Rs, Rt, IFID_PC_inc, IFID_PC, instr, IFID_instr, IFID_Rs, IFID_Rt, halt, IFID_halt, instrmem_stall);
	input clk, rst, stall, halt, instrmem_stall;
	input	[15:0]	PC_inc, PC, instr;
	input 	[2:0] 	Rs, Rt;
	output	[15:0]	IFID_PC_inc, IFID_PC, IFID_instr;
	output 	[2:0]	IFID_Rs, IFID_Rt;
	output  		IFID_halt;
	wire 	[15:0] 	IFID_PC_inc_reg_out, IFID_PC_reg_out, IFID_instr_reg_out;
	reg16 IFID_PC_inc_reg(.clk(clk), .rst(rst), .en(~stall), .D(PC_inc), .Q(IFID_PC_inc));
	reg16 IFID_PC_reg(.clk(clk), .rst(rst), .en(~stall), .D(PC), .Q(IFID_PC));
	reg16 IFID_instr_reg(.clk(clk), .rst(rst), .en(~stall), .D(instr), .Q(IFID_instr));
	reg3 IFID_Rs_reg(.clk(clk), .rst(rst), .en (~stall), .D  (Rs), .Q  (IFID_Rs));
	reg3 IFID_Rt_reg(.clk(clk), .rst(rst), .en (~stall), .D  (Rt), .Q  (IFID_Rt));
	reg1 IFID_halt_reg(.clk(clk), .rst(rst), .en(~stall), .D(halt), .Q(IFID_halt));
	//assign IFID_PC = stall?16'h0000:IFID_PC_reg_out;
	//assign IFID_PC = IFID_PC_reg_out;
	//assign IFID_PC_inc = stall?IFID_PC_reg_out:IFID_PC_inc_reg_out;
	//assign IFID_instr = stall? 16'h0800:IFID_instr_reg_out;
endmodule
