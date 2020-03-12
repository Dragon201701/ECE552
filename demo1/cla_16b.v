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
   
    wire [N-1:0] P, G;
    wire c1, c2, c3;

    // Propagate intermediates 
    wire n_p3p2p1, p3p2p1, n_p3p2p1p0, p3p2p1p0; // p0
    wire n_p7p6p5, p7p6p5, n_p7p6p5p4, p7p6p5p4; // p1
    wire n_p11p10p9, p11p10p9, n_p11p10p9p8, p11p10p9p8; // p2
    wire n_p15p14p13, p15p14p13, n_p15p14p13p12, p15p14p13p12; // p3

    // Generate intermediates
    wire n_p3p2p1g0, p3p2p1g0, n_p3p2g1, p3p2g1, n_p3g2, p3g2, n_g0_7, g0__7; // G0
    wire n_p7p6p5g4, p7p6p5g4, n_p7p6g5, p7p6g5, n_p7g6, p7g6, n_g1_7, g1__7; // G1
    wire n_p11p10g9, p11p10g9, n_p11g10, p11g10, n_g2_7, g2__7; // G2
    wire n_p15p14p13g12, p15p14p13g12, n_p15p14g13, p15p14g13, n_p15g14, p15g14, n_g3_7, g3__7; // G3

    // Carry intermediates
    wire n_P0cin, P0cin; // C1
    wire n_P1P0cin, P1P0cin, n_P1g0, P1g0; // C2
    wire n_P2g1, P2g1, n_P2P1g0, P2P1g0, n_P2P1P0cin, P2P1P0cin, n_c3_7, c3__7; // C3
    wire n_P3g2, P3g2, n_P3P2g1, P3P2g1, n_P3P2P1g0, P3P2P1g0, n_P3P2P1P0cin, P3P2P1P0cin, n_c4_9, c4__9; // C4

    wire co_0, co_1, co_2; // Don't care about carry outs?

    // Set up adder
    cla_4b b3_0(.A(A[3:0]), .B(B[3:0]), .C_in(C_in), .S(S[3:0]), .C_out(co_0), .P(P[3:0]), .G(G[3:0]));
    cla_4b b7_4(.A(A[7:4]), .B(B[7:4]), .C_in(c1), .S(S[7:4]), .C_out(co_1), .P(P[7:4]), .G(G[7:4]) );
    cla_4b b11_8(.A(A[11:8]), .B(B[11:8]), .C_in(c2), .S(S[11:8]), .C_out(co_2), .P(P[11:8]), .G(G[11:8]) );
    cla_4b b15_12(.A(A[15:12]), .B(B[15:12]), .C_in(c3), .S( S[15:12]), .C_out(C_out), .P(P[15:12]), .G(G[15:12]) );  

    // Propagate signals
    // P0
    nand3 p0_1(.in1(P[3]), .in2(P[2]), .in3(P[1]), .out(n_p3p2p1));
    not1 p0_2(.in1(n_p3p2p1), .out(p3p2p1));

    nand2 p0_3(.in1(p3p2p1), .in2(P[0]), .out(n_p3p2p1p0));
    not1 p0_4(.in1(n_p3p2p1p0), .out(p3p2p1p0));

    // P1
    nand3 p1_1(.in1(P[7]), .in2(P[6]), .in3(P[5]), .out(n_p7p6p5));
    not1 p1_2(.in1(n_p7p6p5), .out(p7p6p5));

    nand2 p1_3(.in1(p7p6p5), .in2(P[4]), .out(n_p7p6p5p4));
    not1 p1_4(.in1(n_p7p6p5p4), .out(p7p6p5p4));

    // P2
    nand3 p2_1(.in1(P[11]), .in2(P[10]), .in3(P[9]), .out(n_p11p10p9));
    not1 p2_2(.in1(n_p11p10p9), .out(p11p10p9));

    nand2 p2_3(.in1(p11p10p9), .in2(P[8]), .out(n_p11p10p9p8));
    not1 p2_4(.in1(n_p11p10p9p8), .out(p11p10p9p8));

    // P3
    nand3 p3_1(.in1(P[15]), .in2(P[14]), .in3(P[13]), .out(n_p15p14p13));
    not1 p3_2(.in1(n_p15p14p13), .out(p15p14p13));

    nand2 p3_3(.in1(p15p14p13), .in2(P[12]), .out(n_p15p14p13p12));
    not1 p3_4(.in1(n_p15p14p13p12), .out(p15p14p13p12));


    // Generate Signals
    // Can reuse some stuff from propagate
    
    // G0
    nand2 g0_1(.in1(p3p2p1), .in2(G[0]), .out(n_p3p2p1g0));
    not1 g0_2(.in1(n_p3p2p1g0), .out(p3p2p1g0));

    nand3 g0_3(.in1(P[3]), .in2(P[2]), .in3(G[1]), .out(n_p3p2g1));
    not1 g0_4(.in1(n_p3p2g1), .out(p3p2g1));

    nand2 g0_5(.in1(P[3]), .in2(G[2]), .out(n_p3g2));
    not1 g0_6(.in1(n_p3g2), .out(p3g2));

    nor3 g0_7(.in1(G[3]), .in2(p3g2), .in3(p3p2g1), .out(n_g0_7));
    not1 g0_8(.in1(n_g0_7), .out(g0__7));

    nor2 g0_9(.in1(g0__7), .in2(p3p2p1g0), .out(n_g0));
    not1 g0_10(.in1(n_g0), .out(g0));

    // G1
    nand2 g1_1(.in1(p7p6p5), .in2(G[4]), .out(n_p7p6p5g4));
    not1 g1_2(.in1(n_p7p6p5g4), .out(p7p6p5g4));

    nand3 g1_3(.in1(P[7]), .in2(P[6]), .in3(G[5]), .out(n_p7p6g5));
    not1 g1_4(.in1(n_p7p6g5), .out(p7p6g5));

    nand2 g1_5(.in1(P[7]), .in2(G[6]), .out(n_p7g6));
    not1 g1_6(.in1(n_p7g6), .out(p7g6));

    nor3 g1_7(.in1(G[7]), .in2(p7g6), .in3(p7p6g5), .out(n_g1_7));
    not1 g1_8(.in1(n_g1_7), .out(g1__7));

    nor2 g1_9(.in1(g1__7), .in2(p7p6p5g4), .out(n_g1));
    not1 g1_10(.in1(n_g1), .out(g1));

    // G2
    nand2 g2_1(.in1(p11p10p9), .in2(G[8]), .out(n_p11p10p9g8));
    not1 g2_2(.in1(n_p11p10p9g8), .out(p11p10p9g8));

    nand3 g2_3(.in1(P[11]), .in2(P[10]), .in3(G[9]), .out(n_p11p10g9));
    not1 g2_4(.in1(n_p11p10g9), .out(p11p10g9));

    nand2 g2_5(.in1(P[11]), .in2(G[10]), .out(n_p11g10));
    not1 g2_6(.in1(n_p11g10), .out(p11g10));

    nor3 g2_7(.in1(G[11]), .in2(p11g10), .in3(p11p10g9), .out(n_g2_7));
    not1 g2_8(.in1(n_g2_7), .out(g2__7));

    nor2 g2_9(.in1(g2__7), .in2(p11p10p9g8), .out(n_g2));
    not1 g2_10(.in1(n_g2), .out(g2));

    // G3  
    nand2 g3_1(.in1(p15p14p13), .in2(G[12]), .out(n_p15p14p13g12));
    not1 g3_2(.in1(n_p15p14p13g12), .out(p15p14p13g12));

    nand3 g3_3(.in1(P[15]), .in2(P[14]), .in3(G[13]), .out(n_p15p14g13));
    not1 g3_4(.in1(n_p15p14g13), .out(p15p14g13));

    nand2 g3_5(.in1(P[15]), .in2(G[14]), .out(n_p15g14));
    not1 g3_6(.in1(n_p15g14), .out(p15g14));

    nor3 g3_7(.in1(G[11]), .in2(p15g14), .in3(p15p14g13), .out(n_g3_7));
    not1 g3_8(.in1(n_g3_7), .out(g3__7));

    nor2 g3_9(.in1(g3__7), .in2(p15p14p13g12), .out(n_g3));
    not1 g3_10(.in1(n_g3), .out(g3));

    // Carry signals
    // C1
    nand2 c1_1(.in1(p3p2p1p0), .in2(C_in), .out(n_P0cin));
    not1 c1_2(.in1(n_P0cin), .out(P0cin));

    nor2 c1_3(.in1(g0), .in2(P0cin), .out(n_c1));
    not1 c1_4(.in1(n_c1), .out(c1));
    
    // C2
    nand3 c2_1(.in1(p7p6p5p4), .in2(p3p2p1p0), .in3(C_in), .out(n_P1P0cin));
    not1 c2_2(.in1(n_P1P0cin), .out(P1P0cin));

    nand2 c2_3(.in1(p7p6p5p4), .in2(g0), .out(n_P1g0));
    not1 c2_4(.in1(n_P1g0), .out(P1g0));

    nor3 c2_5(.in1(g1), .in2(P1g0), .in3(P1P0cin), .out(n_c2));
    not1 c2_6(.in1(n_c2), .out(c2));

    // C3
    nand2 c3_1(.in1(p11p10p9p8), .in2(P1P0cin), .out(n_P2P1P0cin));
    not1 c3_2(.in1(n_P2P1P0cin), .out(P2P1P0cin));

    nand2 c3_3(.in1(p11p10p9p8), .in2(P1g0), .out(n_P2P1g0));
    not1 c3_4(.in1(n_P2P1g0), .out(P2P1g0));

    nand2 c3_5(.in1(p11p10p9p8), .in2(g1), .out(n_P2g1));
    not1 c3_6(.in1(n_P2g1), .out(P2g1));

    nor3 c3_7(.in1(g2), .in2(P2g1), .in3(P2P1g0), .out(n_c3_7));
    not1 c3_8(.in1(n_c3_7), .out(c3__7));

    nor2 c3_9(.in1(c3__7), .in2(P2P1P0cin), .out(n_c3));
    not1 c3_10(.in1(n_c3), .out(c3));

    // C4
    nand2 c4_1(.in1(p15p14p13p12), .in2(P2P1P0cin), .out(n_P3P2P1P0cin));
    not1 c4_2(.in1(n_P3P2P1P0cin), .out(P3P2P1P0cin));

    nand2 c4_3(.in1(p15p14p13p12), .in2(P2P1g0), .out(n_P3P2P1g0));
    not1 c4_4(.in1(n_P3P2P1g0), .out(P3P2P1g0));

    nand2 c4_5(.in1(p15p14p13p12), .in2(P2g1), .out(n_P3P2g1));
    not1 c4_6(.in1(n_P3P2g1), .out(P3P2g1));

    nand2 c4_7(.in1(p15p14p13p12), .in2(g2), .out(n_P3g2));
    not1 c4_8(.in1(n_P3g2), .out(P3g2));

    nor3 c4_9(.in1(g3), .in2(P3g2), .in3(P3P2g1), .out(n_c4_9));
    not1 c4_10(.in1(n_c4_9), .out(c4__9));

    nor3 c4_11(.in1(c4__9), .in2(P3P2P1g0), .in3(P3P2P1P0cin), .out(n_c4));
    not1 c4_12(.in1(n_c4), .out(c4));


endmodule
