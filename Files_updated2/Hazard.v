`include "defines.v"

module DETECT_HAZARD(forward_EN, is_imm, store_branch_not_equal, source1_ID, source2_ID, destination_execute, WriteBack_enable_execute, destination_Memory, WriteBack_Enable_Memory, Memory_R_enable_execute, branch_comm, hazard_detected);
  input [`REG_LENGTH-1:0] destination_execute, destination_Memory;
  input [`REG_LENGTH-1:0] source1_ID, source2_ID;
  input forward_EN, WriteBack_enable_execute, WriteBack_Enable_Memory, is_imm, store_branch_not_equal, Memory_R_enable_execute;
  input [1:0] branch_comm;
  output hazard_detected;

  wire src2_is_valid, exe_has_hazard, mem_has_hazard, hazard, instr_is_branch;

  assign exe_has_hazard = WriteBack_enable_execute && (source1_ID == destination_execute || (src2_is_valid && source2_ID == destination_execute));
  assign mem_has_hazard = WriteBack_Enable_Memory && (source1_ID == destination_Memory || (src2_is_valid && source2_ID == destination_Memory));

  assign src2_is_valid =  (~is_imm) || store_branch_not_equal;
  assign hazard = (exe_has_hazard || mem_has_hazard);
  assign instr_is_branch = (branch_comm == `BEZ_CONDITION || branch_comm == `BNE_CONDITION);

  assign hazard_detected = ~forward_EN ? hazard : (instr_is_branch && hazard) || (Memory_R_enable_execute && mem_has_hazard);
endmodule // DETECT_HAZARD
module FORWARD_EXECUTE (source1_Execute, source2_Execute, Store_source_Execute, destination_Memory, destination_WriteBack, WriteBack_Enable_Memory, WriteBack_Enable_WriteBack, value1_select, value2_select, ST_val_sel);
  input WriteBack_Enable_Memory, WriteBack_Enable_WriteBack;
  input [`REG_LENGTH-1:0] source1_Execute, source2_Execute, Store_source_Execute,destination_Memory, destination_WriteBack;
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