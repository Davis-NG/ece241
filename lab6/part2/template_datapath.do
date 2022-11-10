# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2_template.v

#load simulation using mux as the top level simulation module
vsim datapath

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
do datapath_settings.do

# create clock
force {clk} 0 0ns, 1 {5ns} -r 10ns

# reset circuit (active low)
force resetn 0
force data_in 8'd0
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns
force resetn 1

# 1: load 5 into a
force data_in 8'd5
force ld_a 1
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 2: load 4 into b 
force data_in 8'd4
force ld_a 0
force ld_b 1
force ld_c 0
force ld_x 0
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 3: load 3 into c 
force data_in 8'd3
force ld_a 0
force ld_b 0
force ld_c 1
force ld_x 0
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 4: load 2 into x 
force data_in 8'd2
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 1
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 5: compute a*a and store in reg a
force data_in 8'd2
force ld_a 1
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 1
force ld_r 0
force alu_op 1
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 6: compute (a*a) + c store in output register
force data_in 8'd2
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force ld_r 1
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd2
run 10ns




# testing 14*14 + 8 = 204

# 1: load 14 into a
force data_in 8'd14
force ld_a 1
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 2: load 4 into b 
force data_in 8'd4
force ld_a 0
force ld_b 1
force ld_c 0
force ld_x 0
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 3: load 8 into c 
force data_in 8'd8
force ld_a 0
force ld_b 0
force ld_c 1
force ld_x 0
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 4: load 2 into x 
force data_in 8'd2
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 1
force ld_alu_out 0
force ld_r 0
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 5: compute a*a and store in reg a
force data_in 8'd2
force ld_a 1
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 1
force ld_r 0
force alu_op 1
force alu_select_a 2'd0
force alu_select_b 2'd0
run 10ns

# 6: compute (a*a) + c store in output register
force data_in 8'd2
force ld_a 0
force ld_b 0
force ld_c 0
force ld_x 0
force ld_alu_out 0
force ld_r 1
force alu_op 0
force alu_select_a 2'd0
force alu_select_b 2'd2
run 10ns