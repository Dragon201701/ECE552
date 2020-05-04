module EXMEMreg (clk, rst, Rs, Rt, Rd, jumpCtl, memAddr, writeData, memRead, memWrite, PC_inc, PC_new, regWrite, MemToReg, PC, lbi, slbi, halt, stall,
	no_Op, EXMEM_noOp, EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, EXMEM_jumpCtl, instr, EXMEM_instr, EXMEM_memAddr, EXMEM_writeData, EXMEM_memRead, EXMEM_memWrite, EXMEM_PC_inc, EXMEM_PC_new, EXMEM_PC, EXMEM_regWrite, EXMEM_MemToReg, EXMEM_lbi, EXMEM_slbi, EXMEM_halt);
	input clk, rst, no_Op;
	input	[2:0]	Rs, Rt, Rd, jumpCtl;
	input 	[15:0]	memAddr, writeData, PC_inc, PC_new, PC, instr;
	input			memRead, memWrite, regWrite, MemToReg, lbi, slbi, halt;
	input 			stall;
	output 	[2:0]	EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, EXMEM_jumpCtl;
	output	[15:0]	EXMEM_memAddr, EXMEM_writeData, EXMEM_PC_inc, EXMEM_PC_new, EXMEM_PC, EXMEM_instr;
	output			EXMEM_memRead, EXMEM_memWrite, EXMEM_regWrite, EXMEM_MemToReg, EXMEM_lbi, EXMEM_slbi, EXMEM_halt;
        output EXMEM_noOp;
    /*wire EXMEM_memRead_out, EXMEM_memWrite_out;
    assign EXMEM_memRead = EXMEM_memRead_out & ~stall;
    assign EXMEM_memWrite = EXMEM_memWrite_out & ~stall;*/
	reg16   EXMEM_instr_reg(.clk(clk), .rst(rst), .en (~stall), .D  (instr), .Q  (EXMEM_instr));
	reg3 EXMEM_Rs_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rs), .Q(EXMEM_Rs));
	reg3 EXMEM_Rt_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rt), .Q(EXMEM_Rt));
	reg3 EXMEM_Rd_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rd), .Q(EXMEM_Rd));
	reg3 EXMEM_jumpCtl_reg(.clk(clk), .rst(rst), .en(~stall), .D(jumpCtl), .Q(EXMEM_jumpCtl));
	reg16 EXMEM_memAddr_reg(.clk(clk), .rst(rst), .en(~stall), .D(memAddr), .Q(EXMEM_memAddr));
	reg16 EXMEM_writeData_reg(.clk(clk), .rst(rst), .en (~stall), .D  (writeData), .Q  (EXMEM_writeData));
	reg16 EXMEM_PC_inc_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC_inc), .Q  (EXMEM_PC_inc));
	reg16 EXMEM_PC_new_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC_new), .Q  (EXMEM_PC_new));
	reg16 EXMEM_PC_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC), .Q  (EXMEM_PC));
	reg1 	EXMEM_memRead_reg(.clk(clk), .rst(rst), .en (~stall), .D  (memRead), .Q  (EXMEM_memRead));  // ~stall& for these four
	reg1 	EXMEM_memWrite_reg(.clk(clk), .rst(rst), .en (~stall), .D  (memWrite), .Q  (EXMEM_memWrite)); // 
	reg1 	EXMEM_regWrite_reg(.clk(clk), .rst(rst), .en (~stall), .D  (regWrite), .Q  (EXMEM_regWrite)); // 
	reg1 	EXMEM_MemToReg_reg(.clk(clk), .rst(rst), .en (~stall), .D  (MemToReg), .Q  (EXMEM_MemToReg)); // 
	reg1 	EXMEM_lbi_reg(.clk(clk), .rst(rst), .en (~stall), .D  (lbi), .Q  (EXMEM_lbi));
	reg1 	EXMEM_slbi_reg(.clk(clk), .rst(rst), .en (~stall), .D  (slbi), .Q  (EXMEM_slbi));
	reg1 	EXMEM_halt_reg(.clk(clk), .rst(rst), .en (~stall), .D  (halt), .Q  (EXMEM_halt));
    reg1    EXMEM_noOp_reg(.clk(clk), .rst(rst), .en (~stall), .D  (no_Op), .Q  (EXMEM_noOp));


	endmodule
