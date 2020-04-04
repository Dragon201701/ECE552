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
   
   wire regWrite, btr, aluSrc, memWrite, memRead, memToReg, halt, noOp, slbi, immPres, lbi, stuCtl, PCsrc;
   wire decode_err, sl, sco, seq, ror;
   //wire [1:0] aluCtl;
   wire [2:0] Rs, Rt, Rd, aluOp, branchCtl, jumpCtl;
   wire [15:0] immVal;
   wire [15:0] instr, fetch_instr, decode_instr, next_pc, exImmVaL, branch, jump, Out, wrData;
   wire [15:0] regData1, regData2, read1Data, read2Data, aluOut, writeData, memoryOut;
   wire [15:0] PC_inc, PC, PC_new;
   //wire [15:0] pc, nextpc;
   wire FD_flush;
   assign FD_flush = 1'b0;

   // Pipeline
   wire  [15:0] IFID_PC_inc, IFID_instr;

   wire  [2:0]    IDEX_Rs, IDEX_Rt, IDEX_Rd, IDEX_aluOp, IDEX_branchCtl, IDEX_jumpCtl;
   wire  [15:0]   IDEX_read1Data, IDEX_read2Data, IDEX_exImmVal;
   wire           IDEX_regWrite, IDEX_aluSrc, IDEX_btr, IDEX_memWrite, IDEX_memRead, IDEX_MemToReg, IDEX_slbi, IDEX_lbi, IDEX_seq, IDEX_sl, IDEX_sco, IDEX_ror;

   // Fetch
   fetch fetchStage(.clk(clk), .rst(rst), .PC_inc(PC_inc), .instr(instr), .PCsrc(PCsrc), .PC_new(PC_new));

   // Deode

   decode decodeStage(.clk(clk), .rst(rst), .instr(instr), .writeData(writeData), .err(err), .read1Data(read1Data), .read2Data(read2Data), 
      .exImmVaL(exImmVaL), .aluOp(aluOp), .regWrite(regWrite), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), .memRead(memRead), .memToReg(memToReg), .branchCtl(branchCtl), 
      .jumpCtl(jumpCtl), .halt(), .noOp(), .slbi(slbi), .lbi(lbi), .seq(seq), .sl(sl), .sco(sco), .ror(ror), .Rs(Rs), .Rt(Rt), .Rd(Rd));


   // Execute
   execute executeStage(.aluOp(aluOp), .sl(sl), .sco(sco), .seq(seq), .ror(ror), .jumpCtl(jumpCtl), .branchCtl(branchCtl),
      .btr(btr), .lbi(lbi), .slbi(slbi), .aluSrc(aluSrc), .regData1(read1Data), .regData2(read2Data), .immVal(exImmVaL), .inc_pc(PC_inc), 
       .new_pc(PC_new), .Out(Out), .Zero(Zero), .Ofl(Ofl), .memRead(memRead), .memWrite(memWrite), .PCsrc(PCsrc));

   // Memory
   memory memoryStage(.aluOut(Out), .wrData(read2Data), .memRead(memRead), .memWrite(memWrite), .clk(clk), .rst(rst), .memoryOut(memoryOut), .halt(halt));

   // Wb
   wb wbStage(.PC_inc(PC_inc), .jumpCtl(jumpCtl), .memToReg(memToReg), .memData(memoryOut), .aluOut(Out), .immVal(exImmVaL), .writeData(writeData));

   assign err = 1'b0; //Ofl | decode_err;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
