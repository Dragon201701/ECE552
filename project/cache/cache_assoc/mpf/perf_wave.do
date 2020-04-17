onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mem_system_perfbench/Addr
add wave -noupdate -radix ascii /mem_system_perfbench/addr_trace_file_name
add wave -noupdate /mem_system_perfbench/CacheHit
add wave -noupdate /mem_system_perfbench/CacheHit_ref
add wave -noupdate /mem_system_perfbench/clk
add wave -noupdate /mem_system_perfbench/DataIn
add wave -noupdate /mem_system_perfbench/DataOut
add wave -noupdate /mem_system_perfbench/DataOut_ref
add wave -noupdate /mem_system_perfbench/Done
add wave -noupdate /mem_system_perfbench/Done_ref
add wave -noupdate /mem_system_perfbench/fd
add wave -noupdate /mem_system_perfbench/n_cache_hits
add wave -noupdate /mem_system_perfbench/n_replies
add wave -noupdate /mem_system_perfbench/n_requests
add wave -noupdate /mem_system_perfbench/reg_readorwrite
add wave -noupdate /mem_system_perfbench/req_cycle
add wave -noupdate /mem_system_perfbench/rst
add wave -noupdate /mem_system_perfbench/rval
add wave -noupdate /mem_system_perfbench/Stall
add wave -noupdate /mem_system_perfbench/Stall_ref
add wave -noupdate /mem_system_perfbench/test_success
add wave -noupdate /mem_system_perfbench/Rd
add wave -noupdate /mem_system_perfbench/Wr
add wave -noupdate -divider State
add wave -noupdate /mem_system_perfbench/DUT/m0/control/state
add wave -noupdate -divider Cache
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/comp
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/write
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/data_in
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/data_out
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/dirty
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/enable
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/err
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/hit
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/valid
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/valid_in
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/index
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/offset
add wave -noupdate -expand -group Cache0 /mem_system_perfbench/DUT/m0/c0/tag_in
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/comp
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/write
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/data_in
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/data_out
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/dirty
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/enable
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/err
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/hit
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/valid
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/valid_in
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/index
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/offset
add wave -noupdate -expand -group Cache1 /mem_system_perfbench/DUT/m0/c1/tag_in
add wave -noupdate -divider Memory
add wave -noupdate -expand -group Memory /mem_system_perfbench/DUT/m0/mem/addr
add wave -noupdate -expand -group Memory /mem_system_perfbench/DUT/m0/mem/data_in
add wave -noupdate -expand -group Memory /mem_system_perfbench/DUT/m0/mem/err
add wave -noupdate -expand -group Memory /mem_system_perfbench/DUT/m0/mem/rd
add wave -noupdate -expand -group Memory /mem_system_perfbench/DUT/m0/mem/stall
add wave -noupdate -expand -group Memory /mem_system_perfbench/DUT/m0/mem/wr
add wave -noupdate -expand -group Memory /mem_system_perfbench/DUT/m0/mem/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2514 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 265
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
WaveRestoreZoom {810 ns} {4471 ns}
