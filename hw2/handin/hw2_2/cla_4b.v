/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 2
    
    a 4-bit CLA module
*/
module cla_4b(A, B, C_in, P, G, S, C_out);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    input [N-1: 0] A, B;
    input          C_in;
    output [N-1:0] S;
    output         P, G, C_out;

    // YOUR CODE HERE
    wire c0, c1, c2;
    wire p0, g0, p1, g1, p2, g2, p3, g3;
    wire g0_bar, g1_bar, g2_bar, g3_bar;
    wire nand2_c0_0_out, nand2_c1_0_out, nand2_c2_0_out, nand2_c3_0_out;
    wire nand2_p3_p2, nand2_p1_p0;
    wire nand2_p3g2_out, nand2_p3p2g1_out, nand3_G_0_out, nand2_p1g0_out, nor2_G_0_out;
    wire G_bar;
    // Carry Look Ahead Logic
    // Ci+1 = NAND(NOT(g), NAND(p, ci))
    not1 not1_c0_0(.in1(g0), .out(g0_bar));
    nand2 nand2_c0_0(.in1(p0), .in2(C_in), .out(nand2_c0_0_out));
    nand2 nand2_c0_1(.in1(g0_bar), .in2(nand2_c0_0_out), .out(c0));

    not1 not1_c1_0(.in1(g1), .out(g1_bar));
    nand2 nand2_c1_0(.in1(p1), .in2(c0), .out(nand2_c1_0_out));
    nand2 nand2_c1_1(.in1(g1_bar), .in2(nand2_c1_0_out), .out(c1));

    not1 not1_c2_0(.in1(g2), .out(g2_bar));
    nand2 nand2_c2_0(.in1(p2), .in2(c1), .out(nand2_c2_0_out));
    nand2 nand2_c2_1(.in1(g2_bar), .in2(nand2_c2_0_out), .out(c2));
    
    not1 not1_c3_0(.in1(g3), .out(g3_bar));
    nand2 nand2_c3_0(.in1(p3), .in2(c2), .out(nand2_c3_0_out));
    nand2 nand2_c3_1(.in1(g3_bar), .in2(nand2_c3_0_out), .out(C_out));

    // Propagate: P0 = p3*p2*p1*p0 = NOR(NAND(P3, P2), NAND(P1, P0))
    nand2 nand2_p32(.in1(p3), .in2(p2), .out(nand2_p3_p2));
    nand2 nand2_p10(.in1(p1), .in2(p0), .out(nand2_p1_p0));
    nor2 nor2_P(.in1(nand2_p3_p2), .in2(nand2_p1_p0), .out(P));

    // GenerageL G0 = g3+p3g2+p3p2g1+p3p2p1g0 
    //              = NOT(NOR(NAND(NOT(g3), NAND(p3, g2), NAND(p3, p2, g1)), NOR(NAND(p3, p2), NAND(p1, g0))))
    nand2 nand2_p3g2(.in1(p3), .in2(g2), .out(nand2_p3g2_out));
    nand3 nand2_p3p2g1(.in1(p3), .in2(p2), .in3(g1), .out(nand2_p3p2g1_out));
    nand3 nand3_G_0(.in1(g3_bar), .in2(nand2_p3g2_out), .in3(nand2_p3p2g1_out), .out(nand3_G_0_out));

    nand2 nand2_p1g0(.in1(p1), .in2(g0), .out(nand2_p1g0_out));
    nor2 nor2_G_0(.in1(nand2_p3_p2), .in2(nand2_p1g0_out), .out(nor2_G_0_out));

    nor2 nor2_G(.in1(nand3_G_0_out), .in2(nor2_G_0_out), .out(G_bar));
    not1 not1_G(.in1(G_bar), .out(G)); 

    // 4*fulladder_1b
    fullAdder_1b fulladder_0(.A(A[0]), .B(B[0]), .C_in(C_in), .p(p0), .g(g0),
     .S(S[0]), .C_out());
    fullAdder_1b fulladder_1(.A(A[1]), .B(B[1]), .C_in(c0), .p(p1), .g(g1),
     .S(S[1]), .C_out());
    fullAdder_1b fulladder_2(.A(A[2]), .B(B[2]), .C_in(c1), .p(p2), .g(g2),
     .S(S[2]), .C_out());
    fullAdder_1b fulladder_3(.A(A[3]), .B(B[3]), .C_in(c2), .p(p3), .g(g3),
     .S(S[3]), .C_out());

endmodule
