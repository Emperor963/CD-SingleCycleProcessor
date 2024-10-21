module paddsb (
    input [15:0] A;
    input [15:0] B;

    output [15:0] Sum;
);

wire [3:0]A_a; //15-12
wire [3:0]A_b; //11-8
wire [3:0]A_c; //7-4
wire [3:0]A_d; //3-0

wire [3:0]B_a; //15-12
wire [3:0]B_b; //11-8
wire [3:0]B_c; //7-4
wire [3:0]B_d; //3-0

wire [3:0]Sum_a; //15-12
wire [3:0]Sum_b; //11-8
wire [3:0]Sum_c; //7-4
wire [3:0]Sum_d; //3-0

wire [3:0]ovfl;
wire [3:0]Cout;

wire dummy0, dummy1, dummy2;

adder_4bit add0 (.A(A_b), .B(B_b), .C(1b'0), .Sum(Sum_a[11:8]), .Cout(Cout[0]), .P(dummy1), .G(dummy2), .ovfl(ovfl[2]));
adder_4bit add1 (.A(A_a), .B(B_a), .C(Cout[0]), .Sum(Sum_b[15:12]), .Cout(Cout[1]), .P(dummy1), .G(dummy2), .ovfl(ovfl[3]));


adder_4bit add2 (.A(A_d), .B(B_d), .C(1b'0), .Sum(Sum_c[3:0]), .Cout(Cout[2]), .P(dummy1), .G(dummy2), .ovfl(ovfl[0]));
adder_4bit add3 (.A(A_c), .B(B_c), .C(Cout[1]), .Sum(Sum_d[7:4]), .Cout(Cout[3]), .P(dummy1), .G(dummy2), .ovfl(ovfl[1])));
adder_4bit add5 (.A,(Sum_))


              
endmodule 