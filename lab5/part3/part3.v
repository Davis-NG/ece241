`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(ClockIn, Resetn, Start, Letter, DotDashOut, NewBitOut);
    input ClockIn, Resetn, Start;
    input [2:0] Letter;
    output DotDashOut, NewBitOut;
    wire [11:0] holdL;  // Ava hold this L
    wire [11:0] Mcode;

    assign DotDashOut = Mcode[11];

    LUT l0(.select(Letter), .letter(holdL));


    RateDivider_500Hz d0(.ClockIn(ClockIn), .Reset(Resetn), .Enable(NewBitOut));
    register_12bit r0(.Clock(ClockIn), .Reset_n(Resetn), .EnableDC(NewBitOut), .Load(Start), .d(holdL), .q(Mcode));

endmodule

// 12 bits
module register_12bit(Clock, Reset_n, EnableDC, Load, d, q);
    input Clock, Reset_n, EnableDC, Load;
    input [11:0] d;
    output reg [11:0] q;

    always @(posedge Clock, negedge Reset_n) // triggered every time clock rises
    begin
        if (Reset_n == 1'b0)            // when Reset_n is 0 (tested on every rising clock edge)
            q <= 0;                     // q is set to when Reset_b is not zero
        else if (Load == 1'b1)
            q <= d;
        else if (EnableDC == 1'b1) 
                q <= q << 1;
    end
endmodule


module LUT(select, letter);
    input [2:0] select;
    output reg [11:0] letter;

    always @(*)
        case (select)
            3'b000: letter = 12'b1011_1000_0000; 
            3'b001: letter = 12'b1110_1010_1000;
            3'b010: letter = 12'b1110_1011_1010;
            3'b011: letter = 12'b1110_1010_0000; 
            3'b100: letter = 12'b1000_0000_0000; 
            3'b101: letter = 12'b1010_1110_1000;
            3'b110: letter = 12'b1110_1110_1000; 
            3'b111: letter = 12'b1010_1010_0000; 
            default: letter = 12'b0;
        endcase
endmodule

// adjustable clock divider
module RateDivider_500Hz(ClockIn, Reset, Enable);
    input ClockIn, Reset; 
    output Enable;
    
    reg [10:0] Divider;

    always @(posedge ClockIn, negedge Reset)
    begin
        if (Reset == 1'b0)
            Divider <= 11'd0;
        else if (Divider == 11'b000_0000_0000)
            Divider <= 11'd259;   // load to 500Hz/2Hz - 1
        else 
            Divider <= Divider - 1;  // count down to zero
    end

    assign Enable = (Divider == 11'b00_0000_0000)?1:0;  // pulse enable for display counter to 1 when counter reaches 0
endmodule

/*
* For FPGA
*/
// top level module
module TopG(CLOCK_50, SW, KEY, LEDR);
    input CLOCK_50;
    input [2:0] SW;
    input [1:0] KEY;
    output [1:0] LEDR;

    wire [11:0] holdL;
    wire [11:0] Mcode;

    assign LEDR[0] = Mcode[11];

    LUT l0(.select(SW), .letter(holdL));

    register_12bit r0(.Clock(CLOCK_50), .Reset_n(KEY[0]), .EnableDC(LEDR[1]), .Load(KEY[1]), .d(holdL), .q(Mcode));

    RateDivider_50MHz d0(.ClockIn(CLOCK_50), .Reset(KEY[0]), .Enable(LEDR[1]));

endmodule

// adjustable clock divider
module RateDivider_50MHz(ClockIn, Reset, Enable);
    input ClockIn, Reset; 
    input [1:0] Speed;
    output Enable;
    
    reg [27:0] Divider;

    always @(posedge ClockIn, negedge Reset)
    begin
        if (Reset == 1'b0)
            Divider <= 28'd0;
        else if (Divider == 28'd0) 
            Divider <= 28'd24_999_999;    // load to 50MHz/2Hz - 1
            // Divider <= 
        else 
            Divider <= Divider - 1;  // count down to zero
    end

    assign Enable = (Divider == 28'd0)?1:0;  // pulse enable for display counter to 1 when Divider reaches 0
endmodule
