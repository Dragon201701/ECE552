module mux4_16 (sel, in0, in1, in2, in3, out);
	input	[1:0]	sel;
	input	[15:0]	in0, in1, in2, in3;
	output 	reg	[15:0]	out;
	always @(*) begin
		case (sel)
			2'b00: out <= in0;
			2'b01: out <= in1;
			2'b10: out <= in2;
			2'b11: out <= in3;
		endcase // sel
	end

endmodule