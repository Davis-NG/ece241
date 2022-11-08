`timescale 1ns / 1ns // `timescale time_unit/time_precision

// Arithmetic logic unit
module part3(A, B, Function, ALUout);
    input [3:0] A, B;
    input [2:0] Function;
    output reg [7:0] ALUout;
    wire [3:0] sum, carry;

    part2 a0(.a(A), .b(B), .c_in(0), .s(sum), .c_out(carry));

    always @(*)
        case (Function)
           3'b000: ALUout = {3'b000, {carry[3], sum}}; // adder from part2
           3'b001: ALUout = A + B; // adder using the Verilog '+' operator
           3'b010: ALUout = {{4{B[3]}}, B[3:0]};  // sign extension of B to 8 bits
           3'b011: ALUout = {7'b0, |{A, B}}; //Output 8’b00000001 if at least 1 of the 8 bits in the two inputs is 1 using a single OR operation
           3'b100: ALUout = {7'b0, &{A, B}}; // Output 8’b00000001 if all of the 8 bits in the two inputs are 1 using a single AND operation
           3'b101: ALUout = {A, B}; // Display A in the most significant four bits and B in the lower four bits
           default: ALUout = 8'b0; // default case
        endcase
endmodule

// top level module
module ALU(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [7:0] SW, KEY;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output [7:0] LEDR;
    wire [7:0] ALU;

    part3 u0(.A(SW[7:4]), .B(SW[3:0]), .Function(~KEY[2:0]), .ALUout(ALU));

    assign LEDR = ALU; // display ALUout on LEDs

    hex_decoder d0(.c(SW[7:4]), .display(HEX2)); // display input A on 7 segment display
    hex_decoder d1(.c(SW[3:0]), .display(HEX0)); // display input B on 7 segment display

    // display ALUout on 7 segment display
    hex_decoder d2(.c(ALU[3:0]), .display(HEX4)); 
    hex_decoder d3(.c(ALU[7:4]), .display(HEX5));

    // display 0 on HEX1 and HEX3
    assign HEX1 = 7'b1000000;
    assign HEX3 = 7'b1000000;
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

// ripple carry adder from part2
module part2(a, b, c_in, s, c_out);
    input [3:0] a, b;
    input c_in;
    output [3:0] s, c_out;

    full_adder f0(.a(a[0]), .b(b[0]), .c_i(c_in), .s(s[0]), .c_o(c_out[0]));   
    full_adder f1(.a(a[1]), .b(b[1]), .c_i(c_out[0]), .s(s[1]), .c_o(c_out[1]));
    full_adder f2(.a(a[2]), .b(b[2]), .c_i(c_out[1]), .s(s[2]), .c_o(c_out[2]));
    full_adder f3(.a(a[3]), .b(b[3]), .c_i(c_out[2]), .s(s[3]), .c_o(c_out[3]));
endmodule

module full_adder(a, b, c_i, s, c_o);
    input a, b, c_i;
    output c_o, s;
    wire sel;

    assign sel = a^b;
    assign s = sel^c_i;

    mux2to1 u1(.x(b), .y(c_i), .s(sel), .m(c_o));
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
