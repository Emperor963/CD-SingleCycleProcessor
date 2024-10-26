module cpu_control(
    input [3:0]control,

    output RegRead,
    output MemRead,
    output [1:0]MemtoReg,
    output MemWrite,
    output [2:0]ALUOp,
    output ALUsrc,
    output RegWrite,
    output [1:0]PCSour,
    output LH,
    output HLT ); 

    /* result = 
                RegRead
                MemRead
                MemWrite
                ALUsrc
                RegWrite
                PcSource
                PCW

    */

    reg [6:0]result;
    reg [2:0]ALU;
    reg [1:0]MR;
    reg [1:0]PCSource;

    // Assign bits of result to output ports
    assign RegRead  = result[6];  // Bit 0 of result
    assign MemRead  = result[5];  // Bit 1 of result
    assign MemWrite = result[4];  // Bit 2 of result
    assign ALUsrc   = result[3];  // Bit 3 of result
    assign RegWrite = result[2];  // Bit 4 of result
    assign LH       = result[1];  // Bit 5 of result
    assign HLT      = result[0];

    assign ALUOp = ALU;

    assign MemtoReg = MR;
    
    assign PCSour = PCSource;


always @(*) begin
    case (control)
            4'b0000: begin      // ADD
            result = 7'b10001x0; ALU = 3'b000; MR = 2'b10; PCSource = 2'b00;
            end
            4'b0001: begin
            result = 7'b10001x0; ALU = 3'b001;  MR= 2'b10;  PCSource = 2'b00;     // SUB
            end
            4'b0010: begin
            result = 7'b10001x0; ALU = 3'b010;  MR= 2'b10;  PCSource = 2'b00;    // XOR
            end
            4'b0011: begin
            result = 7'b10001x0; ALU = 3'b011;  MR= 2'b10;  PCSource = 2'b00;    // RED 
            end
            4'b0100: begin
            result = 7'b10011x0; ALU = 3'b100;  MR= 2'b10;   PCSource = 2'b00;    // SLL
            end
            4'b0101: begin
            result = 7'b10011x0; ALU = 3'b101;  MR= 2'b10;  PCSource = 2'b00;    // SRA 
            end
            4'b0110: begin
            result = 7'b10011x0; ALU = 3'b110;  MR= 2'b10;  PCSource = 2'b00;    // ROR (Rotate Right)
            end
            4'b0111: begin
            result = 7'b10001x0; ALU = 3'b111;  MR= 2'b10;  PCSource = 2'b00;     // PADDSB (Padding Signed Bytes)
            end

            4'b1000: begin                         
            result = 7'b11011x0; ALU = 3'b000;  MR= 2'b11;   PCSource = 2'b00;     //LW 
            end
            4'b1001: begin                        
            result = 7'b10110x0; ALU = 3'b000;  MR= 2'bxx;  PCSource = 2'b00;     // SW
            end
            4'b1010:  begin                       
            result = 7'b000x100; ALU = 3'bxxx;  MR= 2'b01;  PCSource = 2'b00;     // LLB
            end
            4'b1011:  begin                      
            result = 7'b000x110; ALU = 3'bxxx;  MR= 2'b01;  PCSource = 2'b00;      // LHB
            end
            4'b1100:  begin                      
            result = 7'bx00x0x0; ALU = 3'bxxx;  MR= 2'bxx;  PCSource = 2'b11;       // B
            end
            4'b1101:  begin                       
            result = 7'b100x0x0; ALU = 3'bxxx;  MR= 2'bxx;  PCSource = 2'b01;       // BR
            end
            4'b1110:  begin                     
            result = 7'bx00x1x0; ALU = 3'bxxx;  MR= 2'b00;  PCSource = 2'b00;        //PCS
            end
            4'b1111:  begin                       
            result = 7'bxxxxxx1; ALU = 3'bxxx;  MR= 2'bxx;  PCSource = 2'b01;        //HLT
            end
            default: begin  // Default case to handle unknown opcodes
                result = 7'b0000000;
                ALU = 3'b000;
                MR = 2'b00;
                PCSource = 2'b00;
            end
    endcase

end


endmodule