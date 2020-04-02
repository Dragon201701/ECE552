// Control Logic signals for our processor
module control(instr, clk, rst, ldOrSt, sl, sco, seq, regWrite, aluSrc, aluCtl, memWrite, memRead, memToReg, branchCtl, jumpCtl, invA, invB, halt, noOp, immCtl, stu, slbi, immPres, lbi, btr);

   input clk, rst;
   input [15:0] instr;
   output reg regWrite, aluSrc, btr, memWrite, memRead, memToReg, branchCtl, jumpCtl, invA, invB, halt, noOp, immCtl, stu, slbi, immPres, lbi;
   output reg seq, sl, sco, ldOrSt;
   output reg [1:0] aluCtl;

// Consult Excel Sheet for signal layout for each instruction
always @ (*)
begin

	// Default have halt and noOp deasserted
	stu <= 0;
	halt <= 0;
	noOp <= 0;
	ldOrSt <= 0;
	btr <= 0;
	sco <= 0;
	sl <= 0;
	seq <= 0;
	case (instr[15:11])
        5'b00000: begin
        	// HALT, Don't Cares
        	regWrite <= 0; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
            invA <= 0; invB <= 0; halt <= 1; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;	  
            aluCtl <= 0;
        end
        5'b00001: begin noOp <= 1;// NOP, Don't Cares
			
			regWrite <= 0; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
            invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;	  
            aluCtl <= 0;
		  end
		// Addi
		5'b01000: begin
			
			regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
            invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;	  
            aluCtl <= 0;
	  	end
		// Subi
		5'b01001: begin
			
			regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
            invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
            aluCtl <= 1;
	  end
	// Xori
	5'b01010: begin
			
		  	regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 2;
	  end
	// Andi
	5'b01011: begin
			
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Roli
	5'b10100: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Slli
	5'b10101: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Rori
	5'b10110: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Srli
	5'b10111: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0;
	  end
	// St
	5'b10000: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 1; memRead <= 0; memToReg <= 1; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0; ldOrSt <= 1;
	  end
        // Ld
	5'b10001: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 1; memToReg <= 1; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0; ldOrSt <= 1;
	  end
        // Stu
	5'b10011: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 1; memRead <= 0; memToReg <= 1; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 1; slbi <= 0; immPres <= 1; lbi <= 0;
                  aluCtl <= 0; ldOrSt <= 1;
	  end
	// Btr
	5'b11001: begin 
		
	          regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
		  btr <= 1;
	  end
	// Add, Sub, Xor, Andn  TODO: Set invB for andn
	5'b11011: begin 
		
	          regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Rol, Sll, Ror, Srl
	5'b11010: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
        // Seq
	5'b11100: begin 
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
		  seq <= 1;
	  end
        // Slt
	5'b11101: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
		  sl <= 1;
	  end
	// Sle
	5'b11110: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
		  sl <= 1;
	  end
	// Sco
	5'b11111: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
		  sco <= 1;
	  end
	// Beqz
	5'b01100: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 1; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
        // Bnez
	5'b01101: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 1; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Bltz
	5'b01110: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 1; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Bgez
	5'b01111: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 1; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Lbi
	5'b11000: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 1;
                  aluCtl <= 0;
	  end
	// Slbi
	5'b10010: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 0;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 1; immPres <= 1; lbi <= 0;
                  aluCtl <= 0;
	  end
	// J displacement
	5'b00100: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 1;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Jr
	5'b00101: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 1;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
 	// Jal
	5'b00110: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 1;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
	// Jalr
	5'b00111: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 0; jumpCtl <= 1;
                  invA <= 0; invB <= 0; halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; lbi <= 0;
                  aluCtl <= 0;
	  end
	  5'b00010:begin end // siic
	  5'b00011: begin end // RTI
	  default: begin end // ERROR
   endcase
end

// aluCtl logic

endmodule
