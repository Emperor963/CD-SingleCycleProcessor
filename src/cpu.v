module cpu(
    input clk,
    input rst,

    output hlt,
    output [15:0] pc
);


//Initialize 
wire[2:0] flag_in, flag_out, wr //Flag register variables
wire[15:0] instruction //Instruction wire


wire[15:0] ALUOut; //Output from ALU
wire[15:0] MEMOut; //Output from Memory Read
wire[15:0] BitManOut; //Output from LLB LHB module
wire[15:0] RegWrite; //Output after 3 to 1 MUX 


wire [15:0] ALU1; //ALU input 1
wire [15:0] ALU2; //ALU Input 2

flag_reg FLAG(.clk(clk), .rst(rst), .wr(wr), .in(flag_in), .out(flag_out));

endmodule