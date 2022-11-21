vlog -work work part2.v
vsim -L work part2
log -r /*
do setting.do

#create clock
force {iClock} 0 0ns, 1 {5ns} -r 10ns

# RESET
force iResetn 1'b0
force iXY_Coord 7'b0
force iPlotBox 1'b0
force iBlack 1'b0
force iLoadX 1'b0
run 10ns
force iResetn 1'b1

# Set and Load X
force iXY_Coord 7'd3
force iLoadX 1'b1
run 100ns
force iLoadX 1'b0
run 100ns

# Set Y and Load Y/Colour
force iXY_Coord 7'd7
force iColour 3'd101
force iPlotBox 1'b1
run 100ns
force iPlotBox 1'b0
run 1000ns

# Set and Load X
force iXY_Coord 7'd100
force iLoadX 1'b1
run 100ns
force iLoadX 1'b0
run 100ns

# Set Y and Load Y/Colour
force iXY_Coord 7'd80
force iColour 3'd101
force iPlotBox 1'b1
run 100ns
force iPlotBox 1'b0
run 1000ns