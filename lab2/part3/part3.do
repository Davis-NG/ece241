# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim hex_decoder

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {c[0]} 0
force {c[1]} 0
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 1
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 0
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 0
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 1
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 1
force {c[3]} 0
run 10ns

force {c[0]} 0
force {c[1]} 0
force {c[2]} 0
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 0
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 0
force {c[3]} 1
run 10ns

force {c[0]} 0
force {c[1]} 0
force {c[2]} 1
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 0
force {c[2]} 1
force {c[3]} 1
run 10ns

force {c[0]} 0
force {c[1]} 1
force {c[2]} 1
force {c[3]} 1
run 10ns

force {c[0]} 1
force {c[1]} 1
force {c[2]} 1
force {c[3]} 1
run 10ns