// Wire widths
`define WORD_LEN 32
`define REG_FILE_ADDR_LEN 5
`define EXE_CMD_LEN 2
`define FORW_SEL_LEN 2
`define OP_CODE_LEN 6

// Memory constants
`define DATA_MEM_SIZE 32
`define INSTR_MEM_SIZE 1024
`define REG_FILE_SIZE 32
`define MEM_CELL_SIZE 8

// To be used inside controller.v
`define OP_NOP 6'b000000
`define OP_SUB 6'b000001
`define OP_ADD 6'b000010
`define OP_ADDI 6'b100000
`define OP_SUBI 6'b100001
`define OP_LD 6'b100010
`define OP_ST 6'b100011
`define OP_BEZ 6'b100100
`define OP_BNE 6'b100101
`define OP_JMP 6'b100110

// To be used in side ALU
`define EXE_NOP 2'b00 // for NOP, BEZ, BNQ, JMP
`define EXE_ADD 2'b01
`define EXE_SUB 2'b10


// To be used in conditionChecker
`define COND_JUMP 2'b10
`define COND_BEZ 2'b11
`define COND_BNE 2'b01
`define COND_NOTHING 2'b00