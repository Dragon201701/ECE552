module controller (
	// system input
	Addr, DataIn, Rd, Wr, clk, rst, 
	// system output
	DataOut, Done, Stall, CacheHit, err,

	// c0 input
	c0_en, c0_tag_in, c0_index, c0_offset, c0_data_in, c0_compare, c0_write, c0_valid_in, 
	// c0 output
	c0_tag_out, c0_data_out, c0_hit, c0_dirty, c0_valid_out,

	// c1 input
	c1_en, c1_tag_in, c1_index, c1_offset, c1_data_in, c1_compare, c1_write, c1_valid_in, 
	// c1 output
	c1_tag_out, c1_data_out, c1_hit, c1_dirty, c1_valid_out, 

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

	
	input [4:0] c0_tag_out;
	input [15:0]	c0_data_out;
	input c0_hit, c0_dirty, c0_valid_out;

	output c0_en, c0_write, c0_compare, c0_valid_in;
	output [4:0] c0_tag_in;
	output [7:0] c0_index;
	output [2:0] c0_offset;
	output [15:0] c0_data_in;



	input [4:0] c1_tag_out;
	input [15:0]	c1_data_out;
	input c1_hit, c1_dirty, c1_valid_out;

	output c1_en, c1_write, c1_compare, c1_valid_in;
	output [4:0] c1_tag_in;
	output [7:0] c1_index;
	output [2:0] c1_offset;
	output [15:0] c1_data_in;


	input [15:0] mem_data_out;
	input mem_stall;
	input [3:0] mem_busy;

	output [15:0] mem_addr, mem_data_in;
	output mem_read, mem_write;

	parameter  IDLE = 4'h0, COMP_READ = 4'h1, MEM_READ = 4'h2, MEM_READ_STALL = 4'h3, ACCESS_WRITE = 4'h4, COMP_WRITE = 4'h5, MEM_WRITE_0 = 4'h6, MEM_WRITE_1 = 4'h7, MEM_WRITE_2 = 4'h8, MEM_WRITE_3 = 4'h9,
            ACCESS_READ = 4'ha, EVICT_WRITE_0 = 4'hb, EVICT_WRITE_1 = 4'hc, EVICT_WRITE_2 = 4'hd, EVICT_WRITE_3 = 4'he;


	wire [3:0] mem_read_count, evict_write_count, mystate, mystate_n;
	wire 		write, read, c0_hit_signal, c1_hit_signal, complete, evict_complete, c0_dirty_signal, c1_dirty_signal, c0_valid_out_signal, c1_valid_out_signal, 
				victim, victim_cache_dirty, victim_cache_dirty_signal, victimway_en;
	wire [15:0] c0_data_out_reg, c1_data_out_reg, mem_data_out_reg, data_out_reg_out;
	reg [15:0] cache_addr, mem_addr_reg, DataOut_reg, mem_data_in_reg;
	reg   [3:0] state, next_state;
	reg c0_status_en, c1_status_en, c0_compare_reg, c1_compare_reg, memory_read_reg, memory_write_reg, c0_write_reg, c1_write_reg, cache_status_en, mem_read_count_en, mem_read_count_clear, input_reg, data_out_reg_en,
	c0_data_en, c1_data_en, mem_data_available, sys_stall, cache_done, c0_en_reg, c1_en_reg, evict_write_count_en, evict_write_cout_clear, c0_valid_in_reg, c1_valid_in_reg, cache_way;

	assign c0_data_in = (((c0_write_reg & ~c0_compare_reg)|(c1_write_reg & ~c1_compare_reg))&(mem_read_count != 4'h0))?mem_data_out:DataIn;
	assign c1_data_in = (((c0_write_reg & ~c0_compare_reg)|(c1_write_reg & ~c1_compare_reg))&(mem_read_count != 4'h0))?mem_data_out:DataIn;
	assign c0_tag_in = cache_addr[15:11];
    assign c0_index = cache_addr[10:3];
    assign c0_offset = cache_addr[2:0];
    assign c1_tag_in = cache_addr[15:11];
    assign c1_index = cache_addr[10:3];
    assign c1_offset = cache_addr[2:0];
    assign CacheHit = ((c0_hit & c0_valid_out)|(c1_hit & c1_valid_out)) & (state == COMP_READ | state == COMP_WRITE);
    assign mystate_n = next_state;
    assign mem_addr = mem_addr_reg;
    assign c0_compare = c0_compare_reg;
    assign c1_compare = c1_compare_reg;
    assign mem_read = memory_read_reg;
    assign mem_write = memory_write_reg;
    assign c0_write = c0_write_reg;
    assign c1_write = c1_write_reg;
    assign DataOut = DataOut_reg;
    assign complete = (mem_read_count == 4'h4)?1:0;
    assign evict_complete = (evict_write_count == 4'h4); 
    assign Stall = sys_stall;
    assign Done = cache_done;
    assign c0_en = c0_en_reg;
    assign c1_en = c1_en_reg;
    assign mem_data_in = mem_data_in_reg;
    assign c0_valid_in = c0_valid_in_reg;
    assign c1_valid_in = c1_valid_in_reg;
    assign victim_cache_dirty = victim? c1_dirty:c0_dirty;
    assign victimway_en = state == IDLE;
	reg4 state_reg(.clk(clk), .rst(rst), .en(1'b1), .D(mystate_n), .Q(mystate));

	reg1 write_reg(.clk(clk), .rst(rst), .en(input_reg), .D(Wr), .Q(write));
    reg1 read_reg(.clk(clk), .rst(rst), .en(input_reg), .D(Rd), .Q(read));

    reg16 data_out_reg(.clk(clk), .rst(rst), .en (data_out_reg_en), .D  (DataOut_reg), .Q  (data_out_reg_out));

    reg1 c0hitreg(.clk(clk), .rst(rst), .en(c0_status_en), .D(c0_hit), .Q(c0_hit_signal));
    reg1 c0dirtyreg(.clk(clk), .rst(rst), .en(c0_status_en), .D(c0_dirty), .Q(c0_dirty_signal));
    reg1 c1hitreg(.clk(clk), .rst(rst), .en(c1_status_en), .D(c1_hit), .Q(c1_hit_signal));
    reg1 c1dirtyreg(.clk(clk), .rst(rst), .en(c1_status_en), .D(c1_dirty), .Q(c1_dirty_signal));
    reg1 c0validoutreg(.clk(clk), .rst(rst), .en(c0_status_en), .D(c0_valid_out), .Q(c0_valid_out_signal));
    reg1 c1validoutreg(.clk(clk), .rst(rst), .en(c1_status_en), .D(c1_valid_out), .Q(c1_valid_out_signal));

    reg16 c0_data_reg(.clk(clk), .rst(rst), .en (c0_data_en), .D  (c0_data_out), .Q  (c0_data_out_reg));
    reg16 c1_data_reg(.clk(clk), .rst(rst), .en (c1_data_en), .D  (c1_data_out), .Q  (c1_data_out_reg));

    reg16 mem_data_reg(.clk(clk), .rst(rst), .en(mem_data_available), .D(mem_data_out), .Q(mem_data_out_reg));

	count_4b mem_read_counter(.clk(clk), .rst(rst), .en(mem_read_count_en), .clear(mem_read_count_clear), .cnt_o(mem_read_count));
	count_4b evict_write_counter(.clk(clk), .rst(rst), .en(evict_write_count_en), .clear(evict_write_cout_clear), .cnt_o(evict_write_count));
	
	victimway victimwayff(.clk    (clk), .rst    (rst), .en(victimway_en), .trigger(Rd|Wr), .out(victim));
	reg1 victimcachedirtyreg(.clk(clk), .rst(rst), .en (c0_status_en|c1_status_en), .D(victim_cache_dirty), .Q(victim_cache_dirty_signal));
    always @(*) begin
    	//state
	    state = mystate; 

	    c0_compare_reg = 0;
	    c0_write_reg = 0;
	    c1_compare_reg = 0;
	    c1_write_reg = 0;

	    memory_read_reg = 0;
	    memory_write_reg = 0;

	    cache_status_en = 0;

	    c0_en_reg = 0;
	    c1_en_reg = 0;

	    cache_done = 0;
	    sys_stall = 1;
	    input_reg = 0;
	    mem_read_count_en = 0;
	    mem_read_count_clear = 0;
	    mem_data_available = 0;

	    c0_data_en = 0;
	    c1_data_en = 0;

	    data_out_reg_en = 0;

	    evict_write_count_en = 0;
	    evict_write_cout_clear = 0;

	    c0_valid_in_reg = 0;
	    c1_valid_in_reg = 0;

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

	        c0_en_reg = 1;
	        c1_en_reg = 1;
	        c0_compare_reg = 1;
	        c0_write_reg = 0;
	        c1_compare_reg = 1;
	        c1_write_reg = 0;

	        next_state = ((c0_hit&c0_valid_out)|(c1_hit&c1_valid_out))? IDLE:
	        			(c0_valid_out&c1_valid_out&victim_cache_dirty)?ACCESS_READ:MEM_READ;

	        cache_way = (~c0_valid_out&~c1_valid_out)? 0:
	        			(c0_valid_out&~c1_valid_out)? 1:
	        			(~c0_valid_out&c1_valid_out)? 0:
	        			victim;

	        cache_done = ((c0_hit&c0_valid_out)|(c1_hit&c1_valid_out))? 1:0;
	        //cache_status_en = 1;
	        c0_status_en = 1;
	        c1_status_en = 1;


	        mem_data_available = 0;
	        //cache_data_en = 1;
	        data_out_reg_en = ((c0_hit&c0_valid_out)|(c1_hit&c1_valid_out));
	        DataOut_reg =(c0_hit&c0_valid_out)? c0_data_out :
	        			 (c1_hit&c1_valid_out)? c1_data_out : 16'h0000;
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
	        //cache_en_reg = 1;
	        c0_en_reg = ~cache_way;
	        c1_en_reg = cache_way;

	        //cache_write_reg = 1;
	        c0_write_reg = 1;
	        c1_write_reg = 1;



	        cache_done = complete;
	        next_state = complete?IDLE:MEM_READ;
	        //mem_data_available = (read&Addr == mem_addr)?1:0;
	        data_out_reg_en = (read& (Addr == mem_addr))?1:0;
	        DataOut_reg = (read& (Addr == mem_addr))?mem_data_out:data_out_reg_out;
	        c0_valid_in_reg = complete&~victim;
	        c1_valid_in_reg = complete&victim;
	      end

	      COMP_WRITE: begin 
	        cache_addr = Addr;
	        //cache_en_reg = 1;
	        c0_en_reg = 1;
	        c1_en_reg = 1;

	        //cache_write_reg = 1;
	        c0_write_reg = 1;
	        c1_write_reg = 1;

	        //cache_compare_reg = 1;
	        c0_compare_reg = 1;
	        c1_compare_reg = 1;


	        next_state =  ((c0_hit&c0_valid_out)|(c1_hit&c1_valid_out))? IDLE: MEM_WRITE_0;
	        //cache_status_en = 1;
	        c0_status_en = 1;
	        c1_status_en = 1;

	        mem_addr_reg = Addr;
	        cache_done = ((c0_hit&c0_valid_out)|(c1_hit&c1_valid_out));
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

	        //next_state = (cache_dirty_signal&cache_valid_out)?ACCESS_READ:MEM_READ;
	        next_state = (c0_valid_out_signal&c1_valid_out_signal&victim_cache_dirty_signal)?ACCESS_READ:MEM_READ;

	        cache_way = (~c0_valid_out&~c1_valid_out)? 0:
	        			(c0_valid_out&~c1_valid_out)? 1:
	        			(~c0_valid_out&c1_valid_out)? 0:
	        			victim;

	        mem_read_count_clear = next_state == MEM_READ?1:0;
	        //mem_data_available = ~mem_stall;
	        //cache_done = 1;
	      end
	      ACCESS_READ: begin 
	      	//cache_en_reg = 1;
	      	c0_en_reg = ~cache_way;
	      	c1_en_reg = cache_way;


	      	cache_addr = {Addr[15:3], evict_write_count[1:0], 1'b0};
	      	mem_addr_reg = {cache_way?c1_tag_out:c0_tag_out, cache_way?c1_index:c0_index, evict_write_count[1:0], 1'b0};
	      	mem_data_in_reg = victim? c1_data_out:c0_data_out;
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