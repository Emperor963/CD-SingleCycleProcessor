module cpu(
    input clk,
    input rst,

    output hlt,
    output [15:0] pc
);

//pc storing

wire pc_curr, pc_next;

//Initialize 
wire[2:0] flag_in, flag, wr; //Flag register variables
wire[15:0] instruction; //Instruction wire


wire[15:0] ALUOut; //Output from ALU
wire[15:0] MEMOut; //Output from Memory Read
wire[15:0] BitManOut; //Output from LLB LHB module
wire[15:0] rd_data; //Output after 4 to 1 MUX 
wire[15:0] rs, rt,rd, src1, src2, dst_reg, rd2, bmrd, alurd, memrd;


//CONTROL SIGNALS
wire RegRead, MemRead, MemWrite, ALUSrc, RegWrite, PCW, LH, halt; //1 bit control signals
wire [1:0] MemtoReg; // 2 bit bus for 4 to 1 MUX
wire [2:0] ALUOp; // 3 bit ALU Control
wire [1:0] PCSrc; // 2 bit PCSrc


wire [15:0] ALU1; //ALU input 1
wire [15:0] ALU2; //ALU Input 2

flag_reg FLAG(.clk(clk), .rst(rst), .wr(wr), .in(flag_in), .out(flag));


//Shaky logic with .d
pc_reg pcStore(.clk(clk), .rst(rst), .d(next_pc), .wr(!halt), .q(pc_curr));

wire [15:0] pcc_out;
wire [15:0] pc_up;
//PC Control
pc_control pcController(.pc_in(pc_curr), .imm(instruction[8:0]), .FLAG(flag), 
                        .C(instruction[11:9]), .rd1(rd1) .pc_out(pcc_out), .pc_update(pc_up));

wire [15:0] braddr = pcc_out ^ rd1; //decode encrypted content of pc using rd1

//sigC for HALT
MUX16bit_2to1 pcmux(.sigA(pc_up), .sigB(rd1), .sigC(16'b0), .sigD(braddr), .control(PCSrc), .out(pc_next));

//CPU Control
cpu_control cpuController(.control(instruction[15:12]), .RegRead(RegRead), .MemRead(MemRead), 
                          .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUOp(ALUOp),
                          .ALUSrc(ALUSrc), .RegWrite(RegWrite), .PCSour(PCSrc), .LH(LH), .hlt(halt));

//Instruction Memory
memory1c_instr IMem(.data_out(instruction), .addr(pc_curr), .clk(clk), .rst(rst));


//Data Memory
memory1c_data DMem(.data_out(memrd), .data_in(rd2), .addr(ALUOut), .enable(MemRead), 
                   .wr(MemWrite), .clk(clk), .rst(rst));

//Register RF
assign rt = instruction[3:0];
assign rs = instruction[7:4];
assign rd = instruction[11:8];

assign dst_reg = rd;

MUX4bit_2to1 sourceMux(.sigA(rd), .sigB(rs), .control(RegRead), .out(src1));
Register_File RF(.clk(clk), .rst(rst), .src_reg1(src1), .src_reg2(rt), .dst_reg(dst_reg), 
                .write_reg(RegWrite), .dst_data(rd_data), .src_data1(rd1), .src_data2(rd2));


wire [3:0] aluImm = instruction[3:0];
wire [15:0] aluImmVal, aluIn2;
SignExtend4bit sext4(.A(aluImm), .B(aluImmVal));

MUX16bit_2to1 aluSrcMux(.sigA(rd1), .sigB(aluImmVal), .control(ALUSrc), .out(aluIn2));

//ALU UPDATE FLAGS
ALU alu(.In1(rd1), .In2(aluIn2), .ALUOp(ALUOp), .FLAG_in(flag), .FLAG(flag_in), .ALUOut(alurd));

MUX16_4to1 writerMux(.sigA(pc_up), .sigB(bmrd), .sigC(alurd), .sigD(memrd), 
                    .control(MemtoReg), .out(rd_data));
//LLB/LHB Module

bitman BitManipulator(.LH(LH), .RD1(rd1), .i(instruction[7:0]), .RD(bmrd));

assign halt = hlt;
assign pc = pc_curr;

endmodule