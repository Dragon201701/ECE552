/*
   CS/ECE 552 Spring '20
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
module memory (aluOut, wrData, memRead, memWrite, clk, rst, memoryOut, halt, err, Done, Stall, lbi);

   input memRead, memWrite, clk, rst, halt, lbi;
  
   input [15:0] wrData, aluOut;
   output [15:0] memoryOut;
   wire [15:0] memoryOut_t;
   output err, Done, Stall;
   wire   en;
   assign en = memWrite | memRead;
   // Memory segment
   // Initialize memory
   // TODO: Change memory back to syn type 
   //memory2c_align data_mem(.data_out(memoryOut), .data_in(wrData), .addr(aluOut), .enable(en), .wr(memWrite), .createdump(clk), .clk(clk), .rst(rst), .err(err) );
   //stallmem data_mem(.DataOut(memoryOut), .Done(Done), .Stall(Stall), .CacheHit(), .DataIn(wrData), .Addr(aluOut), .Wr(memWrite), .Rd(memRead), .createdump(clk), .clk(clk), .rst(rst), .err(err));

   mem_system data_mem(
   // Outputs
   .DataOut(memoryOut_t), .Done(Done), .Stall(Stall), .CacheHit(), .err(err),
   // Inputs
   .Addr(aluOut), .DataIn(wrData), .Rd(memRead), .Wr(memWrite), .createdump(clk), .clk(clk), .rst(rst)
   );


   assign memoryOut = lbi ? aluOut : memoryOut_t;

endmodule




