module pipeline (clk, rst, flush, stall);
	input clk, rst;
	output flush, stall;
	wire	[3:0] count, count_out, count_in;
	assign flush = 1'b0;
	assign stall = (count_out == 4'h5)?1:0;
	assign count_in = (count_out == 4'h5)?4'h0:count_out;
	reg4 countdff(.clk(clk), .rst(rst), .en(1'b1), .D(count_in), .Q(count));
	cla_4b counter(.A(count), .B(4'h1), .C_in(1'b0), .S(count_out), .P(), .G(), .C_out());
endmodule