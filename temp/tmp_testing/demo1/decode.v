/*
   CS/ECE 552 Spring '20
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
module decode (instr, writeEn, writeData, immCtl, extCtl, immPres, jumpCtl, linkCtl, stuCtl, rst, clk, read1Data, read2Data, exImmVaL, err);

    input   writeEn, immCtl, extCtl, clk, rst, immPres, jumpCtl, linkCtl, stuCtl;
    input   [15:0]  instr; // instruction
    input   [15:0]  writeData;
    output err;
    output [15:0]  read1Data, read2Data;
    output [15:0] exImmVaL;

    
    wire   [2:0]    Rs, R1, R2; // R1 is either Rd or Rt, R2 is Rd. 
    // Instatiate register file

    assign Rs = instr[10:8];
    assign R1 = instr[7:5];
    //assign R2 = instr[4:2];
    assign R2 = (stuCtl)? instr[10:8]:(jumpCtl & linkCtl) ? 3'b111 : (immPres ? immCtl ? instr[10:8] : instr[7:5] : instr[4:2]);
    regFile decodeRegisters(
                // Outputs
                .read1Data(read1Data), .read2Data(read2Data), .err(err),
                // Inputs
                .clk(clk), .rst(rst), .read1RegSel(Rs), .read2RegSel(R1), .writeRegSel(R2), .writeData(writeData), .writeEn(writeEn)
                );

    // TODO EPC...

    // Assuming Rs is the first read register
    // TODO: Check
    extension extension(.instr(instr), .immCTL(immCtl), .extCTL(extCtl), .jumpCTL(jumpCtl), .extVal(exImmVaL));

    // Sign extension of immediate occurs here
    //assign signedImmVal = slbi ? immVal : immCtl ? { {8{immVal[7]}}, immVal[7:0]} : { {11{immVal[4]}} , immVal[4:0]};


endmodule
