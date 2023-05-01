if exist ../top.v (
    vsim -pli simfpga.vpi -L 220model -L altera_mf_ver -L verilog -c -do "run -all" tb
)
if exist ../top.sv (
    vsim -pli simfpga.vpi -L 220model -L altera_mf_ver -L verilog -c -do "run -all" tb
)
if exist ../top.vhd (
    vsim -pli simfpga.vpi -Lf 220model -Lf altera_mf -t 1ns -c -do "set StdArithNoWarnings 1" -do "set NumericStdNoWarnings 1" -do "run -all" tb
)
