module ror(
    input[15:0] Ain,
    input[4:0] shamt,

    output[15:0] Aout
);

reg[15:0] Adummy;

assign Adummy = Ain >> shamt;

assign shamt = !shamt + 1; //Take negation of shamt


endmodule