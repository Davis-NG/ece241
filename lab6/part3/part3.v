//Sw[7:0] data_in

//KEY[0] synchronous reset when pressed
//KEY[1] go signal

//LEDR displays result
//HEX0 & HEX1 also displays result

module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder, ResultValid);
    input Clock;
    input Resetn;
    input Go;
    input [3:0] Divisor;
    input [3:0] Dividend;
    output [3:0] Quotient;
    output [3:0] Remainder; 
    output ResultValid;

    // lots of wires to connect our datapath and control
    wire ld_value, ld_result;
    wire shift;

    control C0(
        .clk(Clock),
        .resetn(Resetn),

        .go(Go),

        .ld_value(ld_value),
        .ld_result(ld_result),

        .shift(shift),
        .result_valid(ResultValid)
    );

    datapath D0(
        .clk(Clock),
        .resetn(Resetn),

        .ld_value(ld_value),
        .ld_result(ld_result),

        .shift(shift),

        .Divisor(Divisor),
        .Dividend(Dividend),

        .Quotient(Quotient),
        .Remainder(Remainder)
    );

endmodule


module control(
    input clk,
    input resetn,
    input go,

    output reg  ld_value, ld_result,
    output reg  shift,
    output reg  result_valid
    );

    reg [5:0] current_state, next_state;

    localparam  S_LOAD          = 5'd0,
                S_LOAD_WAIT     = 5'd1,
                S_CYCLE_1       = 5'd2,
                S_CYCLE_2       = 5'd3,
                S_CYCLE_3       = 5'd4,
                S_CYCLE_4       = 5'd5,
                S_DISPLAY       = 5'd6;

    // Next state logic aka our state table
    always@(*)
    begin: state_table
            case (current_state)
                S_LOAD: next_state = go ? S_LOAD_WAIT : S_LOAD; // Loop in current state until value is input
                S_LOAD_WAIT: next_state = go ? S_LOAD_WAIT : S_CYCLE_1; // Loop in current state until go signal goes low
                S_CYCLE_1: next_state = S_CYCLE_2; // Loop in current state until value is input
                S_CYCLE_2: next_state = S_CYCLE_3;
                S_CYCLE_3: next_state = S_CYCLE_4;
                S_CYCLE_4: next_state = S_DISPLAY;
                S_DISPLAY: next_state = go ? S_LOAD_WAIT : S_DISPLAY; // we will be done our two operations, start over after
            default:     next_state = S_LOAD;
        endcase
    end // state_table


    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_value = 1'b0;
        ld_result = 1'b0;
        shift = 1'b0;
        result_valid = 1'b0;

        case (current_state)
            S_LOAD: begin
                ld_value = 1'b1;
                end
            S_CYCLE_1: begin 
                shift = 1'b1;
            end
            S_CYCLE_2: begin 
                shift = 1'b1;
            end
            S_CYCLE_3: begin 
                shift = 1'b1;
            end
            S_CYCLE_4: begin
                shift = 1'b1;
                ld_result = 1'b1;
            end
            S_DISPLAY: begin 
                ld_value = 1'b1;
                result_valid = 1'b1;
            end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals

    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module datapath(
    input clk,
    input resetn,
    input [3:0] Divisor,
    input [3:0] Dividend,
    input ld_value, ld_result,
    input shift,
    output reg [3:0] Quotient,
    output reg [3:0] Remainder
    );

    // input registers
    reg [4:0] a, divisor;
    reg [3:0] dividend;

    always @(posedge clk) begin    // Uses blocking assignment 
        if (!resetn) begin
            a = 5'b0;
            divisor = 5'b0;
            dividend = 4'b0;
        end
        else begin
            if (ld_value) begin
                dividend = Dividend;
                divisor = {1'b0, Divisor};
                a = 5'b0;
            end
            if (shift) begin
                a = a << 1;
                a[0] = dividend[3];
                dividend = dividend << 1;
                a = a - divisor;

                if (a[4] == 1'b1) begin
                    dividend[0] = 1'b0;
                    a = a + divisor;
                end
                else
                    dividend[0] = 1'b1;
            end
        end
    end

    // Output result register
    always@(posedge clk) begin
        if (!resetn) begin
            Quotient <= 4'b0;
            Remainder <= 5'b0;
        end
        else
            if (ld_result) begin
                Quotient <= dividend[3:0];
                Remainder <= a[3:0];
            end
    end

endmodule

// top level module for FPGA
module TopG(SW, KEY, CLOCK_50, LEDR, HEX0, HEX2, HEX4, HEX5);
    input [9:0] SW;
    input [3:0] KEY;
    input CLOCK_50;
    output [9:0] LEDR;
    output [6:0] HEX0, HEX2, HEX4, HEX5;

    wire resetn;
    wire go;

    wire [3:0] Quotient;
    wire [3:0] Remainder;
    assign go = ~KEY[1];
    assign resetn = KEY[0];
    assign LEDR[3:0] = Quotient;

    part3 u0(
        .Clock(CLOCK_50),
        .Resetn(resetn),
        .Go(go),
        .Divisor(SW[3:0]),
        .Dividend(SW[7:4]),
        .Quotient(Quotient),
        .Remainder(Remainder),
        .ResultValid(LEDR[4])
    );

    hex_decoder divisor(
        .c(SW[3:0]), 
        .display(HEX0)
    );

    hex_decoder dividend(
        .c(SW[7:4]), 
        .display(HEX2)
    );

    hex_decoder quotient(
        .c(Quotient), 
        .display(HEX4)
    );

    hex_decoder remainder(
        .c(Remainder), 
        .display(HEX5)
    );

endmodule

// hex decoder
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
