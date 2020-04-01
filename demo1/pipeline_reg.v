module pipeline_reg_ctl (in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,in17,in18,in19,in20,in21,in22,
                    out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,
	     	    clk, rst, en);

        input   clk, rst, en;
        input in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,in17,in18,in19,in20,in21;
	input [1:0] in22;  // ALU control
	
	output out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21;
	output [1:0] out22; // ALU control

        // TODO: ENABLE SIGNAL
        // TODO: SIMPLIFY LOGIC
	
	dff dff_0(.d(in1), .clk(clk), .rst(rst), .q(out1));
        dff dff_1(.d(in2), .clk(clk), .rst(rst), .q(out2));
        dff dff_2(.d(in3), .clk(clk), .rst(rst), .q(out3));
        dff dff_3(.d(in4), .clk(clk), .rst(rst), .q(out4));

        dff dff_4(.d(in5), .clk(clk), .rst(rst), .q(out5));
        dff dff_5(.d(in6), .clk(clk), .rst(rst), .q(out6));
        dff dff_6(.d(in7), .clk(clk), .rst(rst), .q(out7));
        dff dff_7(.d(in8), .clk(clk), .rst(rst), .q(out8));

        dff dff_8(.d(in9), .clk(clk), .rst(rst), .q(out9));
        dff dff_9(.d(in10), .clk(clk), .rst(rst), .q(out10));
        dff dff_10(.d(in11), .clk(clk), .rst(rst), .q(out11));
        dff dff_11(.d(in12), .clk(clk), .rst(rst), .q(out12));

        dff dff_12(.d(in13), .clk(clk), .rst(rst), .q(out13));
        dff dff_13(.d(in14), .clk(clk), .rst(rst), .q(out14));
        dff dff_14(.d(in15), .clk(clk), .rst(rst), .q(out15));
        dff dff_15(.d(in16), .clk(clk), .rst(rst), .q(out16));

        dff dff_16(.d(in17), .clk(clk), .rst(rst), .q(out17));
        dff dff_17(.d(in18), .clk(clk), .rst(rst), .q(out18));
        dff dff_18(.d(in19), .clk(clk), .rst(rst), .q(out19));
        dff dff_19(.d(in20), .clk(clk), .rst(rst), .q(out20));

        dff dff_20(.d(in21), .clk(clk), .rst(rst), .q(out21));
        dff dff_21(.d(in22[0]), .clk(clk), .rst(rst), .q(out22[0]));
        dff dff_22(.d(in22[1]), .clk(clk), .rst(rst), .q(out22[1]));


endmodule
