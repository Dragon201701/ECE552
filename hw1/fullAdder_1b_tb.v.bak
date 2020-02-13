`timescale 1ns / 1ns
module fullAdder_1b_tb();
	reg A, B, C_in;
	wire p, g, S, C_out;
	fullAdder_1b iDUT(.A(A), .B(B), .C_in(C_in), .p(p), .g(g), .S(S), .C_out(C_out));
	initial begin 
		A = 0;
		B = 0;
		C_in = 0;
		
	end
	always begin 
		#1 A = ~A;
	end
		
	always begin
		#2 B = ~B;
	end
	always begin
		#4 C_in = ~C_in;
	end
endmodule
