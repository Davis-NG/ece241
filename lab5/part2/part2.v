`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2(ClockIn, Reset, Speed, CounterValue);
    input ClockIn, Reset;
    input [1:0] Speed;
    output [3:0] CounterValue;
    wire enable;

    RateDivider_500Hz r0(.ClockIn(ClockIn), .Reset(Reset), .Enable(enable), .Speed(Speed));
    DisplayCounter c0(.ClockIn(ClockIn), .Reset(Reset), .EnableDC(enable), .q(CounterValue));
endmodule

// adjustable clock divider
module RateDivider_500Hz(ClockIn, Reset, Speed, Enable);
    input ClockIn, Reset; 
    input [1:0] Speed;
    output Enable;
    
    reg [10:0] Divider;

    always @(posedge ClockIn) begin
        if (Reset == 1'b1)
            Divider <= 11'd0;
        else if (Divider == 11'b000_0000_0000)
            //Divider <= d;
            case(Speed)                     // load counter to: (clock speed)/(desired speed) - 1
                2'b00: Divider <= 11'd0;     // load to 500Hz/500Hz - 1
                2'b01: Divider <= 11'd499;   // load to 500Hz/1Hz - 1
                2'b10: Divider <= 11'd999;   // load to 500Hz/0.5Hz - 1
                2'b11: Divider <= 11'd1999;  // load to 500Hz/0.25Hz - 1
                default Divider <= 11'd0;
            endcase
        else 
            Divider <= Divider - 1;  // count down to zero
    end

    assign Enable = (Divider == 11'b00_0000_0000)?1:0;  // pulse enable for display counter to 1 when counter reaches 0
endmodule

// display counter - PC APPROVED
module DisplayCounter(ClockIn, Reset, EnableDC, q);
    input ClockIn, Reset, EnableDC;
    output reg [3:0] q;

    always @(posedge ClockIn)
    begin 
        if (Reset == 1'b1)
            q <= 0;
        else if (EnableDC == 1'b1)
        begin
            if (q == 4'b1111)
                q <= 0;
            else q <= q + 1;
        end
    end
endmodule

// not PC approved
//module DisplayCounter(ClockIn, Reset, EnableDC, q);
//    input ClockIn, Reset, EnableDC;
//        output reg [3:0] q;
//
//            always @(posedge ClockIn)
//            begin 
//                if (Reset == 1'b1)
//                    q <= 0;
//                else if (q == 4'b1111)
//                    q <= 0;
//                else if (EnableDC == 1'b1)
//                    q <= q + 1;
//                else
//                    q <= q;
//            end
//endmodule


/*
* For FPGA
*/
// top level module
module topG(SW, HEX0, CLOCK_50);
    input CLOCK_50;
    input [9:0] SW;
    output [6:0] HEX0;
    wire [3:0] CounterValue; 
    wire enable;

    RateDivider_50MHz r0(.ClockIn(CLOCK_50), .Reset(SW[9]), .Enable(enable), .Speed(SW[1:0]));
    DisplayCounter c1(.ClockIn(CLOCK_50), .Reset(SW[9]), .EnableDC(enable), .q(CounterValue));
    // display CounterValue on 7 seg display
    hex_decoder h0(.c(CounterValue), .display(HEX0)); 
endmodule

// adjustable clock divider
module RateDivider_50MHz(ClockIn, Reset, Speed, Enable);
    input ClockIn, Reset; 
    input [1:0] Speed;
    output Enable;
    
    reg [27:0] Divider;

    always @(posedge ClockIn)
    begin
        if (Reset == 1'b1)
            Divider <= 28'd0;
        else if (Divider == 28'd0) 
            //Divider <= d;
            case(Speed)                     // load counter to: (clock speed)/(desired speed) - 1
                2'b00: Divider = 28'd0;             // load to 50MHz/50MHz - 1
                2'b01: Divider = 28'd49_999_999;    // load to 50MHz/1Hz - 1
                2'b10: Divider = 28'd99_999_999;    // load to 50MHz/0.5Hz - 1
                2'b11: Divider = 28'd199_999_999;   // load to 50MHz/0.25Hz - 1
                default Divider = 28'd0;
            endcase
        else 
            Divider <= Divider - 1;  // count down to zero
    end

    assign Enable = (Divider == 28'd0)?1:0;  // pulse enable for display counter to 1 when Divider reaches 0
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






