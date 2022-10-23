`include "defines.v"

module EXE_REG_MEM (clk, reset, writeback_enabled_inputvalue, memory_read_enabled_inputvalue, memory_write_enabled_inputvalue, program_counter_input, alu_mod_result_input, storevalue_input, destination_inputval,
                          writeback_enabled,    memory_read_enabled,    memory_write_enabled,    programrun_counter,   alu_unit_result,   STVal,   destination_source);
  input clk, reset;
  // TO BE REGISTERED FOR ID STAGE
  input writeback_enabled_inputvalue, memory_read_enabled_inputvalue, memory_write_enabled_inputvalue;
  input [`REG_LENGTH-1:0] destination_inputval;
  input [`MAX_LENGTH-1:0] program_counter_input, alu_mod_result_input, storevalue_input;
  // REGISTERED VALUES FOR ID STAGE
  output reg writeback_enabled, memory_read_enabled, memory_write_enabled;
  output reg [`REG_LENGTH-1:0] destination_source;
  output reg [`MAX_LENGTH-1:0] programrun_counter, alu_unit_result, STVal;

  always @ (posedge clk) begin
    if (reset) begin
      {writeback_enabled, memory_read_enabled, memory_write_enabled, programrun_counter, alu_unit_result, STVal, destination_source} <= 0;
    end
    else begin
      writeback_enabled <= writeback_enabled_inputvalue;
      memory_read_enabled <= memory_read_enabled_inputvalue;
      memory_write_enabled <= memory_write_enabled_inputvalue;
      programrun_counter <= program_counter_input;
      alu_unit_result <= alu_mod_result_input;
      STVal <= storevalue_input;
      destination_source <= destination_inputval;
    end
  end
endmodule // EXE_REG_MEM
