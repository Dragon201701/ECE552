module IDEXreg (clk, rst, Rs, IDEX_Rs, Rt, IDEX_Rt, Rd, IDEX_Rd, aluOp, IDEX_aluOp, branchCtl, IDEX_branchCtl, jumpCtl, IDEX_jumpCtl,
		read1Data, IDEX_read1Data, read2Data, IDEX_read2Data, exImmVal, IDEX_exImmVal, PC_inc, IDEX_PC_inc, PC, IDEX_PC,
		regWrite, IDEX_regWrite, aluSrc, IDEX_aluSrc, btr, IDEX_btr, memWrite, IDEX_memWrite, memRead, IDEX_memRead, MemToReg, IDEX_MemToReg, lbi, IDEX_lbi, slbi, IDEX_slbi, 
		seq, IDEX_seq, sl, IDEX_sl, sco, IDEX_sco, ror, IDEX_ror,
		flush, stall);

		input clk, rst;

		input	[2:0]	Rs, Rt, Rd, aluOp, branchCtl, jumpCtl;
		output	[2:0]	IDEX_Rs, IDEX_Rt, IDEX_Rd, IDEX_aluOp, IDEX_branchCtl, IDEX_jumpCtl;

		input	[15:0]	read1Data, read2Data, exImmVal, PC_inc, PC;
		output	[15:0]	IDEX_read1Data, IDEX_read2Data, IDEX_exImmVal, IDEX_PC_inc, IDEX_PC;

		input			regWrite, aluSrc, btr, memWrite, memRead, MemToReg, slbi, lbi, seq, sl, sco, ror;
		input			IDEX_regWrite, IDEX_aluSrc, IDEX_btr, IDEX_memWrite, IDEX_memRead, IDEX_MemToReg, IDEX_slbi, IDEX_lbi, IDEX_seq, IDEX_sl, IDEX_sco, IDEX_ror;

		input			flush, stall;


		reg3	IDEX_Rs_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rs), .Q(IDEX_Rs));
		reg3	IDEX_Rt_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rt), .Q(IDEX_Rt));
		reg3	IDEX_Rd_reg(.clk(clk), .rst(rst), .en(1'b1), .D(Rd), .Q(IDEX_Rd));
		reg3	IDEX_ALUop_reg(.clk(clk), .rst(rst), .en(1'b1), .D(aluOp), .Q(IDEX_aluOp));
		reg3	IDEX_branchCtl_reg(.clk(clk), .rst(rst), .en(1'b1), .D(branchCtl), .Q(IDEX_branchCtl));
		reg3	IDEX_jumpCtl_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (jumpCtl), .Q  (IDEX_jumpCtl));
		reg16	IDEX_read1Data_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (read1Data), .Q  (IDEX_read1Data));
		reg16	IDEX_read2Data_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (read2Data), .Q  (IDEX_read2Data));
		reg16	IDEX_exImmVal_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (exImmVal), .Q  (IDEX_exImmVal));
		reg16	IDEX_PC_inc_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PC_inc), .Q  (IDEX_PC_inc));
		reg16	IDEX_PC_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (PC), .Q  (IDEX_PC));
		reg1 	IDEX_regWrite_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (regWrite), .Q  (IDEX_regWrite));
		reg1 	IDEX_aluSrc_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (aluSrc), .Q  (IDEX_aluSrc));
		reg1 	IDEX_btr_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (btr), .Q  (IDEX_btr));
		reg1 	IDEX_memWrite_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (memWrite), .Q  (IDEX_memWrite));
		reg1 	IDEX_memRead_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (memRead), .Q  (IDEX_memRead));
		reg1 	IDEX_MemToReg_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (MemToReg), .Q  (IDEX_MemToReg));
		reg1 	IDEX_slbi_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (slbi), .Q  (IDEX_slbi));
		reg1 	IDEX_lbi_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (lbi), .Q  (IDEX_lbi));
		reg1 	IDEX_seq_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (seq), .Q  (IDEX_seq));
		reg1 	IDEX_sl_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (sl), .Q  (IDEX_sl));
		reg1 	IDEX_sco_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (sco), .Q  (IDEX_sco));
		reg1 	IDEX_ror_reg(.clk(clk), .rst(rst), .en (1'b1), .D  (ror), .Q  (IDEX_ror));


endmodule