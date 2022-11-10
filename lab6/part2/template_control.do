# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2_template.v

#load simulation using mux as the top level simulation module
vsim control

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# create clock
force {clk} 0 0ns, 1 {5ns} -r 10ns

# reset circuit (active low)
force resetn 0
run 10ns

force go 0
force resetn 1
run 1000ns

# 1: Mimic person pressing "go" to move from S_LOAD_A to S_LOAD_B
force go 1
run 1000ns
force go 0
run 1000ns

# 2: Mimic person pressing "go" to move from S_LOAD_B to S_LOAD_C
force go 1
run 1000ns
force go 0
run 1000ns

# 3: Mimic person pressing "go" to move from S_LOAD_C to S_LOAD_X
force go 1
run 1000ns
force go 0
run 1000ns

# 4: Mimic person pressing "go" to move from S_LOAD_X to to S_CYCLE_0 to S_CYCLE_1 to LOAD_A
force go 1
run 1000ns
force go 0
run 1000ns