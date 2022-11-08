# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.v

#load simulation using mux as the top level simulation module
vsim part2 

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# create clock
force ClockIn 1 0ms, 0 {2ms} -r 4ms

# reset
force Reset 1
run 4ms

force Reset 0
force Speed 2'b00
run 24 ms

force Reset 1
run 24ms

force Reset 0
run 24ms

force Reset 1
run 24ms

force Reset 0
run 24ms

force Reset 1
run 24ms