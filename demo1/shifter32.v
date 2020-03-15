/*
    CS/ECE 552 Spring '20
    Homework #2, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the Op() value that is passed in (2 bit number).  It uses these
    shifts to shift the value any number of bits between 0 and 15 bits.
 */
module shifter32 (In, Cnt, shft_left, log_right);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 32;
   parameter   C = 5;
   parameter   O = 2;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   //input [O-1:0]   Op;
   //output[N-1:0]  Out;


   output reg [N-1:0] shft_left, log_right;
   wire [N-1:0] rot_left;
   wire [N-1:0] int_arith_right, arith_right;
// Start

   // OP CODES
   // 00 - Rotate left 
   // 01 - Shift left
   // 10 - Shift right arith
   // 11 - Shift right log

always @ (*)
 begin
   // Just be explicit
   case (Cnt[C-1:0])
	   5'b00000: begin shft_left[31:0] <= In; log_right[31:0] <= In; end
	   5'b00001: begin shft_left[31:0]  <= {In[30:0], 1'b0}; log_right[31:0] <= {1'b0, In[31:1]}; end
	5'b00010: begin shft_left[31:0]  <= {In[29:0], {2{1'b0}}}; log_right[31:0] <= {{2{1'b0}}, In[31:2]}; end
	5'b00011: begin shft_left[31:0]  <= {In[28:0], {3{1'b0}}}; log_right[31:0] <= {{3{1'b0}}, In[31:3]}; end
	5'b00100: begin shft_left[31:0] <= {In[27:0], {4{1'b0}}}; log_right[31:0] <= {{4{1'b0}}, In[31:4]}; end
	5'b00101: begin shft_left[31:0] <= {In[26:0], {5{1'b0}}}; log_right[31:0] <= {{5{1'b0}}, In[31:5]}; end
	5'b00110: begin shft_left[31:0] <= {In[25:0], {6{1'b0}}}; log_right[31:0] <= {{6{1'b0}}, In[31:6]}; end
	5'b00111: begin shft_left[31:0] <= {In[24:0], {7{1'b0}}}; log_right[31:0] <= {{7{1'b0}}, In[31:7]}; end
	5'b01000: begin shft_left[31:0] <= {In[23:0], {8{1'b0}}}; log_right[31:0] <= {{8{1'b0}}, In[31:8]}; end
	5'b01001: begin shft_left[31:0] <= {In[22:0], {9{1'b0}}}; log_right[31:0] <= {{9{1'b0}}, In[31:9]}; end
	5'b01010: begin shft_left[31:0] <= {In[21:0], {10{1'b0}}}; log_right[31:0] <= {{10{1'b0}}, In[31:10]}; end
	5'b01011: begin shft_left[31:0] <= {In[20:0], {11{1'b0}}}; log_right[31:0] <= {{11{1'b0}}, In[31:11]}; end
	5'b01100: begin shft_left[31:0] <= {In[19:0], {12{1'b0}}}; log_right[31:0] <= {{12{1'b0}}, In[31:12]}; end
	5'b01101: begin shft_left[31:0] <= {In[18:0], {13{1'b0}}}; log_right[31:0] <= {{13{1'b0}}, In[31:13]}; end
	5'b01110: begin shft_left[31:0] <= {In[17:0], {14{1'b0}}}; log_right[31:0] <= {{14{1'b0}}, In[31:14]}; end
	5'b01111: begin shft_left[31:0] <= {In[16:0], {15{1'b0}}}; log_right[31:0] <= {{15{1'b0}}, In[31:15]}; end
        5'b10000: begin shft_left[31:0] <= {In[15:0], {16{1'b0}}}; log_right[31:0] <= {{16{1'b0}}, In[31:16]}; end
	default: begin shft_left[31:0] <= 4'hFFFF; log_right[31:0] <= 4'hFFFF; end
  endcase
end


   //assign Out[N-1:0] = Op[1] ? (Op[0] ? (log_right[N-1:0]) : (arith_right[N-1:0]) ) : (Op[0] ? (shft_left[N-1:0]) : (rot_left[N-1:0]) );

endmodule
