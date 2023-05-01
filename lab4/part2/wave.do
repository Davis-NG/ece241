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
force {Clock} 0 0ns, 1 {5ns} -r 10ns

# reset
force Reset_b 0
run 10ns

# Testing own addition
force Reset_b 1
force Function 3'b000
force Data 4'b0001
run 30ns

force Data 4'b0011
run 30ns


# reset
force Reset_b 0
run 10ns

# Testing Verilog addition
force Reset_b 1
force Function 3'b001
force Data 4'b0001
run 30ns

force Data 4'b0011
run 30ns


# reset
force Reset_b 0
run 10ns

# Testing sign extension 
force Reset_b 1
force Function 3'b010
force Data 4'b0111
run 10ns

force Function 3'b000
run 10ns

force Function 3'b010
run 10ns

force Reset_b 0
run 10ns
force Reset_b 1
run 10ns

force Function 3'b000
force Data 4'b1001
run 10ns

force Function 3'b010
run 10ns

# Testing case 8 hold current value from register
force Function 3'b111
force Data 4'b0000
run 10ns
force Data 4'b1111
run 10ns

# Testing verilog multiplication
 
