module tb_SignExtend8bit;

    // Testbench inputs
    reg [8:0] Ain;

    // Testbench outputs
    wire [15:0] Bout;

    // Instantiate the sign extend module
    SignExtend8bit uut (
        .A(Ain),
        .B(Bout)
    );

    // Test procedure
    initial begin
        // Monitor output for debugging
        $monitor("Time: %0d, in: %b, out: %b", $time, Ain, Bout);

        // Test with various inputs
        Ain = 8'b01110000; #10; // Positive small number
        Ain = 8'b10001111; #10; // Negative small number (two's complement)
        Ain = 8'b00101010; #10; // Most negative 8-bit number (-128)
        Ain = 8'b011111111; #10; // Largest positive 8-bit number (127)
        Ain = 8'b00001010; #10; // Zero
        Ain = 8'b11111111; #10; // -1 in two's complement

        // Finish simulation
        $finish;
    end

endmodule
