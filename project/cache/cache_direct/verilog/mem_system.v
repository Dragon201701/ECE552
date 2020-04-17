/* $Author: karu $ */
/* $LastChangedDate: 2009-04-24 09:28:13 -0500 (Fri, 24 Apr 2009) $ */
/* $Rev: 77 $ */

module mem_system(/*AUTOARG*/
   // Outputs
   DataOut, Done, Stall, CacheHit, err,
   // Inputs
   Addr, DataIn, Rd, Wr, createdump, clk, rst
   );
   
   input [15:0] Addr;
   input [15:0] DataIn;
   input        Rd;
   input        Wr;
   input        createdump;
   input        clk;
   input        rst;
   
   output [15:0] DataOut;
   output Done;
   output Stall;
   output CacheHit;
   output err;

   wire   cache_err, mem_err;

   wire   [15:0]  cache_data_in, cache_data_out;
   wire   [4:0]   tag_out, tag_in;
   wire   [10:3]  cache_index;
   wire   [2:0]   cache_offset;
   wire           cache_hit, cache_dirty, cache_valid_in, cache_en, cache_compare, cache_write, cache_valid_out;

   wire   [15:0]  mem_data_in, mem_data_out, mem_addr;
   wire           mem_stall, mem_read, mem_write;
   wire   [3:0]   mem_busy;

   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter memtype = 0;
   cache #(0 + memtype) c0(// Outputs
                          .tag_out              (tag_out),
                          .data_out             (cache_data_out),
                          .hit                  (cache_hit),
                          .dirty                (cache_dirty),
                          .valid                (cache_valid_out),
                          .err                  (cache_err),
                          // Inputs
                          .enable               (cache_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (tag_in),
                          .index                (cache_index),
                          .offset               (cache_offset),
                          .data_in              (cache_data_in),
                          .comp                 (cache_compare),
                          .write                (cache_write),
                          .valid_in             (cache_valid_in));

   four_bank_mem mem(// Outputs
                     .data_out          (mem_data_out),
                     .stall             (mem_stall),
                     .busy              (mem_busy),
                     .err               (mem_err),
                     // Inputs
                     .clk               (clk),
                     .rst               (rst),
                     .createdump        (createdump),
                     .addr              (mem_addr),
                     .data_in           (mem_data_in),
                     .wr                (mem_write),
                     .rd                (mem_read));

   
   // your code here
   controller control(.Addr(Addr), .DataIn(DataIn), .Rd(Rd), .Wr(Wr), .clk(clk), .rst(rst), .DataOut(DataOut), .Done(Done), .Stall(Stall), .CacheHit(CacheHit), .err(err),
    .cache_en(cache_en), .cache_tag_in(tag_in), .cache_index(cache_index), .cache_offset(cache_offset), 
    .cache_data_in(cache_data_in), .cache_compare(cache_compare), .cache_write(cache_write), .cache_valid_in(cache_valid_in), 
    .cache_tag_out(tag_out), .cache_data_out(cache_data_out), .cache_hit(cache_hit), .cache_dirty(cache_dirty), .cache_valid_out(cache_valid_out), 
    .mem_addr(mem_addr), .mem_data_in(mem_data_in), .mem_write(mem_write), .mem_read(mem_read), .mem_data_out(mem_data_out), .mem_stall(mem_stall), .mem_busy(mem_busy));
   

   

   
   
  
   

   assign err = cache_err | mem_err;
  
   
   
   
   
  
   
   
endmodule // mem_system

// DUMMY LINE FOR REV CONTROL :9:
