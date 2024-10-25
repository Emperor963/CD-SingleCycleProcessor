module ror(
    input[15:0] Ain,
    input[4:0] shamt,

    output[15:0] Aout
);

wire [15:0] Adummy;

assign Adummy = Ain << 1;

//MAYBE CHANGE THIS TO BITWISE OR?
assign Aout = {Adummy[shamt,1],Ain[15:shamt]}; //Hooooly shit this is so smart


//Basically we're concatenating the 15th to shamt'th bit in the lower significant bits,
//and concatenating it with the (shamt-1)th bit to the 0th bit to the front. But in order to get 
//the (shamt - 1)th bit without using -1, we take a dummy A variable, shift it to the left by 1 bit
//and take the shamt th bit to 1th bit because they're all logically shifted by one. 


//I can not stress how proud I am of this ingenious design.

endmodule




