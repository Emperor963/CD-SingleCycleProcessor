
module adder_1bit {

    input [3:0]A,
    input [3:0]B,
    input  C,

    output [3:0]Sum,
    output G,
    output P }
    
    wire G;
    wire P;

    assign G = (A & B) ? 1'b1:1'b0;
    assign P = (A | B) ? 1'b1:1'b0;

    assign Sum = A ^ B ^ C;  

endmodule 