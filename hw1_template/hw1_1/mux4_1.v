/*
    CS/ECE 552 Spring '20
    Homework #1, Problem 1

    4-1 mux template
*/
module mux4_1(InA, InB, InC, InD, S, Out);
    input        InA, InB, InC, InD;
    input [1:0]  S;
    output       Out;

    // YOUR CODE HERE
    wire mux2_1_1_out, mux2_1_2_out;
    mux2_1 mux2_1_1(.InA(InA), .InB(InB), .S(S[0]), .Out(mux2_1_1_out));
    mux2_1 mux2_1_2(.InA(InC), .InB(InD), .S(S[0]), .Out(mux2_1_2_out));
    mux2_1 mux2_1_3(.InA(mux2_1_1_out), .InB(mux2_1_2_out), .S(S[1]), .Out(Out));

endmodule
