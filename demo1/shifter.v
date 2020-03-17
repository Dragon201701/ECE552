/*
    CS/ECE 552 Spring '20
    Homework #2, Problem 1
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the Op() value that is passed in (2 bit number).  It uses these
    shifts to shift the value any number of bits between 0 and 15 bits.
 */
module shifter (In, Cnt, Op, Out);

   // declare constant for size of inputs, outputs (N) and # bits to shift (C)
   parameter   N = 16;
   parameter   C = 4;
   parameter   O = 2;

   input [N-1:0]   In;
   input [C-1:0]   Cnt;
   input [O-1:0]   Op;
   output [N-1:0]  Out;

   /* YOUR CODE HERE */
   /*
    Opcode - Operation
    00  Rotate Left
    01  Shift Left
    10  Shift right arithmetic
    11  Shift right logical
	  */

    wire [N-1:0] out_stage1, out_stage2, out_stage3;
    assign out_stage1 = (Cnt[0] == 1)? (Op[1] == 0)? {In[N-2:0], (Op[0] == 0)? In[N-1]:1'b0}:
                                                     {(Op[0] == 0)? In[N-1]:0, In[N-1:1]}:In;
    assign out_stage2 = (Cnt[1] == 1)? (Op[1] == 0)? {out_stage1[N-3:0], (Op[0] == 0)? out_stage1[N-1:N-2]:2'b0}: 
                                                     {(Op[0] == 0)? {out_stage1[N-1], out_stage1[N-1]}:2'b00, out_stage1[N-1:2]}:out_stage1;
    assign out_stage3 = (Cnt[2] == 1)? (Op[1] == 0)? {out_stage2[N-5:0], (Op[0] == 0)? out_stage2[N-1:N-4]:4'b0}: 
                                                     {(Op[0] == 0)? {out_stage2[N-1], out_stage2[N-1], out_stage2[N-1], out_stage2[N-1]}:4'b0000, out_stage2[N-1:4]}:out_stage2;
    assign Out = (Cnt[3] == 1)? (Op[1] == 0)? {out_stage3[7:0], (Op[0] == 0)? out_stage3[N-1:N-8]:8'b0}: 
                                              {(Op[0] == 0)? {out_stage3[N-1], out_stage3[N-1], out_stage3[N-1], out_stage3[N-1],out_stage3[N-1], out_stage3[N-1], out_stage3[N-1], out_stage3[N-1]}:
                                                             8'b0, out_stage3[N-1:8]}:out_stage3;
endmodule
                              
