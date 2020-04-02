/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   wire regWrite, btr, aluSrc, memWrite, memRead, memToReg, branchCtl, jumpCtl, invA, invB, halt, noOp, immCtl, stu, slbi, immPres, lbi;
   wire decode_err, sl, sco, seq, ldOrSt;
   wire [1:0] aluCtl;

   wire [2:0] regRs, readReg1, readReg2, writeReg1, writeRegSel;
   wire [15:0] immVal;
   wire [15:0] currInstr, next_pc, signedImmVal, branch, jump, new_pc, Out, wrData;
   wire [15:0] regData1, regData2, read1Data, read2Data, aluOut, writeData, memoryOut;

   // Register wires
   // IF/ID
   wire regWrite_fd, aluSrc_fd, memWrite_fd, memRead_fd, memToReg_fd, branchCtl_fd, ldOrSt_fd, jumpCtl_fd, invA_fd, invB_fd, halt_fd, noOp_fd, immCtl_fd, stu_fd, slbi_fd, immPres_fd, lbi_fd, btr_fd, sl_fd,
	   sco_fd, seq_fd;
   wire [1:0] aluCtl_fd;
   wire [15:0] immVal_fd, branch_fd, jump_fd, new_pc_fd, currInstr_fd;
   wire [2:0] readReg1_fd, readReg2_fd, writeReg1_fd;
   
   // ID/EX
   wire regWrite_dx, aluSrc_dx, memWrite_dx, memRead_dx, memToReg_dx, branchCtl_dx, ldOrSt_dx, jumpCtl_dx, invA_dx, invB_dx, halt_dx, noOp_dx, immCtl_dx, stu_dx, slbi_dx, immPres_dx, lbi_dx, btr_dx, sl_dx,
           sco_dx, seq_dx;
   wire [1:0] aluCtl_dx;
   wire [15:0] read1Data_dx, read2Data_dx, signedImmVal_dx, branch_dx, jump_dx, new_pc_dx, currInstr_dx;
   wire [2:0] regRs_dx, writeReg1_dx, readReg1_dx;

   // EX/MEM
   wire regWrite_xm, aluSrc_xm, memWrite_xm, memRead_xm, memToReg_xm, branchCtl_xm, ldOrSt_xm, jumpCtl_xm, invA_xm, invB_xm, halt_xm, noOp_xm, immCtl_xm, stu_xm, slbi_xm, immPres_xm, lbi_xm, btr_xm, sl_xm,
           sco_xm, seq_xm;
   wire [1:0] aluCtl_xm;
   wire [15:0] Out_xm, wrData_xm, new_pc_xm, signedImmVal_xm, currInstr_xm;
   wire [2:0] writeReg1_xm, readReg1_xm;

   // MEM/WB
   wire regWrite_mw, aluSrc_mw, memWrite_mw, memRead_mw, memToReg_mw, branchCtl_mw, ldOrSt_mw, jumpCtl_mw, invA_mw, invB_mw, halt_mw, noOp_mw, immCtl_mw, stu_mw, slbi_mw, immPres_mw, lbi_mw, btr_mw, sl_mw,
           sco_mw, seq_mw;
   wire [1:0] aluCtl_mw;
   wire [15:0] memoryOut_mw, Out_mw, new_pc_mw, signedImmVal_mw, currInstr_mw;
   wire [2:0] writeReg1_mw, readReg1_mw;

   wire pc_modified;
   wire [15:0] nextpc, pc, inc_pc, incpc;


   // pc_modified used if jump / branch instruction selected
   assign nextpc = rst ? 16'h0000 : pc_modified ? next_pc : inc_pc;
   reg16 pcreg(.clk(clk), .rst(rst), .en(1'b1), .D(nextpc), .Q(pc));
   cla_16b inc_PC(.A(pc), .B(2), .C_in(0), .S(inc_pc), .C_out());

   //reg16 inc_save(.clk(clk), .rst(rst), .en(1'b1), .D(incpc), .Q(inc_pc));
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */

   // Setup Control signals with control module
   control ctlSignals(.instr(currInstr), .clk(clk), .rst(rst), .regWrite(regWrite), .aluSrc(aluSrc), .aluCtl(aluCtl), .memWrite(memWrite), .memRead(memRead), .memToReg(memToReg), .branchCtl(branchCtl), 
	   .ldOrSt(ldOrSt), .jumpCtl(jumpCtl), .invA(invA), .invB(invB), .halt(halt), .noOp(noOp), .immCtl(immCtl), .stu(stu), .slbi(slbi), .immPres(immPres), .lbi(lbi), .btr(btr), .sl(sl), .sco(sco), .seq(seq));

   // Fetch
   fetch fetchStage(.jumpCtl(jumpCtl), .pc(pc), .wr(1'b0), .enable(1'b1), .clk(clk), .rst(rst), .lbi(lbi), .halt(halt), .noOp(noOp), .immPres(immPres), .immCtl(immCtl), .readReg1(readReg1), .readReg2(readReg2), .writeReg1(writeReg1), .immVal(immVal), .branch(branch), .jump(jump), .new_pc(new_pc), .instr(currInstr));

   // IF/ID - Pipeline register for control signals
   pipeline_reg_ctl if_id(.in1(regWrite),.in2(aluSrc),.in3(memWrite),.in4(memRead),.in5(memToReg),.in6(branchCtl),.in7(ldOrSt),.in8(jumpCtl),.in9(invA),.in10(invB),.in11(halt),.in12(noOp),.in13(immCtl),.in14(stu),.in15(slbi),.in16(immPres),.in17(lbi),.in18(btr),.in19(sl),.in20(sco),.in21(seq), .in22(aluCtl),
                    .out1(regWrite_fd),.out2(aluSrc_fd),.out3(memWrite_fd),.out4(memRead_fd),.out5(memToReg_fd),.out6(branchCtl_fd),.out7(ldOrSt_fd),.out8(jumpCtl_fd),.out9(invA_fd),.out10(invB_fd),.out11(halt_fd),.out12(noOp_fd),.out13(immCtl_fd),.out14(stu_fd),.out15(slbi_fd),.out16(immPres_fd),.out17(lbi_fd),.out18(btr_fd),.out19(sl_fd),.out20(sco_fd),.out21(seq_fd),.out22(aluCtl_fd),
                    .clk(clk), .rst(rst), .en(en));

   // Pipeline Data - Outputs from fetch pipelined
   reg16 immVal_if_id(.D(immVal), .clk(clk), .rst(rst), .en(1'b1), .Q(immVal_fd)); // X
   reg16 branch_if_id(.D(branch), .clk(clk), .rst(rst), .en(1'b1), .Q(branch_fd)); // X
   reg16 jump_if_id(.D(jump), .clk(clk), .rst(rst), .en(1'b1), .Q(jump_fd));       // X
   reg16 new_pc_if_id(.D(new_pc), .clk(clk), .rst(rst), .en(1'b1), .Q(new_pc_fd));
   reg16 currInstr_if_id(.D(currInstr), .clk(clk), .rst(rst), .en(1'b1), .Q(currInstr_fd)); // X
   reg3  readReg1_if_id(.D(readReg1), .clk(clk), .rst(rst), .en(1'b1), .Q(readReg1_fd)); // X
   reg3  readReg2_if_id(.D(readReg2), .clk(clk), .rst(rst), .en(1'b1), .Q(readReg2_fd)); // X
   reg3  writeReg1_if_id(.D(writeReg1), .clk(clk), .rst(rst), .en(1'b1), .Q(writeReg1_fd)); // X

   // Deode
   // NOTE stu comes from wb stage
   // TODO: Check Out
   decode decodeStage(.slbi(slbi_fd), .writeEn(regWrite_mw), .writeData(writeData), .writeRegSel(writeRegSel), .read2RegSel(readReg2_fd), .read1RegSel(readReg1_fd), .stu(stu_fd), .aluOut(Out), .immCtl(immCtl_fd), .immVal(immVal_fd), .rst(rst), .clk(clk), .jump(jumpCtl), .regRs(regRs), .read1Data(read1Data), .read2Data(read2Data), .signedImmVal(signedImmVal), .err(decode_err));

   // ID/EX - Pipeline register for control signals
   pipeline_reg_ctl id_ex(.in1(regWrite_fd),.in2(aluSrc_fd),.in3(memWrite_fd),.in4(memRead_fd),.in5(memToReg_fd),.in6(branchCtl_fd),.in7(ldOrSt_fd),.in8(jumpCtl_fd),.in9(invA_fd),.in10(invB_fd),.in11(halt_fd),.in12(noOp_fd),.in13(immCtl_fd),.in14(stu_fd),.in15(slbi_fd),.in16(immPres_fd),.in17(lbi_fd),.in18(btr_fd),.in19(sl_fd),.in20(sco_fd),.in21(seq_fd), .in22(aluCtl_fd),
                    .out1(regWrite_dx),.out2(aluSrc_dx),.out3(memWrite_dx),.out4(memRead_dx),.out5(memToReg_dx),.out6(branchCtl_dx),.out7(ldOrSt_dx),.out8(jumpCtl_dx),.out9(invA_dx),.out10(invB_dx),.out11(halt_dx),.out12(noOp_dx),.out13(immCtl_dx),.out14(stu_dx),.out15(slbi_dx),.out16(immPres_dx),.out17(lbi_dx),.out18(btr_dx),.out19(sl_dx),.out20(sco_dx),.out21(seq_dx),.out22(aluCtl_dx),
                    .clk(clk), .rst(rst), .en(en));

   // Pipeline Data
   reg16 branch_id_ex(.D(branch_fd), .clk(clk), .rst(rst), .en(1'b1), .Q(branch_dx)); // X
   reg16 jump_id_ex(.D(jump_fd), .clk(clk), .rst(rst), .en(1'b1), .Q(jump_dx)); // X
   reg16 new_pc_id_ex(.D(new_pc_fd), .clk(clk), .rst(rst), .en(1'b1), .Q(new_pc_dx)); // X
   reg16 currInstr_id_ex(.D(currInstr_fd), .clk(clk), .rst(rst), .en(1'b1), .Q(currInstr_dx)); // X
   reg3  writeReg1_id_ex(.D(writeReg1_fd), .clk(clk), .rst(rst), .en(1'b1), .Q(writeReg1_dx)); // X
   reg3  readReg1_id_ex(.D(readReg1_fd), .clk(clk), .rst(rst), .en(1'b1), .Q(readReg1_dx));

   reg16 read1Data_id_ex(.D(read1Data), .clk(clk), .rst(rst), .en(1'b1), .Q(read1Data_dx)); // X
   reg16 read2Data_id_ex(.D(read2Data), .clk(clk), .rst(rst), .en(1'b1), .Q(read2Data_dx)); // X
   reg16 signedImmVal_id_ex(.D(signedImmVal), .clk(clk), .rst(rst), .en(1'b1), .Q(signedImmVal_dx)); // X
   // Check regRs
   // reg3  regRs_id_ex(.D(regRs), .clk(clk), .rst(rst), .en(en), .Q(regRs_dx));


   // Execute
   execute executeStage(.ldOrSt(ldOrSt_dx), .sl(sl_dx), .sco(sco_dx), .seq(seq_dx), .immPres(immPres_dx), .btr(btr_dx), .slbi(slbi_dx), .aluSrc(aluSrc_dx), .regData1(read1Data_dx), .regData2(read2Data_dx), .immVal(signedImmVal_dx), .immCtl(immCtl_dx), .jump(jumpCtl_dx), .branch(branchCtl_dx), .jumpVal(jump_dx), .branchVal(branch_dx), .pc(new_pc_dx), .instr(currInstr_dx), .invA(invA_dx), .invB(invB_dx), .next_pc(next_pc), .Out(Out), .wrData(wrData), .Zero(Zero), .Ofl(Ofl), .pc_modified(pc_modified));

   // EX/MEM - Pipeline register for control signals
   pipeline_reg_ctl ex_mem(.in1(regWrite_dx),.in2(aluSrc_dx),.in3(memWrite_dx),.in4(memRead_dx),.in5(memToReg_dx),.in6(branchCtl_dx),.in7(ldOrSt_dx),.in8(jumpCtl_dx),.in9(invA_dx),.in10(invB_dx),.in11(halt_dx),.in12(noOp_dx),.in13(immCtl_dx),.in14(stu_dx),.in15(slbi_dx),.in16(immPres_dx),.in17(lbi_dx),.in18(btr_dx),.in19(sl_dx),.in20(sco_dx),.in21(seq_dx), .in22(aluCtl_dx),
                    .out1(regWrite_xm),.out2(aluSrc_xm),.out3(memWrite_xm),.out4(memRead_xm),.out5(memToReg_xm),.out6(branchCtl_xm),.out7(ldOrSt_xm),.out8(jumpCtl_xm),.out9(invA_xm),.out10(invB_xm),.out11(halt_xm),.out12(noOp_xm),.out13(immCtl_xm),.out14(stu_xm),.out15(slbi_xm),.out16(immPres_xm),.out17(lbi_xm),.out18(btr_xm),.out19(sl_xm),.out20(sco_xm),.out21(seq_xm),.out22(aluCtl_xm),
                    .clk(clk), .rst(rst), .en(en));
  
   // Pipeline Data
   reg16 new_pc_ex_mem(.D(new_pc_dx), .clk(clk), .rst(rst), .en(1'b1), .Q(new_pc_xm)); // X
   reg16 signedImmVal_ex_mem(.D(signedImmVal_dx), .clk(clk), .rst(rst), .en(1'b1), .Q(signedImmVal_xm)); // X
   reg3  writeReg1_ex_mem(.D(writeReg1_dx), .clk(clk), .rst(rst), .en(1'b1), .Q(writeReg1_xm)); // X
   reg3  readReg1_ex_mem(.D(readReg1_dx), .clk(clk), .rst(rst), .en(1'b1), .Q(readReg1_xm));
   reg16 currInstr_ex_mem(.D(currInstr_dx), .clk(clk), .rst(rst), .en(1'b1), .Q(currInstr_xm));

   reg16 Out_ex_mem(.D(Out), .clk(clk), .rst(rst), .en(1'b1), .Q(Out_xm)); // X
   reg16 wrData_ex_mem(.D(wrData), .clk(clk), .rst(rst), .en(1'b1), .Q(wrData_xm)); // X
	    
   // Memory
   memory memoryStage(.aluOut(Out_xm), .wrData(wrData_xm), .memRead(memRead_xm), .memWrite(memWrite_xm), .memToReg(memToReg_xm), .clk(clk), .rst(rst), .memoryOut(memoryOut), .halt(halt_xm));


   // MEM/WB - Pipeline register for control signals
   pipeline_reg_ctl mem_wb(.in1(regWrite_xm),.in2(aluSrc_xm),.in3(memWrite_xm),.in4(memRead_xm),.in5(memToReg_xm),.in6(branchCtl_xm),.in7(ldOrSt_xm),.in8(jumpCtl_xm),.in9(invA_xm),.in10(invB_xm),.in11(halt_xm),.in12(noOp_xm),.in13(immCtl_xm),.in14(stu_xm),.in15(slbi_xm),.in16(immPres_xm),.in17(lbi_xm),.in18(btr_xm),.in19(sl_xm),.in20(sco_xm),.in21(seq_xm), .in22(aluCtl_xm),
                    .out1(regWrite_mw),.out2(aluSrc_mw),.out3(memWrite_mw),.out4(memRead_mw),.out5(memToReg_mw),.out6(branchCtl_mw),.out7(ldOrSt_mw),.out8(jumpCtl_mw),.out9(invA_mw),.out10(invB_mw),.out11(halt_mw),.out12(noOp_mw),.out13(immCtl_mw),.out14(stu_mw),.out15(slbi_mw),.out16(immPres_mw),.out17(lbi_mw),.out18(btr_mw),.out19(sl_mw),.out20(sco_mw),.out21(seq_mw),.out22(aluCtl_mw),
                    .clk(clk), .rst(rst), .en(en));

   // Pipeline Data
   reg16 new_pc_mem_wb(.D(new_pc_xm), .clk(clk), .rst(rst), .en(1'b1), .Q(new_pc_mw)); // X
   reg16 signedImmVal_mem_wb(.D(signedImmVal_xm), .clk(clk), .rst(rst), .en(1'b1), .Q(signedImmVal_mw)); // X
   reg3  writeReg1_mem_wb(.D(writeReg1_xm), .clk(clk), .rst(rst), .en(1'b1), .Q(writeReg1_mw)); // X
   reg3  readReg1_mem_wb(.D(readReg1_xm), .clk(clk), .rst(rst), .en(2'b1), .Q(readReg1_mw));
   reg16 currInstr_mem_wb(.D(currInstr_xm), .clk(clk), .rst(rst), .en(1'b1), .Q(currInstr_mw));

   reg16 memoryOut_mem_wb(.D(memoryOut), .clk(clk), .rst(rst), .en(1'b1), .Q(memoryOut_mw)); // X
   reg16 Out_mem_wb(.D(Out_xm), .clk(clk), .rst(rst), .en(1'b1), .Q(Out_mw)); // X

   // Wb
   wb wbStage(.currInstr(currInstr_mw), .writeReg1(writeReg1_mw), .readReg1(readReg1_mw), .stu(stu_mw), .pc(new_pc_mw), .jumpCtl(jumpCtl_mw), .memToReg(memToReg_mw), .memData(memoryOut_mw), .aluOut(Out_mw), .lbi(lbi_mw), .immVal(signedImmVal_mw), .writeData(writeData), .writeRegSel(writeRegSel));

   assign err = 1'b0; //Ofl | decode_err;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
