`include "defines.v"

module MEM_REG_WB (clk, reset, writeback_enabled_inputvalue, memory_read_enabled_inputvalue, alu_mod_result_input, memReadValIn, destination_inputval,
                         writeback_enabled,    memory_read_enabled,    alu_unit_result,   memReadVal,   destination_source);
  input clk, reset;
  // TO BE REGISTERED FOR ID STAGE
  input writeback_enabled_inputvalue, memory_read_enabled_inputvalue;
  input [`REG_LENGTH-1:0] destination_inputval;
  input [`MAX_LENGTH-1:0] alu_mod_result_input, memReadValIn;
  // REGISTERED VALUES FOR ID STAGE
  output reg writeback_enabled, memory_read_enabled;
  output reg [`REG_LENGTH-1:0] destination_source;
  output reg [`MAX_LENGTH-1:0] alu_unit_result, memReadVal;

  always @ (posedge clk) begin
    if (reset) begin
      {writeback_enabled, memory_read_enabled, destination_source, alu_unit_result, memReadVal} <= 0;
    end
    else begin
      writeback_enabled <= writeback_enabled_inputvalue;
      memory_read_enabled <= memory_read_enabled_inputvalue;
      destination_source <= destination_inputval;
      alu_unit_result <= alu_mod_result_input;
      memReadVal <= memReadValIn;
    end
  end
endmodule // MEM_REG_WB
