/*
   CS/ECE 552 Spring '20
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
module execute (ldOrSt, sl, sco, seq, immPres, slbi, btr, aluSrc, regData1, regData2, immVal, immCtl, jump, branch, jumpVal, branchVal, pc, instr, invA, invB, next_pc, Out, wrData, Zero, Ofl);

   input sl, sco, seq, ldOrSt;
   input slbi, jump, branch, immCtl, invA, invB, aluSrc, immPres, btr;
   input [15:0] regData1, regData2, immVal, branchVal, jumpVal, instr, pc;
   wire [15:0] almost_newPc, newPc, InA, InB, immValShifted, jumpValSigned, branchValSigned, pc_or_rs, aluOut;
   wire [2:0] opCode;
   wire sign, setOutput, cout, doWeBranch;

   output [15:0] next_pc, Out, wrData;
   output Zero, Ofl;

   // slt and sle for last parts
   assign setOutput = sco ? cout : seq ? (InA == InB) : (sl & instr[11]) ? ($signed(InA) < $signed(InB)) : ($signed(InA) <= $signed(InB));

   // Top wire connecting to alu
   assign InA = slbi ? (regData1 << 8) : regData1;

   // Bottom wire connecting to alu
   assign InB = aluSrc ? immVal : regData2;

   assign wrData = regData2;

   // What operation is it
   // If an immediate is present, will have to use
   // Different bit numbers to represent
   assign opCode = ldOrSt ? instr[15:13] : (immPres ? {~instr[13], instr[12:11]} : {instr[11],instr[1:0]});

   assign sign = (regData1[15] | regData2[15]);

   alu executeALU(.slbi(slbi), .InA(InA), .InB(InB), .Cin(1'b0), .Op(opCode), .invA(invA), .invB(invB), .sign(sign), .Out(aluOut), .Zero(Zero), .Ofl(Ofl), .cout(cout));  

   assign Out = (sl | seq | sco) ? setOutput : btr ? {InA[0],InA[1],InA[2],InA[3],InA[4],InA[5],InA[6],InA[7],InA[8],InA[9],InA[10],InA[11],InA[12],InA[13],InA[14],InA[15]} : aluOut;

   assign immValShifted = immVal << 1;

   // Sign extend the branch and jump values
   assign jumpValSigned = instr[11] ? {{8{jumpVal[10]}}, jumpVal[7:0]} : {{4{jumpVal[10]}}, jumpVal[10:0]};
   assign branchValSigned = { {8{branchVal[7]}}, branchVal[7:0]};


   // Choose where to use PC or Rs for JR and JALR instructions
   // Assume regData1 is regRs
   assign pc_or_rs = (jump & immCtl) ? regData1 : pc;

   // 2-bit mux for resolving the next instruction
   assign almost_newPc = jump ? jumpValSigned : branch ? branchValSigned : immVal;
   assign newPc = almost_newPc + pc_or_rs;

 
   // Resolve branches
   assign doWeBranch = (instr[12:11] == 2'b00 & branch) ? (regData1[15:0] == 0) :
	   (instr[12:11] == 2'b01 & branch) ? (regData1[15:0] != 0):
	   (instr[12:11] == 2'b10 & branch) ? (regData1[15]) :
	   (instr[12:11] == 2'b11 & branch) ? (~regData1[15]): 1'b0;

   // Either new PC or old PC
   assign next_pc = (jump | doWeBranch) ? newPc : pc;

   // TODO: Probably add logic for Zero and Ofl

endmodule
