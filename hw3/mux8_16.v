module mux8_16 (clk, rst, en, read1_sel, read2_sel, write1_sel, in0, in1, in2, in3, in4, in5, in6, in7, read1_out, read2_out, write1_out);

	// TODO: Probably want to do this param in regFile.v
	parameter N = 16;

	// Handle write enable stuff in regFile.v

	input clk, rst, en;
	input	[2:0]	read1_sel, read2_sel, write1_sel;
	input	[N-1:0]	in0, in1, in2, in3, in4, in5, in6, in7;
	output	[N-1:0]	read1_out, read2_out, write1_out;

	wire [N-1:0] out0, out1, out2, out3, out4, out5, out6, out7;
	wire [7:0] decode_out_r1, decode_out_r2, decode_out_w1;

	// The 3 bits select the register
	// 16 bit output
	reg16 in_0(.D(in0[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_0[15:0]);
	reg16 in_1(.D(in1[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_1[15:0]);
	reg16 in_2(.D(in2[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_2[15:0]);
	reg16 in_3(.D(in3[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_3[15:0]);
	reg16 in_4(.D(in4[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_4[15:0]);
	reg16 in_5(.D(in5[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_5[15:0]);
	reg16 in_6(.D(in6[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_6[15:0]);
	reg16 in_7(.D(in7[15:0]), .clk(clk), .rst(rst), .en(en), .Q(out_7[15:0]);
	
	// Decoder. Select REG
	dec3to8 decode_read1(.in(read1_sel[2:0]), .out(decode_out_r1[7:0]));
	dec3to8 decode_read2(.in(read2_sel[2:0]), .out(decode_out_r2[7:0]));
	dec3to8 decode_out1(.in(write1_sel[2:0]), .out(decode_out_w1[7:0]));

	// Output logic for read1
	case (decode_out_r1[7:0])
		8'b00000001: assign read_1[15:0] = out_0[15:0];
		8'b00000010: assign read_1[15:0] = out_1[15:0];
		8'b00000100: assign read_1[15:0] = out_2[15:0];
		8'b00001000: assign read_1[15:0] = out_3[15:0];
		8'b00010000: assign read_1[15:0] = out_4[15:0];
		8'b00100000: assign read_1[15:0] = out_5[15:0];
		8'b01000000: assign read_1[15:0] = out_6[15:0];
		8'b10000000: assign read_1[15:0] = out_7[15:0];

	// Output logic for read2
	case (decode_out_w1[7:0])
		8'b00000001: assign read_2[15:0] = out_0[15:0];
		8'b00000010: assign read_2[15:0] = out_1[15:0];
		8'b00000100: assign read_2[15:0] = out_2[15:0];
		8'b00001000: assign read_2[15:0] = out_3[15:0];
		8'b00010000: assign read_2[15:0] = out_4[15:0];
		8'b00100000: assign read_2[15:0] = out_5[15:0];
		8'b01000000: assign read_2[15:0] = out_6[15:0];
		8'b10000000: assign read_2[15:0] = out_7[15:0];

	// Output logic for write1
	case (decode_out_[7:0])
		8'b00000001: assign write1_out[15:0] = out_0[15:0];
		8'b00000010: assign write1_out[15:0] = out_1[15:0];
		8'b00000100: assign write1_out[15:0] = out_2[15:0];
		8'b00001000: assign write1_out[15:0] = out_3[15:0];
		8'b00010000: assign write1_out[15:0] = out_4[15:0];
		8'b00100000: assign write1_out[15:0] = out_5[15:0];
		8'b01000000: assign write1_out[15:0] = out_6[15:0];
		8'b10000000: assign write1_out[15:0] = out_7[15:0];
		
endmodule