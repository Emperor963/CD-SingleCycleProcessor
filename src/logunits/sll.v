module sll(
    input[15:0] Ain,
    input[4:0] shamt,

    output[15:0] Aout
);

wire[15:0] At1, At2, At4, At8; //temporary storages for constant shifts

<<<<<<< HEAD
assign At1 = shamt[0] ? {Ain[15:1] , 1'b0} : Ain;
assign At2 = shamt[1] ? {At1[15:2] , 2'b0} : At1;
assign At4 = shamt[2] ? {At2[15:4] , 4'b0} : At2;
assign At8 = shamt[3] ? {At4[15:8] , 8'b0} : At4;
=======
assign At1 = shamt[0] ? (Ain << 1) : Ain;
assign At2 = shamt[1] ? (At1 << 2) : At1;
assign At4 = shamt[2] ? (At2 << 4) : At2;
assign At8 = shamt[3] ? (At4 << 8) : At4;
>>>>>>> 82220d2291169a1018da2144aba78396c4fa6737

assign Aout = shamt[4] ? 16'b0 : At8;


endmodule