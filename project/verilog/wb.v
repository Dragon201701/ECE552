/*
   CS/ECE 552 Spring '20
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
module wb (PC_inc, jumpCtl, memToReg, memData, aluOut, immVal, writeData);

   input memToReg;
   input [15:0] memData, aluOut, immVal, PC_inc;
   input [2:0] jumpCtl;
   output [15:0] writeData;
   wire [15:0] inter_writeData;
   assign inter_writeData = memToReg ? memData : aluOut;  

   // Lbi implementation
   //cla_16b inc_pc(.A(pc), .B(16'h0002), .C_in(1'b0), .S(pc_inc), .C_out());
   assign writeData = jumpCtl[1] ? PC_inc : inter_writeData;

endmodule
