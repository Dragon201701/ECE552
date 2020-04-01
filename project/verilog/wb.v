/*
   CS/ECE 552 Spring '20
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
module wb (pc, jumpCtl, memToReg, memData, aluOut, lbi, immVal, writeData);

   input memToReg, lbi, jumpCtl;
   input [15:0] memData, aluOut, immVal, pc;

   output [15:0] writeData;
   wire [15:0] inter_writeData, pc_inc;
   assign inter_writeData = memToReg ? memData : aluOut;  

   // Lbi implementation
   cla_16b inc_pc(.A(pc), .B(16'h0002), .C_in(1'b0), .S(pc_inc), .C_out());
   assign writeData = jumpCtl ? pc_inc : (lbi ? immVal : inter_writeData);

endmodule
