# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim datapath

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# create clock
force {clk} 0 0ns, 1 {5ns} -r 10ns

# reset circuit (active low)
force resetn 0
force Divisor 4'b0
force Dividend 3'b0
force ld_value 0
force ld_result 0
force shift 0

run 10ns
force resetn 1

# load 7/3
force Dividend 3'd7
force Divisor 4'd3
force ld_value 1
force ld_result 0
force shift 0
run 10ns

# cylce 1
force Dividend 3'd8
force Divisor 4'd3
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 2
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 3
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 4
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 1
force shift 1
run 10ns


# load 14/10
force Dividend 3'd14
force Divisor 4'd10
force ld_value 1
force ld_result 0
force shift 0
run 10ns

# cylce 1
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 2
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 3
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 4
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 1
force shift 1
run 10ns

# load 10/10
force Dividend 3'd10
force Divisor 4'd10
force ld_value 1
force ld_result 0
force shift 0
run 10ns

# cylce 1
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 2
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 3
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 0
force shift 1
run 10ns

# cylce 4
force Dividend 3'd0
force Divisor 4'd0
force ld_value 0
force ld_result 1
force shift 1
run 10ns