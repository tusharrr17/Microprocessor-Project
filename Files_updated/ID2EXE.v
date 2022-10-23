`include "defines.v"

module ID_REG_EXE (clk, reset, destination_inputval, register2_inputval, value1_inputval, value2_inputval, program_counter_input, EXE_CMD_IN, memory_read_enabled_inputvalue, memory_write_enabled_inputvalue, writeback_enabled_inputvalue, brTaken_in, src1_in, src2_in,
                         destination_source,   ST_value,   valuein1,   valuein2,   programrun_counter,  EXE_CMD,    memory_read_enabled,    memory_write_enabled,    writeback_enabled, brTaken_out, src1_out, src2_out);
  input clk, reset;
  // TO BE REGISTERED FOR ID STAGE
  input memory_read_enabled_inputvalue, memory_write_enabled_inputvalue, writeback_enabled_inputvalue, brTaken_in;
  input [`FUNC_SIZE-1:0] EXE_CMD_IN;
  input [`REG_LENGTH-1:0] destination_inputval, src1_in, src2_in;
  input [`MAX_LENGTH-1:0] register2_inputval, value1_inputval, value2_inputval, program_counter_input;
  // REGISTERED VALUES FOR ID STAGE
  output reg memory_read_enabled, memory_write_enabled, writeback_enabled, brTaken_out;
  output reg [`FUNC_SIZE-1:0] EXE_CMD;
  output reg [`REG_LENGTH-1:0] destination_source, src1_out, src2_out;
  output reg [`MAX_LENGTH-1:0] ST_value, valuein1, valuein2, programrun_counter;

  always @ (posedge clk) begin
    if (reset) begin
      {memory_read_enabled, memory_read_enabled, writeback_enabled, EXE_CMD, destination_source, ST_value, valuein1, valuein2, programrun_counter, brTaken_out, src1_out, src2_out} <= 0;
    end
    else begin
      memory_read_enabled <= memory_read_enabled_inputvalue;
      memory_write_enabled <= memory_write_enabled_inputvalue;
      writeback_enabled <= writeback_enabled_inputvalue;
      EXE_CMD <= EXE_CMD_IN;
      destination_source <= destination_inputval;
      ST_value <= register2_inputval;
      valuein1 <= value1_inputval;
      valuein2 <= value2_inputval;
      programrun_counter <= program_counter_input;
      brTaken_out <= brTaken_in;
      src1_out <= src1_in;
      src2_out <= src2_in;
    end
  end
endmodule // ID_REG_EXE
