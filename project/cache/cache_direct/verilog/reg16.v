module reg16 (D, clk, rst, en, Q);	
	input	clk, rst, en;	
	input	[15:0]	D;	
	output	[15:0]	Q;	
	wire 	[15:0]	in, out;	

	assign in = (en)? D[15:0] : out[15:0];	
	assign Q = out[15:0];	
	dff dff_0(.d(in[0]), .clk(clk), .rst(rst), .q(out[0]));	
	dff dff_1(.d(in[1]), .clk(clk), .rst(rst), .q(out[1]));	
	dff dff_2(.d(in[2]), .clk(clk), .rst(rst), .q(out[2]));	
	dff dff_3(.d(in[3]), .clk(clk), .rst(rst), .q(out[3]));	

	dff dff_4(.d(in[4]), .clk(clk), .rst(rst), .q(out[4]));	
	dff dff_5(.d(in[5]), .clk(clk), .rst(rst), .q(out[5]));	
	dff dff_6(.d(in[6]), .clk(clk), .rst(rst), .q(out[6]));	
	dff dff_7(.d(in[7]), .clk(clk), .rst(rst), .q(out[7]));	

	dff dff_8(.d(in[8]), .clk(clk), .rst(rst), .q(out[8]));	
	dff dff_9(.d(in[9]), .clk(clk), .rst(rst), .q(out[9]));	
	dff dff_10(.d(in[10]), .clk(clk), .rst(rst), .q(out[10]));	
	dff dff_11(.d(in[11]), .clk(clk), .rst(rst), .q(out[11]));	

	dff dff_12(.d(in[12]), .clk(clk), .rst(rst), .q(out[12]));	
	dff dff_13(.d(in[13]), .clk(clk), .rst(rst), .q(out[13]));	
	dff dff_14(.d(in[14]), .clk(clk), .rst(rst), .q(out[14]));	
	dff dff_15(.d(in[15]), .clk(clk), .rst(rst), .q(out[15]));	

endmodule
