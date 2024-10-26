module cpu(
    input clk,
    input rst,

    output hlt,
    output [15:0] pc
);

//pc storing

wire pc_curr, pc_next;

//Initialize 
wire[2:0] flag_in, flag, wr //Flag register variables
wire[15:0] instruction //Instruction wire


wire[15:0] ALUOut; //Output from ALU
wire[15:0] MEMOut; //Output from Memory Read
wire[15:0] BitManOut; //Output from LLB LHB module
wire[15:0] rd_data; //Output after 4 to 1 MUX 
wire[15:0] rs, rt, dst_reg, rd1, rd2, bmrd, alurd;


//CONTROL SIGNALS
wire RegRead, MemRead, MemWrite, ALUSrc, RegWrite, PCW, LH; //1 bit control signals
wire [1:0] MemtoReg; // 2 bit bus for 4 to 1 MUX
wire [2:0] ALUOp; // 3 bit ALU Control
wire [1:0] PCSrc; // 2 bit PCSrc


wire [15:0] ALU1; //ALU input 1
wire [15:0] ALU2; //ALU Input 2

flag_reg FLAG(.clk(clk), .rst(rst), .wr(wr), .in(flag_in), .out(flag));


//UPDATE WR
pc_reg pcStore(.clk(clk), .rst(rst), .d(), .wr(), .q(pc_curr));

wire [15:0] pcc_out;
//PC Control
pc_control pcController(.pc_in(pc_curr), .imm(instruction[8:0]), .FLAG(flag), 
                        .C(instruction[11:9]), .pc_out(pcc_out));



//CPU Control
cpu_control cpuController(.control(instruction[15:12]), .RegRead(RegRead), .MemRead(MemRead), 
                          .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUOp(ALUOp),
                          .ALUSrc(ALUSrc), .RegWrite(RegWrite), .PCSour(PCSrc), .LH(LH));

//Instruction Memory
memory1c_instr IMem(.data_out(instruction), .addr(pc_curr), .clk(clk), .rst(rst));


//Data Memory
memory1c_data DMem(.data_out(), .data_in(), .addr(), .enable(), .wr(), .clk(), .rst());

//Register RF
Register_File RF(.clk(clk), .rst(rst), .src_reg1(src1), .src_reg2(rt), .dst_reg(dst_Reg), 
                .write_reg(RegWrite), .dst_data(rd_data), .src_data1(rd1), .src_data2(rd2));

//ALU UPDATE FLAGS
ALU alu(.In1(rd1), .In2(), .ALUOp(ALUOp), .FLAG_in(), .FLAG(), .ALUOut(alurd));

//LLB/LHB Module

bitman BitManipulator(.LH(LH), .RD1(rd1), .i(instruction[7:0]), .RD(bmrd));


endmodule