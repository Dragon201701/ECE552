/*
   CS/ECE 552 Spring '20
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
module wb (currInstr, writeReg1, readReg1, stu, pc, jumpCtl, memToReg, memData, aluOut, lbi, immVal, writeData, writeRegSel);

   input memToReg, lbi, jumpCtl, stu;
   input [15:0] memData, aluOut, immVal, pc, currInstr;

   input [2:0] writeReg1, readReg1;
   output [15:0] writeData; 
   output [2:0] writeRegSel;

   wire [15:0] inter_writeData;

   assign inter_writeData = memToReg ? memData : aluOut;  

   // Lbi implementation
   assign writeData = jumpCtl ? pc : (lbi ? immVal : (stu ? aluOut : inter_writeData));

   assign writeRegSel = (currInstr[15:11] == 5'b10011) ? readReg1 : writeReg1;


endmodule
