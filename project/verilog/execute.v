/*
   CS/ECE 552 Spring '20
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
module execute (aluOp, sl, sco, seq, lbi, slbi, btr, ror, aluSrc, jumpCtl, branchCtl, regData1, regData2, immVal, inc_pc, new_pc, Out, Zero, Ofl, PCsrc);

   input sl, sco, seq, ror;
   input lbi, slbi, aluSrc, btr;
   input [15:0] regData1, regData2, immVal, inc_pc;
   input [2:0] aluOp, jumpCtl, branchCtl;
   wire [15:0] pc_add, InA, inA, InB, inB, rotaterightbits, immValShifted, jumpValSigned, branchValSigned, aluOut, setOut;
   wire [2:0] opCode;
   wire sign, setOutput, cout, Cin, sltresult, sleresult, branch;
   output [15:0] Out, new_pc;
   output Zero, Ofl, PCsrc;

   wire beqz, bnez, bltz, bgez;

   assign InA = slbi ? (regData1 << 8) : regData1;

   assign inB = aluSrc ? immVal :  regData2;

   cla_16b rightrotatebits(.A(16'h0010), .B(~inB), .C_in (1'b1), .S(rotaterightbits), .C_out());

   assign InB = ror? rotaterightbits : inB;

   assign sign = (regData1[15] | regData2[15]);

   alu executeALU(.slbi(slbi),.InA(InA), .InB(InB), .Cin(1'b0), .Op(aluOp), .invA(1'b0), .invB(1'b0), .sign(sign), .Out(aluOut), .Zero(Zero), .Ofl(Ofl), .cout(cout));  

   assign Out = lbi? immVal : (sl | seq | sco) ? setOut : btr ? {InA[0],InA[1],InA[2],InA[3],InA[4],InA[5],InA[6],InA[7],InA[8],InA[9],InA[10],InA[11],InA[12],InA[13],InA[14],InA[15]} : aluOut;

   assign sltresult = (InA[15]&InB[15])|(~InA[15]&~InB[15])?~aluOut[15]&~Zero:(InA[15]&~InB[15]);
   assign sleresult = sltresult | Zero;
   assign setOutput = (sl&seq)? sleresult : (seq&~sl)? Zero:(sl&~seq)? sltresult : sco? cout : 0;

   assign setOut = setOutput?16'h0001:16'h0000;

   cla_16b jb_pc_add(.A(inc_pc), .B(immVal), .C_in(0), .S(pc_add), .C_out());


   branchctlunit branchunit(.regData1(regData1), .branchCtl(branchCtl), .branch(branch));
   assign PCsrc = branch|jumpCtl[2];
   assign new_pc = jumpCtl[0]?aluOut:pc_add;

endmodule
