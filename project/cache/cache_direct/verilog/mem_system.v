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


   wire   [15:0]  mem_data, mem_data_out, cache_data, cache_data_reg_out;
   wire   [4:0] tag, tag_out;
   wire   [10:3]  index;
   wire   [2:0] offset;
   reg    [15:0]  mem_addr, DataOut_reg;
   reg   [3:0] state, next_state;
   reg   cache_compare, cache_write,  memory_read, memory_write, cache_done, cache_en, input_reg, cache_status_en, sys_stall, mem_data_available, cache_data_en;
   wire   [3:0] mystate, mystate_n;

   wire   [3:0] mem_read_count;
   reg         mem_read_count_en, mem_read_count_clear;
   count_4b mem_read_counter(.clk(clk), .rst(rst), .en(mem_read_count_en), .clear(mem_read_count_clear), .cnt_o(mem_read_count));
   wire   valid, dirty, cache_hit, stall, cache_err, mem_err, mem_busy, mem_stall, complete;
   wire   write, read, cache_hit_signal;


   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter memtype = 0;
   cache #(0 + memtype) c0(// Outputs
                          .tag_out              (),
                          .data_out             (cache_data),
                          .hit                  (cache_hit),
                          .dirty                (dirty),
                          .valid                (valid),
                          .err                  (cache_err),
                          // Inputs
                          .enable               (cache_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (tag),
                          .index                (index),
                          .offset               (offset),
                          .data_in              ((cache_write & ~cache_compare&(mem_read_count != 4'h0))?mem_data:DataIn),
                          .comp                 (cache_compare),
                          .write                (cache_write),
                          .valid_in             (1'b1));

   four_bank_mem mem(// Outputs
                     .data_out          (mem_data),
                     .stall             (mem_stall),
                     .busy              (mem_busy),
                     .err               (mem_err),
                     // Inputs
                     .clk               (clk),
                     .rst               (rst),
                     .createdump        (createdump),
                     .addr              (Addr),
                     .data_in           (DataIn),
                     .wr                (memory_write),
                     .rd                (memory_read));

   
   // your code here

   
  parameter  IDLE = 4'h0, COMP_READ = 4'h1, MEM_READ = 4'h2, MEM_READ_STALL = 4'h3, ACCESS_WRITE = 4'h4, COMP_WRITE = 4'h5, MEM_WRITE_0 = 4'h6, MEM_WRITE_1 = 4'h7, MEM_WRITE_2 = 4'h8, MEM_WRITE_3 = 4'h9;
   assign tag = Addr[15:11];
   assign index = Addr[10:3];
   assign offset = Addr[2:0];
   //assign mystate = state;
   assign mystate_n = next_state;
   assign CacheHit = cache_hit & state == COMP_READ;
   assign Stall = sys_stall;
   assign Done = cache_done;
   assign complete = (mem_read_count == 4'h4)?1:0;
   assign DataOut = DataOut_reg;
   assign err = cache_err | mem_err;
   reg1 write_reg(.clk(clk), .rst(rst), .en(input_reg), .D(Wr), .Q(write));
   reg1 read_reg(.clk(clk), .rst(rst), .en(input_reg), .D(Rd), .Q(read));
   reg1 cachehitreg(.clk(clk), .rst(rst), .en(cache_status_en), .D(cache_hit), .Q(cache_hit_signal));
   reg4 state_reg(.clk(clk), .rst(rst), .en(1'b1), .D(mystate_n), .Q(mystate));
   reg16 mem_data_reg(.clk(clk), .rst(rst), .en(mem_data_available), .D(mem_data), .Q(mem_data_out));
   reg16 cache_data_reg(.clk(clk), .rst(rst), .en (cache_data_en), .D  (cache_data), .Q  (cache_data_reg_out));
   always @(*) begin
    state = mystate; 
    cache_compare = 0;
    cache_write = 0;
    memory_read = 0;
    memory_write = 0;
    cache_status_en = 0;
    cache_en = 0;
    cache_done = 0;
    mem_addr = Addr;
    sys_stall = 1;
    input_reg = 0;
    mem_read_count_en = 0;
    mem_read_count_clear = 0;
    cache_data_en = 0;
    DataOut_reg = 16'h0;
    case(state)
      IDLE: begin
        sys_stall = 0;
        input_reg = 1;
        next_state = Rd? COMP_READ : Wr? COMP_WRITE : IDLE;
        DataOut_reg = cache_data_reg_out;
      end
      COMP_READ: begin 
        mem_read_count_clear = 1;
        cache_en = 1;
        cache_compare = 1;
        cache_write = 0;
        //next_state = (Rd&cache_hit&valid)? IDLE:((Rd&~cache_hit)|(Rd&cache_hit&~valid))? MEM_READ : Wr? COMP_WRITE : COMP_READ;
        next_state = (cache_hit&valid)? IDLE:MEM_READ;
        cache_done = (cache_hit&valid)? 1:0;
        cache_status_en = 1;
        mem_data_available = 0;
        cache_data_en = 1;
        DataOut_reg = cache_data;
      end
      MEM_READ: begin 
        
        mem_addr = {Addr[15:2], mem_read_count[1:0]};
        memory_read = 1;
        next_state = MEM_READ_STALL;
      end
      MEM_READ_STALL: begin
        mem_read_count_en = 1;
        next_state = mem_stall? MEM_READ_STALL : ACCESS_WRITE;
      end
      ACCESS_WRITE: begin 
        cache_en = 1;
        cache_write = 1;
        cache_done = complete | (write&cache_hit_signal);
        next_state = (complete | (write&cache_hit_signal))?IDLE:MEM_READ;
      end
      COMP_WRITE: begin 
        cache_en = 1;
        cache_write = 1;
        cache_compare = 1;
        next_state = MEM_WRITE_0;
        cache_status_en = 1;
      end
      MEM_WRITE_0: begin 
        memory_write = 1;
        next_state = MEM_WRITE_1;
      end
      MEM_WRITE_1: begin
        memory_write = 1;
        next_state = MEM_WRITE_2;
      end
      MEM_WRITE_2: begin 
        memory_write = 1;
        next_state = MEM_WRITE_3;
      end
      MEM_WRITE_3: begin 
        memory_write = 1;
        next_state = (write&cache_hit_signal)?ACCESS_WRITE:MEM_READ;
        mem_read_count_clear = next_state == MEM_READ?1:0;
        //mem_data_available = ~mem_stall;
        //cache_done = 1;
      end
      default: next_state = IDLE;
    endcase // state
  end
   
endmodule // mem_system

// DUMMY LINE FOR REV CONTROL :9:
