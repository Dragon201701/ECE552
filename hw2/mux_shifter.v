module mux_shifter (prev, cur, next, op, en, out);
	input prev, cur, next, en;
	input [1:0] op;
	output out;
	wire opresult;
	mux2_1 opmux(.InA(prev), .InB(next), .S(op[1]), .Out(opresult));
	mux2_1 en(.InA(cur), .InB(opresult), .S(en), .Out(out));
endmodule