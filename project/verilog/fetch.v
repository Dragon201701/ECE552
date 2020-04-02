/*
   CS/ECE 552 Spring '20
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
module fetch (pc, clk, rst, halt, pc_inc, instr);

   input clk, rst, halt;
   input [15:0] pc;

   output [15:0] pc_inc, instr;
   wire   [15:0] pc_add;
  // Initialize memory
  // TODO: Change memory back to syn type
   memory2c instr_mem(.data_out(instr), .data_in(pc), .addr(pc), .enable(1'b1), .wr(1'b0), .createdump(clk), .clk(clk), .rst(rst) );
   
  cla_16b incPC(.A(pc), .B(16'h0002), .C_in(1'b0), .S(pc_add), .C_out());
   
  //assign readReg1 = instr[10:8];
  //assign readReg2 = instr[7:5];
  // If lbi asserted, store into Rs.
  // If immPres, have to use higher bits for Rd
  // Else do lower bits
  //assign writeReg1 = immPres ? instr[7:5] : lbi ? instr[10:8] : instr[4:2];
  //assign writeReg1 = jumpCtl ? 3'b111 : (immPres ? immCtl ? instr[10:8] : instr[7:5] : instr[4:2]);
  
  //assign immVal = immCtl ? {{8{0}},instr[7:0]} : {{11{0}},instr[4:0]};


  // TODO: EPC, noOp
  assign pc_inc = halt ? pc : pc_add;
  //assign pc_inc = pc_add;
endmodule