`include "defines.v"

module EXECUTE_STAGE (clk, EXE_CMD, value1_select, value2_select, ST_val_sel, valuein1, valuein2, ALU_res_MEM, result_WB, ST_value_in, ALUResult, ST_value_out);
  input clk;
  input [`FORWARDING_LENGTH-1:0] value1_select, value2_select, ST_val_sel;
  input [`FUNC_SIZE-1:0] EXE_CMD;
  input [`MAX_LENGTH-1:0] valuein1, valuein2, ALU_res_MEM, result_WB, ST_value_in;
  output [`MAX_LENGTH-1:0] ALUResult, ST_value_out;

  wire [`MAX_LENGTH-1:0] ALU_val1, ALU_val2;

  mux_32_3input mux_ST_value (
    .input1(ST_value_in),
    .input2(ALU_res_MEM),
    .in3(result_WB),
    .selector(ST_val_sel),
    .outputfinal(ST_value_out)
  );

  mux_32_3input mux_val1 (
    .input1(valuein1),
    .input2(ALU_res_MEM),
    .in3(result_WB),
    .selector(value1_select),
    .outputfinal(ALU_val1)
  );

  mux_32_3input mux_val2 (
    .input1(valuein2),
    .input2(ALU_res_MEM),
    .in3(result_WB),
    .selector(value2_select),
    .outputfinal(ALU_val2)
  );


  ALU_module ALU_module(
    .valuein1(ALU_val1),
    .valuein2(ALU_val2),
    .EXE_CMD(EXE_CMD),
    .alu_module_output(ALUResult)
  );
endmodule // EXECUTE_STAGE
