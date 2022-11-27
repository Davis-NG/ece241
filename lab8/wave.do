vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part1.v

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
do wave_setting2.do

# create clock
force {iClock} 0 0ns, 1 {5ns} -r 10ns

# reset circuit (active low)
force iResetn 0
force iColour 3'd3
run 10ns

force iResetn 1
run 100000ns