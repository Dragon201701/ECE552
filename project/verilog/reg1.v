module reg1 (D, clk, rst, en, Q);	
	input	clk, rst, en;	
	input		D;	
	output		Q;	
	wire 		in, out;	

	assign in = (en)? D : out;	
	assign Q = out;	
	dff dff_0(.d(in), .clk(clk), .rst(rst), .q(out));	

endmodule
