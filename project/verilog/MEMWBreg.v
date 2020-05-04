module MEMWBreg (clk, rst, memoryOut, PC_inc, PC, jumpCtl, MemToReg, ALUOut, regWrite, Rs, Rt, Rd, lbi, slbi, halt, no_Op, MEMWB_noOp, stall, memRead, MEMWB_memRead, instr, MEMWB_instr,
		MEMWB_memoryOut, MEMWB_PC_inc, MEMWB_PC, MEMWB_jumpCtl, MEMWB_ALUout, MEMWB_MemToReg, MEMWB_regWrite, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd, MEMWB_lbi, MEMWB_slbi, MEMWB_halt);
	input clk, rst, no_Op, stall;
	input 	[15:0]	memoryOut, PC_inc, ALUOut, PC, instr;
	input	[2:0]	jumpCtl, Rs, Rt, Rd;
	input   memRead;
	output MEMWB_memRead;
	input 			MemToReg, regWrite, lbi, slbi, halt;
	output 	[15:0] 	MEMWB_memoryOut, MEMWB_PC_inc, MEMWB_PC, MEMWB_ALUout, MEMWB_instr;
	output 	[2:0]	MEMWB_jumpCtl, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd;
	output			MEMWB_MemToReg, MEMWB_regWrite, MEMWB_lbi, MEMWB_slbi, MEMWB_halt, MEMWB_noOp;

	reg16   MEMWB_instr_reg(.clk(clk), .rst(rst), .en (~stall), .D  (instr), .Q  (MEMWB_instr));
	reg16 	MEMWB_memoryOut_reg(.clk(clk), .rst(rst), .en (~stall), .D  (memoryOut), .Q  (MEMWB_memoryOut));
	reg16	MEMWB_PC_inc_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC_inc), .Q  (MEMWB_PC_inc));
	reg16	MEMWB_PC_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC), .Q  (MEMWB_PC));
	reg16 	MEMWB_ALUout_reg(.clk(clk), .rst(rst), .en (~stall), .D  (ALUOut), .Q  (MEMWB_ALUout));
	reg3	MEMWB_jumpCtl_reg(.clk(clk), .rst(rst), .en (~stall), .D  (jumpCtl), .Q  (MEMWB_jumpCtl));
	reg3	MEMWB_Rs_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rs), .Q(MEMWB_Rs));
	reg3	MEMWB_Rt_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rt), .Q(MEMWB_Rt));
	reg3	MEMWB_Rd_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rd), .Q(MEMWB_Rd));
	reg1 	MEMWB_MemToReg_reg(.clk(clk), .rst(rst), .en (~stall), .D  (MemToReg), .Q  (MEMWB_MemToReg));
	reg1 	MEMWB_regWrite_reg(.clk(clk), .rst(rst), .en (~stall), .D  (regWrite), .Q  (MEMWB_regWrite));
        reg1    MEMWB_memRead_reg(.clk(clk), .rst(rst), .en (~stall), .D  (memRead), .Q  (MEMWB_memRead));

	reg1 	MEMWB_lbi_reg(.clk(clk), .rst(rst), .en (~stall), .D  (lbi), .Q  (MEMWB_lbi));
	reg1 	MEMWB_slbi_reg(.clk(clk), .rst(rst), .en (~stall), .D  (slbi), .Q  (MEMWB_slbi));
	reg1 	MEMWB_halt_reg(.clk(clk), .rst(rst), .en (~stall), .D  (  halt), .Q  (MEMWB_halt));
        reg1    MEMWB_noOp_reg(.clk(clk), .rst(rst), .en (~stall), .D  (no_Op), .Q  (MEMWB_noOp));

endmodule
        
