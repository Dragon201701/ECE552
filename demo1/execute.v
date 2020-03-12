/*
   CS/ECE 552 Spring '20
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
module execute (slbi, aluSrc, regData1, regData2, immVal, immCtl, jump, branch, jumpVal, branchVal, pc, instr, invA, invB, next_pc, Out, wrData, Zero, Ofl);


   input slbi, jump, branch, immCtl, invA, invB, aluSrc;
   input [15:0] regData1, regData2, immVal, branchVal, jumpVal, instr, pc;
   wire [15:0] InA, InB, immValShifted, jumpValSigned, branchValSigned, pc_or_rs;
   wire [2:0] opCode;
   wire sign;

   output [15:0] next_pc, Out, wrData;
   output Zero, Ofl;

   // Top wire connecting to alu
   assign InA = slbi ? (regData1 << 8) : regData1;

   // Bottom wire connecting to alu
   assign InB = aluSrc ? immVal : regData2;

   // What operation is it
   assign opCode = {instr[11],instr[1:0]};
   assign sign = (regData1[15] | regData2[15]);

   alu executeALU(.InA(InA), .InB(InB), .Cin(1'b0), .Op(opCode), .invA(invA), .invB(invB), .sign(sign), .Out(Out), .Zero(Zero), .Ofl(Ofl));  

   assign immValShifted = immVal << 1;

   // Sign extend the branch and jump values
   assign jumpValSigned = { {4{jumpVal[10]}}, jumpVal[10:0]};
   assign branchValSigned = { {8{branchVal[7]}}, branchVal[7:0]};


   // Choose where to use PC or Rs for JR and JALR instructions
   // Assume regData1 is regRs
   assign pc_or_rs = (jump & immCtl) ? regData1 : pc;

   // 2-bit mux for resolving the next instruction
   assign almost_newPc = jump ? jumpValSigned : branch ? branchValSigned : immVal;
   assign newPc = almost_newPc + pc_or_rs;

   // Either new PC or old PC
   assign next_pc = (jump | branch) ? newPc : pc;

   // TODO: Probably add logic for Zero and Ofl

endmodule
