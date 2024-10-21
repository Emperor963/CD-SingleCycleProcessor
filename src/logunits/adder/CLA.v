moduel CLA_4bit(
    input [3:0]G;
    input [3:0]P;
    input Cin;

    output [3:0]Cout;

) {
    wire [2:0] Carry;

    assign Cout[0] = G[0] | (P[0] & Cin);
    assign Cout[1] = G[1] | (P[1] & Carry[0]);
    assign Cout[2] = G[2] | (P[2] & Carry[1]);
    assign Cout[3] = G[3] | (P[3] & Carry[2]);

}