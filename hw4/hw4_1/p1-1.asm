// Copyright (c) 2020, Yuanzhe Liu
// All rights reserved.
//
// EX-EX forwarding Test
// The EX-EX forwarding is that the result of first instruction ALU operation can be 
// directly feed into the next instructions's alu input. 
//
// ECE/CS552, Spring 2020
// Yuanzhe Liu, 3/24/2020
lbi		r0, 8
lbi		r1, 16
lbi		r2, 32
ADD		r3, r0, r1 // R3 <= 24
ADD		r4, r3, r2 // R4 <= 56
