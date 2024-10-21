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

wire [15:0]Sum_f;

wire [3:0]to_addA;
wire [3:0]to_addB;

wire [3:0]Cout;

wire Cout2;


adder_4bit add0 (.A(A_b), .B(B_b), .C(1b'0), .Sum(Sum_a[11:8]), .Cout(Cout[0]));
adder_4bit add1 (.A(A_a), .B(B_a), .C(Cout[0]), .Sum(Sum_b[15:12]), .Cout(Cout[1]));

adder_4bit add2 (.A(A_d), .B(B_d), .C(1b'0), .Sum(Sum_c[3:0]), .Cout(Cout[2]));
adder_4bit add3 (.A(A_c), .B(B_c), .C(Cout[2]), .Sum(Sum_d[7:4]), .Cout(Cout[3]));

adder_4bit add4 (.A(Sum_d), .B(Sum_b), .C(1'b0), .Sum(Sum_f[3:0]), .Cout(Cout2));
adder_4bit add5 (.A(Sum_c), .B(Sum_a), .C(Cout2), .Sum(Sum_f[7:4]), .Cout(Cout3));

assign to_addA = (Cout[1]) ? 3'b0001:3'b0000;
assign to_addB = (Cout[3]) ? 3'b0001:3'b0000;

adder_4bit add6 (.A(to_addA), .B(to_addB), .C(Cout2), .Sum(Sum_f[11:8]));

assign  Sum[15:9]  = (Sum_f[8]) ? 1'b1111111: 
                     (Sum_f[9]) ? 1'b0000001:a'b0000000;


assign Sum[8:0] = Sum_f[8:0]


endmodule 