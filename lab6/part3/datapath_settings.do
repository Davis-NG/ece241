onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath/clk
add wave -noupdate /datapath/resetn
add wave -noupdate /datapath/Divisor
add wave -noupdate /datapath/Dividend
add wave -noupdate /datapath/ld_a
add wave -noupdate /datapath/ld_divisor
add wave -noupdate /datapath/ld_dividend
add wave -noupdate /datapath/ld_quotient
add wave -noupdate /datapath/ld_remainder
add wave -noupdate /datapath/shift
add wave -noupdate /datapath/Quotient
add wave -noupdate /datapath/Remainder
add wave -noupdate /datapath/a
add wave -noupdate /datapath/dividend
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {89156 ps} {90156 ps}
