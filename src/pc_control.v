module pc_control(
    input [15:0] pc_in,
    input [8:0] imm,
    input [2:0] FLAG,
    input [2:0] C,

    output [15:0] pc_out
);

wire [15:0] SEXTImm;
assign SEXTImm = {{7{imm[8]}}, imm[8:0]};
wire [15:0] targetAddr; 
assign targetAddr = SEXTImm << 1;

wire N = FLAG[0];
wire Z = FLAG[1];
wire V = FLAG[2];

wire[15:0] PC_update, target_address;

clAddSub pcAddr(.A(pc_in), .Bin(16'd2), .Cin(1'b0), .isSub(1'b0), .S(PC_update) 
                //, .Cout(), .ovfl()
                );
claAddSub targAddr(.A(PC_update), .Bin(targetAddr), .Cin(1'b0), .isSub(1'b0), .S(target_address)
                    );


reg[15:0] out;
always @(*) begin
    
    case (C)

    3'b000:
        out = !Z ? target_address : PC_update;
    3'b001:
        out = Z ? target_address : PC_update;
    3'b010:
        out = (!Z & !N) ? target_address  : PC_update;
    3'b011:
        out = N ? target_address : PC_update;
    3'b100:
        out = (Z | (!Z & !N)) ? target_address : PC_update;
    3'b101:
        out = (N | Z) ? target_address : PC_update;
    3'b110:
        out = V ? target_address : PC_update;
    3'b111:
        ou = target_address;

    default:
        out = PC_update;
    endcase

end


assign pc_out = out;


endmodule