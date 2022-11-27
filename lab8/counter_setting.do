onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Counter/clk
add wave -noupdate /Counter/resetn
add wave -noupdate /Counter/count_en
add wave -noupdate -radix unsigned /Counter/x_init
add wave -noupdate -radix unsigned /Counter/y_init
add wave -noupdate /Counter/DirX
add wave -noupdate /Counter/DirY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {305525 ps} 0}
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
WaveRestoreZoom {2525 ps} {1063025 ps}
