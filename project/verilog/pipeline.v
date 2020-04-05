module pipeline (clk, rst, IDEX_Rs, IDEX_Rt, IDEX_Rd, EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd, flush, stall);
	input clk, rst;
	input 	[2:0]	IDEX_Rs, IDEX_Rt, IDEX_Rd, EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd;
	output flush, stall;
	wire	[3:0] count, count_out, count_in;
	wire 	stallCtl;
	wire 	stallcounterRst;
	assign stallCtl = (EXMEM_Rd == IDEX_Rs) | (EXMEM_Rd == IDEX_Rt) | (MEMWB_Rd == IDEX_Rs) | (MEMWB_Rd == IDEX_Rt);
	assign stallcounterRst = rst | ~stallCtl | 
	assign flush = 1'b0;
	assign stall = (count_out == 4'h5)?1:0;
	assign count_in = (count_out == 4'h5)?4'h0:count_out;
	reg4 countdff(.clk(clk), .rst(stallcounterRst), .en(1'b1), .D(count_in), .Q(count));
	cla_4b counter(.A(count), .B(4'h1), .C_in(1'b0), .S(count_out), .P(), .G(), .C_out());
endmodule