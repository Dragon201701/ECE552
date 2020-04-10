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


   wire   [15:0]  mem_data;
   wire   [4:0] tag, tag_out;
   wire   [10:3]  index;
   wire   [2:0] offset;
   reg   [2:0] state, next_state;
   reg   cache_compare, cache_write,  memory_read, memory_write, cache_done;
   wire   [2:0] mystate, mystate_n;
   wire   valid, dirty, hit, stall, c0_err, c1_err, mem_err, mem_busy, mem_stall;



   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter memtype = 0;
   cache #(0 + memtype) c0(// Outputs
                          .tag_out              (),
                          .data_out             (DataOut),
                          .hit                  (hit),
                          .dirty                (dirty),
                          .valid                (valid),
                          .err                  (err),
                          // Inputs
                          .enable               (1'b1),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (tag),
                          .index                (index),
                          .offset               (offset),
                          .data_in              ((cache_write & ~cache_compare)?mem_data:DataIn),
                          .comp                 (cache_compare),
                          .write                (cache_write),
                          .valid_in             (1'b1));

   four_bank_mem mem(// Outputs
                     .data_out          (mem_data),
                     .stall             (mem_stall),
                     .busy              (mem_busy),
                     .err               (err),
                     // Inputs
                     .clk               (clk),
                     .rst               (rst),
                     .createdump        (createdump),
                     .addr              (Addr),
                     .data_in           (DataIn),
                     .wr                (memory_write),
                     .rd                (memory_read));

   
   // your code here

   
  parameter  IDLE = 3'b000, COMP_READ = 3'b001, MEM_READ = 3'b010, MEM_READ_STALL = 3'b011, ACCESS_WRITE = 3'b100, COMP_WRITE = 3'b101, MEM_WRITE = 3'b110, MEM_WRITE_STALL = 3'b111;
   assign tag = Addr[15:11];
   assign index = Addr[10:3];
   assign offset = Addr[2:0];
   assign mystate = state;
   assign mystate_n = next_state;
   assign CacheHit = hit;
   assign Stall = mem_stall;
   assign Done = cache_done;
   reg3 state_reg(.clk(clk), .rst(rst), .en(1'b1), .D(mystate_n), .Q(mystate));
   always @(*) begin 
    cache_compare = 0;
    cache_write = 0;
    memory_read = 0;
    memory_write = 0;
    cache_done = 0;
    case(state)
      IDLE:  
        next_state = Rd? COMP_READ : Wr? COMP_WRITE : IDLE;
      COMP_READ: begin 
        cache_compare = 1;
        cache_write = 0;
        next_state = (hit&valid)? IDLE : MEM_READ; //TODO: valid?
      end
      MEM_READ: begin 
        memory_read = 1;
        next_state = MEM_READ_STALL;
      end
      MEM_READ_STALL: 
        next_state = mem_stall? MEM_READ_STALL : ACCESS_WRITE;
      ACCESS_WRITE: begin 
        cache_write = 1;
        next_state = IDLE;
        cache_done = 1;
      end
      COMP_WRITE: begin 
        cache_write = 1;
        cache_compare = 1;
        next_state = MEM_WRITE;
      end
      MEM_WRITE: begin 
        memory_write = 1;
        next_state = MEM_WRITE_STALL;
      end
      MEM_WRITE_STALL: begin 
        next_state = mem_stall? MEM_WRITE_STALL : IDLE;
        cache_done = 1;
      end
      default: next_state = IDLE;
    endcase // state
  end
   
endmodule // mem_system

// DUMMY LINE FOR REV CONTROL :9:
