// Copyright (c) 2020, Yuanzhe Liu
// All rights reserved.
//
// Branch Prediction program 1 
// sum 1 to 10
// A for loop that sums 1 to 10 together (of course, get 55) 
// for (i = 10; i > 0; i--)
//	sum += i;
// ECE/CS552, Spring 2020
// Yuanzhe Liu, 3/24/2020

lbi r0, 10; //loop index
lbi r1, 0; // sum result
// lbi r3, 0; // compare result

.Loop:
	beqz r0, .Loop_Done
	add r1, r1, r0
	subi r0, r0, 1
	j .Loop

.Loop_Done:
	halt