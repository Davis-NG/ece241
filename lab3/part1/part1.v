`timescale 1ns / 1ns // `timescale time_unit/time_precision

// 7 to 1 multiplexer using case statements
module part1(MuxSelect, Input, Out);    
    input [6:0] Input; 
    input [2:0] MuxSelect;
    output Out;

    reg Out;                            // declare the output signal for the always block

    always @(*)                         // declare always block
    begin
        case (MuxSelect[2:0])           // start case statement
            3'b000: Out = Input[0];     // case 0
            3'b001: Out = Input[1];     // case 1
            3'b010: Out = Input[2];     // case 2
            3'b011: Out = Input[3];     // case 3
            3'b100: Out = Input[4];     // case 4
            3'b101: Out = Input[5];     // case 5
            3'b110: Out = Input[6];     // case 6
            default: Out = 0;           // default case 
        endcase
    end
endmodule

// Top level module
module mux(SW, LEDR);
    input [9:0] SW;
    output [9:0] LEDR; 
    part1 u1(.MuxSelect(SW[9:7]), .Input(SW[6:0]), .Out(LEDR[0]));
endmodule
