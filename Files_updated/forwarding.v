`include "defines.v"

module FORWARD_EXECUTE (source1_Execute, source2_Execute, Store_source_Execute, destination_Memory, destination_WriteBack, WriteBack_Enable_Memory, WriteBack_Enable_WriteBack, value1_select, value2_select, ST_val_sel);
  input [`REG_LENGTH-1:0] source1_Execute, source2_Execute, Store_source_Execute;
  input [`REG_LENGTH-1:0] destination_Memory, destination_WriteBack;
  input WriteBack_Enable_Memory, WriteBack_Enable_WriteBack;
  output reg [`FORWARDING_LENGTH-1:0] value1_select, value2_select, ST_val_sel;

  always @ ( * ) begin
    // initializing selector signals to 0
    // they will change to enable forwrding if needed.
    {value1_select, value2_select, ST_val_sel} <= 0;

    // determining forwarding control signal for ALU_module valuein1
    if (WriteBack_Enable_Memory && source1_Execute == destination_Memory) value1_select <= 2'd1;
    else if (WriteBack_Enable_WriteBack && source1_Execute == destination_WriteBack) value1_select <= 2'd2;

    // determining forwarding control signal for store value (ST_val)
    if (WriteBack_Enable_Memory && Store_source_Execute == destination_Memory) ST_val_sel <= 2'd1;
    else if (WriteBack_Enable_WriteBack && Store_source_Execute == destination_WriteBack) ST_val_sel <= 2'd2;

    // determining forwarding control signal for ALU_module valuein2
    if (WriteBack_Enable_Memory && source2_Execute == destination_Memory) value2_select <= 2'd1;
    else if (WriteBack_Enable_WriteBack && source2_Execute == destination_WriteBack) value2_select <= 2'd2;
  end
endmodule // forwarding
