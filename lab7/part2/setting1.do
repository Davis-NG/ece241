onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /part2/iClock
add wave -noupdate /part2/iResetn
add wave -noupdate /part2/iPlotBox
add wave -noupdate /part2/iBlack
add wave -noupdate /part2/iLoadX
add wave -noupdate /part2/iColour
add wave -noupdate -radix unsigned /part2/iXY_Coord
add wave -noupdate -radix unsigned /part2/oX
add wave -noupdate -radix unsigned /part2/oY
add wave -noupdate /part2/oColour
add wave -noupdate /part2/oPlot
add wave -noupdate /part2/oDone
add wave -noupdate /part2/ld_x
add wave -noupdate /part2/ld_y
add wave -noupdate /part2/ld_colo
add wave -noupdate /part2/x_count_en
add wave -noupdate /part2/y_count_en
add wave -noupdate /part2/clear
add wave -noupdate -radix unsigned /part2/x_count
add wave -noupdate -radix unsigned /part2/y_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1533269 ps} 0}
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
WaveRestoreZoom {0 ps} {4105500 ps}
