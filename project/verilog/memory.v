/*
   CS/ECE 552 Spring '20
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
module memory (aluOut, wrData, memRead, memWrite, clk, rst, memoryOut, halt, err);

   input memRead, memWrite, clk, rst, halt;
  
   input [15:0] wrData, aluOut;
   output [15:0] memoryOut;
   output err;
   wire   en;
   assign en = memWrite | memRead;
   // Memory segment
   // Initialize memory
   // TODO: Change memory back to syn type 
   memory2c_align data_mem(.data_out(memoryOut), .data_in(wrData), .addr(aluOut), .enable(en), .wr(memWrite), .createdump(clk), .clk(clk), .rst(rst), .err(err) );


endmodule
