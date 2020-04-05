module reg4 (D, clk, rst, en, Q);	
	input	clk, rst, en;	
	input	[3:0]	D;	
	output	[3:0]	Q;	
	wire 	[3:0]	in, out;	

	assign in = (en)? D[3:0] : out[3:0];	
	assign Q = out[3:0];	
	dff dff_0(.d(in[0]), .clk(clk), .rst(rst), .q(out[0]));	
	dff dff_1(.d(in[1]), .clk(clk), .rst(rst), .q(out[1]));	
	dff dff_2(.d(in[2]), .clk(clk), .rst(rst), .q(out[2]));	
	dff dff_3(.d(in[3]), .clk(clk), .rst(rst), .q(out[3]));	

endmodule
