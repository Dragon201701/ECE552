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
   
   wire regWriteIn, regWriteOut, btr, aluSrc, memWrite, memRead, MemToReg, no_Op, slbi, lbi, stuCtl, PCsrc;
   wire decode_err, sl, sco, seq, ror;
   //wire [1:0] aluCtl;
   wire [2:0] Decode_Rs, Decode_Rt, RdIn, RdOut, aluOp, branchCtl, jumpCtl, Fetch_Rs, Fetch_Rt;
   wire [15:0] instr, fetch_instr, decode_instr, next_pc, exImmVal, jump, Out, wrData;
   wire [15:0] regData1, regData2, read1Data, read2Data, aluOut, writeData, memoryOut;
   wire [15:0] PC_inc, PC, PC_new, IFID_PC, IDEX_PC, EXMEM_PC, MEMWB_PC;
   //wire [15:0] pc, nextpc;
   wire FD_flush;
   assign FD_flush = 1'b0;
   // Pipeline
   wire  [15:0]   IFID_PC_inc, IFID_instr;
   wire  [2:0]    IFID_Rs, IFID_Rt;
   wire  [2:0]    IDEX_Rs, IDEX_Rt, IDEX_Rd, IDEX_aluOp, IDEX_branchCtl, IDEX_jumpCtl;
   wire  [15:0]   IDEX_read1Data, IDEX_read2Data, IDEX_exImmVal, IDEX_PC_new, IDEX_PC_inc;
   wire           IDEX_regWrite, IDEX_aluSrc, IDEX_btr, IDEX_memWrite, IDEX_memRead, IDEX_MemToReg, IDEX_slbi, IDEX_lbi, IDEX_seq, IDEX_sl, IDEX_sco, IDEX_ror, IDEX_PCsrc;
   wire  	  IDEX_noOp;

   wire  [15:0]   EXMEM_PC_inc, EXMEM_memAddr, EXMEM_PC_new, EXMEM_writeData;
   wire  [2:0]    EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, EXMEM_jumpCtl;
   wire           EXMEM_memRead, EXMEM_memWrite, EXMEM_PCsrc, EXMEM_regWrite, EXMEM_MemToReg, EXMEM_lbi, EXMEM_slbi;
   wire		  EXMEM_noOp;

   wire  [2:0]    MEMWB_jumpCtl, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd;
   wire  [15:0]   MEMWB_Out, MEMWB_memoryOut, MEMWB_PC_inc, MEMWB_ALUout;
   wire           MEMWB_MemToReg, MEMWB_regWrite, MEMWB_lbi, MEMWB_slbi;
   wire		  MEMWB_noOp;

   wire           flush, instr_stall, mem_stall, stall, forwarding_ex_Rs, forwarding_ex_Rt, forwarding_mem_Rs, forwarding_mem_Rt;
   wire           halt, halt_out, IFID_halt, IDEX_halt, EXMEM_halt, MEMWB_halt;
   wire           datamem_err, mem_err, instrmem_err;
   wire           mem_done;
   wire           instrmem_stall;
   jk_r memerr(.q(mem_err), .j(datamem_err), .k(1'b0), .clk(clk), .rst(rst));
   jk_r memstall(.q(q));
   assign halt = MEMWB_halt | mem_err;
   assign stall = mem_stall|instr_stall;

   pipeline Pipeline_Control(.clk(clk), .rst(rst), 
      .IFID_Rs(IFID_Rs), .IFID_Rt(IFID_Rt),
      .IDEX_Rs(IDEX_Rs), .IDEX_Rt(IDEX_Rt), .IDEX_Rd(IDEX_Rd), 
      .EXMEM_Rs(EXMEM_Rs), .EXMEM_Rt(EXMEM_Rt), .EXMEM_Rd(EXMEM_Rd), 
      .MEMWB_Rs(MEMWB_Rs), .MEMWB_Rt(MEMWB_Rt), .MEMWB_Rd(MEMWB_Rd), 
      .EXMEM_regWrite(EXMEM_regWrite), .MEMWB_regWrite   (MEMWB_regWrite), .IDEX_memRead(IDEX_memRead),
      .EXMEM_lbi(EXMEM_lbi), .EXMEM_slbi(EXMEM_slbi), .MEMWB_lbi(MEMWB_lbi), .MEMWB_slbi(MEMWB_slbi), 
      .stall(instr_stall), .forwarding_ex_Rs(forwarding_ex_Rs), .forwarding_ex_Rt(forwarding_ex_Rt), .forwarding_mem_Rs(forwarding_mem_Rs), .forwarding_mem_Rt(forwarding_mem_Rt));

   // Fetch
   fetch fetchStage(.clk(clk), .rst(rst), .PC_inc(PC_inc), .instr(instr), .PCsrc(PCsrc), .PC_new(PC_new), .PC(PC), .stall(stall), .Rs(Fetch_Rs), .Rt(Fetch_Rt), 
      .halt_in(halt), .halt_out(halt_out), .mem_err(mem_err), .instrmem_err(instrmem_err), .instrmem_stall(instrmem_stall));

   IFIDreg IFID(.clk(clk), .rst(rst|flush), .stall(stall), .PC_inc(PC_inc), .PC(PC), .instr(instr), .Rs(Fetch_Rs), .Rt(Fetch_Rt), .halt(halt_out),
      .IFID_PC_inc(IFID_PC_inc), .IFID_PC(IFID_PC), .IFID_instr(IFID_instr), .IFID_Rs(IFID_Rs), .IFID_Rt(IFID_Rt), .IFID_halt(IFID_halt));

   // Deode
   decode decodeStage(.clk(clk), .rst(rst), .instr(IFID_instr), .writeData(writeData), .err(err), .read1Data(read1Data), .read2Data(read2Data), 
      .exImmVal(exImmVal), .aluOp(aluOp), .regWriteIn(MEMWB_regWrite), .regWriteOut(regWriteOut), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), .memRead(memRead), .MemToReg(MemToReg), .branchCtl(branchCtl), 
      
      .jumpCtl(jumpCtl), .no_Op(no_Op), .slbi(slbi), .lbi(lbi), .seq(seq), .sl(sl), .sco(sco), .ror(ror), .Rs(Decode_Rs), .Rt(Decode_Rt), .RdIn(MEMWB_Rd), .RdOut(RdOut),
      .PC_inc(IFID_PC_inc), .PC_new(PC_new), .PCsrc(PCsrc), .flush(flush), .EXMEM_noOp(EXMEM_noOp), .MEMWB_noOp(MEMWB_noOp),
      .EX_Rd(IDEX_Rd), .EX_data(Out), .EX_link(IDEX_jumpCtl[1]), .EX_PC_inc(IDEX_PC_inc), .MEM_Rd(EXMEM_Rd), .MEM_data(memoryOut), .MEM_link(EXMEM_jumpCtl[1]), .MEM_PC_inc(EXMEM_PC_inc));


   IDEXreg IDEX(.clk(clk), .rst(rst), .Rs(Decode_Rs), .Rt(Decode_Rt), .Rd(RdOut), .aluOp(aluOp), .jumpCtl(jumpCtl), 
      .IDEX_Rs(IDEX_Rs), .IDEX_Rt(IDEX_Rt), .IDEX_Rd(IDEX_Rd), .IDEX_aluOp(IDEX_aluOp), .IDEX_jumpCtl(IDEX_jumpCtl), 

      .read1Data(read1Data), .read2Data(read2Data), .exImmVal(exImmVal), .PC_new(), .PC(IFID_PC), .PC_inc(IFID_PC_inc), 
      .IDEX_read1Data(IDEX_read1Data), .IDEX_read2Data(IDEX_read2Data), .IDEX_exImmVal(IDEX_exImmVal), .IDEX_PC_new(), .IDEX_PC(IDEX_PC), .IDEX_PC_inc(IDEX_PC_inc),

      .regWrite(regWriteOut), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), .memRead(memRead), .MemToReg(MemToReg), .lbi(lbi), .slbi(slbi), .seq(seq), .sl(sl), .sco(sco), .ror(ror), .halt(IFID_halt),
      .IDEX_regWrite(IDEX_regWrite), .IDEX_aluSrc(IDEX_aluSrc), .IDEX_btr(IDEX_btr), .IDEX_memWrite(IDEX_memWrite), .IDEX_memRead(IDEX_memRead), .IDEX_MemToReg(IDEX_MemToReg), 
      .IDEX_lbi(IDEX_lbi), .IDEX_slbi(IDEX_slbi), .IDEX_seq(IDEX_seq), .IDEX_sl(IDEX_sl), .IDEX_sco(IDEX_sco), .IDEX_ror(IDEX_ror), .IDEX_halt(IDEX_halt),

      .stall(stall), .no_Op(no_Op), .IDEX_noOp(IDEX_noOp) );


   // Execute
   execute executeStage(.aluOp(IDEX_aluOp), .sl(IDEX_sl), .sco(IDEX_sco), .seq(IDEX_seq), .ror(IDEX_ror),
      .btr(IDEX_btr), .lbi(IDEX_lbi), .slbi(IDEX_slbi), .aluSrc(IDEX_aluSrc), 
      .regData1(forwarding_ex_Rs?EXMEM_memAddr:(forwarding_mem_Rs?(MEMWB_MemToReg?MEMWB_memoryOut:writeData):IDEX_read1Data)), // Changed to writeData
      .regData2(forwarding_ex_Rt?EXMEM_memAddr:(forwarding_mem_Rt?(MEMWB_MemToReg?MEMWB_memoryOut:writeData):IDEX_read2Data)), 
      .immVal(IDEX_exImmVal), .Out(Out), .Zero(), .Ofl());

   EXMEMreg EXMEM(.clk(clk), .rst(rst),
      .Rs(IDEX_Rs), .Rt(IDEX_Rt), .Rd(IDEX_Rd), .jumpCtl(IDEX_jumpCtl), .memAddr(Out), .writeData(forwarding_ex_Rt?EXMEM_memAddr:(forwarding_mem_Rt?writeData:IDEX_read2Data)), .PC_inc(IDEX_PC_inc), .PC_new(), .PC(IDEX_PC),
      .memRead(IDEX_memRead), .memWrite(IDEX_memWrite), .regWrite(IDEX_regWrite), .MemToReg(IDEX_MemToReg), .lbi(IDEX_lbi), .slbi(IDEX_slbi), .halt(IDEX_halt),
      .EXMEM_Rs(EXMEM_Rs), .EXMEM_Rt(EXMEM_Rt), .EXMEM_Rd(EXMEM_Rd), .EXMEM_jumpCtl(EXMEM_jumpCtl), 
      .EXMEM_memAddr(EXMEM_memAddr), .EXMEM_writeData(EXMEM_writeData), .EXMEM_PC_inc(EXMEM_PC_inc), .EXMEM_PC_new(), .EXMEM_PC(EXMEM_PC),
      .EXMEM_memRead(EXMEM_memRead), .EXMEM_memWrite(EXMEM_memWrite), .EXMEM_regWrite(EXMEM_regWrite), .EXMEM_MemToReg(EXMEM_MemToReg), 
      .EXMEM_lbi(EXMEM_lbi), .EXMEM_slbi(EXMEM_slbi), .EXMEM_halt(EXMEM_halt), 
      .stall(mem_stall), .no_Op(IDEX_noOp), .EXMEM_noOp(EXMEM_noOp)  );


   // Memory
   memory memoryStage(.aluOut(EXMEM_memAddr), .wrData(EXMEM_writeData), .memRead(EXMEM_memRead), .memWrite(EXMEM_memWrite), .clk(clk), .rst(rst), .memoryOut(memoryOut), 
      .halt(halt), .err(datamem_err), .Done(mem_done), .Stall(mem_stall), .lbi(EXMEM_lbi));

   MEMWBreg MEMWB(.clk(clk), .rst(rst), .memoryOut(memoryOut), .PC_inc(EXMEM_PC_inc), .ALUOut(EXMEM_memAddr), .PC(EXMEM_PC), .jumpCtl(EXMEM_jumpCtl), .stall(stall), 
      .Rs(EXMEM_Rs), .Rt(EXMEM_Rt), .Rd(EXMEM_Rd), .MemToReg(EXMEM_MemToReg), .regWrite(EXMEM_regWrite), .lbi(EXMEM_lbi), .slbi(EXMEM_slbi), .halt(EXMEM_halt),
      .MEMWB_memoryOut(MEMWB_memoryOut), .MEMWB_PC_inc(MEMWB_PC_inc), .MEMWB_PC(MEMWB_PC), .MEMWB_ALUout(MEMWB_ALUout), .MEMWB_jumpCtl(MEMWB_jumpCtl),
      .no_Op(EXMEM_noOp), .MEMWB_noOp(MEMWB_noOp), .memRead(EXMEM_memRead), .MEMWB_memRead(MEMWB_memRead),
      .MEMWB_Rs(MEMWB_Rs), .MEMWB_Rt(MEMWB_Rt), .MEMWB_Rd(MEMWB_Rd), .MEMWB_MemToReg(MEMWB_MemToReg), .MEMWB_regWrite(MEMWB_regWrite), .MEMWB_lbi(MEMWB_lbi), .MEMWB_slbi(MEMWB_slbi), .MEMWB_halt(MEMWB_halt));
   // Wb
   wb wbStage(.PC_inc(MEMWB_PC_inc), .jumpCtl(MEMWB_jumpCtl), .memToReg(MEMWB_MemToReg), .memData(MEMWB_memoryOut), .aluOut(MEMWB_ALUout), .writeData(writeData));

   assign err = 1'b0; //Ofl | decode_err;

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
