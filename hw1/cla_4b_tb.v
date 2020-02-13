module cla_4b_tb ();
	reg	[3:0]	A, B;
	wire [3:0]	S;
	reg			C_in;
	wire		P,G,C_out;
	reg			clk;
	wire		Cout;
	wire	[3:0]	Sum;
	reg	[4:0]	result;
	reg	goldenP, goldenG, p3, p2, p1, p0, g3, g2, g1, g0;
	cla_4b iDUT(.A(A), .B(B), .C_in(C_in), .S(S),
		.P(P), .G(G), .C_out(C_out));
	assign Sum = result[3:0];
	assign Cout = result[4];
	initial begin 
		A = 4'b0000;
		B = 4'b0000;
		C_in = 0;
		clk = 0;
	end
	always@(posedge clk) begin
      	A[3:0] = $random;
      	B[3:0] = $random;
      	C_in = $random;
		result = A + B + C_in;
		p3=A[3]|B[3];
		p2=A[2]|B[2];
		p1=A[1]|B[1];
		p0=A[0]|B[0];
		g3=A[3]&B[3];
		g2=A[2]&B[2];
		g1=A[1]&B[1];
		g0=A[0]&B[0];
		goldenP=p0&p1&p2&p3;
		goldenG=g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0);
    end
    always
    	#5	clk = ~clk;
endmodule
