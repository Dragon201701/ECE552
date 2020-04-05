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
   
   wire regWriteIn, regWriteOut, btr, aluSrc, memWrite, memRead, MemToReg, halt, noOp, slbi, lbi, stuCtl, PCsrc;
   wire decode_err, sl, sco, seq, ror;
   //wire [1:0] aluCtl;
   wire [2:0] Rs, Rt, RdIn, RdOut, aluOp, branchCtl, jumpCtl;
   wire [15:0] instr, fetch_instr, decode_instr, next_pc, exImmVal, branch, jump, Out, wrData;
   wire [15:0] regData1, regData2, read1Data, read2Data, aluOut, writeData, memoryOut;
   wire [15:0] PC_inc, PC, PC_new, IFID_PC, IDEX_PC, EXMEM_PC, MEMWB_PC;
   //wire [15:0] pc, nextpc;
   wire FD_flush;
   assign FD_flush = 1'b0;

   // Pipeline
   wire  [15:0]   IFID_PC_inc, IFID_instr;

   wire  [2:0]    IDEX_Rs, IDEX_Rt, IDEX_Rd, IDEX_aluOp, IDEX_branchCtl, IDEX_jumpCtl;
   wire  [15:0]   IDEX_read1Data, IDEX_read2Data, IDEX_exImmVal, IDEX_PC_inc;
   wire           IDEX_regWrite, IDEX_aluSrc, IDEX_btr, IDEX_memWrite, IDEX_memRead, IDEX_MemToReg, IDEX_slbi, IDEX_lbi, IDEX_seq, IDEX_sl, IDEX_sco, IDEX_ror;

   wire  [15:0]   EXMEM_PC_inc, EXMEM_memAddr, EXMEM_PC_new, EXMEM_wrData;
   wire  [2:0]    EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, EXMEM_jumpCtl;
   wire           EXMEM_memRead, EXMEM_memWrite, EXMEM_PCsrc, EXMEM_regWrite, EXMEM_MemToReg;

   wire  [2:0]    MEMWB_jumpCtl, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd;
   wire  [15:0]   MEMWB_Out, MEMWB_memoryOut, MEMWB_PC_inc, MEMWB_ALUout;
   wire           MEMWB_MemToReg, MEMWB_regWrite;

   wire           flush, stall;

   pipeline Pipeline_Control(.flush(flush), .stall(stall));

   // Fetch
   fetch fetchStage(.clk(clk), .rst(rst), .PC_inc(PC_inc), .instr(instr), .PCsrc(PCsrc), .PC_new(PC_new), .PC(PC));

   IFIDreg IFID(.clk(clk), .rst(rst), .flush(flush), .stall(stall), .PC_inc(PC_inc), .PC(PC), .instr(instr), .IFID_PC_inc(IFID_PC_inc), .IFID_PC(IFID_PC), .IFID_instr(IFID_instr));

   // Deode
   decode decodeStage(.clk(clk), .rst(rst), .instr(IFID_instr), .writeData(writeData), .err(err), .read1Data(read1Data), .read2Data(read2Data), 
      .exImmVal(exImmVal), .aluOp(aluOp), .regWriteIn(MEMWB_regWrite), .regWriteOut(regWriteOut), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), .memRead(memRead), .MemToReg(MemToReg), .branchCtl(branchCtl), 
      .jumpCtl(jumpCtl), .halt(), .noOp(), .slbi(slbi), .lbi(lbi), .seq(seq), .sl(sl), .sco(sco), .ror(ror), .Rs(Rs), .Rt(Rt), .RdIn(MEMWB_Rd), .RdOut(RdOut));


   IDEXreg IDEX(.clk(clk), .rst(rst), .Rs(Rs), .Rt(Rt), .Rd(RdOut), .aluOp(aluOp), .branchCtl(branchCtl), .jumpCtl(jumpCtl), 
      .IDEX_Rs(IDEX_Rs), .IDEX_Rt(IDEX_Rt), .IDEX_Rd(IDEX_Rd), .IDEX_aluOp(IDEX_aluOp), .IDEX_branchCtl(IDEX_branchCtl), .IDEX_jumpCtl(IDEX_jumpCtl), 

      .read1Data(read1Data), .read2Data(read2Data), .exImmVal(exImmVal), .PC_inc(IFID_PC_inc), .PC(IFID_PC),
      .IDEX_read1Data(IDEX_read1Data), .IDEX_read2Data(IDEX_read2Data), .IDEX_exImmVal(IDEX_exImmVal), .IDEX_PC_inc(IDEX_PC_inc), .IDEX_PC(IDEX_PC),

      .regWrite(regWriteOut), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), .memRead(memRead), .MemToReg(MemToReg), .lbi(lbi), .slbi(slbi), .seq(seq), .sl(sl), .sco(sco), .ror(ror), 
      .IDEX_regWrite(IDEX_regWrite), .IDEX_aluSrc(IDEX_aluSrc), .IDEX_btr(IDEX_btr), .IDEX_memWrite(IDEX_memWrite), .IDEX_memRead(IDEX_memRead), .IDEX_MemToReg(IDEX_MemToReg), 
      .IDEX_lbi(IDEX_lbi), .IDEX_slbi(IDEX_slbi), .IDEX_seq(IDEX_seq), .IDEX_sl(IDEX_sl), .IDEX_sco(IDEX_sco), .IDEX_ror(IDEX_ror), 

      .flush(flush), .stall(stall));


   // Execute
   execute executeStage(.aluOp(IDEX_aluOp), .sl(IDEX_sl), .sco(IDEX_sco), .seq(IDEX_seq), .ror(IDEX_ror), .jumpCtl(IDEX_jumpCtl), .branchCtl(IDEX_branchCtl),
      .btr(IDEX_btr), .lbi(IDEX_lbi), .slbi(IDEX_slbi), .aluSrc(IDEX_aluSrc), .regData1(IDEX_read1Data), .regData2(IDEX_read2Data), .immVal(IDEX_exImmVal), .inc_pc(IDEX_PC_inc), 
       .new_pc(PC_new), .Out(Out), .Zero(), .Ofl(), .PCsrc(PCsrc));

   EXMEMreg EXMEM(.clk(clk), .rst(rst),
      .Rs(IDEX_Rs), .Rt(IDEX_Rt), .Rd(IDEX_Rd), .jumpCtl(IDEX_jumpCtl), .memAddr(Out), .writeData(IDEX_read2Data), .PC_inc(IDEX_PC_inc), .PC_new(PC_new), .PC(IDEX_PC),
      .memRead(IDEX_memRead), .memWrite(IDEX_memWrite), .PCsrc(PCsrc), .regWrite(IDEX_regWrite), .MemToReg(IDEX_MemToReg),
      .EXMEM_Rs(EXMEM_Rs), .EXMEM_Rt(EXMEM_Rt), .EXMEM_Rd(EXMEM_Rd), .EXMEM_jumpCtl(EXMEM_jumpCtl), 
      .EXMEM_memAddr(EXMEM_memAddr), .EXMEM_writeData(EXMEM_writeData), .EXMEM_PC_inc(EXMEM_PC_inc), .EXMEM_PC_new(EXMEM_PC_new), .EXMEM_PC(EXMEM_PC),
      .EXMEM_memRead(EXMEM_memRead), .EXMEM_memWrite(EXMEM_memWrite), .EXMEM_PCsrc(EXMEM_PCsrc), .EXMEM_regWrite(EXMEM_regWrite), .EXMEM_MemToReg(EXMEM_MemToReg));




   // Memory
   memory memoryStage(.aluOut(EXMEM_memAddr), .wrData(EXMEM_writeData), .memRead(EXMEM_memRead), .memWrite(EXMEM_memWrite), .clk(clk), .rst(rst), .memoryOut(memoryOut), .halt(halt));

   MEMWBreg MEMWB(.clk(clk), .rst(rst), .memoryOut(memoryOut), .PC_inc(EXMEM_PC_inc), .ALUOut(EXMEM_memAddr), .PC(EXMEM_PC), .jumpCtl(EXMEM_jumpCtl), 
      .Rs(IDEX_Rs), .Rt(IDEX_Rt), .Rd(EXMEM_Rd), .MemToReg(EXMEM_MemToReg), .regWrite(EXMEM_regWrite), 
      .MEMWB_memoryOut(MEMWB_memoryOut), .MEMWB_PC_inc(MEMWB_PC_inc), .MEMWB_PC(MEMWB_PC), .MEMWB_ALUout(MEMWB_ALUout), .MEMWB_jumpCtl(MEMWB_jumpCtl),
      .MEMWB_Rs(MEMWB_Rs), .MEMWB_Rt(MEMWB_Rt), .MEMWB_Rd(MEMWB_Rd), .MEMWB_MemToReg(MEMWB_MemToReg), .MEMWB_regWrite(MEMWB_regWrite));
   // Wb
   wb wbStage(.PC_inc(MEMWB_PC_inc), .jumpCtl(MEMWB_jumpCtl), .memToReg(MEMWB_MemToReg), .memData(MEMWB_memoryOut), .aluOut(MEMWB_ALUout), .writeData(writeData));

   assign err = 1'b0; //Ofl | decode_err;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
