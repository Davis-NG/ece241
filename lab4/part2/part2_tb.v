`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2_tb;
    reg Clock, Reset_b;
    reg [3:0] Data; 
    reg [2:0] Function;
    wire [7:0] ALUout;


    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;  
    
    part2 u0(.Clock(Clock), .Reset_b(Reset_b), .Data(Data), .Function(Function), .ALUout(ALUout));    
    
    reg clk;

    // note that sensitive list is omitted in always block
    // therefore always-block run forever
    // clock period = 2 ns
    always 
    begin
        clk = 1'b1; 
        #20; // high for 20 * timescale = 20 ns
   
        clk = 1'b0;
        #20; // low for 20 * timescale = 20 ns
   end 
endmodule
