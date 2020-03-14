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
module alu (slbi, InA, InB, Cin, Op, invA, invB, sign, Out, Zero, Ofl, cout);

   // declare constant for size of inputs, outputs (N),
   // and operations (O)
   parameter    N = 16;
   parameter    O = 3;
   
   input [N-1:0] InA; // Data Input
   input [N-1:0] InB; // Data Input
   input         Cin; // Carry-in
   input [O-1:0] Op;   
   input         invA;// active high A invert indicator
   input         invB;// active high B invert indicator
   input         sign;// Sign(active high) or Unsigned indicator
   input	 slbi;
   output [N-1:0] Out;
   output         Ofl;// High if Overflow occurs
   output         Zero;// High if result == 0
   output 	  cout;

   /* YOUR CODE HERE */
  /*Opcode Function Result
  000 rll Rotate left
  001 sll Shift left logical
  010 sra Shift right arithmetic
  011 srl Shift right logical
  100 ADD A+B
  101 AND A AND B
  110 OR  A OR B
  111 XOR A XOR B
  */
  wire [15:0] rotate;
  reg [31:0] tmp;
  wire [N-1:0] shifter_out, ror_check;
  wire [N-1:0] AND_RESULT, OR_RESULT, XOR_RESULT, ADD_RESULT, LOGIC_RESULT, SUB_RESULT;
  wire [N-1:0] A, B;
  wire Overflow;
  assign A = (invA==1'b1)? ~InA : InA;
  assign B = (invB==1'b1)? ~InB : InB;
  shifter shift(.In(A), .Cnt(B[3:0]), .Op(Op[1:0]), .Out(shifter_out));
  cla_16b adder(.A(A), .B(B), .C_in(Cin), .S(ADD_RESULT), .C_out(Overflow));
  assign cout = Overflow;
  assign Ofl = (sign==1'b1)? (~A[15]&~B[15]&ADD_RESULT[15])|(A[15]&B[15]&~ADD_RESULT[15]):Overflow;
  assign AND_RESULT = A & ~B;
  assign OR_RESULT = A | B;
  assign XOR_RESULT = A ^ B;
  assign SUB_RESULT = B - A;
  assign LOGIC_RESULT = slbi ? OR_RESULT:
			(Op == 3'b100)? ADD_RESULT: 
                        (Op == 3'b101)? SUB_RESULT: 
                        (Op == 3'b110)? XOR_RESULT:
                        AND_RESULT;
  assign Zero = (LOGIC_RESULT == 16'b0)?1:(shifter_out == 16'b00)?1:0;

  assign ror_check = (Op[1:0] == 2'b10) ? rotate : shifter_out;
  assign Out = (Op[2] == 1)? LOGIC_RESULT:ror_check;

  // Rotate 
  always @ (*)
  begin
  tmp <= {A, A} >> B[3:0];
  end
  assign rotate = tmp[15:0];

endmodule
