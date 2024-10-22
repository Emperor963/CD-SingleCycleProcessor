module write_decoder_4_16(
    input [3:0] reg_id,
    input write_reg,
    output [15:0] wordline
);

wire [15:0] sample;

assign wire = 16'h1;

assign wordline = (write_reg == 1'b0) 16'h0 : sample << reg_id; //CHANGE TO CONST SHAMTS

endmodule