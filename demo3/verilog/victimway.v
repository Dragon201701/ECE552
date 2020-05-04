module victimway (clk, rst, en, trigger, out);
	input clk, rst, en, trigger;
	output out;
	wire d;
	assign d = en?(trigger?~out:out):out; 
	dff victim(.clk(clk), .rst(rst), .d(d), .q(out));
endmodule