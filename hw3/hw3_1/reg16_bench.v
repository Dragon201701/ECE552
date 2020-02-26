module reg16_bench;
   
   reg clk, rst, en;
   reg [15:0] D, Q;

   reg16 DUT (.D(D), .clk(clk), .rst(rst), .en(en), .Q(Q) );
   
initial begin
  for (int i=0; i<16l i = i + 1) begin
      D = i;
      @(posedge clk);
  end
end

always
  #5 clk = ~clk;

initial begin
  $display("\t\ttime,\tclk,\tQ,\tD"); 
  $monitor("%d,\t%b,\t%b,\t%b",$time, clk, Q, D);
end

initial
 #100 $finish;


endmodule // alu_hier_bench
