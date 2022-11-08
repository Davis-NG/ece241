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

# CAse 0 & 1
force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 1
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {A[0]} 1
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 1
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {A[0]} 1
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 0

force {B[0]} 0
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 0
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1

force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0
run 10ns

force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 0
run 10ns

# CAse 2
force {Function[0]} 0
force {Function[1]} 1
force {Function[2]} 0

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 1
run 10ns

force {A[0]} 0
force {A[1]} 1
force {A[2]} 1
force {A[3]} 0

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 0
run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
run 10ns

# CAse 3 */
force {Function[0]} 1
force {Function[1]} 1
force {Function[2]} 0

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
run 10ns 

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 1
force {B[2]} 0
force {B[3]} 0
run 10ns 

force {A[0]} 0
force {A[1]} 1
force {A[2]} 0
force {A[3]} 1

force {B[0]} 0
force {B[1]} 1
force {B[2]} 1
force {B[3]} 0
run 10ns 

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1
run 10ns

#CAse 4 
force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 1

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
run 10ns 

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 0
force {B[2]} 1
force {B[3]} 0
run 10ns 

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 0
force {B[1]} 0
force {B[2]} 1
force {B[3]} 0
run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1
run 10ns 

#CAse 5 
force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 1

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
run 10ns

force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 1

force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 1
run 10ns

force {A[0]} 0
force {A[1]} 1
force {A[2]} 0
force {A[3]} 0

force {B[0]} 1
force {B[1]} 1
force {B[2]} 0
force {B[3]} 0
run 10ns

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1
run 10ns

# test default case 
force {Function[0]} 0
force {Function[1]} 1
force {Function[2]} 1

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1
run 10ns 

force {Function[0]} 1
force {Function[1]} 1
force {Function[2]} 1

force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1

force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1
run 10ns 


























