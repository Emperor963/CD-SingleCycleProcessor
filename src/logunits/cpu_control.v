module cpu_control(
    input [3:0]opcode;
    output [5:0]result;
    output [2:0]ALU;
    output [1:0]LoadI;
    output [1:0]PCbus;
) 

    /* result = 
                Regwrite,
                ALU source,
                RegDst, 0 = rt 1 = rd
                MemRead,
                MemWrite,
                MemtoReg,
                branch


        LoadI = loadtype, loadlocation;

        PCbus = HLT, PClocation
    */


always @(*) begin
    case (control)
            4'b0000: begin
            result = 7'b1000000;  ALU = 3'b000; LoadI = 2'b00; PCbus = 2'b00;     // ADD
            end
            4'b0001: begin
            result = 7'b1000000; ALU = 3'b001;  LoadI = 2'b00; PCbus = 2'b00;       // SUB
            end
            4'b0010: begin
            result = 7'b1000000; ALU = 3'b010;  LoadI = 2'b00; PCbus = 2'b00;     // XOR
            end
            4'b0011: begin
            result = 7'b1000000; ALU = 3'b011;  LoadI = 2'b00; PCbus = 2'b00;     // RED 
            end
            4'b0100: begin
            result = 7'b1000000; ALU = 3'b100;  LoadI = 2'b00; PCbus = 2'b00;     // SLL
            end
            4'b0101: begin
            result = 7'b1000000; ALU = 3'b101;  LoadI = 2'b00; PCbus = 2'b00;    // SRA 
            end
            4'b0110: begin
            result = 7'b1000000; ALU = 3'b110;  LoadI = 2'b00; PCbus = 2'b00;     // ROR (Rotate Right)
            end
            4'b0111: begin
            result =  7'b1000000; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;     // PADDSB (Padding Signed Bytes)
            end


            4'b1000: begin                         
            result =  7'b1101010; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;      //LW 
            end
            4'b1001: begin                        
            result =  7'b0100110; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;      // SW
            end
            4'b1010:  begin                       
            result =  7'b100000; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;      // LLB
            end
            4'b1011:  begin                      
            result =  7'b100000; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;      // LHB
            end
            4'b1100:  begin                      
            result =  7'b100000; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;       // B
            end
            4'b1101:  begin                       
            result =  7'b100000; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;       // BR
            end
            4'b1110:  begin                     
            result =  7'b100000; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;        //PCS
            end
            4'b1111:  begin                       
            result =  7'b100000; ALU = 3'b111;  LoadI = 2'b00; PCbus = 2'b00;        //HLT
            end

end


endmodule