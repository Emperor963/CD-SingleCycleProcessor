
module adder_1bit {

    input A,
    input B,
    input  C,

    output Sum,
    output G,
    output P }
    
    wire G;
    wire P;

    assign G = (A & B) ? 1'b1:1'b0;
    assign P = (A | B) ? 1'b1:1'b0;

    assign Sum = A ^ B ^ C;  

endmodule 