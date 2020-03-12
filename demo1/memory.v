/*
   CS/ECE 552 Spring '20
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
module memory (aluOut, wrData, memRead, memWrite, memToReg, clk, rst, memoryOut, halt);

   input memRead, memWrite, memToReg, clk, rst, halt;
  
   input [15:0] wrData, aluOut;
   output [15:0] memoryOut;

   // Memory segment
   // Initialize memory
   // TODO: Change memory back to syn type 
   memory2c data_mem(.data_out(memoryOut), .data_in(wrData), .addr(aluOut), .enable(memRead), .wr(memWrite), .createdump(clk), .clk(clk), .rst(rst) );


endmodule
