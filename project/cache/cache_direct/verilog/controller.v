module controller (
	// system input
	Addr, DataIn, Rd, Wr, clk, rst, 
	// system output
	DataOut, Done, Stall, CacheHit, err,

	// cache input
	cache_en, cache_tag_in, cache_index, cache_offset, cache_data_in, cache_compare, cache_write, cache_valid_in, 
	// cache output
	cache_tag_out, cache_data_out, cache_hit, cache_dirty, cache_valid_out, 

	// memory input
	mem_addr, mem_data_in, mem_write, mem_read, 
	// memory output
	mem_data_out, mem_stall, mem_busy);
	
	input [15:0] Addr;
   	input [15:0] DataIn;
	input        Rd;
	input        Wr;
	input        clk;
	input        rst;

	output [15:0] DataOut;
	output Done;
	output Stall;
	output CacheHit;
	output err;

	
	input [4:0] cache_tag_out;
	input [15:0]	cache_data_out;
	input cache_hit, cache_dirty, cache_valid_out;

	output cache_en, cache_write, cache_compare, cache_valid_in;
	output [4:0] cache_tag_in;
	output [7:0] cache_index;
	output [2:0] cache_offset;
	output [15:0] cache_data_in;


	input [15:0] mem_data_out;
	input mem_stall;
	input [3:0] mem_busy;

	output [15:0] mem_addr, mem_data_in;
	output mem_read, mem_write;

	parameter  IDLE = 4'h0, COMP_READ = 4'h1, MEM_READ = 4'h2, MEM_READ_STALL = 4'h3, ACCESS_WRITE = 4'h4, COMP_WRITE = 4'h5, MEM_WRITE_0 = 4'h6, MEM_WRITE_1 = 4'h7, MEM_WRITE_2 = 4'h8, MEM_WRITE_3 = 4'h9,
            ACCESS_READ = 4'ha, EVICT_WRITE_0 = 4'hb, EVICT_WRITE_1 = 4'hc, EVICT_WRITE_2 = 4'hd, EVICT_WRITE_3 = 4'he;


	wire [3:0] mem_read_count, evict_write_count, mystate, mystate_n;
	wire 		write, read, cache_hit_signal, complete, evict_complete, cache_dirty_signal;
	wire [15:0] cache_data_out_reg, mem_data_out_reg, data_out_reg_out;
	reg [15:0] cache_addr, mem_addr_reg, DataOut_reg, mem_data_in_reg;
	reg   [3:0] state, next_state;
	reg cache_compare_reg, memory_read_reg, memory_write_reg, cache_write_reg, cache_status_en, mem_read_count_en, mem_read_count_clear, input_reg, data_out_reg_en,
	cache_data_en, mem_data_available, sys_stall, cache_done, cache_en_reg, evict_write_count_en, evict_write_cout_clear, cache_valid_in_reg;

	assign cache_data_in = (cache_write_reg & ~cache_compare_reg&(mem_read_count != 4'h0))?mem_data_out:DataIn;
	assign cache_tag_in = cache_addr[15:11];
    assign cache_index = cache_addr[10:3];
    assign cache_offset = cache_addr[2:0];
    assign CacheHit = cache_hit & cache_valid_out & (state == COMP_READ | state == COMP_WRITE);
    assign mystate_n = next_state;
    assign mem_addr = mem_addr_reg;
    assign cache_compare = cache_compare_reg;
    assign mem_read = memory_read_reg;
    assign mem_write = memory_write_reg;
    assign cache_write = cache_write_reg;
    assign DataOut = DataOut_reg;
    assign complete = (mem_read_count == 4'h4)?1:0;
    assign evict_complete = (evict_write_count == 4'h4); 
    assign Stall = sys_stall;
    assign Done = cache_done;
    assign cache_en = cache_en_reg;
    assign mem_data_in = mem_data_in_reg;
    assign cache_valid_in = cache_valid_in_reg;
	reg4 state_reg(.clk(clk), .rst(rst), .en(1'b1), .D(mystate_n), .Q(mystate));

	reg1 write_reg(.clk(clk), .rst(rst), .en(input_reg), .D(Wr), .Q(write));
    reg1 read_reg(.clk(clk), .rst(rst), .en(input_reg), .D(Rd), .Q(read));
    reg16 data_out_reg(.clk(clk), .rst(rst), .en (data_out_reg_en), .D  (DataOut_reg), .Q  (data_out_reg_out));
    reg1 cachehitreg(.clk(clk), .rst(rst), .en(cache_status_en), .D(cache_hit), .Q(cache_hit_signal));
    reg1 cachedirtyreg(.clk(clk), .rst(rst), .en(cache_status_en), .D(cache_dirty), .Q(cache_dirty_signal));
    reg16 cache_data_reg(.clk(clk), .rst(rst), .en (cache_data_en), .D  (cache_data_out), .Q  (cache_data_out_reg));
    reg16 mem_data_reg(.clk(clk), .rst(rst), .en(mem_data_available), .D(mem_data_out), .Q(mem_data_out_reg));
	count_4b mem_read_counter(.clk(clk), .rst(rst), .en(mem_read_count_en), .clear(mem_read_count_clear), .cnt_o(mem_read_count));
	count_4b evict_write_counter(.clk(clk), .rst(rst), .en(evict_write_count_en), .clear(evict_write_cout_clear), .cnt_o(evict_write_count));
	

    always @(*) begin
    	//state
	    state = mystate; 
	    cache_compare_reg = 0;
	    cache_write_reg = 0;
	    memory_read_reg = 0;
	    memory_write_reg = 0;
	    cache_status_en = 0;
	    cache_en_reg = 0;
	    cache_done = 0;
	    //mem_addr = Addr;
	    sys_stall = 1;
	    input_reg = 0;
	    mem_read_count_en = 0;
	    mem_read_count_clear = 0;
	    mem_data_available = 0;
	    cache_data_en = 0;
	    data_out_reg_en = 0;
	    //cache_addr = 16'h0000;
	    evict_write_count_en = 0;
	    evict_write_cout_clear = 0;
	    cache_valid_in_reg = 0;
	    case(state)
	      IDLE: begin
	        sys_stall = 0;
	        input_reg = 1;
	        next_state = Rd? COMP_READ : Wr? COMP_WRITE : IDLE;
	        mem_read_count_clear = 1;
	        evict_write_cout_clear = 1;
	        //DataOut_reg = cache_data_reg_out;
	        DataOut_reg = data_out_reg_out;
	      end
	      COMP_READ: begin 
	        cache_addr = Addr;
	        cache_en_reg = 1;
	        cache_compare_reg = 1;
	        cache_write_reg = 0;
	        //next_state = (Rd&cache_hit&valid)? IDLE:((Rd&~cache_hit)|(Rd&cache_hit&~valid))? MEM_READ : Wr? COMP_WRITE : COMP_READ;
	        next_state = (cache_hit&cache_valid_out)? IDLE:cache_dirty?ACCESS_READ:MEM_READ;
	        cache_done = (cache_hit&cache_valid_out)? 1:0;
	        cache_status_en = 1;
	        mem_data_available = 0;
	        //cache_data_en = 1;
	        data_out_reg_en = (cache_hit&cache_valid_out);
	        DataOut_reg = (cache_hit&cache_valid_out)? cache_data_out : 16'h0000;
	      end
	      MEM_READ: begin 
	        
	        mem_addr_reg = {Addr[15:3], mem_read_count[1:0], 1'b0};
	        cache_addr = mem_addr;
	        memory_read_reg = 1;
	        next_state = MEM_READ_STALL;
	      end
	      MEM_READ_STALL: begin
	        mem_read_count_en = 1;
	        //memory_read_reg = 1;
	        next_state = mem_stall? MEM_READ_STALL : ACCESS_WRITE;
	      end
	      ACCESS_WRITE: begin 
	        cache_en_reg = 1;
	        cache_write_reg = 1;
	        cache_done = complete;
	        next_state = complete?IDLE:MEM_READ;
	        //mem_data_available = (read&Addr == mem_addr)?1:0;
	        data_out_reg_en = (read& (Addr == mem_addr))?1:0;
	        DataOut_reg = (read& (Addr == mem_addr))?mem_data_out:data_out_reg_out;
	        cache_valid_in_reg = complete;
	      end
	      COMP_WRITE: begin 
	        cache_addr = Addr;
	        cache_en_reg = 1;
	        cache_write_reg = 1;
	        cache_compare_reg = 1;
	        next_state = (cache_hit&cache_valid_out)?IDLE: MEM_WRITE_0;
	        cache_status_en = 1;
	        mem_addr_reg = Addr;
	        cache_done = cache_hit&cache_valid_out;
	        mem_data_in_reg = DataIn;
	      end
	      MEM_WRITE_0: begin 

	        memory_write_reg = 1;
	        next_state = MEM_WRITE_1;
	      end
	      MEM_WRITE_1: begin
	        memory_write_reg = 1;
	        next_state = MEM_WRITE_2;
	      end
	      MEM_WRITE_2: begin 
	        memory_write_reg = 1;
	        next_state = MEM_WRITE_3;
	      end
	      MEM_WRITE_3: begin 
	        memory_write_reg = 1;
	        next_state = (cache_dirty_signal&cache_valid_out)?ACCESS_READ:MEM_READ;
	        mem_read_count_clear = next_state == MEM_READ?1:0;
	        //mem_data_available = ~mem_stall;
	        //cache_done = 1;
	      end
	      ACCESS_READ: begin 
	      	cache_en_reg = 1;
	      	cache_compare_reg = 0;
	      	cache_write_reg = 0;
	      	cache_addr = {Addr[15:3], evict_write_count[1:0], 1'b0};
	      	mem_addr_reg = {cache_tag_out, cache_index, evict_write_count[1:0], 1'b0};
	      	mem_data_in_reg = cache_data_out;
	      	evict_write_count_en = ~evict_complete;
	      	memory_write_reg = ~evict_complete;
	      	next_state = evict_complete?MEM_READ:ACCESS_READ;
	      	mem_read_count_clear = next_state == MEM_READ;
	      end
	      /*EVICT_WRITE_0: begin
	      	memory_write_reg = 1;
	      	next_state = EVICT_WRITE_1;
	      end
	      EVICT_WRITE_1: begin
	      	memory_write_reg = 1;
	      	evict_write_count_en = 1;
	      	next_state = EVICT_WRITE_2;
	      end
	      EVICT_WRITE_2: begin
	      	memory_write_reg = 1;
	      	next_state = EVICT_WRITE_3;
	      end
	      EVICT_WRITE_3: begin
	      	memory_write_reg = 1;
	      	next_state = evict_complete? MEM_READ:ACCESS_READ;
	      	mem_read_count_clear = next_state == MEM_READ;
	      end*/
	      default: next_state = IDLE;
	    endcase // state
  	end

endmodule