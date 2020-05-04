 module extension (instr, extVal);
	input	[15:0]	instr;
	output	[15:0]	extVal;
	wire	[15:0]	jumpimm, sign5to16, zero5to16, sign8to16, zero8to16, sign11to16;
	assign sign5to16 = {{11{instr[4]}},instr[4:0]};
    assign zero5to16 = {{11{0}},instr[4:0]};
    assign sign8to16 = {{8{instr[7]}}, instr[7:0]};
    assign zero8to16 = {{8{0}}, instr[7:0]};
    assign sign11to16 = {{5{instr[10]}}, instr[10:0]};

    //assign jumpimm = jumpCTL? sign11to16:zero5to16;
    //mux4_16 mux4_16_1(.sel({immCTL, extCTL}), .in0(jumpimm), .in1(sign5to16), .in2(zero8to16), .in3(sign8to16), .out(extVal));
    // TODO: need optimization.
    assign extVal = (instr[15:12] == 4'b0100 | instr[15:12] == 4'b1000 | instr[15:13] == 3'b101 | instr[15:11] == 5'b10011)? sign5to16 :
                    (instr[15:13] == 3'b011 | instr[15:11] == 5'b11000 | (instr[15:13] == 3'b001 & instr[11]))? sign8to16 :
                    (instr[15:11] == 5'b10010)? zero8to16 :
                    (instr[15:13] == 3'b001 & ~instr[11])? sign11to16 :
                    (instr[15:12] == 4'b0101)? zero5to16 : 16'h0000;
endmodule