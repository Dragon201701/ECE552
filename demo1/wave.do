onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /proc_hier_bench/PC
add wave -noupdate -radix binary /proc_hier_bench/Inst
add wave -noupdate /proc_hier_bench/RegWrite
add wave -noupdate /proc_hier_bench/WriteRegister
add wave -noupdate /proc_hier_bench/WriteData
add wave -noupdate /proc_hier_bench/MemWrite
add wave -noupdate /proc_hier_bench/MemRead
add wave -noupdate /proc_hier_bench/MemAddress
add wave -noupdate /proc_hier_bench/MemData
add wave -noupdate /proc_hier_bench/Halt
add wave -noupdate /proc_hier_bench/inst_count
add wave -noupdate /proc_hier_bench/trace_file
add wave -noupdate /proc_hier_bench/sim_log_file
add wave -noupdate /proc_hier_bench/Rs
add wave -noupdate -divider Control
add wave -noupdate /proc_hier_bench/DUT/p0/ctlSignals/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {397 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 276
configure wave -valuecolwidth 132
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
WaveRestoreZoom {0 ns} {2605 ns}
