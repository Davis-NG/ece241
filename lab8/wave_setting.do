onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /part1/iColour
add wave -noupdate /part1/iResetn
add wave -noupdate /part1/iClock
add wave -noupdate -radix unsigned /part1/oX
add wave -noupdate -radix unsigned /part1/oY
add wave -noupdate /part1/oColour
add wave -noupdate /part1/oPlot
add wave -noupdate /part1/oNewFrame
add wave -noupdate /part1/x_count_en
add wave -noupdate /part1/y_count_en
add wave -noupdate -radix unsigned /part1/FrameCounter
add wave -noupdate /part1/erase
add wave -noupdate /part1/count_en
add wave -noupdate -radix unsigned /part1/x_count
add wave -noupdate -radix unsigned /part1/x_init
add wave -noupdate -radix unsigned /part1/y_count
add wave -noupdate -radix unsigned /part1/y_init
add wave -noupdate /part1/C0/clk
add wave -noupdate /part1/C0/resetn
add wave -noupdate -radix unsigned /part1/C0/x_count
add wave -noupdate -radix unsigned /part1/C0/y_count
add wave -noupdate -radix unsigned /part1/C0/FrameCounter
add wave -noupdate /part1/C0/x_count_en
add wave -noupdate /part1/C0/y_count_en
add wave -noupdate /part1/C0/plot
add wave -noupdate /part1/C0/erase
add wave -noupdate /part1/C0/count_en
add wave -noupdate /part1/C0/newFrame
add wave -noupdate -radix unsigned /part1/C0/current_state
add wave -noupdate -radix unsigned /part1/C0/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8246439 ps} 0}
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
WaveRestoreZoom {0 ps} {105010500 ps}
