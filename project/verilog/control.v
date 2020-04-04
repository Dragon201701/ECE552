// Control Logic signals for our processor
module control(instr, clk, rst, sl, sco, seq, regWrite, aluOp, aluSrc, memWrite, memRead, memToReg, branchCtl, jumpCtl, halt, noOp, immCtl, extCtl, stu, slbi, immPres, lbi, btr, ror);

   input clk, rst;
   input [15:0] instr;
   output reg [2:0] branchCtl, jumpCtl;
   output reg regWrite, aluSrc, btr, memWrite, memRead, memToReg, halt, noOp, immCtl, extCtl, stu, lbi, slbi, immPres, ror;
   output reg seq, sl, sco;
   output reg [2:0] aluOp;


// Consult Excel Sheet for signal layout for each instruction
always @ (*)
begin

	// Default have halt and noOp deasserted
	halt <= 0;
	noOp <= 0;
	btr <= 0;
	sco <= 0;
	sl <= 0;
	seq <= 0;
	branchCtl <= 3'b000;
	jumpCtl <= 3'b000;
	stu <= 0;
	aluOp <= 3'b000;
	lbi <= 0;
	slbi <= 0;
	ror <= 0;
	case (instr[15:11])
        5'b00000: begin
        	// HALT, Don't Cares
        	regWrite <= 0; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
              halt <= 1; noOp <= 0; immCtl <= 0; extCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0;  
             
        end
        5'b00001: begin noOp <= 1;// NOP, Don't Cares
			
			regWrite <= 0; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
              halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0;	  
            
		  end
		// Addi
		5'b01000: begin
			
			regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
              halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1;	  
             aluOp <= 3'b100;
	  	end
		// Subi
		5'b01001: begin
			
			regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
              halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1;
            aluOp <= 3'b101;
	  end
	// Xori
	5'b01010: begin
			
		  	regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1;
                   aluOp <= 3'b110;
	  end
	// Andi
	5'b01011: begin
			
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 0; stu <= 0; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b111;
	  end
	// Roli
	5'b10100: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b000;
	  end
	// Slli
	5'b10101: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b001;
	  end
	// Rori
	5'b10110: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b000; ror <= 1;
	  end
	// Srli
	5'b10111: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b011;
	  end
	// St
	5'b10000: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 1'b1; memRead <= 0; memToReg <= 1; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b100;
	  end
        // Ld
	5'b10001: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 1'b1; memToReg <= 1; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b100;
	  end
        // Stu
	5'b10011: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 1; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 1; stu <= 1; slbi <= 0; immPres <= 1; 
                   aluOp <= 3'b100;
	  end
	// Btr
	5'b11001: begin 
		
	          regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   
		  btr <= 1;
	  end
	// Add, Sub, Xor, Andn 
	5'b11011: begin 
		
	          regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= {1'b1, instr[1:0]};
	  end
	// Rol, Sll, Ror, Srl
	5'b11010: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= instr[0]? {1'b0, instr[1:0]} : 3'b000; ror <= (instr[1:0] == 2'b10)?1:0;
	  end
        // Seq
	5'b11100: begin 
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b101;
		  seq <= 1;
	  end
        // Slt
	5'b11101: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b101;
		  sl <= 1;
	  end
	// Sle
	5'b11110: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b101;
		  sl <= 1; seq <= 1;
	  end
	// Sco
	5'b11111: begin
		
		  regWrite <= 1; aluSrc <= 0; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b100;
		  sco <= 1;
	  end
	// Beqz
	5'b01100: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 3'b100;
                    halt <= 0; noOp <= 0; immCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b101;
	  end
        // Bnez
	5'b01101: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 3'b101;
                    halt <= 0; noOp <= 0; immCtl <= 1; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b101;
	  end
	// Bltz
	5'b01110: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 3'b110;
                    halt <= 0; noOp <= 0; immCtl <= 1; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <=3'b101;
	  end
	// Bgez
	5'b01111: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; branchCtl <= 3'b111;
                    halt <= 0; noOp <= 0; immCtl <= 1; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b101;
	  end
	// Lbi
	5'b11000: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 1; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 1; lbi <= 1;
	  end
	// Slbi
	5'b10010: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0; 
                    halt <= 0; noOp <= 0; immCtl <= 1; extCtl <= 0; stu <= 0; slbi <= 1; immPres <= 1; 
	  end
	// J displacement
	5'b00100: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0;  jumpCtl <= 3'b100;
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                   
	  end
	// Jr
	5'b00101: begin
		
		  regWrite <= 0; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0;  jumpCtl <= 3'b101; 
                    halt <= 0; noOp <= 0; immCtl <= 1; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b100;
	  end
 	// Jal
	5'b00110: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0;  jumpCtl <= 3'b110; 
                    halt <= 0; noOp <= 0; immCtl <= 0; extCtl <= 0; stu <= 0; slbi <= 0; immPres <= 0; 
                  
	  end
	// Jalr
	5'b00111: begin
		
		  regWrite <= 1; aluSrc <= 1; memWrite <= 0; memRead <= 0; memToReg <= 0;  jumpCtl <= 3'b111; 
                    halt <= 0; noOp <= 0; immCtl <= 1; extCtl <= 1; stu <= 0; slbi <= 0; immPres <= 0; 
                   aluOp <= 3'b100;
	  end
	  5'b00010:begin end // siic
	  5'b00011: begin end // RTI
	  default: begin end // ERROR
   endcase
end


endmodule
