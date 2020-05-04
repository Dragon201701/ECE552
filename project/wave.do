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
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/instr
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC_inc
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC_new
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/Rs
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/Rt
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/stall
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PC_next
add wave -noupdate -group Fetch /proc_hier_pbench/DUT/p0/fetchStage/PCsrc
add wave -noupdate -expand -group IFID /proc_hier_pbench/DUT/p0/IFID_PC
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/instr
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/Rs
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/Rt
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/read1Data
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/read2Data
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/regWriteOut
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/regWriteIn
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/RdIn
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/RdOut
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/writeData
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/PC_new
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/PCsrc
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/flush
add wave -noupdate -expand -group Decode /proc_hier_pbench/DUT/p0/decodeStage/branch
add wave -noupdate -group IDEX /proc_hier_pbench/DUT/p0/IDEX_PC
add wave -noupdate -group IDEX /proc_hier_pbench/DUT/p0/IDEX_Rs
add wave -noupdate -group IDEX /proc_hier_pbench/DUT/p0/IDEX_Rt
add wave -noupdate -group IDEX /proc_hier_pbench/DUT/p0/IDEX_Rd
add wave -noupdate -group IDEX /proc_hier_pbench/DUT/p0/Pipeline_Control/IDEX_memRead
add wave -noupdate -group IDEX /proc_hier_pbench/DUT/p0/IDEX_regWrite
add wave -noupdate -group IDEX /proc_hier_pbench/DUT/p0/IDEX_memWrite
add wave -noupdate -expand -group Pipeline -divider {Forwarding EX-EX}
add wave -noupdate -expand -group Pipeline /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_ex_Rs
add wave -noupdate -expand -group Pipeline /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_ex_Rt
add wave -noupdate -expand -group Pipeline -divider {Forwarding EX-MEM}
add wave -noupdate -expand -group Pipeline /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_mem_Rs
add wave -noupdate -expand -group Pipeline /proc_hier_pbench/DUT/p0/Pipeline_Control/forwarding_mem_Rt
add wave -noupdate -expand -group Pipeline -divider Control
add wave -noupdate -expand -group Pipeline /proc_hier_pbench/DUT/p0/Pipeline_Control/data_hazard
add wave -noupdate -expand -group Pipeline /proc_hier_pbench/DUT/p0/stall
add wave -noupdate -expand -group Pipeline /proc_hier_pbench/DUT/p0/flush
add wave -noupdate -expand -group Execute -radix hexadecimal /proc_hier_pbench/DUT/p0/executeStage/regData1
add wave -noupdate -expand -group Execute /proc_hier_pbench/DUT/p0/executeStage/regData2
add wave -noupdate -expand -group Execute -radix hexadecimal /proc_hier_pbench/DUT/p0/executeStage/Out
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_PC
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_Rs
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_Rt
add wave -noupdate -expand -group EXMEM /proc_hier_pbench/DUT/p0/EXMEM_Rd
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/memWrite
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/memRead
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/Addr
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/DataIn
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/DataOut
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/Done
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/Stall
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/CacheHit
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/err
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/state
add wave -noupdate -expand -group Memory -expand -group Data_mem /proc_hier_pbench/DUT/p0/memoryStage/data_mem/control/next_state
add wave -noupdate -expand -group Memory -radix decimal /proc_hier_pbench/DUT/p0/memoryStage/wrData
add wave -noupdate -expand -group Memory -radix decimal /proc_hier_pbench/DUT/p0/memoryStage/aluOut
add wave -noupdate -expand -group Memory /proc_hier_pbench/DUT/p0/memoryStage/memoryOut
add wave -noupdate -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_PC
add wave -noupdate -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_Rs
add wave -noupdate -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_Rt
add wave -noupdate -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_Rd
add wave -noupdate -group MEMWB /proc_hier_pbench/DUT/p0/MEMWB_regWrite
add wave -noupdate -expand -group stall /proc_hier_pbench/DUT/p0/fetchStage/instrmem_stall
add wave -noupdate -expand -group stall /proc_hier_pbench/DUT/p0/mem_stall
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12330 ns} 0} {Trace {15736 ns} 0}
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
WaveRestoreZoom {10013 ns} {16213 ns}
