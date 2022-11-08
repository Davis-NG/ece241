`timescale 1ns / 1ns // `timescale time_unit/time_precision

module full_adder(a, b, c_i, s, c_o,);
    input a, b, c_i;
    output c_o, s;
    wire sel;

    assign sel = a^b;
    assign s = sel^c_i;

    mux2to1 u1(.x(b), .y(c_i), .s(sel), .m(c_o));
endmodule
