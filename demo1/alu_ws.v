module alu_ws (slbi, InA, InB, Cin, Op, invA, invB, sign, Out, Zero, Ofl);
	input 	[N-1:0] 	InA; // Data Input
	input 	[N-1:0] 	InB; // Data Input
	input         		Cin; // Carry-in
	input 	[O-1:0] 	Op;   
	input         		invA;// active high A invert indicator
	input         		invB;// active high B invert indicator
	input         		sign;// Sign(active high) or Unsigned indicator
	input	 			slbi;
	output	[N-1:0] 	Out;
	output         		Ofl;// High if Overflow occurs
	output         		Zero;// High if result == 0
	output 	  			cout;
	wire	[N-1:0]		slbi_inA;
	
endmodule