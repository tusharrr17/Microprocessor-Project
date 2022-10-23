`include "defines.v"

module WRITEBACK_STAGE (memory_read_enabled, currmemory_data, alu_result, WB_res);
  input memory_read_enabled;
  input [`MAX_LENGTH-1:0] currmemory_data, alu_result;
  output [`MAX_LENGTH-1:0] WB_res;

  assign WB_res = (memory_read_enabled) ? currmemory_data : alu_result; // RESULTS ARE WRITTEN BACK TO THE DATA MEM
endmodule // WRITEBACK_STAGE
