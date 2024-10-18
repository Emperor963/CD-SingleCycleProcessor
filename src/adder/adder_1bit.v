

module adder_1bit {

    input [3:0]A,
    input [3:0]B,
    input  C,
    output [3:0]Sum,
    output Cout,
    output Ovfl }
    



    wire G;
    wire P;

    assign G = (A & B) ? 1b'1:1b'0;
    assign P = (A | B) ? 1b'1:1b'0;









endmodule 