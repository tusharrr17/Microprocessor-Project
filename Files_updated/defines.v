
// Memory constants
`define DATA_MEMORY_LENGTH 32
`define INSTRUCTION_LENGTH 1024
`define REGF_LENGTH 32
`define MEMORY_SIZE 8

// Wire widths
`define MAX_LENGTH 32
`define REG_LENGTH 5
`define FUNC_SIZE 2
`define FORWARDING_LENGTH 2
`define OP_LENGTH 6


// To be used in side ALU_module
`define NOP_EXECUTE 2'b00 // for NOP, BEZ, BNQ, JMP
`define ADD_EXECUTE 2'b01
`define SUB_EXECUTE 2'b10

// To be used inside Control_unit.v
`define NOP_OPCODE 6'b000000
`define SUB_OPCODE 6'b000001
`define ADD_OPCODE 6'b000010
`define ADDI_OPCODE 6'b100000
`define SUBI_OPCODE 6'b100001
`define LD_OPCODE 6'b100010
`define ST_OPCODE 6'b100011
`define BEZ_OPCODE 6'b100100
`define BNE_OPCODE 6'b100101
`define JMP_OPCODE 6'b100110

// To be used in branch_check
`define JUMP_CONDITION 2'b10
`define BEZ_CONDITION 2'b11
`define BNE_CONDITION 2'b01
`define NULL_CONDITION 2'b00