module extension (instr, immCTL, exCTL, jumpCTL, extVal);
	input	[15:0]	instr;
	input	immCTL, exCTL, jumpCTL;
	output	[15:0]	extVal;
	wire	[15:0]	jumpimm;
	assign sign5to16 = {{11{instr[4]}},instr[4:0]};
    assign zero5to16 = {{11{0},instr[4:0]};
    assign sign8to16 = {{8{instr[7]}}, instr[7:0]};
    assign zero8to16 = {{8{0}}, instr[7:0]};
    assign sign11to16 = {{5{instr[10]}}, instr[10:0]};

    assign jumpimm = jumpCTL? sign11to16:zero5to16;
    mux4_16 mux4_16_1(.sel({immCTL, exCTL}), .in0(jumpimm), .in1(sign5to16), .in2(zero8to16), .in3(sign8to16), .out(extVal)));

endmodule