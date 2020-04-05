module MEMWBreg (clk, rst, memoryOut, PC_inc, PC, jumpCtl, MemToReg, ALUOut, regWrite, Rs, Rt, Rd,
		MEMWB_memoryOut, MEMWB_PC_inc, MEMWB_PC, MEMWB_jumpCtl, MEMWB_ALUout, MEMWB_MemToReg, MEMWB_regWrite, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd);
	input clk, rst;
	input 	[15:0]	memoryOut, PC_inc, ALUOut, PC;
	input	[2:0]	jumpCtl, Rs, Rt, Rd;
	input 			MemToReg, regWrite;
	output 	[15:0] 	MEMWB_memoryOut, MEMWB_PC_inc, MEMWB_PC, MEMWB_ALUout;
	output 	[2:0]	MEMWB_jumpCtl, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd;
	output			MEMWB_MemToReg, MEMWB_regWrite;
	reg16 	MEMWB_memoryOut_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (memoryOut), .Q  (MEMWB_memoryOut));
	reg16	MEMWB_PC_inc_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PC_inc), .Q  (MEMWB_PC_inc));
	reg16	MEMWB_PC_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PC), .Q  (MEMWB_PC));
	reg16 	MEMWB_ALUout_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (ALUOut), .Q  (MEMWB_ALUout));
	reg3	MEMWB_jumpCtl_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (jumpCtl), .Q  (MEMWB_jumpCtl));
	reg3	MEMWB_Rs_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rs), .Q(MEMWB_Rs));
	reg3	MEMWB_Rt_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rt), .Q(MEMWB_Rt));
	reg3	MEMWB_Rd_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rd), .Q(MEMWB_Rd));
	reg1 	MEMWB_MemToReg_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (MemToReg), .Q  (MEMWB_MemToReg));
	reg1 	MEMWB_regWrite_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (regWrite), .Q  (MEMWB_regWrite));
endmodule