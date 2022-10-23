`include "defines.v"

module IF_REG_ID (clk, reset, flush, freeze, program_counter_input, instructionIn, programrun_counter, instruction);
  input clk, reset, flush, freeze;
  input [`MAX_LENGTH-1:0] program_counter_input, instructionIn;
  output reg [`MAX_LENGTH-1:0] programrun_counter, instruction;

  always @ (posedge clk) begin
    if (reset) begin
      programrun_counter <= 0; // PC
      instruction <= 0; // INSTRUCTION
    end
    else begin
      if (~freeze) begin
        if (flush) begin
          instruction <= 0;
          programrun_counter <= 0;
        end
        else begin
          instruction <= instructionIn;
          programrun_counter <= program_counter_input;
        end
      end
    end
  end
endmodule // IF_REG_ID
