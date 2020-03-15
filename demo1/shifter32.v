/*
    CS/ECE 552 Spring '20
    Homework #2, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the Op() value that is passed in (2 bit number).  It uses these
    shifts to shift the value any number of bits between 0 and 15 bits.
 */
module shifter32 (In, Cnt, Op, Out);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 32;
   parameter   C = 4;
   parameter   O = 2;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   input [O-1:0]   Op;
   output[N-1:0]  Out;


   wire [N-1:0] shft_left, log_right;
   reg [N-1:0] rot_left;
   wire signed [N-1:0] int_arith_right, arith_right;
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
	4'b0000: rot_left[N-1:0] = In[N-1:0];
	4'b0001: rot_left[N-1:0] = {In[N-1-1:0], In[N-1]};	
	4'b0010: rot_left[N-1:0] = {In[N-1-2:0], In[N-1:14]};
	4'b0011: rot_left[N-1:0] = {In[N-1-3:0], In[N-1:13]};
	4'b0100: rot_left[N-1:0] = {In[N-1-4:0], In[N-1:12]};
	4'b0101: rot_left[N-1:0] = {In[N-1-5:0], In[N-1:11]};
	4'b0110: rot_left[N-1:0] = {In[N-1-6:0], In[N-1:10]};
	4'b0111: rot_left[N-1:0] = {In[N-1-7:0], In[N-1:9]};
	4'b1000: rot_left[N-1:0] = {In[N-1-8:0], In[N-1:8]};
	4'b1001: rot_left[N-1:0] = {In[N-1-9:0], In[N-1:7]};
	4'b1010: rot_left[N-1:0] = {In[N-1-10:0], In[N-1:6]};
	4'b1011: rot_left[N-1:0] = {In[N-1-11:0],In[N-1:5]};
	4'b1100: rot_left[N-1:0] = {In[N-1-12:0],In[N-1:4]};
	4'b1101: rot_left[N-1:0] = {In[N-1-13:0],In[N-1:3]};
	4'b1110: rot_left[N-1:0] = {In[N-1-14:0],In[N-1:2]};
	4'b1111: rot_left[N-1:0] = {In[0],In[N-1:1]};
   endcase
end

   // Have to assign to a signed variable before the shift
   assign int_arith_right = In;

   assign shft_left[N-1:0] = In <<< Cnt;
   assign arith_right[N-1:0] = int_arith_right >>> Cnt;
   assign log_right[N-1:0] = In >> Cnt;

   assign Out[N-1:0] = Op[1] ? (Op[0] ? (log_right[N-1:0]) : (arith_right[N-1:0]) ) : (Op[0] ? (shft_left[N-1:0]) : (rot_left[N-1:0]) );

endmodule
