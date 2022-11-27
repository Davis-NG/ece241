`timescale 1ns / 1ns // `timescale time_unit/time_precision

// carry ripple adder
module part2(a, b, c_in, s, c_out);
    input [3:0] a, b;
    input c_in;
    output [3:0] s, c_out;

    full_adder f0(.a(a[0]), .b(b[0]), .c_i(c_in),     .s(s[0]), .c_o(c_out[0]));   
    full_adder f1(.a(a[1]), .b(b[1]), .c_i(c_out[0]), .s(s[1]), .c_o(c_out[1]));
    full_adder f2(.a(a[2]), .b(b[2]), .c_i(c_out[1]), .s(s[2]), .c_o(c_out[2]));
    full_adder f3(.a(a[3]), .b(b[3]), .c_i(c_out[2]), .s(s[3]), .c_o(c_out[3]));
endmodule

// full adder
module full_adder(a, b, c_i, s, c_o);
    input a, b, c_i;
    output c_o, s;

    wire sel;

    assign sel = a^b;
    assign s = sel^c_i;

    mux2to1 u1(.x(b), .y(c_i), .s(sel), .m(c_o));
endmodule

// 2 to 1 multiplexer
module mux2to1(x, y, s, m);
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
    //assign m = s & y | ~s & x;
    // OR
    assign m = s ? y : x;

endmodule

// top level module
module ripple_carry_adder_4bit(SW, LEDR);
    input [9:0] SW;
    wire [3:0] carrys;
    output [9:0] LEDR;
       
    part2 u1(.a(SW[7:4]), .b(SW[3:0]), .c_in(SW[8]), .s(LEDR[3:0]), .c_out(carrys));
    assign LEDR[9] = carrys[3]; // display the carry bit from last full adder 
endmodule 
