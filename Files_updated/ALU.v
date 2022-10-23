`include "defines.v"

module ALU_module (valuein1, valuein2, EXE_CMD, alu_module_output);
  input [`MAX_LENGTH-1:0] valuein1, valuein2;
  input [`FUNC_SIZE-1:0] EXE_CMD;
  output reg [`MAX_LENGTH-1:0] alu_module_output;

  always @ ( * ) begin
    case (EXE_CMD)
      `ADD_EXECUTE: alu_module_output <= valuein1 + valuein2;
      `SUB_EXECUTE: alu_module_output <= valuein1 - valuein2;
      default: alu_module_output <= 0;
    endcase
  end
endmodule 