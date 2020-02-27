module mux8_16 (clk, rst, wr_en, read1_sel, read2_sel, write1_sel, data_in, read1_out, read2_out, err);

	// TODO: Probably want to do this param in regFile.v
	parameter N = 16;

	input clk, rst, wr_en;
	input	[2:0]	read1_sel, read2_sel, write1_sel;
	input	[N-1:0]	data_in;
	output reg [N-1:0]	read1_out, read2_out;
	output reg err;

	wire [N-1:0] out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7;
	wire [7:0] decode_out_r1, decode_out_r2, decode_out_w1, en;

	// The 3 bits select the register
	// 16 bit output
	reg16 in_0(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[0]), .Q(out_0[15:0]));
	reg16 in_1(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[1]), .Q(out_1[15:0]));
	reg16 in_2(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[2]), .Q(out_2[15:0]));
	reg16 in_3(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[3]), .Q(out_3[15:0]));
	reg16 in_4(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[4]), .Q(out_4[15:0]));
	reg16 in_5(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[5]), .Q(out_5[15:0]));
	reg16 in_6(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[6]), .Q(out_6[15:0]));
	reg16 in_7(.D(data_in[15:0]), .clk(clk), .rst(rst), .en(en[7]), .Q(out_7[15:0]));
	
	// Decoder. Select REG
	dec3to8 decode_read1(.in(read1_sel[2:0]), .out(decode_out_r1[7:0]));
	dec3to8 decode_read2(.in(read2_sel[2:0]), .out(decode_out_r2[7:0]));
	dec3to8 decode_out1(.in(write1_sel[2:0]), .out(decode_out_w1[7:0]));


always @ (decode_out_r1, decode_out_r2) begin

	// Output logic for read1
	err <= 1'b0;
	case (decode_out_r1[7:0])
		8'b00000001: read1_out[15:0] <= out_0[15:0]; 
		8'b00000010: read1_out[15:0] <= out_1[15:0]; 
		8'b00000100: read1_out[15:0] <= out_2[15:0]; 
		8'b00001000: read1_out[15:0] <= out_3[15:0]; 
		8'b00010000: read1_out[15:0] <= out_4[15:0]; 
		8'b00100000: read1_out[15:0] <= out_5[15:0]; 
		8'b01000000: read1_out[15:0] <= out_6[15:0]; 
		8'b10000000: read1_out[15:0] <= out_7[15:0]; 
		default: err <= 1'b1;
        endcase
	// Output logic for read2
	case (decode_out_r2[7:0])
		8'b00000001: read2_out[15:0] <= out_0[15:0]; 
		8'b00000010: read2_out[15:0] <= out_1[15:0]; 
		8'b00000100: read2_out[15:0] <= out_2[15:0]; 
		8'b00001000: read2_out[15:0] <= out_3[15:0]; 
		8'b00010000: read2_out[15:0] <= out_4[15:0]; 
		8'b00100000: read2_out[15:0] <= out_5[15:0]; 
		8'b01000000: read2_out[15:0] <= out_6[15:0]; 
		8'b10000000: read2_out[15:0] <= out_7[15:0]; 
		default: err <= 1'b1;
        endcase
end

        assign en = wr_en ? decode_out_w1[7:0] : 8'b00000000;
		
endmodule
