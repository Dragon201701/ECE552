/*
   CS/ECE 552 Spring '20
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
module fetch (clk, rst, PCsrc, PC_new, PC_inc, PC, instr);

   input clk, rst, PCsrc;
   input [15:0] PC_new;

   output [15:0] PC_inc, instr, PC;
   wire   [15:0] PC_next;
   wire halt, noOp;
   assign halt = (instr[15:11] == 5'b00000)?1:0;
   assign noOp = (instr[15:11] == 5'b00001)?1:0;
  assign PC_next = rst? 16'h0000 :
                   halt? PC :
                   noOp? PC_inc :
                   PCsrc? PC_new : PC_inc;
  reg16 pcreg(.clk(clk),.rst(rst),.en(1'b1),.D(PC_next), .Q(PC));
  // Initialize memory
  // TODO: Change memory back to syn type
   memory2c instr_mem(.data_out(instr), .data_in(PC), .addr(PC), .enable(1'b1), .wr(1'b0), .createdump(clk), .clk(clk), .rst(rst) );
   
  cla_16b incPC(.A(PC), .B(16'h0002), .C_in(1'b0), .S(PC_inc), .C_out());
   
  //assign readReg1 = instr[10:8];
  //assign readReg2 = instr[7:5];
  // If lbi asserted, store into Rs.
  // If immPres, have to use higher bits for Rd
  // Else do lower bits
  //assign writeReg1 = immPres ? instr[7:5] : lbi ? instr[10:8] : instr[4:2];
  //assign writeReg1 = jumpCtl ? 3'b111 : (immPres ? immCtl ? instr[10:8] : instr[7:5] : instr[4:2]);
  
  //assign immVal = immCtl ? {{8{0}},instr[7:0]} : {{11{0}},instr[4:0]};


  // TODO: EPC, noOp
  //assign pc_inc = halt ? pc : pc_next;
  //assign pc_inc = pc_add;
endmodule
