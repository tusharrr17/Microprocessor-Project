`include "defines.v"

module MEMORY_stage (clk, reset, memory_read_enabled, memory_write_enabled, ALU_res, ST_value, dataMem_out);
  input clk, reset, memory_read_enabled, memory_write_enabled;
  input [`MAX_LENGTH-1:0] ALU_res, ST_value;
  output [`MAX_LENGTH-1:0]  dataMem_out;

// DATA MEMORY VALUES AND ENABLES ARE SET HERE 
  data_memory data_memory (
    .clk(clk),
    .reset(reset),
    .write_enabled(memory_write_enabled),
    .read_enabled(memory_read_enabled),
    .address(ALU_res),
    .data_input_mem(ST_value),
    .data_output_mem(dataMem_out)
  );
endmodule // MEMORY_stage
