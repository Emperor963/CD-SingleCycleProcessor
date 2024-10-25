module 16bit_3to1MUX(
    input [15:0] sigA,
    input [15:0] sigB,
    input [15:0] sigC,
    input [15:0] sigD;

    input [1:0] control,

    output [15:0] out
);

wire[1:0] t1, t2, t3, t4; //temporary wires to store check values

assign t1 = !(control ^ 00);
assign t2 = !(control ^ 01);
assign t3 = !(control ^ 10);
assign t4 = !(control ^ 11);


assign out = (t1[0] & t1[1]) ? sigA :
             (t2[0] & t2[1]) ? sigB :
             (t3[0] & t3[1]) ? sigC :
             (t4[0] & t4[1]) ? sigD;



endmodule