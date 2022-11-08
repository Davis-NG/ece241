`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part1(Clock, Enable, Clear_b, CounterValue);
    input Clock, Enable, Clear_b;
    output [7:0] CounterValue; 
    wire [6:0] w;

    TFlipFlop T1(.Clock(Clock), .Reset(Clear_b), .T(Enable), .Q(CounterValue[0]));
    TFlipFlop T2(.Clock(Clock), .Reset(Clear_b), .T(w[0]), .Q(CounterValue[1]));
    TFlipFlop T3(.Clock(Clock), .Reset(Clear_b), .T(w[1]), .Q(CounterValue[2]));
    TFlipFlop T4(.Clock(Clock), .Reset(Clear_b), .T(w[2]), .Q(CounterValue[3]));
    TFlipFlop T5(.Clock(Clock), .Reset(Clear_b), .T(w[3]), .Q(CounterValue[4]));
    TFlipFlop T6(.Clock(Clock), .Reset(Clear_b), .T(w[4]), .Q(CounterValue[5]));
    TFlipFlop T7(.Clock(Clock), .Reset(Clear_b), .T(w[5]), .Q(CounterValue[6]));
    TFlipFlop T8(.Clock(Clock), .Reset(Clear_b), .T(w[6]), .Q(CounterValue[7]));

    assign w[0] = Enable&CounterValue[0]; 
    assign w[1] = w[0]&CounterValue[1]; 
    assign w[2] = w[1]&CounterValue[2]; 
    assign w[3] = w[2]&CounterValue[3]; 
    assign w[4] = w[3]&CounterValue[4]; 
    assign w[5] = w[4]&CounterValue[5]; 
    assign w[6] = w[5]&CounterValue[6]; 

endmodule 

// top level module
module TopG(KEY, SW, HEX0, HEX1);
    input [3:0] KEY;
    input [9:0] SW;
    output [6:0] HEX0, HEX1;
    wire [7:0] Counter;
    
    part1 u1(.Clock(KEY[0]), .Enable(SW[1]), .Clear_b(SW[0]), .CounterValue(Counter));

    hex_decoder h0(.c(Counter[3:0]), .display(HEX0));
    hex_decoder h1(.c(Counter[7:4]), .display(HEX1));
endmodule

// T flip-flop
module TFlipFlop(Clock, Reset, T, Q);
    input Clock, Reset, T;
    output Q;
    wire D;
    
    assign D = T^Q;

    DFlipFlop d0(.Clock(Clock), .Reset(Reset), .d(D), .q(Q));
endmodule

// D flip-flop
module DFlipFlop(Clock, Reset, d, q);
    input Clock, Reset, d;
    output reg q;

    always @(posedge Clock, negedge Reset) // triggered every time clock rises
    begin
        if (Reset == 1'b0) // when Reset_b is 0 (tested on every rising clock edge)
            q <= 0;         // q is set to when Reset_b is not zero
        else 
            q <= d;         // value of d passes through to output q
    end
endmodule

// hexdecimal decoder from lab2
module hex_decoder(c, display);
    input [3:0] c;
    output [6:0] display;

    assign display[0] = ~((~c[0]|c[1]|c[2]|c[3])&(c[0]|c[1]|~c[2]|c[3])&(~c[0]|~c[1]|c[2]|~c[3])&(~c[0]|c[1]|~c[2]|~c[3])); // Eqn 0
    assign display[1] = ~((~c[0]|c[1]|~c[2]|c[3])&(c[0]|~c[1]|~c[2]|c[3])&(~c[0]|~c[1]|c[2]|~c[3])&(c[0]|c[1]|~c[2]|~c[3])&(c[0]|~c[1]|~c[2]|~c[3])&(~c[0]|~c[1]|~c[2]|~c[3])); // Eqn 1
    assign display[2] = ~((c[0]|~c[1]|c[2]|c[3])&(c[0]|c[1]|~c[2]|~c[3])&(c[0]|~c[1]|~c[2]|~c[3])&(~c[0]|~c[1]|~c[2]|~c[3])); // Eqn 2
    assign display[3] = ~((~c[0]|c[1]|c[2]|c[3])&(c[0]|c[1]|~c[2]|c[3])&(~c[0]|~c[1]|~c[2]|c[3])&(c[0]|~c[1]|c[2]|~c[3])&(~c[0]|~c[1]|~c[2]|~c[3])); // Eqn 3
    assign display[4] = ~((~c[0]|c[1]|c[2]|c[3])&(~c[0]|~c[1]|c[2]|c[3])&(c[1]|c[1]|~c[2]|c[3])&(~c[0]|c[1]|~c[2]|c[3])&(~c[0]|~c[1]|~c[2]|c[3])&(~c[0]|c[1]|c[2]|~c[3])); // Eqn 4
    assign display[5] = ~((~c[0]|c[1]|c[2]|c[3])&(c[0]|~c[1]|c[2]|c[3])&(~c[0]|~c[1]|c[2]|c[3])&(~c[0]|~c[1]|~c[2]|c[3])&(~c[0]|c[1]|~c[2]|~c[3])); // Enq 5
    assign display[6] = ~((c[0]|c[1]|c[2]|c[3])&(~c[0]|c[1]|c[2]|c[3])&(~c[0]|~c[1]|~c[2]|c[3])&(c[0]|c[1]|~c[2]|~c[3])); // Enq 6
endmodule   
