//
// This is the template for Part 1 of Lab 8.
//
// Paul Chow
// November 2021
// Updated November 2022
//

// iColour is the colour for the box
//
// oX, oY, oColour and oPlot should be wired to the appropriate ports on the VGA controller
//

// Some constants are set as parameters to accommodate the different implementations
// X_SCREEN_PIXELS, Y_SCREEN_PIXELS are the dimensions of the screen
//       Default is 160 x 120, which is the baseline for the DE1_SoC vga controller
// CLOCKS_PER_SECOND should be the frequency of the clock being used.
`timescale 1 ns/10 ps

module part1(iColour, iResetn, iClock, oX, oY, oColour, oPlot, oNewFrame);
   input wire [2:0] iColour;
   input wire 	    iResetn;
   input wire 	    iClock;
   output wire [7:0] oX;         // VGA pixel coordinates
   output wire [6:0] oY;
   
   output wire [2:0] oColour;     // VGA pixel colour (0-7)
   output wire 	     oPlot;       // Pixel drawn enable
   output wire       oNewFrame;    // goes high for 1 cycle when a new frame starts

   parameter
     X_SCREEN_PIXELS = 160,  // X screen width for starting resolution
     Y_SCREEN_PIXELS = 120,  // Y screen height for starting resolution
     CLOCKS_PER_SECOND = 1200, // 5 KHZ 
     X_BOXSIZE = 8'd4,   // Box X dimension
     Y_BOXSIZE = 7'd4,   // Box Y dimension
     X_MAX = X_SCREEN_PIXELS - 1 - X_BOXSIZE, // 0-based and account for box width
     Y_MAX = Y_SCREEN_PIXELS - 1 - Y_BOXSIZE,
     PULSES_PER_SIXTIETH_SECOND = CLOCKS_PER_SECOND / 60;

   //
   // Your code goes here
   //

   // lots of wires to connect our datapath and control
    wire x_count_en, y_count_en;
    wire [3:0] FrameCounter;
    wire erase, count_en, delay_en;
    wire [7:0] x_count, x_init;
    wire [6:0] y_count, y_init;

    RateDivider #(.PULSES(PULSES_PER_SIXTIETH_SECOND)) R0(
        .ClockIn(iClock),
        .Resetn(iResetn),
        .FrameCounter(FrameCounter),
        .enable(delay_en),
        .newFrame(oNewFrame)
    );

    Counter #(.X_MAX(X_MAX), .Y_MAX(Y_MAX)) R1(
        .clk(iClock),
        .resetn(iResetn),
        .count_en(count_en),
        .x_init(x_init),
        .y_init(y_init)
    );

    control C0(
        .clk(iClock),
        .resetn(iResetn),
        .FrameCounter(FrameCounter),
        .x_count(x_count),
        .y_count(y_count),

        .erase(erase),
        .count_en(count_en),
        .plot(oPlot),
        .x_count_en(x_count_en),
        .y_count_en(y_count_en),
        .delay_en(delay_en)
    );

    datapath D0(
        .clk(iClock), 
        .resetn(iResetn), 

        .colour(iColour),

        .x_count_en(x_count_en),
        .y_count_en(y_count_en),
        .clear(erase),

        .x_init(x_init),
        .y_init(y_init),
        .x_count(x_count),
        .y_count(y_count),

        .outX(oX), 
        .outY(oY),
        .outColo(oColour)
    );
endmodule // part1

// clock divider to output 60 Hz
module RateDivider #(parameter PULSES = 1200, parameter width = $clog2(PULSES)) (ClockIn, Resetn, FrameCounter, enable, newFrame);
    input ClockIn, Resetn, enable; 
    output reg [3:0] FrameCounter;
    output newFrame;
    
    reg [width-1:0] Divider;
    always @(posedge ClockIn)
    begin
        if (Resetn == 1'b0)
            Divider <= 0;
        else if (Divider == 0)
                Divider <= PULSES - 1'b1;   // load per sixtieth second - 1
            else 
                Divider <= Divider - 1;  // count down to zero
    end

    // track the number of frames 
    always @(posedge ClockIn) begin
        if (Resetn == 1'b0)
            FrameCounter <= 4'b0;
        else if (enable == 1'b1)
            if (Divider == 0)
                FrameCounter <= FrameCounter + 1'b1;  
            else 
                FrameCounter <= FrameCounter;  
        else FrameCounter <= 4'b0;     
    end

    assign newFrame = (Divider == 0)?1:0;
endmodule

module Counter #(parameter X_MAX = 160 - 4 - 1, Y_MAX = 120 - 4 - 1)(
    input clk,
    input resetn,
    input count_en,

    output reg [7:0] x_init,
    output reg [6:0] y_init
    );

    reg DirX;
    reg DirY;

    localparam  LEFT = 1'b0,
                RIGHT = 1'b1,
                UP = 1'b0,
                DOWN = 1'b1;        

    // screen coordinates counter
    always @(posedge clk) begin
        if (!resetn) begin
            x_init <= 8'b0;
            y_init <= 7'b0;
        end
        else if (count_en) begin
            if (DirX == RIGHT) 
                x_init <= x_init + 1'b1;
            else
                x_init <= x_init - 1'b1;

            if (DirY == DOWN) 
                y_init <= y_init + 1'b1;    // down is positive
            else
                y_init <= y_init - 1'b1;
        end
    end

    // direction registers
    always @(posedge clk) begin
        if (!resetn) begin
            DirX <= RIGHT;
            DirY <= DOWN;
        end
        else begin
            if (x_init == 8'd1)
                DirX <= RIGHT;
            else if (x_init == X_MAX)
                DirX <= LEFT;
            
            if (y_init == 8'd1)
                DirY <= DOWN;
            else if (y_init == Y_MAX) 
                DirY <= UP;
        end
    end
endmodule

// control logic to draw the box
module control(
    input clk,
    input resetn,
    input [7:0] x_count, 
    input [6:0] y_count,
    input [3:0] FrameCounter,

    output reg x_count_en, y_count_en, delay_en,
    output reg plot,
    output reg erase, count_en
    );

    reg [3:0] current_state, next_state;

    localparam  S_DRAW          = 4'd0,
                S_INCREMENT_Y   = 4'd1,
                S_WAIT          = 4'd2,
                S_ERASE         = 4'd3,
                S_ERASE_Y       = 4'd4,
                S_COUNT         = 4'd5;

    // Next state logic aka our state table
    always@(*)
    begin: state_table
        case (current_state)
            S_DRAW: begin 
                if (x_count == 8'd2)
                    next_state = S_INCREMENT_Y;
                else
                    next_state = S_DRAW;
            end
            S_INCREMENT_Y:  begin 
                if (y_count == 7'd3)
                    next_state = S_WAIT;
                else 
                    next_state = S_DRAW;
            end
            S_WAIT: next_state = FrameCounter == 4'd15 ? S_ERASE : S_WAIT;
            S_ERASE: begin 
                if (x_count == 8'd2)
                    next_state = S_ERASE_Y;
                else
                    next_state = S_ERASE;
            end
            S_ERASE_Y: begin 
                if (y_count == 7'd3)
                    next_state = S_COUNT;
                else 
                    next_state = S_ERASE;
            end
            S_COUNT: next_state = S_DRAW;
            default:    next_state = S_DRAW;
        endcase
    end // state_table

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        x_count_en = 1'b0;
        y_count_en = 1'b0;
        plot = 1'b0;
        erase = 1'b0;
        count_en = 1'b0;
        delay_en = 1'b0;

        case (current_state)
            S_DRAW: begin
                x_count_en = 1'b1;
                plot = 1'b1;
            end
            S_INCREMENT_Y: begin
                y_count_en = 1'b1;
                plot = 1'b1;
            end
            S_WAIT: delay_en = 1'b1;
            S_ERASE: begin
                x_count_en = 1'b1;
                plot = 1'b1;
                erase = 1'b1;
            end
            S_ERASE_Y: begin
                y_count_en = 1'b1;
                plot = 1'b1;
                erase = 1'b1;
            end
            S_COUNT: begin
                count_en = 1'b1;
            end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals

    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_DRAW;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

// datapath to draw box (similar to lab7)
module datapath(
    input clk,
    input resetn,
    input [2:0] colour,
    input [7:0] x_init, 
    input [6:0] y_init,
    input x_count_en, y_count_en,
    input clear,

    output reg [7:0] x_count,
    output reg [6:0] y_count,
    output reg [7:0] outX,
    output reg [6:0] outY,
    output reg [2:0] outColo
    );

    // counters
    always @(posedge clk) begin
        if (!resetn) begin
            x_count <= 8'b0;
            y_count <= 7'd0; 
        end
        else
            if (x_count_en)
                x_count <= x_count + 1'b1;
            else if (y_count_en) begin
                y_count <= y_count + 1'b1;
                x_count <= 8'b0;
            end
            else
                y_count <= 7'b0;
    end

    // The outputs
    always @(*)
    begin
        // Mux for colour
        case (clear)
            1'b0: outColo = colour;
            1'b1: outColo = 3'b000;
            default: outColo = 3'd0;
        endcase

        outX = x_init + x_count;
        outY = y_init + y_count;
    end
endmodule