onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R0_out
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R1_out
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R2_out
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R3_out
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R4_out
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R5_out
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R6_out
add wave -noupdate -expand -group Registers /proc_hier_pbench/DUT/p0/decodeStage/decodeRegisters/registers/R7_out
add wave -noupdate -expand -group IFID /proc_hier_pbench/DUT/p0/IFID_PC
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/instr
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/Rs
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/Rt
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/read1Data
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/read2Data
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/regWriteOut
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/RdIn
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/RdOut
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/writeData
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/PC_new
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/PCsrc
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/flush
add wave -noupdate -group Decode /proc_hier_pbench/DUT/p0/decodeStage/branch
add wave -noupdate -expand -group IDEX /proc_hier_pbench/DUT/p0/IDEX_PC
add wave -noupdate -expand -group IDEX /proc_hier_pbench/DUT/p0/IDEX_Rs
add wave -noupdate -expand -group IDEX /proc_hier_pbench/DUT/p0/IDEX_Rt
add wave -noupdate -expand -group IDEX /proc_hier_pbench/DUT/p0/IDEX_Rd
add wave -noupdate -group Forwarding -divider {Forwarding EX-EX}
add wave -noupdate -group Forwarding /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_ex_Rs
add wave -noupdate -group Forwarding /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_ex_Rt
add wave -noupdate -group Forwarding -divider {Forwarding EX-MEM}
add wave -noupdate -group Forwarding /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_mem_Rs
add wave -noupdate -group Forwarding /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_mem_Rt
add wave -noupdate -expand -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_PC
add wave -noupdate -expand -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_Rs
add wave -noupdate -expand -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_Rt
add wave -noupdate -expand -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_Rd
add wave -noupdate -expand -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_regWrite
add wave -noupdate /proc_hier_pbench/DUT/p0/stall
add wave -noupdate /proc_hier_pbench/DUT/p0/flush
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/instr
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC_inc
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC_new
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/Rs
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/Rt
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/stall
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC_next
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PCsrc
add wave -noupdate /proc_hier_pbench/DUT/p0/Pipeline_Control/data_hazard
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_PC
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_Rs
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_Rt
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_Rd
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_regWrite
add wave -noupdate /proc_hier_pbench/DUT/p0/IFID/stall
add wave -noupdate /proc_hier_pbench/DUT/p0/Pipeline_Control/data_hazard
add wave -noupdate /proc_hier_pbench/DUT/p0/Pipeline_Control/IFID_Rs
add wave -noupdate /proc_hier_pbench/DUT/p0/Pipeline_Control/IFID_Rt
add wave -noupdate /proc_hier_pbench/DUT/p0/Pipeline_Control/IDEX_Rt
add wave -noupdate /proc_hier_pbench/DUT/p0/Pipeline_Control/IDEX_memRead
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/memRead
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/memWrite
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/wrData
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/aluOut
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/memoryOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1133 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 169
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3655 ns}
