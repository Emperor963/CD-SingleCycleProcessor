`timescale 1ns/1ns

module claAddSub(
    input[15:0] A,
    input[15:0] Bin,
    input Cin,
    input isSub,

    output[15:0] S,
    output Cout,
    output ovfl
); 

reg [15:0] B;

assign B =  Bin ^ {16{isSub}}; 

wire[4:0] carry;
wire[3:0] gen;
wire[3:0] prop;
wire[15:0] tempSum;

assign carry[0] = Cin;
wire ovfl4;

adder_4bit adder1(
    .A(A[3:0]),
    .B(B[3:0]),
    .Cin(Cin),
    .Sum(tempSum[3:0]),
    .Cout(carry[0]),
    .P(prop[0]),
    .G(gen[0]),
    .ovfl(ovfl4)
);

//THIS ADDER IS TO ADD THE ISSUB BIT TO NEGATION OF B IF ISSUB IS 1. IF THIS DOES
//NOT WORK, REVERT BACK TO Cin FOR adder_1 TO BEING isSub WITH NO CARRY IN.
adder_4bit adder_01(
    .A(tempSum[3:0]),
    .B(B[3:0]),
    .Cin(isSub),
    .Sum(tempSum[3:0]),
    .Cout(carry[0]),
    .P(prop[0]),
    .G(gen[0]),
    .ovfl(ovfl4)
)

assign carry[1] = gen[0] | (prop[0] & carry[0]);

adder_4bit adder2(
    .A(A[7:4]),
    .B(B[7:4]),
    .Cin(Cin),
    .Sum(tempSum[7:4]),
    .Cout(carry[1]),
    .P(prop[1]),
    .G(gen[1]),
    .ovfl(ovfl4)
);

assign carry[2] = gen[1] | (prop[1] & carry[1]);

adder_4bit adder3(
    .A(A[11:8]),
    .B(B[11:8]),
    .Cin(Cin),
    .Sum(tempSum[11:8]),
    .Cout(carry[2]),
    .P(prop[2]),
    .G(gen[2]),
    .ovfl(ovfl4)
);

assign carry[3] = gen[2] | (prop[2] & carry[2]);

adder_4bit adder4(
    .A(A[15:12]),
    .B(B[15:12]),
    .Cin(Cin),
    .Sum(tempSum[15:12]),
    .Cout(carry[3]),
    .P(prop[3]),
    .G(gen[3]),
    .ovfl(ovfl4)
);

assign carry[4] = gen[3] | (prop[3] & carry[3]);

assign ovfl = (!A[15] & !B[15] & tempSum[15]) | (A[15] & B[15] & !tempSum[15]);

assign S = tempSum;

endmodule;