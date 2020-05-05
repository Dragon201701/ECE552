/*
   CS/ECE 552 Spring '20
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
module decode (instr, writeData, rst, clk, read1Data, read2Data, exImmVal, err, aluOp, regWriteIn, regWriteOut, aluSrc, btr,
    EXMEM_noOp, MEMWB_noOp, memWrite, memRead, MemToReg, branchCtl, jumpCtl, no_Op, slbi, lbi, seq, sl, sco, ror, Rs, Rt, RdIn, RdOut, PC_inc, PC_new, PCsrc, flush, 
    EX_Rd, EX_data, EX_link, EX_PC_inc, EX_lbi, EX_slbi, MEM_Rs, MEM_Rd, MEM_data, MEM_addr, MEM_memWrite, MEM_jump, MEM_PC_inc, MEM_lbi, MEM_slbi);

    input   clk, rst, regWriteIn, EX_link;
    input   [15:0]  instr, PC_inc, EX_data, MEM_data, MEM_addr, EX_PC_inc, MEM_PC_inc; // instruction
    input   [15:0]  writeData;
    input   [2:0]   RdIn, EX_Rd, MEM_Rd, MEM_Rs, MEM_jump;
    input EXMEM_noOp, MEMWB_noOp, EX_lbi, EX_slbi, MEM_lbi, MEM_slbi, MEM_memWrite;
    output err;
    output [15:0]  read1Data, read2Data, PC_new;
    output [15:0] exImmVal;
    output [2:0] aluOp, jumpCtl, branchCtl, Rs, Rt, RdOut;
    output regWriteOut, aluSrc, btr, memWrite, memRead, MemToReg, no_Op, slbi, lbi, seq, sl, sco, ror, PCsrc, flush;
    wire stu, flush;
    wire    [15:0]  pc_add;
    
    //wire   [2:0]    Rs, Rt, Rd, regWrite; // R1 is either Rd or Rt, R2 is Rd. 
    // Instatiate register file

    assign Rs = instr[10:8];
    assign Rt = instr[7:5];
    //assign R2 = instr[4:2];
    assign RdOut = stu?instr[10:8]:jumpCtl[1]?3'b111:(lbi|slbi)? instr[10:8]:(instr[15:14] == 2'b11)?instr[4:2]:instr[7:5];
    regFile_bypass decodeRegisters(
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
    cla_16b jb_pc_add(.A(jumpCtl[0]?(
                        jumpCtl[1]? (
                                        EX_link? EX_PC_inc:
                                        MEM_jump[1]?( (Rs==3'b111)? MEM_PC_inc:read1Data ):
                                        ((EX_Rd == Rs) & ((Rs != 3'b000 & EXMEM_noOp != 1'b1) | EX_lbi | EX_slbi))? EX_data:
                                        ((MEM_jump[1]?MEM_Rs:MEM_Rd) == Rs) & ((Rs != 3'b000 & MEMWB_noOp != 1'b1) | MEM_lbi | MEM_slbi)? (MEM_memWrite?MEM_data:MEM_addr):
                                        read1Data
                                     ):
                                    (
                                        EX_Rd == Rs? EX_data:
                                        MEM_Rd == Rs? MEM_data:
                                        read1Data
                                    ) 
                        ):
                        PC_inc), 
        .B(exImmVal), .C_in(1'b0), .S(PC_new), .C_out());

    branchctlunit branchunit(.regData1((EX_Rd == Rs)? EX_data : (MEM_Rd == Rs)? MEM_data : read1Data), .branchCtl(branchCtl), .branch(branch));
    assign PCsrc = branch|jumpCtl[2];
    
    assign no_Op = instr[15:11] == 5'b00001 ? 1'b1 : 1'b0;

    control controlUnit(.aluOp(aluOp), .clk(clk), .rst(rst), .instr(instr), .regWrite(regWriteOut), .aluSrc(aluSrc), .btr(btr), .memWrite(memWrite), 
        .memRead(memRead), .MemToReg(MemToReg), .branchCtl(branchCtl), .jumpCtl(jumpCtl), .halt(),
        .noOp(), .immCtl(), .extCtl(), .stu(stu), .slbi(slbi), .immPres(), .lbi(lbi), .seq(seq), .sl(sl), .sco(sco), .ror(ror));
    assign flush = branch | jumpCtl[2];
endmodule
