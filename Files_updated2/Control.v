`include "defines.v"

module Control_unit (opCode, branch_enabled, EXE_CMD, Branch_command, is_immediate, store_branch_not_equal, writeback_enabled, memory_read_enabled, memory_write_enabled, hazard_detected);
  input hazard_detected;
  input [`OP_LENGTH-1:0] opCode;
  output reg [`FUNC_SIZE-1:0] EXE_CMD;
  output reg [1:0] Branch_command;
  output reg branch_enabled,is_immediate, store_branch_not_equal, writeback_enabled, memory_read_enabled, memory_write_enabled;

  always @ ( * ) begin
    if (hazard_detected == 0) begin
      {branch_enabled, EXE_CMD, Branch_command, is_immediate, store_branch_not_equal, writeback_enabled, memory_read_enabled, memory_write_enabled} <= 0;
      case (opCode)

        // Writing to the Register File
        `ADD_OPCODE: begin EXE_CMD <= `ADD_EXECUTE; writeback_enabled <= 1; end
        `SUB_OPCODE: begin EXE_CMD <= `SUB_EXECUTE; writeback_enabled <= 1; end

        // Immediate Operations
        `ADDI_OPCODE: begin EXE_CMD <= `ADD_EXECUTE; writeback_enabled <= 1; is_immediate <= 1; end
        `SUBI_OPCODE: begin EXE_CMD <= `SUB_EXECUTE; writeback_enabled <= 1; is_immediate <= 1; end

        // Memory operations
        `LD_OPCODE: begin EXE_CMD <= `ADD_EXECUTE; writeback_enabled <= 1; is_immediate <= 1; store_branch_not_equal <= 1; memory_read_enabled <= 1; end
        `ST_OPCODE: begin EXE_CMD <= `ADD_EXECUTE; is_immediate <= 1; memory_write_enabled <= 1; store_branch_not_equal <= 1; end

        // branch operations
        `BEZ_OPCODE: begin EXE_CMD <= `NOP_EXECUTE; Branch_command <= `BEZ_CONDITION; is_immediate <= 1 ; branch_enabled <= 1; end
        `BNE_OPCODE: begin EXE_CMD <= `NOP_EXECUTE; Branch_command <= `BNE_CONDITION; is_immediate <= 1; branch_enabled <= 1; store_branch_not_equal <= 1; end
        `JMP_OPCODE: begin EXE_CMD <= `NOP_EXECUTE; Branch_command <= `JUMP_CONDITION; is_immediate <= 1; branch_enabled <= 1; end

        default: {branch_enabled, EXE_CMD, Branch_command, is_immediate, store_branch_not_equal, writeback_enabled, memory_read_enabled, memory_write_enabled} <= 0;
      endcase
    end

    else if (hazard_detected ==  1) begin
      // Prevents writes to Register file or Memory
      {EXE_CMD, writeback_enabled, memory_write_enabled} <= 0;
    end
  end
endmodule
module branch_check (registerval1, registerval2, cuBranchComm, branch_condition_check);
  input [`MAX_LENGTH-1: 0] registerval1, registerval2;
  input [1:0] cuBranchComm;
  output reg branch_condition_check;

  always @ ( * ) begin
    case (cuBranchComm)
      `JUMP_CONDITION: branch_condition_check <= 1;
      `BEZ_CONDITION: branch_condition_check <= (registerval1 == 0) ? 1 : 0;
      `BNE_CONDITION: branch_condition_check <= (registerval1 != registerval2) ? 1 : 0;
      `NULL_CONDITION: branch_condition_check <= 0;
      default: branch_condition_check <= 0;
    endcase
  end
endmodule