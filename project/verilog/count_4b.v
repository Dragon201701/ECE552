module count_4b(clk, rst, en, clear, cnt_o);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    input               clk, rst, en, clear;
    output [N-1:0]   cnt_o;
/*
    always @ (posedge clk or posedge rst)
        if (rst)
            cnt_o <=0;
        else
            if(en)
                if(clear)
                    cnt_o<=0;
                else
                    cnt_o <= cnt_o + 1;
*/
    wire [3:0]	   d, q;	

	dff dff_0(.d(d[0]), .clk(clk), .rst(rst), .q(q[0]));	
	dff dff_1(.d(d[1]), .clk(clk), .rst(rst), .q(q[1]));	
	dff dff_2(.d(d[2]), .clk(clk), .rst(rst), .q(q[2]));	
	dff dff_3(.d(d[3]), .clk(clk), .rst(rst), .q(q[3]));

    assign d[0] = (clear==1'b1)? 1'b0 : (en==1'b0)?  q[0] :                      ~q[0] ;               
    assign d[1] = (clear==1'b1)? 1'b0 : (en==1'b0)?  q[1] :   (q[0])           ? ~q[1] : q[1] ;
    assign d[2] = (clear==1'b1)? 1'b0 : (en==1'b0)?  q[2] :   (q[1]&q[0])      ? ~q[2] : q[2] ;
    assign d[3] = (clear==1'b1)? 1'b0 : (en==1'b0)?  q[3] :   (q[2]&q[1]&q[0]) ? ~q[3] : q[3] ;

    assign cnt_o = q;

endmodule
 