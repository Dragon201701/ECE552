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
   
   wire regWrite, btr, aluSrc, memWrite, memRead, memToReg, halt, noOp, stu, slbi, immPres, lbi, stuCtl, PCsrc;
   wire decode_err, sl, sco, seq;
   //wire [1:0] aluCtl;
   wire [2:0] regRs, readReg1, readReg2, writeReg1, aluOp, branchCtl, jumpCtl;
   wire [15:0] immVal;
   wire [15:0] instr, fetch_instr, decode_instr, next_pc, exImmVaL, branch, jump, Out, wrData;
   wire [15:0] regData1, regData2, read1Data, read2Data, aluOut, writeData, memoryOut;
   wire [15:0] PC_inc, PC, PC_new;
   //wire [15:0] pc, nextpc;
   wire FD_flush;
   assign FD_flush = 1'b0;

   /* your code here -- should include instantiation+-s of fetch, decode, execute, mem and wb modules */

   // Setup Control signals with control module
   //control ctlSignals(.instr(instr), .clk(clk), .aluOp(aluOp), .rst(rst), .regWrite(regWrite), .aluSrc(aluSrc), .aluCtl(), .memWrite(memWrite), .memRead(memRead), .memToReg(memToReg), .branchCtl(branchCtl), 
	//  .jumpCtl(jumpCtl), .jrCtl(jrCtl), .stuCtl(stuCtl), .linkCtl(linkCtl), .halt(halt), .noOp(noOp), .stu(stu), .slbi(slbi), .immPres(immPres), .lbi(lbi), .btr(btr), .sl(sl), .sco(sco), .seq(seq));

   // Fetch
   //fetch fetchStage(.pc(pc), .wr(1'b0), .enable(1'b1), .clk(clk), .rst(rst), .halt(halt), .writeReg1(writeReg1), .immVal(immVal), .branch(branch), .jump(jump), .new_pc(next_pc), .instr(currInstr));
   fetch fetchStage(.clk(clk), .rst(rst), .PC_inc(PC_inc), .instr(instr), .PCsrc(PCsrc), .PC_new(PC_new));

   //reg16 FD_instr(.clk(clk), .rst(rst|FD_flush), .en(1'b1), .D(fetch_instr), .Q(decode_instr));
   // Deode
   assign decode_instr = fetch_instr;

   //decode decodeStage(.instr(instr), .writeEn(regWrite), .stuCtl(stuCtl), .writeData(writeData), .exImmVaL(exImmVaL), .rst(rst), .clk(clk), .jumpCtl(jumpCtl), 
   //   .read1Data(read1Data), .read2Data(read2Data), .err(decode_err), .immPres(immPres), .linkCtl(linkCtl)))
   decode decodeStage(.clk(clk), .rst(rst), .instr(instr), .writeData(writeData), .err(err), .read1Data(read1Data), .read2Data(read2Data), 
      .exImmVaL(exImmVaL), .aluOp(aluOp), .regWrite(regWrite), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), .memRead(memRead), .memToReg(memToReg), .branchCtl(branchCtl), 
      .jumpCtl(jumpCtl), .halt(), .noOp(), .stu(stu), .slbi(slbi), .lbi(lbi), .seq(seq), .sl(sl), .sco(sco));


   // Execute
   execute executeStage(.aluOp(aluOp), .sl(sl), .sco(sco), .seq(seq), .jumpCtl(jumpCtl), .branchCtl(branchCtl),
      .btr(btr), .slbi(slbi), .aluSrc(aluSrc), .regData1(read1Data), .regData2(read2Data), .immVal(exImmVaL), .inc_pc(PC_inc), .instr(instr), 
       .new_pc(PC_new), .Out(Out), .Zero(Zero), .Ofl(Ofl), .memRead(memRead), .memWrite(memWrite), .PCsrc(PCsrc));

   // Memory
   memory memoryStage(.aluOut(Out), .wrData(read2Data), .memRead(memRead), .memWrite(memWrite), .clk(clk), .rst(rst), .memoryOut(memoryOut), .halt(halt));

   // Wb
   wb wbStage(.pc(pc), .jumpCtl(jumpCtl), .memToReg(memToReg), .memData(memoryOut), .aluOut(Out), .lbi(lbi), .immVal(exImmVaL), .writeData(writeData));

   assign err = 1'b0; //Ofl | decode_err;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
