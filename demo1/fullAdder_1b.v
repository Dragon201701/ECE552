/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 2
    
    a 1-bit full adder
*/
module fullAdder_1b(A, B, C_in, p, g, S, C_out);
    input  A, B;
    input  C_in;
    output p;
    output g;
    output S;
    output C_out;
    // only use NOT, NAND, NOR, and XOR
    // YOUR CODE HERE
    wire g_bar, p_bar, nand2_1_out, nand2_2_out, nand2_3_out;

    // g = A AND B = NOT(NAND(A,B))
    nand2 nand2_0(.in1(A), .in2(B), .out(g_bar));
    not1 not1_0(.in1(g_bar), .out(g));

    // p = A OR B = NOT(NOR(A,B))
    nor2 nor2_0(.in1(A), .in2(B), .out(p_bar));
    not1 not1_1(.in1(p_bar), .out(p));

    // C_out = NAND(NAND(A,B), NAND(A,C), NAND(A,C))
    nand2 nand2_1(.in1(A), .in2(B), .out(nand2_1_out));
    nand2 nand2_2(.in1(A), .in2(C_in), .out(nand2_2_out));
    nand2 nand2_3(.in1(B), .in2(C_in), .out(nand2_3_out));
    nand3 nand3_0(.in1(nand2_1_out), .in2(nand2_2_out), 
    	.in3(nand2_3_out), .out(C_out));

    // S = XOR(A,B,C_in)
    xor3 xor3_0(.in1(A), .in2(B), .in3(C_in), .out(S));



endmodule
