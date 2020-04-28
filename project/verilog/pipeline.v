module pipeline (clk, rst, IDEX_Rs, IDEX_Rt, IDEX_Rd, EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd, EXMEM_regWrite, MEMWB_regWrite, IDEX_memRead, 
				stall, forwarding_ex_Rs, forwarding_ex_Rt, forwarding_mem_Rs, forwarding_mem_Rt, EXMEM_lbi, EXMEM_slbi, MEMWB_lbi, MEMWB_slbi, IFID_Rs, IFID_Rt);
	input clk, rst;
	input 	[2:0]	IDEX_Rs, IDEX_Rt, IDEX_Rd, EXMEM_Rs, EXMEM_Rt, EXMEM_Rd, MEMWB_Rs, MEMWB_Rt, MEMWB_Rd, IFID_Rs, IFID_Rt;
	input 	EXMEM_regWrite, MEMWB_regWrite, IDEX_memRead, EXMEM_lbi, EXMEM_slbi, MEMWB_lbi, MEMWB_slbi;
	output 	stall, forwarding_ex_Rs, forwarding_ex_Rt, forwarding_mem_Rs, forwarding_mem_Rt;
	wire	[3:0] count, count_out, count_in;
	wire 	stallCtl;
	wire 	stallcounterRst;
	wire 	stallcountEn;
	wire 	data_hazard;
	wire 	jk_out;
	//assign stallcounterRst = rst | ~stallCtl | stall;

	//assign stall

	//assign flush = 1'b0;
	
    //assign stall = 1'b0;
    // TODO: 尝试下能不能直接把 IF_RS和IF_Rt，ID_memRead接进来
    assign data_hazard = IDEX_memRead & ((IDEX_Rt == IFID_Rs)|(IDEX_Rt == IFID_Rt));
	//count stall_cnt(.clk(clk), .rst(rst), .en(stallcountEn), .clear(stallcounterRst), .cnt_o(count_out) );
	jk_r stall_ctl(.q(jk_out), .j(data_hazard), .k(1'b1), .clk(clk), .rst(rst));
	assign stall = jk_out? 0:data_hazard;
	//assign stall = jk_out;
/*	
	assign count_in = (count_out == 4'h5)? 4'h0:count_out;
 	reg4 countdff(.clk(clk), .rst(stallcounterRst), .en(1'b1), .D(count_in), .Q(count));
	cla_4b counter(.A(count), .B(4'h1), .C_in(1'b0), .S(count_out), .P(), .G(), .C_out());
*/

	assign forwarding_ex_Rs = EXMEM_regWrite & (EXMEM_Rd == IDEX_Rs) & ~jk_out;
	assign forwarding_ex_Rt = EXMEM_regWrite & (EXMEM_Rd == IDEX_Rt) & ~jk_out; 
	//assign forwarding_ex_Rd = EX
	assign forwarding_mem_Rs = MEMWB_regWrite & (MEMWB_Rd == IDEX_Rs);
	assign forwarding_mem_Rt = MEMWB_regWrite & (MEMWB_Rd == IDEX_Rt);

	//assign stallcountEn = (count_out == 4'h0 & IDEX_memRead);
	//assign stallcounterRst = IDEX_memRead | (count_out == 4'h4);
endmodule
