module sext5_16 (in, out);
	input	[4:0]	in;
	output	[15:0] 	out;
	assign out = {{10{in[4]}}, in};
endmodule