module srl(
    input[15:0] Ain,
    input[4:0] shamt,

    output[15:0] Aout
);


wire[15:0] At1, At2, At4, At8; //temporary storages for constant shifts

assign At1 = shamt[0] ? (Ain >> 1) : Ain;
assign At2 = shamt[1] ? (At1 >> 2) : At1;
assign At4 = shamt[2] ? (At2 >> 4) : At2;
assign At8 = shamt[3] ? (At4 >> 8) : At4;

assign Aout = shamt[4] ? 16'b0 ; At8;

endmodule