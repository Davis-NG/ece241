onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /part3/Clock
add wave -noupdate /part3/Resetn
add wave -noupdate /part3/Go
add wave -noupdate -radix unsigned /part3/Divisor
add wave -noupdate -radix unsigned /part3/Dividend
add wave -noupdate -radix unsigned /part3/Quotient
add wave -noupdate -radix unsigned /part3/Remainder
add wave -noupdate /part3/ResultValid
add wave -noupdate /part3/ld_value
add wave -noupdate /part3/ld_result
add wave -noupdate /part3/shift
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {542947 ps} 0}
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
WaveRestoreZoom {0 ps} {3160500 ps}
