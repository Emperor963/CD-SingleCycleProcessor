module adder_4bit (
    input [3:0]A;
    input [3:0]B;
    input C;


    output [3:0]Sum;
    output Cout;    
    output P;
    output G;
    
);

wire [2:0]Carry;
wire [3:0]Pp;
wire [3:0]Gg;

adder_1bit add0 (.A(A[0]), .B(B[0]), .C(C), .Sum(Sum[0]), .G(Gg[0])), .P(Pp[0]);
adder_1bit add1 (.A(A[1]), .B(B[1]), .C(Carry[0]), .Sum(Sum[1]), .G(Gg[1])), .P(Pp[1]);
adder_1bit add2 (.A(A[2]), .B(B[2]), .C(Carry[1]), .Sum(Sum[2]), .G(Gg[2])), .P(Pp[2]);
adder_1bit add3 (.A(A[3]), .B(B[3]), .C(Carry[2]), .Sum(Sum[3]), .G(Gg[3])), .P(Pp[3]);

assign P = Pp[3];
assign G = Gg[3];
assign Cout = (A[3] & B[3]);


endmodule