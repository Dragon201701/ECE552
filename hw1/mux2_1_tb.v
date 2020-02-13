module mux2_1_tb();
	reg InA;
	reg InB;
	reg S;
	wire Out;
	reg clk;
	mux2_1 iDUT(.InA(InA), .InB(InB), .S(S), .Out(Out));

	initial begin
		clk = 1'b0;
		InA = 1'b0;
		InB = 1'b0;
		S = 1'b0;
		#10
		InA = 1'b1;
		InB = 1'b0;
		#10
		InA = 1'b1;
		InB = 1'b1;
		#10
		InA = 1'b0;
		InB = 1'b1;
		#10
		InA = 1'b0;
		InB = 1'b0;
		S = 1'b1;
		#10
		InA = 1'b1;
		InB = 1'b0;
		#10
		InA = 1'b1;
		InB = 1'b1;
		#10
		InA = 1'b0;
		InB = 1'b1;
	end
	always
		#5 clk = ~clk;
	
endmodule
