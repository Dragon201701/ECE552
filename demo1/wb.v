/*
   CS/ECE 552 Spring '20
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
module wb (memToReg, memData, aluOut, lbi, immVal, writeData);

   input memToReg, lbi;
   input [15:0] memData, aluOut, immVal;

   output [15:0] writeData;
   wire [15:0] inter_writeData;

   assign inter_writeData = memToReg ? memData : aluOut;  

   // Lbi implementation
   assign writeData = lbi ? immVal : inter_writeData;

endmodule
