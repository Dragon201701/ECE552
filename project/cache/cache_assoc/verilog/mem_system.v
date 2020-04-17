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

  
   wire   c0_err, c1_err, mem_err;

   wire   [15:0]  c0_data_in, c0_data_out, c1_data_in, c1_data_out;
   wire   [4:0]   c0_tag_out, c0_tag_in, c1_tag_out, c1_tag_in;
   wire   [10:3]  c0_index, c1_index;
   wire   [2:0]   c0_offset, c1_offset;
   wire           c0_hit, c0_dirty, c0_valid_in, c0_en, c0_compare, c0_write, c0_valid_out, 
                  c1_hit, c1_dirty, c1_valid_in, c1_en, c1_compare, c1_write, c1_valid_out;

   wire   [15:0]  mem_data_in, mem_data_out, mem_addr;
   wire           mem_stall, mem_read, mem_write;
   wire   [3:0]   mem_busy;

   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter memtype = 0;
   cache #(0 + memtype) c0(// Outputs
                          .tag_out              (c0_tag_out),
                          .data_out             (c0_data_out),
                          .hit                  (c0_hit),
                          .dirty                (c0_dirty),
                          .valid                (c0_valid_out),
                          .err                  (c0_err),
                          // Inputs
                          .enable               (c0_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (c0_tag_in),
                          .index                (c0_index),
                          .offset               (c0_offset),
                          .data_in              (c0_data_in),
                          .comp                 (c0_compare),
                          .write                (c0_write),
                          .valid_in             (c0_valid_in));
   cache #(2 + memtype) c1(// Outputs
                          .tag_out              (c1_tag_out),
                          .data_out             (c1_data_out),
                          .hit                  (c1_hit),
                          .dirty                (c1_dirty),
                          .valid                (c1_valid_out),
                          .err                  (c0_err),
                          // Inputs
                          .enable               (c1_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (c1_tag_in),
                          .index                (c1_index),
                          .offset               (c1_offset),
                          .data_in              (c1_data_in),
                          .comp                 (c1_ompare),
                          .write                (c1_write),
                          .valid_in             (c1_valid_in));

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
    .c0_en(c0_en), .c0_tag_in(c0_tag_in), .c0_index(c0_index), .c0_offset(c0_offset), 
    .c0_data_in(c0_data_in), .c0_compare(c0_compare), .c0_write(c0_write), .c0_valid_in(c0_valid_in), 
    .c0_tag_out(c0_tag_out), .c0_data_out(c0_data_out), .c0_hit(c0_hit), .c0_dirty(c0_dirty), .c0_valid_out(c0_valid_out),

    .c1_en(c1_en), .c1_tag_in(c1_tag_in), .c1_index(c1_index), .c1_offset(c1_offset), 
    .c1_data_in(c1_data_in), .c1_compare(c1_compare), .c1_write(c1_write), .c1_valid_in(c1_valid_in), 
    .c1_tag_out(c1_tag_out), .c1_data_out(c1_data_out), .c1_hit(c1_hit), .c1_dirty(c1_dirty), .c1_valid_out(c1_valid_out),
     
    .mem_addr(mem_addr), .mem_data_in(mem_data_in), .mem_write(mem_write), .mem_read(mem_read), .mem_data_out(mem_data_out), .mem_stall(mem_stall), .mem_busy(mem_busy));
   assign err = c0_err | c1_err | mem_err;
   
endmodule // mem_system

   


// DUMMY LINE FOR REV CONTROL :9:
