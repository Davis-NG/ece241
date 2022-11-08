`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
    input clock, reset, ParallelLoadn, RotateRight, ASRight;
    input [7:0] Data_IN;
    output [7:0] Q;
    wire shift_type; 
    
    mux2to1 m0(.x(Q[0]), .y(Q[7]), .s(ASRight), .m(shift_type));

    sub_circuit s0(.left(Q[1]), .right(Q[7]), .LoadLeft(RotateRight), .D(Data_IN[0]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[0]));
    sub_circuit s1(.left(Q[2]), .right(Q[0]), .LoadLeft(RotateRight), .D(Data_IN[1]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[1]));
    sub_circuit s2(.left(Q[3]), .right(Q[1]), .LoadLeft(RotateRight), .D(Data_IN[2]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[2]));
    sub_circuit s3(.left(Q[4]), .right(Q[2]), .LoadLeft(RotateRight), .D(Data_IN[3]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[3]));
    sub_circuit s4(.left(Q[5]), .right(Q[3]), .LoadLeft(RotateRight), .D(Data_IN[4]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[4]));
    sub_circuit s5(.left(Q[6]), .right(Q[4]), .LoadLeft(RotateRight), .D(Data_IN[5]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[5]));
    sub_circuit s6(.left(Q[7]), .right(Q[5]), .LoadLeft(RotateRight), .D(Data_IN[6]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[6]));
    sub_circuit s7(.left(shift_type), .right(Q[6]), .LoadLeft(RotateRight), .D(Data_IN[7]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(Q[7]));
endmodule

// Top level module
module TopG(SW, KEY, LEDR);
    input [9:0] SW;
    input [3:0] KEY;
    output [7:0] LEDR;

    part3 u0(.clock(~KEY[0]), .reset(SW[9]), .ParallelLoadn(~KEY[1]), .RotateRight(~KEY[2]), .ASRight(~KEY[3]), .Data_IN(SW[7:0]), .Q(LEDR[7:0]));
endmodule

// flip flop with the two multiplexers
module sub_circuit(right, left, LoadLeft, D, loadn, clock, reset, Q);
    input right, left, LoadLeft, loadn, D, clock, reset;
    output Q; 
    wire w1, w2;

    mux2to1 M0(.x(right), .y(left), .s(LoadLeft), .m(w1)); // in loving memory of Mo Wang
    mux2to1 M1(.x(D), .y(w1), .s(loadn), .m(w2));
    
    flipFlop F0(.Clock(clock), .Reset(reset), .d(w2), .q(Q));
endmodule

module mux2to1(x, y, s, m);
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
    //assign m = s & y | ~s & x;
    // OR
    assign m = s ? y : x;
endmodule

module flipFlop(Clock, Reset, d, q);
    input Clock, Reset, d;
    output reg q;

    always @(posedge Clock) // triggered every time clock rises
    begin
        if (Reset == 1'b1) // when Reset_b is 0 (tested on every rising clock edge)
            q <= 0;         // q is set to when Reset_b is not zero
        else 
            q <= d;         // value of d passes through to output q
    end
endmodule
