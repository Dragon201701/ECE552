/*
   CS/ECE 552 Spring '20
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
module decode (slbi, stu, aluOut, writeEn, writeData, writeRegSel, read2RegSel, read1RegSel, immCtl, immVal, rst, clk, jump, regRs, read1Data, read2Data, signedImmVal, err);

    input writeEn, jump, immCtl, clk, rst, slbi, stu;
    input [2:0] writeRegSel, read1RegSel, read2RegSel;
    input [15:0] writeData, aluOut;
    input [15:0] immVal;

    output err;
    output [15:0]  read1Data, read2Data;
    output [2:0] regRs;
    output [15:0] signedImmVal;

    wire [15:0] write = stu ? aluOut : writeData;
    wire [15:0] writeReg = stu ? read1RegSel : writeRegSel; 
    wire [15:0] read1Out, read2Out;

    // Instatiate register file
    regFile decodeRegisters(
                // Outputs
                .read1Data(read1Out), .read2Data(read2Out), .err(err),
                // Inputs
                .clk(clk), .rst(rst), .read1RegSel(read1RegSel), .read2RegSel(read2RegSel), .writeRegSel(writeReg), .writeData(write), .writeEn(writeEn)
                );

    // TODO EPC...

    // Assuming Rs is the first read register
    // TODO: Check
    assign regRs = read1RegSel;


    // Sign extension of immediate occurs here
    assign signedImmVal = slbi ? immVal : immCtl ? { {8{immVal[7]}}, immVal[7:0]} : { {11{immVal[4]}} , immVal[4:0]};

    // Bypass logic
    assign read1Data = (writeEn & (read1RegSel == writeRegSel)) ? writeData : read1Out;
    assign read2Data = (writeEn & (read2RegSel == writeRegSel)) ? writeData : read2Out;



endmodule
