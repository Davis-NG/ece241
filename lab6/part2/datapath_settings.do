onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath/clk
add wave -noupdate /datapath/resetn
add wave -noupdate -radix unsigned /datapath/data_in
add wave -noupdate /datapath/ld_alu_out
add wave -noupdate /datapath/ld_x
add wave -noupdate /datapath/ld_a
add wave -noupdate /datapath/ld_b
add wave -noupdate /datapath/ld_c
add wave -noupdate /datapath/ld_r
add wave -noupdate /datapath/alu_op
add wave -noupdate /datapath/alu_select_a
add wave -noupdate /datapath/alu_select_b
add wave -noupdate -radix unsigned /datapath/data_result
add wave -noupdate -radix unsigned /datapath/a
add wave -noupdate -radix unsigned /datapath/b
add wave -noupdate -radix unsigned /datapath/c
add wave -noupdate -radix unsigned /datapath/x
add wave -noupdate -radix unsigned /datapath/alu_out
add wave -noupdate -radix unsigned /datapath/alu_a
add wave -noupdate -radix unsigned /datapath/alu_b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8667 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {73500 ps}
