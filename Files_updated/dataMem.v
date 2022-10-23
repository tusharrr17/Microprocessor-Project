`include "defines.v"

module data_memory (clk, reset, write_enabled, read_enabled, address, data_input_mem, data_output_mem);
  input clk, reset, read_enabled, write_enabled;
  input [`MAX_LENGTH-1:0] address, data_input_mem;
  output [`MAX_LENGTH-1:0] data_output_mem;

  integer i;
  reg [`MEMORY_SIZE-1:0] data_memory [0:`DATA_MEMORY_LENGTH-1];
  wire [`MAX_LENGTH-1:0] base_address;

  always @ (posedge clk) begin
    if (reset)
      for (i = 0; i < `DATA_MEMORY_LENGTH; i = i + 1)
        data_memory[i] <= 0;
    else if (write_enabled) begin
      {data_memory[base_address], data_memory[base_address + 1], data_memory[base_address + 2], data_memory[base_address + 3]} <= data_input_mem;
      $display("Data Added: %d",data_input_mem);
    end
  end

  assign base_address = ((address & 32'b11111111111111111111111111011111) >> 2) << 2;
  assign data_output_mem = (address < 32) ? 0 : {data_memory[base_address], data_memory[base_address + 1], data_memory[base_address + 2], data_memory[base_address + 3]};
endmodule // data_memory