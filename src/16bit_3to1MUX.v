module 16bit_3to1MUX(
    input [15:0] sigA,
    input [15:0] sigB,
    input [15:0] sigC,

    input [1:0] control,

    output [15:0] out
);

assign out = (control == 01) ? sigA : (control == 10) ? sigB : (control == 11) ? sigC;

endmodule