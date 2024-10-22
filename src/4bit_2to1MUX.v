module 4bit_2to1MUX(
    input [3:0] sigA,
    input [3:0] sigB,
    input control,

    output [3:0] out
);

assign out = control? sigB : sigA;

endmodule