/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 2
    
    a 1-bit full adder
*/
module fullAdder_1b(A, B, C_in, S, C_out);
    input  A, B;
    input  C_in;
    output S;
    output C_out;

	// nd means nand
	// n means not
	// x means xor
    wire axb, a_nd_b, C_nd_axb, n_C_nd_axb, fin;

    
    // Level 1
    // Get output for S
    xor2 a_b(.in1(A), .in2(B), .out(axb));
    xor2 a_b_c(.in1(C_in), .in2(axb), .out(S));
    // Nand A and B for Cout
    // Rest is for Cout
    nand2 nd1(.in1(A), .in2(B), .out(a_nd_b));

    // Level 2
    nand2 nd2(.in1(C_in), .in2(axb), .out(C_nd_axb));

    // Level 3
    not1 n1(.in1(C_nd_axb), .out(n_C_nd_axb));
    not1 n2(.in1(a_nd_b), .out(n_a_nd_b));

    // Level 4
    nor2 nor_1(.in1(n_a_nd_b), .in2(n_C_nd_axb), .out(fin));

    // Final level
    not1 n3(.in1(fin), .out(C_out));

    

endmodule
