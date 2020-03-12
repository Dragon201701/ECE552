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
   
   wire regWrite, aluSrc, memWrite, memRead, memToReg, branchCtl, jumpCtl, invA, invB, halt, noOp, immCtl, stu, slbi, immPres, lbi;
   wire decode_err;
   wire [1:0] aluCtl;

   wire [2:0] regRs, readReg1, readReg2, writeReg1;
   wire [15:0] immVal;
   wire [15:0] currInstr, next_pc, signedImmVal, branch, jump, new_pc, Out, wrData;
   wire [15:0] regData1, regData2, read1Data, read2Data, aluOut, writeData, memoryOut;

   reg [15:0] pc;

   // Reset PC on rst signal
   always @ (posedge clk)
   begin
	   if (rst)
		   pc <= 16'h0000;
	   else
		   pc <= next_pc;
   end


   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */

   // Setup Control signals with control module
   control ctlSignals(.instr(currInstr), .clk(clk), .rst(rst), .regWrite(regWrite), .aluSrc(aluSrc), .aluCtl(aluCtl), .memWrite(memWrite), .memRead(memRead), .memToReg(memToReg), .branchCtl(branchCtl), 
	   .jumpCtl(jumpCtl), .invA(invA), .invB(invB), .halt(halt), .noOp(noOp), .immCtl(immCtl), .stu(stu), .slbi(slbi), .immPres(immPres), .lbi(lbi));

   // Fetch
   fetch fetchStage(.pc(pc), .wr(1'b0), .enable(1'b1), .clk(clk), .rst(rst), .lbi(lbi), .halt(halt), .noOp(noOp), .stu(stu), .immPres(immPres), .immCtl(immCtl), .readReg1(readReg1), .readReg2(readReg2), .writeReg1(writeReg1), .immVal(immVal), .branch(branch), .jump(jump), .new_pc(new_pc), .instr(currInstr));

   // Deode
   decode decodeStage(.writeEn(regWrite), .writeData(writeData), .writeRegSel(writeReg1), .read2RegSel(readReg2), .read1RegSel(readReg1), .immCtl(immCtl), .immVal(immVal), .rst(rst), .clk(clk), .jump(jumpCtl), .regRs(regRs), .read1Data(read1Data), .read2Data(read2Data), .signedImmVal(signedImmVal), .err(decode_err));

   // Execute
   execute executeStage(.slbi(slbi), .aluSrc(aluSrc), .regData1(read1Data), .regData2(read2Data), .immVal(signedImmVal), .immCtl(immCtl), .jump(jumpCtl), .branch(branchCtl), .jumpVal(jump), .branchVal(branch), .pc(new_pc), .instr(currInstr), .invA(invA), .invB(invB), .next_pc(next_pc), .Out(Out), .wrData(wrData), .Zero(Zero), .Ofl(Ofl));

   // Memory
   memory memoryStage(.aluOut(Out), .wrData(wrData), .memRead(memRead), .memWrite(memWrite), .memToReg(memToReg), .clk(clk), .rst(rst), .memoryOut(memoryOut), .halt(halt));

   // Wb
   wb wbStage(.memToReg(memToReg), .memData(memoryOut), .aluOut(Out), .lbi(lbi), .immVal(signedImmVal), .writeData(writeData));

   assign err = Ofl | decode_err;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
