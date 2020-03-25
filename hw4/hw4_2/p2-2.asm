// Copyright (c) 2020, Yuanzhe Liu
// All rights reserved.
//
// Branch Prediction program 2 
// sum 1 to 10
// A for loop that sums 1 to 10 together (of course, get 55) 
// for (i = 10; i > 0; i--)
//	sum += i;
// If I implement in this way, I am actually doing a do-while loop
// i = 10;
// do{
//     sum += i;
//     i--;
// }while(i!=0);
// At most of the time the branch is TAKEN.
// ECE/CS552, Spring 2020
// Yuanzhe Liu, 3/24/2020

lbi r0, 10 //loop index
lbi r1, 0 // sum result
// lbi r3, 0; // compare result

.Loop:
	add r1, r1, r0
	addi r0, r0, -1
	bnez r0, .Loop // if r0 != 0, continue.
.Loop_Done:
	halt

