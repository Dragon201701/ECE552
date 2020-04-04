onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /proc_hier_bench/PC
add wave -noupdate /proc_hier_bench/next_PC
add wave -noupdate /proc_hier_bench/Inst
add wave -noupdate /proc_hier_bench/inst_count
add wave -noupdate /proc_hier_bench/trace_file
add wave -noupdate /proc_hier_bench/WriteData
add wave -noupdate /proc_hier_bench/WriteRegister
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R0_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R1_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R2_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R3_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R4_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R5_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R6_out
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R7_out
add wave -noupdate -group ALU /proc_hier_bench/DUT/p0/executeStage/executeALU/InA
add wave -noupdate -group ALU /proc_hier_bench/DUT/p0/executeStage/executeALU/InB
add wave -noupdate -group ALU /proc_hier_bench/DUT/p0/executeStage/inB
add wave -noupdate -group ALU /proc_hier_bench/DUT/p0/executeStage/executeALU/Op
add wave -noupdate -group ALU /proc_hier_bench/DUT/p0/executeStage/executeALU/shifter_out
add wave -noupdate -group ALU /proc_hier_bench/DUT/p0/executeStage/executeALU/LOGIC_RESULT
add wave -noupdate -group ALU /proc_hier_bench/DUT/p0/executeStage/executeALU/Out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2718 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 383
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {1237 ns}
