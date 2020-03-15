onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /proc_hier_bench/PC
add wave -noupdate /proc_hier_bench/next_PC
add wave -noupdate /proc_hier_bench/Inst
add wave -noupdate /proc_hier_bench/Halt
add wave -noupdate /proc_hier_bench/inst_count
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R0_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R1_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R2_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R3_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R4_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R5_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R6_out
add wave -noupdate -expand -group Registers /proc_hier_bench/DUT/p0/decodeStage/decodeRegisters/R7_out
add wave -noupdate -divider extension
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/exImmVaL
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/extension/instr
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/extension/jumpimm
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/extension/extVal
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/extension/immCTL
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/extension/extCTL
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/extension/jumpCTL
add wave -noupdate -divider Execution
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/InA
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/InB
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/aluOut
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/jrCtl
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/aluSrc
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/inc_pc
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/immVal
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/beqz
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/bnez
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/bltz
add wave -noupdate /proc_hier_bench/DUT/p0/executeStage/bgez
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
add wave -noupdate /proc_hier_bench/DUT/p0/decodeStage/writeEn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3161 ns} 0}
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
WaveRestoreZoom {2502 ns} {3448 ns}
