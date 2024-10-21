module Bitcell(
    input clk,
    input rst,
    input d, 
    input wen, //write enable
    input ren1, //read enable
    input ren2, //read enable
    

    inout bitline1,
    inout bitline2
);

wire output;

dff flip_flop(.q(output), 
              .d(d), 
              .wen(wen), 
              .clk(clk), 
              .rst(rst)
);

assign bitline1 = ren1 ? output : 1'bz;
assign bitline2 = ren2 ? output : 1'bz;

endmodule