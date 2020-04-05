/*
   CS/ECE 552 Spring '20
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
module decode (instr, writeData, rst, clk, read1Data, read2Data, exImmVal, err, aluOp, regWriteIn, regWriteOut, aluSrc, btr, 
    memWrite, memRead, MemToReg, branchCtl, jumpCtl, halt, noOp, slbi, lbi, seq, sl, sco, ror, Rs, Rt, RdIn, RdOut);

    input   clk, rst, regWriteIn;
    input   [15:0]  instr; // instruction
    input   [15:0]  writeData;
    input   [2:0]   RdIn;
    output err;
    output [15:0]  read1Data, read2Data;
    output [15:0] exImmVal;
    output [2:0] aluOp, jumpCtl, branchCtl, Rs, Rt, RdOut;
    output regWriteOut, aluSrc, btr, memWrite, memRead, MemToReg, halt, noOp, slbi, lbi, seq, sl, sco, ror;
    wire stu;
    
    //wire   [2:0]    Rs, Rt, Rd, regWrite; // R1 is either Rd or Rt, R2 is Rd. 
    // Instatiate register file

    assign Rs = instr[10:8];
    assign Rt = instr[7:5];
    //assign R2 = instr[4:2];
    assign RdOut = stu?instr[10:8]:jumpCtl[1]?3'b111:(lbi|slbi)? instr[10:8]:(instr[15:14] == 2'b11)?instr[4:2]:instr[7:5];
    regFile decodeRegisters(
                // Outputs
                .read1Data(read1Data), .read2Data(read2Data), .err(err),
                // Inputs
                .clk(clk), .rst(rst), .read1RegSel(Rs), .read2RegSel(Rt), .writeRegSel(RdIn), .writeData(writeData), .writeEn(regWriteIn)
                );

    // TODO EPC...

    // Assuming Rs is the first read register
    // TODO: Check
    extension extension(.instr(instr), .extVal(exImmVal));

    // Sign extension of immediate occurs here
    //assign signedImmVal = slbi ? immVal : immCtl ? { {8{immVal[7]}}, immVal[7:0]} : { {11{immVal[4]}} , immVal[4:0]};

    control controlUnit(.aluOp(aluOp), .clk(clk), .rst(rst), .instr(instr), .regWrite(regWriteOut), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), 
        .memRead(memRead), .MemToReg(MemToReg), .branchCtl(branchCtl), .jumpCtl(jumpCtl), .halt(halt),
        .noOp(noOp), .immCtl(), .extCtl(), .stu(stu), .slbi(slbi), .immPres(), .lbi(lbi), .seq(seq), .sl(sl), .sco(sco), .ror(ror));

endmodule
