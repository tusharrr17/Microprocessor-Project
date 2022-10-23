`include "defines.v"

module INSTRUCT_DECODE (clk, reset, hazard_detected_in, is_imm_out, ST_or_BNE_out, instruction, registerval1, registerval2, source1, src2_reg_file, src2_forw, valuein1, valuein2, brTaken, EXE_CMD, memory_read_enabled, memory_write_enabled, writeback_enabled, branch_comm);
  input clk, reset, hazard_detected_in;
  input [`MAX_LENGTH-1:0] instruction, registerval1, registerval2;
  output [`REG_LENGTH-1:0] source1, src2_reg_file, src2_forw;
  output [`MAX_LENGTH-1:0] valuein1, valuein2;
  output brTaken, memory_read_enabled, memory_write_enabled, writeback_enabled, is_imm_out, ST_or_BNE_out;
  output [1:0] branch_comm;
  output [`FUNC_SIZE-1:0] EXE_CMD;

  wire is_immediate, store_branch_not_equal;
  wire CU2and, Cond2and;
  wire [1:0] CU2Cond;
  wire [`MAX_LENGTH-1:0] signExt2Mux;



  mux_5 mux_src2 ( // determines the REGISTER source 2 for REGISTER file
    .input1(instruction[15:11]),
    .input2(instruction[25:21]),
    .selector(store_branch_not_equal),
    .outputfinal(src2_reg_file)
  );

    Control_unit Control_unit(
    // INPUT
    .opCode(instruction[31:26]),
    .branch_enabled(CU2and),
    // OUTPUT
    .EXE_CMD(EXE_CMD),
    .Branch_command(CU2Cond),
    .is_immediate(is_immediate),
    .store_branch_not_equal(store_branch_not_equal),
    .writeback_enabled(writeback_enabled),
    .memory_read_enabled(memory_read_enabled),
    .memory_write_enabled(memory_write_enabled),
    .hazard_detected(hazard_detected_in)
  );

  mux_32 mux_val2 ( // determines whether valuein2 is from the reg file or the immediate value
    .input1(registerval2),
    .input2(signExt2Mux),
    .selector(is_immediate),
    .outputfinal(valuein2)
  );



  SIGNED_EXTENSION SIGNED_EXTENSION(
    .in(instruction[15:0]),
    .outputfinal(signExt2Mux)
  );

  mux_5 mux_src2_forw ( // determins the value of REGISTER source 2 for forwarding
    .input1(instruction[15:11]), // source2 = instruction[15:11]
    .input2(5'd0),
    .selector(is_immediate),
    .outputfinal(src2_forw)
  );
  branch_check branch_check (
    .registerval1(registerval1),
    .registerval2(registerval2),
    .cuBranchComm(CU2Cond),
    .branch_condition_check(Cond2and)
  );

  assign brTaken = CU2and && Cond2and;
  assign valuein1 = registerval1;
  assign source1 = instruction[20:16];
  assign is_imm_out = is_immediate;
  assign ST_or_BNE_out = store_branch_not_equal;
  assign branch_comm = CU2Cond;
endmodule // INSTRUCT_DECODE
