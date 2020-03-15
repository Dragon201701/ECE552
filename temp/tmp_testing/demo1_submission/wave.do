onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /proc_hier_bench/PC
add wave -noupdate /proc_hier_bench/Inst
add wave -noupdate /proc_hier_bench/inst_count
add wave -noupdate /proc_hier_bench/PC
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R0_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R1_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R2_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R3_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R4_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R5_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R6_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R7_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/writeEn
add wave -noupdate -divider Execution
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/regWrite
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/aluSrc
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/btr
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/memWrite
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/memRead
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/memToReg
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/branchCtl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/jumpCtl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/jrCtl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/linkCtl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/invA
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/invB
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/halt
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/noOp
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/immCtl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/extCtl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/stu
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/slbi
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/immPres
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/lbi
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/seq
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/sl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/sco
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/ctlSignals/aluCtl
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/executeStage/executeALU/sign
add wave -noupdate -group {Control Signals} /proc_hier_bench/DUT/p0/executeStage/executeALU/Zero
add wave -noupdate -divider ALU
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/executeALU/Cin
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/executeALU/InA
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/executeALU/InB
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/executeALU/invA
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/executeALU/invB
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/inB
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/subCtl
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/rotatebits
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1158 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 388
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
WaveRestoreZoom {9293 ns} {11633 ns}
