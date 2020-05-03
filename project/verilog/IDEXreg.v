module IDEXreg (clk, rst, Rs, IDEX_Rs, Rt, IDEX_Rt, Rd, IDEX_Rd, aluOp, IDEX_aluOp, jumpCtl, IDEX_jumpCtl,
		read1Data, IDEX_read1Data, read2Data, IDEX_read2Data, exImmVal, IDEX_exImmVal, PC_new, IDEX_PC_new, PC, IDEX_PC, PC_inc, IDEX_PC_inc,
		regWrite, IDEX_regWrite, aluSrc, IDEX_aluSrc, btr, IDEX_btr, memWrite, IDEX_memWrite, memRead, IDEX_memRead, MemToReg, IDEX_MemToReg, lbi, IDEX_lbi, slbi, IDEX_slbi, 
		seq, IDEX_seq, sl, IDEX_sl, sco, IDEX_sco, ror, IDEX_ror, halt, IDEX_halt,
		stall, no_Op, IDEX_noOp);

		input clk, rst, no_Op;

		input	[2:0]	Rs, Rt, Rd, aluOp, jumpCtl;
		output	[2:0]	IDEX_Rs, IDEX_Rt, IDEX_Rd, IDEX_aluOp, IDEX_jumpCtl;

		input	[15:0]	read1Data, read2Data, exImmVal, PC_new, PC, PC_inc;
		output	[15:0]	IDEX_read1Data, IDEX_read2Data, IDEX_exImmVal, IDEX_PC_new, IDEX_PC, IDEX_PC_inc;

		input			regWrite, aluSrc, btr, memWrite, memRead, MemToReg, slbi, lbi, seq, sl, sco, ror, halt;
		input			IDEX_regWrite, IDEX_aluSrc, IDEX_btr, IDEX_memWrite, IDEX_memRead, IDEX_MemToReg, IDEX_slbi, IDEX_lbi, IDEX_seq, IDEX_sl, IDEX_sco, IDEX_ror, IDEX_halt;

		input			stall;
                
		output IDEX_noOp;
		wire IDEX_regWrite_out, IDEX_memRead_out, IDEX_memWrite_out;
		
		reg3	IDEX_Rs_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rs), .Q(IDEX_Rs));
		reg3	IDEX_Rt_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rt), .Q(IDEX_Rt));
		reg3	IDEX_Rd_reg(.clk(clk), .rst(rst), .en(~stall), .D(Rd), .Q(IDEX_Rd));
		reg3	IDEX_ALUop_reg(.clk(clk), .rst(rst), .en(~stall), .D(aluOp), .Q(IDEX_aluOp));
		reg3	IDEX_jumpCtl_reg(.clk(clk), .rst(rst), .en (~stall), .D  (jumpCtl), .Q  (IDEX_jumpCtl));
		reg16	IDEX_read1Data_reg(.clk(clk), .rst(rst), .en (~stall), .D  (read1Data), .Q  (IDEX_read1Data));
		reg16	IDEX_read2Data_reg(.clk(clk), .rst(rst), .en (~stall), .D  (read2Data), .Q  (IDEX_read2Data));
		reg16	IDEX_exImmVal_reg(.clk(clk), .rst(rst), .en (~stall), .D  (exImmVal), .Q  (IDEX_exImmVal));
		reg16	IDEX_PC_new_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC_new), .Q  (IDEX_PC_new));
		reg16	IDEX_PC_inc_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC_inc), .Q  (IDEX_PC_inc));
		reg16	IDEX_PC_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PC), .Q  (IDEX_PC));
		reg1 	IDEX_regWrite_reg(.clk(clk), .rst(rst), .en (~stall), .D  (regWrite), .Q  (IDEX_regWrite)); // 1'b1
		reg1 	IDEX_aluSrc_reg(.clk(clk), .rst(rst), .en (~stall), .D  (aluSrc), .Q  (IDEX_aluSrc));
		reg1 	IDEX_btr_reg(.clk(clk), .rst(rst), .en (~stall), .D  (btr), .Q  (IDEX_btr));
		reg1 	IDEX_memWrite_reg(.clk(clk), .rst(rst), .en (~stall), .D  (memWrite), .Q  (IDEX_memWrite)); // 1'b1
		reg1 	IDEX_memRead_reg(.clk(clk), .rst(rst), .en (~stall), .D  (memRead), .Q  (IDEX_memRead)); // 1'b1
		reg1 	IDEX_MemToReg_reg(.clk(clk), .rst(rst), .en (~stall), .D  (MemToReg), .Q  (IDEX_MemToReg));
		reg1 	IDEX_slbi_reg(.clk(clk), .rst(rst), .en (~stall), .D  (slbi), .Q  (IDEX_slbi));
		reg1 	IDEX_lbi_reg(.clk(clk), .rst(rst), .en (~stall), .D  (lbi), .Q  (IDEX_lbi));
		reg1 	IDEX_seq_reg(.clk(clk), .rst(rst), .en (~stall), .D  (seq), .Q  (IDEX_seq));
		reg1 	IDEX_sl_reg(.clk(clk), .rst(rst), .en (~stall), .D  (sl), .Q  (IDEX_sl));
		reg1 	IDEX_sco_reg(.clk(clk), .rst(rst), .en (~stall), .D  (sco), .Q  (IDEX_sco));
		reg1 	IDEX_ror_reg(.clk(clk), .rst(rst), .en (~stall), .D  (ror), .Q  (IDEX_ror));
		reg1 	IDEX_halt_reg(.clk(clk), .rst(rst), .en (~stall), .D  (halt), .Q  (IDEX_halt));
		reg1    IDEX_noOp_reg(.clk(clk), .rst(rst), .en (~stall), .D  (no_Op), .Q  (IDEX_noOp));

		//reg1 	IDEX_PCsrc_reg(.clk(clk), .rst(rst), .en (~stall), .D  (PCsrc), .Q  (IDEX_PCsrc));
		assign IDEX_regWrite = stall?1'b0:IDEX_regWrite_out;
		assign IDEX_memRead = stall?1'b0:IDEX_memRead_out;
		assign IDEX_memWrite = stall?1'b0:IDEX_memWrite_out;

endmodule
