/*
   CS/ECE 552 Spring '20
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
module execute (aluOp, sl, sco, seq, slbi, btr, aluSrc, jumpCtl, jrCtl, linkCtl, branchCtl, regData1, regData2, immVal, inc_pc, instr, invA, invB, new_pc, Out, Zero, Ofl, memRead, memWrite);

   input sl, sco, seq;
   input slbi, invA, invB, aluSrc, btr, jumpCtl, jrCtl, linkCtl, branchCtl, memRead, memWrite;
   input [15:0] regData1, regData2, immVal, instr, inc_pc;
   input [2:0] aluOp;
   wire [15:0] jb_pc, InA, inA, InB, inB, rotaterightbits, immValShifted, jumpValSigned, branchValSigned, pc_or_rs, aluOut, setOut;
   wire [2:0] opCode;
   wire sign, setOutput, cout, Cin, sltresult, sleresult;
   output [15:0] Out, new_pc;
   output Zero, Ofl;
   wire  [15:0] jump_pc, branch_pc;
   wire beqz, bnez, bltz, bgez;
   // slt and sle for last parts
   //assign setOutput = sco ? cout : seq ? (InA == InB) : (sl & instr[11]) ? ($signed(InA) < $signed(InB)) : ($signed(InA) <= $signed(InB));
   //assign subCtl = (instr[15:11]==5'b01001)|((instr[15:11]==5'b11011)&(instr[1:0]==2'b01));
   // Top wire connecting to alu
   assign InA = slbi ? (regData1 << 8) : regData1;

   // Bottom wire connecting to alu
   assign inB = branchCtl? 16'h0000 : aluSrc ? immVal :  regData2;

   cla_16b rightrotatebits(.A(16'h0010), .B(~inB), .C_in (1'b1), .S(rotaterightbits), .C_out());
   // What operation is it
   // If an immediate is present, will have to use
   // Different bit numbers to represent
   assign InB = ((instr[15:11] == 5'b10110)|((instr[15:11]==5'b11010)&instr[1:0]==2'b10))? rotaterightbits : inB;
   /* opCode = slbi? 3'b110:
                   (instr[15:11] == 5'b10101)? 3'b001:
                   ((instr[15:11] == 5'b10110)|(instr[15:11]==5'b11010)|(instr[15:11] == 5'b11010 & instr[0] == 1'b0))? 3'b000:
      ((jumpCtl & jrCtl)|memRead|memWrite)? 3'b100 : (sl|seq|sco)? 3'b101:immPres ? {~instr[13], instr[12:11]} : {instr[11],instr[1:0]};
      */
   assign sign = (regData1[15] | regData2[15]);

   alu executeALU(.slbi(slbi),.InA(InA), .InB(InB), .Cin(1'b0), .Op(aluOp), .invA(1'b0), .invB(1'b0), .sign(sign), .Out(aluOut), .Zero(Zero), .Ofl(Ofl), .cout(cout));  

   assign Out = (sl | seq | sco) ? setOut : btr ? {InA[0],InA[1],InA[2],InA[3],InA[4],InA[5],InA[6],InA[7],InA[8],InA[9],InA[10],InA[11],InA[12],InA[13],InA[14],InA[15]} : aluOut;

   assign sltresult = (InA[15]&InB[15])|(~InA[15]&~InB[15])?~aluOut[15]&~Zero:(InA[15]&~InB[15]);
   assign sleresult = sltresult | Zero;
   assign setOutput = (sl&seq)? sleresult : (seq&~sl)? Zero:(sl&~seq)? sltresult : sco? cout : 0;

   assign setOut = setOutput?16'h0001:16'h0000;
   //assign immValShifted = immVal << 1;
   //cla_16b next_pc_add(.A(pc), .B(2), .C_in(0), .S(next_pc), .C_out());

   cla_16b jb_pc_add(.A(inc_pc), .B(immVal), .C_in(0), .S(jb_pc), .C_out());

   // Sign extend the branch and jump values
   //assign jumpValSigned = instr[11] ? {{8{jumpVal[10]}}, jumpVal[7:0]} : {{4{jumpVal[10]}}, jumpVal[10:0]};
   //assign branchValSigned = { {8{branchVal[7]}}, branchVal[7:0]};

   assign jump_pc = jrCtl? aluOut:jb_pc;
   assign beqz = (instr[15:11] == 5'b01100)? 1:0;
   assign bnez = (instr[15:11] == 5'b01101)? 1:0;
   assign bltz = (instr[15:11] == 5'b01110)? 1:0;
   assign bgez = (instr[15:11] == 5'b01111)? 1:0;
   assign branch_pc = ((beqz&Zero)|(bnez&~Zero)|(bltz&aluOut[15])|(bgez&~aluOut[15]))?jb_pc:inc_pc;
   assign new_pc = jumpCtl?jump_pc:branch_pc;



endmodule
