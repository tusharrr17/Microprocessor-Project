`include "defines.v"

module REGISTER_FILE (clk, reset, source1, source2, destination_source, writing_value, write_enabled, registerval1, registerval2);
  input clk, reset, write_enabled;
  input [`REG_LENGTH-1:0] source1, source2, destination_source;
  input [`MAX_LENGTH-1:0] writing_value;
  output [`MAX_LENGTH-1:0] registerval1, registerval2;

  reg [`MAX_LENGTH-1:0] regMem [0:`REGF_LENGTH-1];
  integer i;

  always @ (negedge clk) begin
    if (reset) begin
      for (i = 0; i < `MAX_LENGTH; i = i + 1)
        regMem[i] <= 0;
	    end

    else if (write_enabled) begin
       regMem[destination_source] <= writing_value;
        $display("Register:%d => Value: %d",destination_source, writing_value); // displays value whnever we write in any of the registers
    end
    regMem[0] <= 0;
  end

  assign registerval1 = (regMem[source1]);
  assign registerval2 = (regMem[source2]);
endmodule // REGISTER_FILE
