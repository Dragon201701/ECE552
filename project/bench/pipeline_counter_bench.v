module pipeline_counter_bench ();
	wire clk, rst;
	wire flush, stall;
	pipeline DUT(.clk(clk), .rst(rst), .flush(flush), .stall(stall));
	clkrst myclk(.clk(clk), .rst(rst), .err());
endmodule