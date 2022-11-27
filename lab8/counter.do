vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part1.v

#load simulation using mux as the top level simulation module
vsim Counter

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
do counter_setting.do

# create clock
force {clk} 0 0ns, 1 {5ns} -r 10ns

# reset circuit (active low)
force resetn 0
run 10ns

force resetn 1
force count_en 1
run 100000ns