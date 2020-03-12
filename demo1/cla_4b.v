/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 2
    
    a 4-bit CLA module
*/
module cla_4b(A, B, C_in, S, C_out, P, G);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    input [N-1: 0] A, B;
    input          C_in;
    output [N-1:0] S;
    output         C_out;
    // Added outputs for P and G
    output [N-1:0] P, G;


    wire n_g0, n_g1, n_g2, n_g3;
    wire g0, g1, g2, g3;
    wire n_p0, n_p1, n_p2, n_p3;
    wire p0, p1, p2, p3;

    // For intermediate c0, c1, c2, c3 signals
    
    wire n_p0cin, p0cin; // c1
    wire n_p1g0, n_p1p0cin, p1g0, p1p0cin; // c2
    wire n_p2g1, n_p2p1g0, n_p2p1p0cin, p2g1, p2p1g0, p2p1p0cin, c3__9; // c3
    wire n_p3g2, n_p3p2g1, n_p3p2p1g0, n_p3p2p1p0cin, p3g2, p3p2g1, p3p2p1g0, p3p2p1p0cin, c4__11; // c4
    wire n_c1, n_c2, n_c3, n_C_out;
    wire c1, c2, c3;
    wire co_0, co_1, co_2, co_3; // Don't care about c_outs?

    // Bits 3-0
    fullAdder_1b b_0(.A(A[0]), .B(B[0]), .C_in(C_in), .S(S[0]), .C_out(co_0));
    fullAdder_1b b_1(.A(A[1]), .B(B[1]), .C_in(c1), .S(S[1]), .C_out(co_1));
    fullAdder_1b b_2(.A(A[2]), .B(B[2]), .C_in(c2), .S(S[2]), .C_out(co_2));
    fullAdder_1b b_3(.A(A[3]), .B(B[3]), .C_in(c3), .S(S[3]), .C_out(co_3));


    // Propagate and Generate Signals
    // 0 
    nand2 g_0(.in1(A[0]), .in2(B[0]), .out(n_g0));
    not1 n_g_0(.in1(n_g0), .out(g0));

    nor2 p_0(.in1(A[0]), .in2(B[0]), .out(n_p0));
    not1 n_p_0(.in1(n_p0), .out(p0));

    // 1
    nand2 g_1(.in1(A[1]), .in2(B[1]), .out(n_g1));
    not1 n_g_1(.in1(n_g1), .out(g1));

    nor2 p_1(.in1(A[1]), .in2(B[1]), .out(n_p1));
    not1 n_p_1(.in1(n_p1), .out(p1));

    // 2
    nand2 g_2(.in1(A[2]), .in2(B[2]), .out(n_g2));
    not1 n_g_2(.in1(n_g2), .out(g2));

    nor2 p_2(.in1(A[2]), .in2(B[2]), .out(n_p2));
    not1 n_p_2(.in1(n_p2), .out(p2));

    // 3
    nand2 g_3(.in1(A[3]), .in2(B[3]), .out(n_g3));
    not1 n_g_3(.in1(n_g3), .out(g3));

    nor2 p_3(.in1(A[3]), .in2(B[3]), .out(n_p3));
    not1 n_p_3(.in1(n_p3), .out(p3));

    // End Propagate and Generate Signals

    // CarryIn Signals
    // c1
    nand2 c1_1(.in1(C_in), .in2(p0), .out(n_p0cin));
    not1 c1_2(.in1(n_p0cin), .out(p0cin));
    nor2 c1_3(.in1(p0cin), .in2(g0), .out(n_c1));
    not1 c1_4(.in1(n_c1), .out(c1));

    // c2
    nand3 c2_1(.in1(C_in), .in2(p0), .in3(p1), .out(n_p1p0cin));
    nand2 c2_2(.in1(g0), .in2(p1), .out(n_p1g0));
   
    not1 c2_3(.in1(n_p1p0cin), .out(p1p0cin));
    not1 c2_4(.in1(n_p1g0), .out(p1g0));

    nor3 c2_5(.in1(p1p0cin), .in2(p1g0), .in3(g1), .out(n_c2));
    not1 c2_6(.in1(n_c2), .out(c2));

    // c3
    nand3 c3_1(.in1(p1), .in2(p0), .in3(C_in), .out(n_p1p0cin));
    // Make input correct
    nand2 c3_2(.in1(n_p1p0cin), .in2(n_p1p0cin), .out(p1p0cin));
    nand2 c3_3(.in1(p2), .in2(p1p0cin), .out(n_p2p1p0cin));
    not1 c3_4(.in1(n_p2p1p0cin), .out(p2p1p0cin));

    nand3 c3_5(.in1(p2), .in2(p1), .in3(g0), .out(n_p2p1g0));
    nand2 c3_6(.in1(n_p2p1g0), .in2(n_p2p1g0), .out(p2p1g0));

    nand2 c3_7(.in1(p2), .in2(g1), .out(n_p2g1));
    nand2 c3_8(.in1(n_p2g1), .in2(n_p2g1), .out(p2g1));

    // Or all
    nor3 c3_9(.in1(p2p1p0cin), .in2(p2p1g0), .in3(p2g1), .out(n_c3_9));
    nor2 c3_10(.in1(n_c3_9), .in2(n_c3_9), .out(c3__9));

    nor2 c3_11(.in1(g2), .in2(c3__9), .out(n_c3));
    not1 c3_12(.in1(n_c3), .out(c3));


    // C_out (c4)
    nand3 c4_1(.in1(p3), .in2(p2), .in3(p1), .out(n_p3p2p1));
    nand2 c4_2(.in1(n_p3p2p1), .in2(n_p3p2p1), .out(p3p2p1));

    // Use p3p2p1 for two sections
    nand3 c4_3(.in1(p3p2p1), .in2(p0), .in3(C_in), .out(n_p3p2p1p0cin));
    nand2 c4_4(.in1(n_p3p2p1p0cin), .in2(n_p3p2p1p0cin), .out(p3p2p1p0cin));

    nand2 c4_5(.in1(p3p2p1), .in2(g0), .out(n_p3p2p1g0));
    nand2 c4_6(.in1(n_p3p2p1g0), .in2(n_p3p2p1g0), .out(p3p2p1g0));

    nand3 c4_7(.in1(p3), .in2(p2), .in3(g1), .out(n_p3p2g1));
    nand2 c4_8(.in1(n_p3p2g1), .in2(n_p3p2g1), .out(p3p2g1));

    nand2 c4_9(.in1(p3), .in2(g2), .out(n_p3g2));
    nand2 c4_10(.in1(n_p3g2), .in2(n_p3g2), .out(p3g2));

    // Or
    nor3 c4_11(.in1(p3p2g1), .in2(p3p2p1g0), .in3(p3p2p1p0cin), .out(n_c4_11));
    not1 c4_12(.in1(n_c4_11), .out(c4__11));

    nor3 c4_13(.in1(g3), .in2(p3g2), .in3(c4__11), .out(n_C_out));
    not1 c4_14(.in1(n_C_out), .out(C_out));


    // Assign p3..p0 to P signal
    assign P[0] = p0;
    assign P[1] = p1;
    assign P[2] = p2;
    assign P[3] = p3;
    // Also for G
    assign G[0] = g0;
    assign G[1] = g1;
    assign G[2] = g2;
    assign G[3] = g3;



endmodule
