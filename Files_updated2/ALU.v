`include "defines.v"

module ALU_module (valuein1, valuein2, EXE_CMD, alu_module_output);
  input [`FUNC_SIZE-1:0] EXE_CMD;
  input [`MAX_LENGTH-1:0] valuein1, valuein2;
  output reg [`MAX_LENGTH-1:0] alu_module_output;

  always @ ( * ) begin
    case (EXE_CMD)
      `SUB_EXECUTE: alu_module_output <= valuein1 - valuein2;
      `ADD_EXECUTE: alu_module_output <= valuein1 + valuein2;
      `NOP_EXECUTE: alu_module_output <= 0;
      default: alu_module_output <= 0;
    endcase
  end
endmodule 