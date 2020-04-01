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
   
   wire regWrite, btr, aluSrc, memWrite, memRead, memToReg, branchCtl, jumpCtl, jrCtl, linkCtl, invA, invB, halt, noOp, immCtl, extCtl, stu, slbi, immPres, lbi, stuCtl;
   wire decode_err, sl, sco, seq;
   wire [1:0] aluCtl;

   wire [2:0] regRs, readReg1, readReg2, writeReg1;
   wire [15:0] immVal;
   wire [15:0] instr, next_pc, exImmVaL, branch, jump, Out, wrData;
   wire [15:0] regData1, regData2, read1Data, read2Data, aluOut, writeData, memoryOut;
   wire [15:0] inc_pc;
   wire [15:0] pc, nextpc;

   // Reset PC on rst signal
   /*always @ (posedge clk)
   begin
	   if (rst)
		   pc <= 16'h0000;
	   else
		   pc <= next_pc;
   end*/

   assign nextpc = rst? 16'h0000:next_pc;
   reg16 pcreg(.clk(clk),.rst(rst),.en(1'b1),.D(nextpc), .Q(pc));
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */

   // Setup Control signals with control module
   control ctlSignals(.instr(instr), .clk(clk), .rst(rst), .regWrite(regWrite), .aluSrc(aluSrc), .aluCtl(aluCtl), .memWrite(memWrite), .memRead(memRead), .memToReg(memToReg), .branchCtl(branchCtl), 
	   .jumpCtl(jumpCtl), .jrCtl(jrCtl), .stuCtl(stuCtl), .linkCtl(linkCtl), .invA(invA), .invB(invB), .halt(halt), .noOp(noOp), .immCtl(immCtl), .extCtl(extCtl), .stu(stu), .slbi(slbi), .immPres(immPres), .lbi(lbi), .btr(btr), .sl(sl), .sco(sco), .seq(seq));

   // Fetch
   //fetch fetchStage(.pc(pc), .wr(1'b0), .enable(1'b1), .clk(clk), .rst(rst), .halt(halt), .writeReg1(writeReg1), .immVal(immVal), .branch(branch), .jump(jump), .new_pc(next_pc), .instr(currInstr));
   fetch fetchStage(.pc(pc), .clk(clk), .rst(rst), .halt(halt), .pc_inc(inc_pc), .instr(instr));
   // Deode
   decode decodeStage(.instr(instr), .writeEn(regWrite), .stuCtl(stuCtl), .writeData(writeData), .immCtl(immCtl), .extCtl(extCtl), .exImmVaL(exImmVaL), .rst(rst), .clk(clk), .jumpCtl(jumpCtl), .read1Data(read1Data), .read2Data(read2Data), .err(decode_err), .immPres(immPres), .linkCtl(linkCtl));

   // Execute
   execute executeStage(.sl(sl), .sco(sco), .seq(seq), .jumpCtl(jumpCtl), .jrCtl(jrCtl), .linkCtl(linkCtl), .branchCtl(branchCtl),.immPres(immPres), .btr(btr), .slbi(slbi), .aluSrc(aluSrc), .regData1(read1Data), .regData2(read2Data), .immVal(exImmVaL), .inc_pc(inc_pc), .instr(instr), .invA(invA), .invB(invB), .new_pc(next_pc), .Out(Out), .Zero(Zero), .Ofl(Ofl), .memRead(memRead), .memWrite(memWrite));

   // Memory
   memory memoryStage(.aluOut(Out), .wrData(read2Data), .memRead(memRead), .memWrite(memWrite), .clk(clk), .rst(rst), .memoryOut(memoryOut), .halt(halt));

   // Wb
   wb wbStage(.pc(pc), .jumpCtl(jumpCtl), .memToReg(memToReg), .memData(memoryOut), .aluOut(Out), .lbi(lbi), .immVal(exImmVaL), .writeData(writeData));

   assign err = 1'b0; //Ofl | decode_err;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
