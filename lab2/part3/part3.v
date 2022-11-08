`timescale 1ns / 1ns // `timescale time_unit/time_precision

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

module hex(SW, HEX0);
    input [3:0] SW;
    output [6:0] HEX0;

    hex_decoder u0(
        .c(SW),
        .display(HEX0)
        );
endmodule