`include "defines.v" 
 
module INSTRUCT_MEMORY (reset, addr, instruction);
    input reset;
    input [`MAX_LENGTH-1:0] addr;
    output [`MAX_LENGTH-1:0] instruction;
 
    wire [$clog2(`INSTRUCTION_LENGTH)-1:0] address = addr[$clog2(`INSTRUCTION_LENGTH)-1:0];
    reg [`MEMORY_SIZE-1:0] instMem [0:`INSTRUCTION_LENGTH-1];
 
    always @ (*) begin
        if (reset) begin
            // No nop added in between instructions since there is a hazard detection unit 

            instMem[0] <= 8'b10000000;  //-- ADDI  r1,r0,6
            instMem[1] <= 8'b00100000;
            instMem[2] <= 8'b00000000;
            instMem[3] <= 8'b00000110;

            instMem[4] <= 8'b10000000;  //-- ADDI  r2,r0,1
            instMem[5] <= 8'b01000000;
            instMem[6] <= 8'b00000000;
            instMem[7] <= 8'b00000001;

            instMem[8] <= 8'b10000000;  //-- ADDI  r3,r0,1
            instMem[9] <= 8'b01100000;
            instMem[10] <= 8'b00000000;
            instMem[11] <= 8'b00000001;

            instMem[12] <= 8'b10000000;  //-- ADDI  r2,r2,1
            instMem[13] <= 8'b01000010;
            instMem[14] <= 8'b00000000;
            instMem[15] <= 8'b00000001;

            instMem[16] <= 8'b10000000;  //-- ADDI  R4,R0,0
            instMem[17] <= 8'b10000000;
            instMem[18] <= 8'b00000000;
            instMem[19] <= 8'b00000000;

            instMem[20] <= 8'b10000000;  //-- ADDI  R5,R0,0
            instMem[21] <= 8'b10100000;
            instMem[22] <= 8'b00000000;
            instMem[23] <= 8'b00000000;

            instMem[24] <= 8'b10000000;  //-- ADDI  R4,R4,1
            instMem[25] <= 8'b10000100;
            instMem[26] <= 8'b00000000;
            instMem[27] <= 8'b00000001;

            instMem[28] <= 8'b00001000;  //-- ADD  R5,R5,R3
            instMem[29] <= 8'b10100101;
            instMem[30] <= 8'b00011000;
            instMem[31] <= 8'b00000000;

            instMem[32] <= 8'b10010100;  //-- BNE  R2,R4,-3
            instMem[33] <= 8'b01000100;
            instMem[34] <= 8'b11111111;
            instMem[35] <= 8'b11111101;

            instMem[36] <= 8'b10000000;  //-- ADDI  R3,R5,0
            instMem[37] <= 8'b01100101;
            instMem[38] <= 8'b00000000;
            instMem[39] <= 8'b00000000;

            instMem[40] <= 8'b10010100;  //-- BNE  R2,R1,-8
            instMem[41] <= 8'b01000001;
            instMem[42] <= 8'b11111111;
            instMem[43] <= 8'b11111000;
        end
    end

  assign instruction = {instMem[address], instMem[address + 1], instMem[address + 2], instMem[address + 3]};
endmodule // insttructionMem