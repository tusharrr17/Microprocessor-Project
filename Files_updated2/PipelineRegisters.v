`include "defines.v"

module ID_REG_EXE (clk, reset, destination_inputval, register2_inputval, value1_inputval, value2_inputval, program_counter_input, EXE_CMD_IN, memory_read_enabled_inputvalue, memory_write_enabled_inputvalue, writeback_enabled_inputvalue, brTaken_in, src1_in, src2_in,
                         destination_source,   ST_value,   valuein1,   valuein2,   programrun_counter,  EXE_CMD,    memory_read_enabled,    memory_write_enabled,    writeback_enabled, brTaken_out, src1_out, src2_out);
  input memory_read_enabled_inputvalue, memory_write_enabled_inputvalue, writeback_enabled_inputvalue, brTaken_in;
  input [`FUNC_SIZE-1:0] EXE_CMD_IN;
  input clk, reset;
  // TO BE REGISTERED FOR ID STAGE
 
  input [`REG_LENGTH-1:0] destination_inputval, src1_in, src2_in;
  input [`MAX_LENGTH-1:0] register2_inputval, value1_inputval, value2_inputval, program_counter_input;
  // REGISTERED VALUES FOR ID STAGE
  output reg [`REG_LENGTH-1:0] destination_source, src1_out, src2_out;
  output reg [`MAX_LENGTH-1:0] ST_value, valuein1, valuein2, programrun_counter;

  output reg memory_read_enabled, memory_write_enabled, writeback_enabled, brTaken_out;
  output reg [`FUNC_SIZE-1:0] EXE_CMD;
  
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
module IF_REG_ID (clk, reset, flush, freeze, program_counter_input, instructionIn, programrun_counter, instruction);
  input clk, reset, flush, freeze;
  input [`MAX_LENGTH-1:0] program_counter_input, instructionIn;
  output reg [`MAX_LENGTH-1:0] programrun_counter, instruction;

  always @ (posedge clk) begin
    
    if (reset) begin
      programrun_counter <= 0;
      instruction <= 0;
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
module MEM_REG_WB (clk, reset, writeback_enabled_inputvalue, memory_read_enabled_inputvalue, alu_mod_result_input, memReadValIn, destination_inputval,
                         writeback_enabled,    memory_read_enabled,    alu_unit_result,   memReadVal,   destination_source);
  input clk, reset;
  input writeback_enabled_inputvalue, memory_read_enabled_inputvalue;
  input [`REG_LENGTH-1:0] destination_inputval;
  // TO BE REGISTERED FOR ID STAGE
  input [`MAX_LENGTH-1:0] alu_mod_result_input, memReadValIn;
  // REGISTERED VALUES FOR ID STAGE

  output reg [`MAX_LENGTH-1:0] alu_unit_result, memReadVal;
  output reg writeback_enabled, memory_read_enabled;
  output reg [`REG_LENGTH-1:0] destination_source;

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
module EXE_REG_MEM (clk, reset, writeback_enabled_inputvalue, memory_read_enabled_inputvalue, memory_write_enabled_inputvalue, program_counter_input, alu_mod_result_input, storevalue_input, destination_inputval,
                          writeback_enabled,    memory_read_enabled,    memory_write_enabled,    programrun_counter,   alu_unit_result,   STVal,   destination_source);
  input clk, reset;
  // TO BE REGISTERED FOR ID STAGE
  input writeback_enabled_inputvalue, memory_read_enabled_inputvalue, memory_write_enabled_inputvalue;
  input [`REG_LENGTH-1:0] destination_inputval;
  input [`MAX_LENGTH-1:0] program_counter_input, alu_mod_result_input, storevalue_input;
  // REGISTERED VALUES FOR ID STAGE
  output reg writeback_enabled, memory_read_enabled, memory_write_enabled;
  output reg [`MAX_LENGTH-1:0] programrun_counter, alu_unit_result, STVal;
  output reg [`REG_LENGTH-1:0] destination_source;

  always @ (posedge clk) begin
    if (reset) begin
      {STVal,memory_read_enabled, memory_write_enabled,writeback_enabled, alu_unit_result, destination_source, programrun_counter} <= 0;
    end
    else begin
      memory_write_enabled <= memory_write_enabled_inputvalue;
      memory_read_enabled <= memory_read_enabled_inputvalue;
      programrun_counter <= program_counter_input;
      alu_unit_result <= alu_mod_result_input;
      STVal <= storevalue_input;
      destination_source <= destination_inputval;
      writeback_enabled <= writeback_enabled_inputvalue;
      
    end
  end
endmodule // EXE_REG_MEM