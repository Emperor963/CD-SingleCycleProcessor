module srl(
    input[15:0] Ain,
    input[4:0] shamt,

    output[15:0] Aout
);


assign Aout = Ain >> shamt;


endmodule