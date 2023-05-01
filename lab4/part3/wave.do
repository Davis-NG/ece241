# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim part3 

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# create clock
force {clock} 0 0ns, 1 {5ns} -r 10ns

# always reset first
force {reset} 1
run 10ns

# Testing parallel load all 1s
force {reset} 0
force {ParallelLoadn} 0
force Data_IN 8'b1111_1111
run 10ns

# Overwrite Q
force {reset} 0
force {ParallelLoadn} 0
force Data_IN 8'b1010_1010
run 10ns

# Testing right bit shifting
force Data_IN 8'b1000_0000
run 10ns

force ParallelLoadn 1
force RotateRight 1
force ASRight 0
# value of Data_IN shouldn't matter
force Data_IN 8'b1111_0000 
run 80ns

# Testing left bit shifting
force ParallelLoadn 1
force RotateRight 0
run 80ns

# Testing Arithmetic shift right
force ParallelLoadn 0
force Data_IN 8'b1000_1000
run 10ns

force ParallelLoadn 1
force RotateRight 1
force ASRight 1
run 80ns














