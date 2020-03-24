// Copyright (c) 2020, Yuanzhe Liu
// All rights reserved.
//
// MEM-EX forwarding Test
// When the next instruction requires data from previous load instruction, 
// the load-use data hazard arise. The MEM-EX forwarding will allow the data
// available at the end of memory stage of previous instruction available to feed 
// into the next instruction execution stage. However, we still have to stall one cycle.
//
// ECE/CS552, Spring 2020
// Yuanzhe Liu, 3/24/2020

lbi r0, U.Here
slbi r0, L.Here   // r0 contains address of ".Here"
lbi r1, 7         // r1 = 7
lbi r2, 8
st r1, r0, 0      // .Here = 7
ld r3, r0, 0      // r3 = 7
NOP
sub r3, r2, r3	  // r3 = 1

// Some empty memory to play around in:
.Here:

halt
halt
halt
halt