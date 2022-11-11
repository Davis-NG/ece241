# set the working dir, where all compiled verilog Goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
do settings.do

# create clock
force {Clock} 0 0ns, 1 {5ns} -r 10ns

# reset circuit (active low)
force Resetn 0
run 10ns

force Go 0
force Resetn 1
run 1000ns

# load 7/3
force Go 1
force Dividend 3'd7
force Divisor 4'd3
run 1000ns
force Go 0
run 1000ns

# load 14/10
force Go 1
force Dividend 3'd14
force Divisor 4'd10
run 1000ns
force Go 0
run 1000ns

# load 15/2
force Go 1
force Dividend 3'd15
force Divisor 4'd2
run 1000ns
force Go 0
run 1000ns

# load 10/10
force Go 1
force Dividend 3'd10
force Divisor 4'd10
run 1000ns
force Go 0
run 1000ns