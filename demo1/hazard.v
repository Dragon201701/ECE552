module hazard (regWrite_fd, regWrite_dx, regWrite_xm, readReg1, readReg2, writeReg1, readReg1_fd, readReg1_dx, readReg1_xm, readReg2_fd, readReg2_dx, readReg2_xm, writeReg1_fd, writeReg1_dx, writeReg1_xm, ex_hazard, no_Op);

   input [2:0] readReg1, readReg2, writeReg1;
   input [2:0] readReg1_fd, readReg1_dx, readReg1_xm, readReg2_fd, readReg2_dx, readReg2_xm, writeReg1_fd, writeReg1_dx, writeReg1_xm;
   input regWrite_fd, regWrite_dx, regWrite_xm;

   output no_Op;
   output ex_hazard;


   assign ex_hazard = (((readReg1 == writeReg1_fd) & (regWrite_fd == 1'b1)) |
	              ((readReg1 == writeReg1_dx) & (regWrite_dx == 1'b1)) |
		      ((readReg1 == writeReg1_xm) & (regWrite_xm == 1'b1)) |
		      ((readReg2 == writeReg1_fd) & (regWrite_fd == 1'b1)) |
		      ((readReg2 == writeReg1_dx) & (regWrite_dx == 1'b1)) |
		      ((readReg2 == writeReg1_xm) & (regWrite_xm == 1'b1)));
   assign no_Op = ex_hazard ? 1'b1 : 1'b0;




endmodule
