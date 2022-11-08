# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.v

#load simulation using mux as the top level simulation module
vsim mux2to1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {x} 0
force {y} 0
force {s} 0
run 10ns

force {x} 1
force {y} 0
force {s} 0
run 10ns

force {x} 0
force {y} 1
force {s} 0
run 10ns

force {x} 1
force {y} 1
force {s} 0
run 10ns

force {x} 0
force {y} 0
force {s} 1
run 10ns

force {x} 1
force {y} 0
force {s} 1
run 10ns

force {x} 0
force {y} 1
force {s} 1
run 10ns

force {x} 1
force {y} 1
force {s} 1
run 10ns
