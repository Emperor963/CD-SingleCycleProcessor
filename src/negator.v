module negator(
    input [15:0] B,
    output [15:0] negB
);

assign negB = !B + 1;

endmodule