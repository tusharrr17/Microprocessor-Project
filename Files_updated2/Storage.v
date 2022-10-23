`include "defines.v"

module data_memory (clk, reset, write_enabled, read_enabled, address, data_input_mem, data_output_mem);
  input clk, reset, read_enabled, write_enabled;
  input [`MAX_LENGTH-1:0] address, data_input_mem;
  output [`MAX_LENGTH-1:0] data_output_mem;

  integer i;
  
  wire [`MAX_LENGTH-1:0] base_address;
  reg [`MEMORY_SIZE-1:0] data_memory [0:`DATA_MEMORY_LENGTH-1];

  always @ (posedge clk) begin
    if (reset)
      for (i = 0; i < `DATA_MEMORY_LENGTH; i = i + 1)
        data_memory[i] <= 0;
    else if (write_enabled) begin
      {data_memory[base_address], data_memory[base_address + 1], data_memory[base_address + 2], data_memory[base_address + 3]} <= data_input_mem;
      $display("Data Added: %d",data_input_mem);
    end
  end

  assign base_address = (address & 32'b11111111111111111111111111011100);
  assign data_output_mem = (address < 32) ? 0 : {data_memory[base_address], data_memory[base_address + 1], data_memory[base_address + 2], data_memory[base_address + 3]};
endmodule // data_memory
module REGISTER_FILE ( clk, reset, source1, source2,writing_value,  registerval1,write_enabled, destination_source, registerval2);
  
  reg [`MAX_LENGTH-1:0] regMem [0:`REGF_LENGTH-1];
  input [`MAX_LENGTH-1:0] writing_value;
  input [`REG_LENGTH-1:0] source1, source2, destination_source;
  input reset,clk,  write_enabled;
  output [`MAX_LENGTH-1:0] registerval1, registerval2;

  
  integer i;

  always @ (negedge clk) begin
    if (reset) begin
      for (i = `MAX_LENGTH-1; i >=0 ; i = i - 1)
        regMem[i] <= 0;
	    end

    else if (write_enabled) begin
       regMem[destination_source] <= writing_value;
        $display("Data added: %d to register %d", writing_value,destination_source);
    end
    regMem[0] <= 0;
  end

  assign registerval1 = (regMem[source1]);
  assign registerval2 = (regMem[source2]);
endmodule // REGISTER_FILE
