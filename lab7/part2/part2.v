//
// This is the template for Part 2 of Lab 7.
//
// Paul Chow
// November 2021
//

module part2(iResetn, iPlotBox, iBlack, iColour, iLoadX, iXY_Coord, iClock, oX, oY, oColour, oPlot, oDone);
   parameter X_SCREEN_PIXELS = 8'd160;
   parameter Y_SCREEN_PIXELS = 7'd120;

   input wire iResetn, iPlotBox, iBlack, iLoadX;
   input wire [2:0] iColour;
   input wire [6:0] iXY_Coord;
   input wire 	    iClock;
   output wire [7:0] oX;         // VGA pixel coordinates
   output wire [6:0] oY;

   output wire [2:0] oColour;     // VGA pixel colour (0-7)
   output wire 	     oPlot;       // Pixel draw enable
   output wire       oDone;       // goes high when finished drawing frame

   //
   // Your code goes here

   // lots of wires to connect our datapath and control
    wire ld_x, ld_y, ld_colo, x_count_en, y_count_en, clear;
    wire [7:0] x_count;
    wire [6:0] y_count;

    control C0(
        .clk(iClock),
        .resetn(iResetn),

        .loadx(iLoadX),
        .plotBox(iPlotBox),
        .black(iBlack),

        .ld_x(ld_x),
        .ld_y(ld_y),
        .ld_colo(ld_colo),
        .x_count_en(x_count_en),
        .y_count_en(y_count_en),
        .clear(clear),
        .plot(oPlot),

        .x_count(x_count),
        .y_count(y_count),

        .done(oDone)
    );

    datapath D0(
        .clk(iClock), 
        .resetn(iResetn), 

        .coord(iXY_Coord), 
        .colour(iColour),

        .ld_x(ld_x),
        .ld_y(ld_y),
        .ld_colo(ld_colo),
        .x_count_en(x_count_en),
        .y_count_en(y_count_en),
        .clear(clear),

        .x_count(x_count),
        .y_count(y_count),

        .outX(oX), 
        .outY(oY),
        .outColo(oColour)
    );

endmodule // part2

module control(
    input clk,
    input resetn,

    input loadx,
    input plotBox,
    input black,

    output reg ld_x, ld_y, ld_colo, x_count_en, y_count_en,
    output reg clear, plot,
    input [7:0] x_count, 
    input [6:0] y_count,
    output reg done
    );

    reg [5:0] current_state, next_state;

    localparam  S_LOAD_X        = 5'd0,
                S_LOAD_X_WAIT   = 5'd1,
                S_LOAD_Y        = 5'd2,
                S_LOAD_Y_WAIT   = 5'd3,
                S_DRAW          = 5'd4,
                S_INCREMENT_Y   = 5'd5,
                S_DONE          = 5'd6,
                S_DRAW_BLACK    = 5'd7,
                S_INCREMENT_BL  = 5'd8;

    // Next state logic aka our state table
    always@(*)
    begin: state_table
            case (current_state)
                S_LOAD_X: begin if (loadx)                     // Loop in current state until value is input or set clear
                                    next_state = S_LOAD_X_WAIT;
                                else if (black)
                                    next_state = S_DRAW_BLACK;
                                else
                                    next_state = S_LOAD_X;
                end
                S_LOAD_X_WAIT: next_state = loadx ? S_LOAD_X_WAIT : S_LOAD_Y; // Loop in current state until loadx signal goes low
                S_LOAD_Y: next_state = plotBox ? S_LOAD_Y_WAIT : S_LOAD_Y; // Loop in current state until value is input
                S_LOAD_Y_WAIT: next_state = plotBox ? S_LOAD_Y_WAIT : S_DRAW; // Loop in current state until plotBox signal goes low

                S_DRAW: begin if (x_count == 8'd3)
                                next_state = S_INCREMENT_Y;
                              else
                                next_state = S_DRAW;
                end
                S_INCREMENT_Y:  begin if (y_count == 7'd3)
                                        next_state = S_DONE;
                                      else 
                                        next_state = S_DRAW;
                end
                
                S_DRAW_BLACK: begin if (x_count == 8'd127)
                                        next_state = S_INCREMENT_BL;
                                    else 
                                        next_state = S_DRAW_BLACK;
                end 
                S_INCREMENT_BL: begin if (y_count == 7'd127)
                                        next_state = S_DONE;
                                      else
                                        next_state = S_DRAW_BLACK;
                end  

                S_DONE: begin if (loadx)                     // Loop in current state until value is input or set clear
                                    next_state = S_LOAD_X_WAIT;
                                else if (black)
                                    next_state = S_DRAW_BLACK;
                                else
                                    next_state = S_DONE;
                end 
            default:     next_state = S_LOAD_X;
        endcase
    end // state_table


    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_x = 1'b0;
        ld_y = 1'b0;
        ld_colo = 1'b0;
        x_count_en = 1'b0;
        y_count_en = 1'b0;
        clear = 1'b0;
        plot = 1'b0;
        done = 1'b0;

        case (current_state)
            S_LOAD_X: begin
                ld_x = 1'b1;
            end
            S_LOAD_Y: begin
                ld_y = 1'b1;
                ld_colo = 1'b1;
            end
            S_DRAW: begin
                x_count_en = 1'b1;
                plot = 1'b1;
            end
            S_INCREMENT_Y: begin
                y_count_en = 1'b1;
            end
            S_DRAW_BLACK: begin
                x_count_en = 1'b1;
                plot = 1'b1;
                clear = 1'b1;
            end
            S_INCREMENT_BL: begin 
                y_count_en = 1'b1;
                clear = 1'b1;
            end
            S_DONE: begin
                ld_x = 1'b1;
                done = 1'b1;
            end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals

    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module datapath(
    input clk,
    input resetn,
    input [6:0] coord,
    input [2:0] colour,
    input ld_x, ld_y, ld_colo,
    input x_count_en, y_count_en,
    input clear,
    output reg [7:0] x_count,
    output reg [6:0] y_count,
    output reg [7:0] outX,
    output reg [6:0] outY,
    output reg [2:0] outColo
    );

    // input registers
    reg [7:0] X;
    reg [6:0] Y;
    reg [2:0] colo;

    // Registers X, Y, colo with respective input logic
    always@(posedge clk) begin
        if(!resetn) begin
            X <= 8'b0;
            Y <= 7'b0;
            colo <= 3'b0;
        end
        else begin
            if(ld_x)
                X <= {1'b0, coord};
            if(ld_y)
                Y <= coord;
            if(ld_colo)
                colo <= colour;
        end
    end

    // counters
    always @(posedge clk) begin
        if (!resetn) begin
            x_count <= 8'b0;
            y_count <= 7'd0; 
        end
        else
            if (x_count_en)
                x_count <= x_count + 1;
            else if (y_count_en) begin
                y_count <= y_count + 1;
                x_count <= 8'b0;
            end
            else
                y_count <= 7'b0;
    end

    // The output multiplexers
    always @(*)
    begin
        case (clear)
            1'b0: begin
                outX = X + x_count;
                outY = Y + y_count;
                outColo = colo;
            end
            1'b1: begin
                outX = x_count;
                outY= y_count;
                outColo = 3'd0;
            end
            default: begin
                outX = 8'b0;
                outY= 7'b0;
                outColo = 3'd0;
            end
        endcase
    end

endmodule

