`include "defines.v"

module WRITEBACK_STAGE ( currmemory_data, alu_result,memory_read_enabled, WB_res);
  input memory_read_enabled;
  input [`MAX_LENGTH-1:0] currmemory_data, alu_result;
  output [`MAX_LENGTH-1:0] WB_res;

  assign WB_res = (memory_read_enabled) ? currmemory_data : alu_result;
endmodule // WRITEBACK_STAGE
