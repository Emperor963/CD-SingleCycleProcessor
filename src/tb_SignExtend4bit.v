module sign_extend_tb;

    // Testbench inputs
    reg [7:0] in;

    // Testbench outputs
    wire [15:0] out;

    // Instantiate the sign extend module
    sign_extend uut (
        .in(in),
        .out(out)
    );

    // Test procedure
    initial begin
        // Monitor output for debugging
        $monitor("Time: %0d, in: %b (%0d), out: %b (%0d)", $time, in, in, out, out);

        // Test with various inputs
        in = 8'b00001111; #10; // Positive small number
        in = 8'b11110000; #10; // Negative small number (two's complement)
        in = 8'b10000000; #10; // Most negative 8-bit number (-128)
        in = 8'b01111111; #10; // Largest positive 8-bit number (127)
        in = 8'b00000000; #10; // Zero
        in = 8'b11111111; #10; // -1 in two's complement

        // Finish simulation
        $finish;
    end

endmodule
