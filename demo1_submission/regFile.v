/*
   CS/ECE 552, Spring '20
   Homework #3, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module regFile (
                // Outputs
                read1Data, read2Data, err,
                // Inputs
                clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                );
    
  input        clk, rst;
  input [2:0]  read1RegSel;
  input [2:0]  read2RegSel;
  input [2:0]  writeRegSel;
  input [15:0] writeData;
  input        writeEn;
  output [15:0] read1Data;
  output [15:0] read2Data;
  output        err;

  parameter N = 16;
  wire [7:0] writedec_out, writeRegSel_dec;
  wire [N-1:0] R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out;
  wire en0, en1, en2, en3, en4, en5, en6, en7;
  assign en0 = writeRegSel_dec[0] & writeEn;
  assign en1 = writeRegSel_dec[1] & writeEn;
  assign en2 = writeRegSel_dec[2] & writeEn;
  assign en3 = writeRegSel_dec[3] & writeEn;
  assign en4 = writeRegSel_dec[4] & writeEn;
  assign en5 = writeRegSel_dec[5] & writeEn;
  assign en6 = writeRegSel_dec[6] & writeEn;
  assign en7 = writeRegSel_dec[7] & writeEn;
  //regFilecode regFilecode(.clk(clk), .rst(rst), .wr_en(writeEn), .read1_sel(read1RegSel), .read2_sel(read2RegSel), .write1_sel(writeRegSel), .data_data(writeData), .read1_out(read1Data), .read2_out(read2Data), .err(err));
  reg16 R0(.D(writeData), .clk(clk), .rst(rst), .en(en0), .Q(R0_out));
  reg16 R1(.D(writeData), .clk(clk), .rst(rst), .en(en1), .Q(R1_out));
  reg16 R2(.D(writeData), .clk(clk), .rst(rst), .en(en2), .Q(R2_out));
  reg16 R3(.D(writeData), .clk(clk), .rst(rst), .en(en3), .Q(R3_out));
  reg16 R4(.D(writeData), .clk(clk), .rst(rst), .en(en4), .Q(R4_out));
  reg16 R5(.D(writeData), .clk(clk), .rst(rst), .en(en5), .Q(R5_out));
  reg16 R6(.D(writeData), .clk(clk), .rst(rst), .en(en6), .Q(R6_out));
  reg16 R7(.D(writeData), .clk(clk), .rst(rst), .en(en7), .Q(R7_out));

  dec3to8 decoder_write(.in(writeRegSel), .out(writeRegSel_dec));
  
  mux8_16 read1mux(.sel(read1RegSel), .in0(R0_out), .in1(R1_out), .in2(R2_out),
    .in3(R3_out), .in4(R4_out), .in5(R5_out), .in6(R6_out), .in7(R7_out), .out(read1Data));
  mux8_16 read2mux(.sel(read2RegSel), .in0(R0_out), .in1(R1_out), .in2(R2_out),
    .in3(R3_out), .in4(R4_out), .in5(R5_out), .in6(R6_out), .in7(R7_out), .out(read2Data));

endmodule
