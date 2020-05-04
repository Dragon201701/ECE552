module reg3 (D, clk, rst, en, Q);	
	input	clk, rst, en;	
	input	[2:0]	D;	
	output	[2:0]	Q;	
	wire 	[2:0]	in, out;	

	assign in = (en)? D[2:0] : out[2:0];	
	assign Q = out[2:0];	
	dff dff_0(.d(in[0]), .clk(clk), .rst(rst), .q(out[0]));	
	dff dff_1(.d(in[1]), .clk(clk), .rst(rst), .q(out[1]));	
	dff dff_2(.d(in[2]), .clk(clk), .rst(rst), .q(out[2]));	

endmodule
