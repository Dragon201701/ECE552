// Copyright (c) 2020, Yuanzhe Liu
// All rights reserved.
//
// Register by-passing Test
// The register by-passing allows the data to be write 
// into the register and read out at the same time
//
// ECE/CS552, Spring 2020
// Yuanzhe Liu, 3/24/2020
lbi r0, 2
lbi r1, 5
lbi r2, 0
sub r2, r1, r0
lbi r3, 1
andn r3, r3, r1
add r4, r2, r0

