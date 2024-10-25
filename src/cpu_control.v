module cpu_control(
    input [3:0]control,
    output RegRead,
    output MemRead,
    output [1:0]MemtoReg,
    output MemWrite,
    output [2:0]ALUOp,
    output ALUsrc,
    output RegWrite,
    output PCSource,
    output PCW,
    output LH
); 

    /* result = 
                RegRead
                MemRead
                MemWrite
                ALUsrc
                RegWrite
                PcSource
                PCW

    */

    wire [6:0]result;
    wire [2:0]ALU;
    wire [1:0]MR;

    // Assign bits of result to output ports
    assign RegRead  = result[6];  // Bit 6 of result
    assign MemRead  = result[5];  // Bit 5 of result
    assign MemWrite = result[4];  // Bit 4 of result
    assign ALUsrc   = result[3];  // Bit 3 of result
    assign RegWrite = result[2];  // Bit 2 of result
    assign PCSource = result[1];  // Bit 1 of result
    assign PCW      = result[0];  // Bit 0 of result
    assign LH       = result[7];  // Bit 7 of result

    assign ALUOp = ALU;

    assign MemtoReg = MR;


always @(*) begin
    case (control)
            4'b0000: begin      // ADD
            result = 8'b1000100; ALU = 3'b 000; MR = 2'b10;
            end
            4'b0001: begin
            result = 8'b1000100; ALU = 3'b001;  MR= 2'b10;       // SUB
            end
            4'b0010: begin
            result = 8'b1000100; ALU = 3'b010;  MR= 2'b10;      // XOR
            end
            4'b0011: begin
            result = 8'b1000100; ALU = 3'b011;  MR= 2'b10;      // RED 
            end
            4'b0100: begin
            result = 8'b1000100; ALU = 3'b100;  MR= 2'b10;       // SLL
            end
            4'b0101: begin
            result = 8'b1000100; ALU = 3'b101;  MR= 2'b10;      // SRA 
            end
            4'b0110: begin
            result = 8'b1000100; ALU = 3'b110;  MR= 2'b10;      // ROR (Rotate Right)
            end
            4'b0111: begin
            result = 8'b1000100; ALU = 3'b111;  MR= 2'b10;       // PADDSB (Padding Signed Bytes)
            end

            4'b1000: begin                         
            result = 8'b1101100; ALU = 3'b000;  MR= 2'b11;        //LW 
            end
            4'b1001: begin                        
            result = 8'b1011100; ALU = 3'b000;  MR= 2'b00;       // SW
            end
            4'b1010:  begin                       
            result = 8'b0001100; ALU = 3'b010;  MR= 2'b01;       // LLB
            end
            4'b1011:  begin                      
            result = 8'b0001100; ALU = 3'b010;  MR= 2'b01;        // LHB
            end
            4'b1100:  begin                      
            result = 8'b0001010; ALU = 3'b010;  MR= 2'b00;         // B
            end
            4'b1101:  begin                       
            result = 8'b1000010; ALU = 3'b010;  MR= 2'b00;         // BR
            end
            4'b1110:  begin                     
            result = 8'b0000101; ALU = 3'b010;  MR= 2'b00;          //PCS
            end
            4'b1111:  begin                       
            result = 8'b0000000; ALU = 3'b010;  MR= 2'b00;          //HLT
            end
            default: begin  // Default case to handle unknown opcodes
                result = 7'b0000000;
                ALU = 3'b000;
                MR = 2'b00;
            end
    endcase

end


endmodule