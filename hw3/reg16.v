module reg16 (D, clk, rst, Q);
	input	clk, rst;
	input	[15:0]	D;
	output	[15:0]	Q;
	
	dff dff_0(.d(D[0]), .clk(clk), .rst(rst), .q(Q[0]));
	dff dff_1(.d(D[1]), .clk(clk), .rst(rst), .q(Q[1]));
	dff dff_2(.d(D[2]), .clk(clk), .rst(rst), .q(Q[2]));
	dff dff_3(.d(D[3]), .clk(clk), .rst(rst), .q(Q[3]));

	dff dff_4(.d(D[4]), .clk(clk), .rst(rst), .q(Q[4]));
	dff dff_5(.d(D[5]), .clk(clk), .rst(rst), .q(Q[5]));
	dff dff_6(.d(D[6]), .clk(clk), .rst(rst), .q(Q[6]));
	dff dff_7(.d(D[7]), .clk(clk), .rst(rst), .q(Q[7]));

	dff dff_8(.d(D[8]), .clk(clk), .rst(rst), .q(Q[8]));
	dff dff_9(.d(D[9]), .clk(clk), .rst(rst), .q(Q[9]));
	dff dff_10(.d(D[10]), .clk(clk), .rst(rst), .q(Q[10]));
	dff dff_11(.d(D[11]), .clk(clk), .rst(rst), .q(Q[11]));

	dff dff_12(.d(D[12]), .clk(clk), .rst(rst), .q(Q[12]));
	dff dff_13(.d(D[13]), .clk(clk), .rst(rst), .q(Q[13]));
	dff dff_14(.d(D[14]), .clk(clk), .rst(rst), .q(Q[14]));
	dff dff_15(.d(D[15]), .clk(clk), .rst(rst), .q(Q[15]));

endmodule
