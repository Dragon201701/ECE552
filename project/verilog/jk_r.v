/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
// D-flipflop

module jk_r (j,k, q, clk, rst);

    output         q;
    input          j,k;
    input          clk;
    input          rst;

    wire            d_in;

    assign d_in = j&~q | ~k&q;

    dff dff_0(.d(d_in), .clk(clk), .rst(rst), .q(q));	

endmodule
// DUMMY LINE FOR REV CONTROL :0:
