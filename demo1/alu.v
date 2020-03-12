/*
    CS/ECE 552 Spring '20
    Homework #2, Problem 2

    A 16-bit ALU module.  It is designed to choose
    the correct operation to perform on 2 16-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the 16-bit result
    of the operation, as well as output a Zero bit and an Overflow
    (OFL) bit.
*/
module alu (InA, InB, Cin, Op, invA, invB, sign, Out, Zero, Ofl);

   // declare constant for size of inputs, outputs (N),
   // and operations (O)
   parameter    N = 16;
   parameter    O = 3;
   
   input [N-1:0] InA;
   input [N-1:0] InB;
   input         Cin;
   input [O-1:0] Op;
   input         invA;
   input         invB;
   input         sign;
   output [N-1:0] Out;
   output         Ofl;
   output         Zero;

   wire signed [N-1:0] shft_out, cla_out;

   wire C_out;
   wire [N-1:0] A, B;
   wire signed [N-1:0] A_signed, B_signed;

   assign A = invA ? ~InA : InA;
   assign B = invB ? ~InB : InB;

   shifter shft0(.In(A), .Cnt(B[3:0]), .Op(Op[1:0]), .Out(shft_out));

   cla_16b cla(.A(A), .B(B), .C_in(Cin), .S(cla_out), .C_out(C_out));

   // If Op[O-1] == 0, use barrel shifter output
   // else use CLA output
   assign Out[N-1:0] = Op[O-1] ? (Op[1] ? (Op[0] ? (A ^ B) : (A | B)) : (Op[0] ? (A & B) : (cla_out))) : shft_out; 

   // Two cases for overflow
   // If two neg numbers yield a positive result or..
   // If two pos numbers yield a negative result
   // In unsigned numbers, carry out is equivalent to overflow
   assign Ofl = sign ? ((A[N-1] & B[N-1] & ~cla_out[N-1]) | (~A[N-1] & ~B[N-1] & cla_out[N-1])) : C_out; 
   
   // Check zero
   assign Zero = (Out == 4'h0000) ? 1'b1 : 1'b0;

endmodule
