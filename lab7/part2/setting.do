onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /part2/iClock
add wave -noupdate /part2/iResetn
add wave -noupdate /part2/iPlotBox
add wave -noupdate /part2/iBlack
add wave -noupdate /part2/iLoadX
add wave -noupdate -radix unsigned /part2/iXY_Coord
add wave -noupdate /part2/iColour
add wave -noupdate -radix unsigned /part2/oX
add wave -noupdate -radix unsigned /part2/oY
add wave -noupdate /part2/oColour
add wave -noupdate /part2/oPlot
add wave -noupdate /part2/oDone
add wave -noupdate /part2/C0/clk
add wave -noupdate /part2/C0/resetn
add wave -noupdate /part2/C0/plotBox
add wave -noupdate /part2/C0/black
add wave -noupdate /part2/C0/loadx
add wave -noupdate -radix unsigned /part2/C0/x_count
add wave -noupdate -radix unsigned /part2/C0/y_count
add wave -noupdate /part2/C0/plot
add wave -noupdate /part2/C0/x_count_en
add wave -noupdate /part2/C0/y_count_en
add wave -noupdate /part2/C0/ld_x
add wave -noupdate /part2/C0/ld_y
add wave -noupdate /part2/C0/ld_colo
add wave -noupdate /part2/C0/clear
add wave -noupdate -radix unsigned /part2/C0/current_state
add wave -noupdate -radix unsigned /part2/C0/next_state
add wave -noupdate /part2/C0/done
add wave -noupdate /part2/D0/clk
add wave -noupdate /part2/D0/resetn
add wave -noupdate /part2/D0/x_count_en
add wave -noupdate /part2/D0/y_count_en
add wave -noupdate /part2/D0/ld_x
add wave -noupdate /part2/D0/ld_y
add wave -noupdate /part2/D0/ld_colo
add wave -noupdate /part2/D0/clear
add wave -noupdate -radix unsigned /part2/D0/X
add wave -noupdate -radix unsigned /part2/D0/Y
add wave -noupdate -radix unsigned /part2/D0/x_count
add wave -noupdate -radix unsigned /part2/D0/y_count
add wave -noupdate -radix unsigned /part2/D0/coord
add wave -noupdate /part2/D0/colour
add wave -noupdate -radix unsigned /part2/D0/outX
add wave -noupdate -radix unsigned /part2/D0/outY
add wave -noupdate /part2/D0/outColo
add wave -noupdate /part2/D0/colo
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {152372 ps} 0}
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
WaveRestoreZoom {0 ps} {1375500 ps}
