// Copyright (c) 2020, Yuanzhe Liu
// All rights reserved.
//
// Branch Prediction program 2 
// a simple condition Branch
// a = (a<b)? a:a+2
// ECE/CS552, Spring 2020
// Yuanzhe Liu, 3/24/2020
lbi r0, 4
lbi r1, 8
slt r2, r0, r1
bnez r2, .Done
addi r0, r0, 2
.Done:
halt