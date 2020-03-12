/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 2
    
    a 16-bit CLA module
*/
module cla_16b(A, B, C_in, S, C_out);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 16;

    input [N-1: 0] A, B;
    input          C_in;
    output [N-1:0] S;
    output         C_out;

    // YOUR CODE HERE
    wire C0, C1, C2;
    wire P0, P0_bar, P1, P1_bar, P2, P2_bar, P3, P3_bar;
    wire G0, G0_bar, G1, G1_bar, G2, G2_bar, G3, G3_bar;
    wire nand2_c0_0_out, nand2_c1_0_out, nand2_c2_0_out, nand2_c3_0_out;
    

    cla_4b cla4_0(.A(A[3:0]), .B(B[3:0]), .C_in(C_in), 
        .S(S[3:0]), .P(P0), .G(G0), .C_out());
    cla_4b cla4_1(.A(A[7:4]), .B(B[7:4]), .C_in(C0), 
        .S(S[7:4]), .P(P1), .G(G1), .C_out());
    cla_4b cla4_2(.A(A[11:8]), .B(B[11:8]), .C_in(C1), 
        .S(S[11:8]), .P(P2), .G(G2), .C_out());
    cla_4b cla4_3(.A(A[15:12]), .B(B[15:12]), .C_in(C2), 
        .S(S[15:12]), .P(P3), .G(G3), .C_out());

    // Carry Look Ahead Logic
    // Ci+1 = NAND(NOT(g), NAND(p, ci))

    not1 not1_c0_0(.in1(G0), .out(G0_bar));
    nand2 nand2_c0_0(.in1(P0), .in2(C_in), .out(nand2_c0_0_out));
    nand2 nand2_c0_1(.in1(G0_bar), .in2(nand2_c0_0_out), .out(C0));

    not1 not1_c1_0(.in1(G1), .out(G1_bar));
    nand2 nand2_c1_0(.in1(P1), .in2(C0), .out(nand2_c1_0_out));
    nand2 nand2_c1_1(.in1(G1_bar), .in2(nand2_c1_0_out), .out(C1));

    not1 not1_c2_0(.in1(G2), .out(G2_bar));
    nand2 nand2_c2_0(.in1(P2), .in2(C1), .out(nand2_c2_0_out));
    nand2 nand2_c2_1(.in1(G2_bar), .in2(nand2_c2_0_out), .out(C2));
    
    not1 not1_c3_0(.in1(G3), .out(G3_bar));
    nand2 nand2_c3_0(.in1(P3), .in2(C2), .out(nand2_c3_0_out));
    nand2 nand2_c3_1(.in1(G3_bar), .in2(nand2_c3_0_out), .out(C_out));
endmodule
