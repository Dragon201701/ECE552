module EXMEMreg (clk, rst, Rs, Rt, Rd, jumpCtl, memAddr, writeData, memRead, memWrite, PCsrc, PC_inc, PC_new, regWrite, MemToReg, PC,
	EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, EXMEM_jumpCtl, EXMEM_memAddr, EXMEM_writeData, EXMEM_memRead, EXMEM_memWrite, EXMEM_PCsrc, EXMEM_PC_inc, EXMEM_PC_new, EXMEM_PC, EXMEM_regWrite, EXMEM_MemToReg);
	input clk, rst;
	input	[2:0]	Rs, Rt, Rd, jumpCtl;
	input 	[15:0]	memAddr, writeData, PC_inc, PC_new, PC;
	input			memRead, memWrite, PCsrc, regWrite, MemToReg;
	output 	[2:0]	EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, EXMEM_jumpCtl;
	output	[15:0]	EXMEM_memAddr, EXMEM_writeData, EXMEM_PC_inc, EXMEM_PC_new, EXMEM_PC;
	output			EXMEM_memRead, EXMEM_memWrite, EXMEM_PCsrc, EXMEM_regWrite, EXMEM_MemToReg;

	reg3 EXMEM_Rs_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rs), .Q(EXMEM_Rs));
	reg3 EXMEM_Rt_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rt), .Q(EXMEM_Rt));
	reg3 EXMEM_Rd_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rd), .Q(EXMEM_Rd));
	reg3 EXMEM_jumpCtl_reg(.clk(clk), .rst(rst), .en(1'b1), .D(jumpCtl), .Q(EXMEM_jumpCtl));
	reg16 EXMEM_memAddr_reg(.clk(clk), .rst(rst), .en(1'b1), .D(memAddr), .Q(EXMEM_memAddr));
	reg16 EXMEM_writeData_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (writeData), .Q  (EXMEM_writeData));
	reg16 EXMEM_PC_inc_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PC_inc), .Q  (EXMEM_PC_inc));
	reg16 EXMEM_PC_new_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PC_new), .Q  (EXMEM_PC_new));
	reg16 EXMEM_PC_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PC), .Q  (EXMEM_PC));
	reg1 	EXMEM_memRead_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (memRead), .Q  (EXMEM_memRead)); 
	reg1 	EXMEM_memWrite_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (memWrite), .Q  (EXMEM_memWrite));
	reg1 	EXMEM_PCsrc_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PCsrc), .Q  (EXMEM_PCsrc));
	reg1 	EXMEM_regWrite_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (regWrite), .Q  (EXMEM_regWrite));
	reg1 	EXMEM_MemToReg_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (MemToReg), .Q  (EXMEM_MemToReg));
endmodule