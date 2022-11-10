onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /part2/Clock
add wave -noupdate /part2/Resetn
add wave -noupdate /part2/Go
add wave -noupdate -radix unsigned /part2/DataIn
add wave -noupdate -radix unsigned /part2/DataResult
add wave -noupdate /part2/ResultValid
add wave -noupdate /part2/ld_a
add wave -noupdate /part2/ld_b
add wave -noupdate /part2/ld_c
add wave -noupdate /part2/ld_x
add wave -noupdate /part2/ld_r
add wave -noupdate /part2/ld_alu_out
add wave -noupdate /part2/alu_select_a
add wave -noupdate /part2/alu_select_b
add wave -noupdate /part2/alu_op
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7743202 ps} 0}
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
WaveRestoreZoom {0 ps} {17860500 ps}
