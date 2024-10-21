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

wire [15:0] B;

assign B =  Bin ^ {16{isSub}}; 

wire[3:0] LAcarry;
wire[3:0] gen;
wire[3:0] prop;
wire[15:0] tempSum;


assign S = {tempSum[15:1], tempSum[0]|isSub};

adder_4bit adder1(
    .A(A[3:0]),
    .B(B[3:0]),
    .Cin(Cin),
    .Sum(S[3:0]),
    .P(prop[0]),
    .G(gen[0]),
);

//THIS ADDER IS TO ADD THE ISSUB BIT TO NEGATION OF B IF ISSUB IS 1. IF THIS DOES
//NOT WORK, REVERT BACK TO Cin FOR adder_1 TO BEING isSub WITH NO CARRY IN.



adder_4bit adder2(
    .A(A[7:4]),
    .B(B[7:4]),
    .Cin(LAcarry[0]),
    .Sum(S[7:4]),
    .P(prop[1]),
    .G(gen[1]),
);


adder_4bit adder3(
    .A(A[11:8]),
    .B(B[11:8]),
    .Cin(LAcarry[1]),
    .Sum(S[11:8]),
    .P(prop[2]),
    .G(gen[2]),
);


adder_4bit adder4(
    .A(A[15:12]),
    .B(B[15:12]),
    .Cin(LAcarry[2]),
    .Sum(S[15:12]),
    .P(prop[3]),
    .G(gen[3]),
);

CLA cla1 (.G(gen),.P(prop), .Cin(Cin), .Cout(LAcarry));

assign ovfl = (!A[15] & !B[15] & tempSum[15]) | (A[15] & B[15] & !tempSum[15]);

assign Cout = LAcarry[3];


endmodule;