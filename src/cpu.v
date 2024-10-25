module cpu(
    input clk,
    input rst,

    output hlt,
    output [15:0] pc
);

//pc storing

wire pc_curr, pc_next;

//Initialize 
wire[2:0] flag_in, flag_out, wr //Flag register variables
wire[15:0] instruction //Instruction wire


wire[15:0] ALUOut; //Output from ALU
wire[15:0] MEMOut; //Output from Memory Read
wire[15:0] BitManOut; //Output from LLB LHB module
wire[15:0] RegWrite; //Output after 3 to 1 MUX 

wire RegRead, MemRead, MemWrite, ALUSrc, RegWrite, PCW, LH; //1 bit control signals
wire [1:0] MemtoReg; // 2 bit bus for 4 to 1 MUX
wire [2:0] ALUOp; // 3 bit ALU Control
wire [1:0] PCSrc; // 2 bit PCSrc


wire [15:0] ALU1; //ALU input 1
wire [15:0] ALU2; //ALU Input 2

flag_reg FLAG(.clk(clk), .rst(rst), .wr(wr), .in(flag_in), .out(flag_out));


//UPDATE WR
pc_reg pcStore(.clk(clk), .rst(rst), .d(), .wr(), .q(pc_curr))


endmodule