`include "defines.v"

module REGISTER (clk, reset, write_enabled, register_inputvalue, register_outputvalue);
  input clk, reset, write_enabled;
  input [`MAX_LENGTH-1:0] register_inputvalue;
  output reg [`MAX_LENGTH-1:0] register_outputvalue;

  always @ (posedge clk) begin
    if (reset == 1) register_outputvalue <= 0;
    else if (write_enabled) register_outputvalue <= register_inputvalue;
  end
endmodule // REGISTER
