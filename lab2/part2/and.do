# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.v

#load simulation using mux as the top level simulation module
vsim v7408

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {pin5} 0
force {pin4} 0
run 10ns

force {pin5} 1
force {pin4} 0
run 10ns

force {pin5} 0
force {pin4} 1
run 10ns

force {pin5} 1
force {pin4} 1
run 10ns