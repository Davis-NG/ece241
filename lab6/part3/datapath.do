onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath/clk
add wave -noupdate /datapath/resetn
add wave -noupdate -radix unsigned /datapath/Divisor
add wave -noupdate -radix unsigned /datapath/Dividend
add wave -noupdate /datapath/ld_value
add wave -noupdate /datapath/ld_result
add wave -noupdate /datapath/shift
add wave -noupdate -radix unsigned /datapath/Quotient
add wave -noupdate -radix unsigned /datapath/Remainder
add wave -noupdate -radix unsigned /datapath/a
add wave -noupdate -radix unsigned /datapath/divisor
add wave -noupdate -radix unsigned /datapath/dividend
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161325 ps} 0}
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
WaveRestoreZoom {400 ps} {168400 ps}
