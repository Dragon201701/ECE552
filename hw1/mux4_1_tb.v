module mux4_1_tb();
	reg InA;
	reg InB;
	reg InC;
	reg InD;
	reg [1:0] S;
	wire Out;
	mux4_1 iDUT(.InA(InA), .InB(InB), .InC(InC), .InD(InD), .S(S), .Out(Out));

	initial begin
		InA = 1'b0;
		InB = 1'b0;
		InC = 1'b0;
		InD = 1'b0; 
		S = 2'b00;
		#16 S = 2'b01;
		#32 S = 2'b10;
		#48 S = 2'b11;

	end
	always begin 
		#1 InA = ~InA;
	end
	always begin 
		#2 InB = ~InB;
	end
	always begin 
		#4 InC = ~InC;
	end
	always begin 
		#8 InD = ~InD;
	end
endmodule