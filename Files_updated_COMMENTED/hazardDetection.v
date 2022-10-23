`include "defines.v"

module DETECT_HAZARD(forward_EN, is_imm, store_branch_not_equal, source1_ID, source2_ID, destination_execute, WriteBack_enable_execute, destination_Memory, WriteBack_Enable_Memory, Memory_R_enable_execute, branch_comm, hazard_detected);
  input [`REG_LENGTH-1:0] source1_ID, source2_ID;
  input [`REG_LENGTH-1:0] destination_execute, destination_Memory;
  input [1:0] branch_comm;
  input forward_EN, WriteBack_enable_execute, WriteBack_Enable_Memory, is_imm, store_branch_not_equal, Memory_R_enable_execute;
  output hazard_detected;

  wire src2_is_valid, exe_has_hazard, mem_has_hazard, hazard, instr_is_branch;

  assign src2_is_valid =  (~is_imm) || store_branch_not_equal;

  assign exe_has_hazard = WriteBack_enable_execute && (source1_ID == destination_execute || (src2_is_valid && source2_ID == destination_execute));
  assign mem_has_hazard = WriteBack_Enable_Memory && (source1_ID == destination_Memory || (src2_is_valid && source2_ID == destination_Memory));

  assign hazard = (exe_has_hazard || mem_has_hazard); // assigns properly whether the hazard is in exe or mem
  assign instr_is_branch = (branch_comm == `BEZ_CONDITION || branch_comm == `BNE_CONDITION); // branch decision

  assign hazard_detected = ~forward_EN ? hazard : (instr_is_branch && hazard) || (Memory_R_enable_execute && mem_has_hazard);
endmodule // DETECT_HAZARD
