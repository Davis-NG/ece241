# set the working dir, where all compiled verilog Goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.v

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
do wave.do

# create clock
force {Clock} 0 0ns, 1 {5ns} -r 10ns

# reset circuit (active low)
force Resetn 0
run 10ns

force Go 0
force Resetn 1
run 1000ns

# 1: load 5 into a
force DataIn 8'd5
force Go 1
run 1000ns
force Go 0
run 1000ns

# 2: load 4 into b 
force DataIn 8'd4
force Go 1
run 1000ns
force Go 0
run 1000ns

# 3: load 3 into c 
force DataIn 8'd3
force Go 1
run 1000ns
force Go 0
run 1000ns

# 4: load 2 into x 
force DataIn 8'd2
force Go 1
run 1000ns
force Go 0
run 1000ns




# testing 14*14 + 8 = 204

# 1: load 14 into a
force DataIn 8'd14
force Go 1
run 1000ns
force Go 0
run 1000ns

# 2: load 4 into b 
force DataIn 8'd4
force Go 1
run 1000ns
force Go 0
run 1000ns

# 3: load 8 into c 
force DataIn 8'd8
force Go 1
run 1000ns
force Go 0
run 1000ns

# 4: load 2 into x 
force DataIn 8'd2
force Go 1
run 1000ns
force Go 0
run 1000ns