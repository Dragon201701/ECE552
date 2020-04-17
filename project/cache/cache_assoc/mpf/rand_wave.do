onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mem_system_randbench/clk
add wave -noupdate /mem_system_randbench/CacheHit
add wave -noupdate /mem_system_randbench/CacheHit_ref
add wave -noupdate /mem_system_randbench/DataIn
add wave -noupdate /mem_system_randbench/DataOut
add wave -noupdate /mem_system_randbench/DataOut_ref
add wave -noupdate /mem_system_randbench/Done
add wave -noupdate /mem_system_randbench/Done_ref
add wave -noupdate /mem_system_randbench/rst
add wave -noupdate /mem_system_randbench/Stall
add wave -noupdate /mem_system_randbench/Stall_ref
add wave -noupdate -divider {New Divider}
add wave -noupdate /mem_system_randbench/Addr
add wave -noupdate /mem_system_randbench/DUT/m0/Rd
add wave -noupdate /mem_system_randbench/DUT/m0/Wr
add wave -noupdate /mem_system_randbench/DUT/m0/state
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_addr
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_write
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_compare
add wave -noupdate -expand -group Cache -divider {New Divider}
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_data
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_done
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_en
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_err
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/cache_hit
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/complete
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/valid
add wave -noupdate -expand -group Cache /mem_system_randbench/DUT/m0/dirty
add wave -noupdate -expand -group Memory /mem_system_randbench/DUT/m0/mem_data
add wave -noupdate -expand -group Memory /mem_system_randbench/DUT/m0/mem_err
add wave -noupdate -expand -group Memory /mem_system_randbench/DUT/m0/memory_read
add wave -noupdate -expand -group Memory /mem_system_randbench/DUT/m0/memory_write
add wave -noupdate -expand -group Memory /mem_system_randbench/DUT/m0/mem_stall
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4839 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {4013 ns} {9263 ns}
