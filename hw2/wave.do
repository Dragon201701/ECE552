onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Input /shifter_hier_bench/Op
add wave -noupdate -expand -group Input -expand /shifter_hier_bench/Cnt
add wave -noupdate -expand -group Input /shifter_hier_bench/In
add wave -noupdate /shifter_hier_bench/DUT/s0/out_stage1
add wave -noupdate /shifter_hier_bench/DUT/s0/out_stage2
add wave -noupdate /shifter_hier_bench/DUT/s0/out_stage3
add wave -noupdate /shifter_hier_bench/Out
add wave -noupdate /shifter_hier_bench/Expected
add wave -noupdate /shifter_hier_bench/idx
add wave -noupdate -group Constant /shifter_hier_bench/C
add wave -noupdate -group Constant /shifter_hier_bench/O
add wave -noupdate -group Constant /shifter_hier_bench/N
add wave -noupdate /shifter_hier_bench/fail
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {163 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
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
WaveRestoreZoom {0 ns} {2626 ns}
