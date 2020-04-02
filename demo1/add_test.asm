//Test of loading a register with addi
slbi r1, 0x4
slbi r2, 0x1
slbi r3, 0x2
slbi r4, 0x3
slbi r5, 0x4
slbi r6, 0x5
stu r1, r1, -1
stu r2, r2, 1
stu r3, r3, 1
nop
nop
nop
nop
nop
nop
halt

