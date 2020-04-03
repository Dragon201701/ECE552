module hazard (branchCtl_fd, branchCtl_dx, stu_fd, stu_dx, stu_xm, jumpCtl_fd, jumpCtl_dx, regWrite_fd, regWrite_dx, regWrite_xm, readReg1, readReg2, writeReg1, readReg1_fd, readReg1_dx, readReg1_xm, readReg2_fd, readReg2_dx, readReg2_xm, writeReg1_fd, writeReg1_dx, writeReg1_xm, ex_hazard, no_Op);

   input [2:0] readReg1, readReg2, writeReg1;
   input [2:0] readReg1_fd, readReg1_dx, readReg1_xm, readReg2_fd, readReg2_dx, readReg2_xm, writeReg1_fd, writeReg1_dx, writeReg1_xm;
   input regWrite_fd, regWrite_dx, regWrite_xm;
   input jumpCtl_fd, jumpCtl_dx;
   input stu_fd, stu_dx, stu_xm;
   input branchCtl_fd, branchCtl_dx;

   output no_Op;
   output ex_hazard;
   wire control_hazard, stu_hazard;

   assign ex_hazard = (((readReg1 == writeReg1_fd) & (regWrite_fd == 1'b1)) |
	              ((readReg1 == writeReg1_dx) & (regWrite_dx == 1'b1)) |
		      ((readReg1 == writeReg1_xm) & (regWrite_xm == 1'b1)) |
		      ((readReg2 == writeReg1_fd) & (regWrite_fd == 1'b1)) |
		      ((readReg2 == writeReg1_dx) & (regWrite_dx == 1'b1)) |
		      ((readReg2 == writeReg1_xm) & (regWrite_xm == 1'b1)));

   // Special case, stu hazard. 
   // Rs is being written to, so have to check
   assign stu_hazard = (((stu_fd == 1'b1) & (readReg1 == readReg1_fd)) |
	   		((stu_fd == 1'b1) & (readReg2 == readReg1_fd)) |
			((stu_dx == 1'b1) & (readReg1 == readReg1_dx)) |
			((stu_dx == 1'b1) & (readReg2 == readReg1_dx)) | 
			((stu_xm == 1'b1) & (readReg1 == readReg1_xm)) |
			((stu_xm == 1'b1) & (readReg2 == readReg1_xm)));
	      
   assign control_hazard = (jumpCtl_fd | jumpCtl_dx | branchCtl_fd | branchCtl_dx );

   assign no_Op = (ex_hazard | control_hazard | stu_hazard) ? 1'b1 : 1'b0;




endmodule
