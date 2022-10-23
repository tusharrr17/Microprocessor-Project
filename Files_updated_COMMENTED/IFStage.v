`include "defines.v"

// FETCHES INSTRUCTIONS FROM THE DATAMEM AND SENDS IT TO THE INSTRUCTION MEM


module INSTRUCT_FETCH (clk, reset, brTaken, brOffset, freeze, programrun_counter, instruction);
  input clk, reset, brTaken, freeze;
  input [`MAX_LENGTH-1:0] brOffset;
  output [`MAX_LENGTH-1:0] programrun_counter, instruction;

  wire [`MAX_LENGTH-1:0] adderIn1, adder4Out,adderoffOut, brOffserTimes4,adderOut;


  adder_module add4 ( // PC += 4 
    .input1(32'd4),
    .input2(programrun_counter),
    .outputfinal(adder4Out)
  );

  adder_module addoff( // OFFSET ADDER
    .input1(brOffserTimes4),
    .input2(programrun_counter),
    .outputfinal(adderoffOut)
  );

  mux_32 adderInput ( // SELECTS BETWEENM OFFSET AND NEXT IMMEDIATE INSTRUCTION
    .input1(adder4Out),
    .input2(adderoffOut),
    .selector(brTaken),
    .outputfinal(adderOut)
  );

  REGISTER PCReg (
    .clk(clk),
    .reset(reset),
    .write_enabled(~freeze),
    .register_inputvalue(adderOut),
    .register_outputvalue(programrun_counter)
  );

  INSTRUCT_MEMORY instructions ( // INSTRUCTONS ARE PASSED
    .reset(reset),
    .addr(programrun_counter),
    .instruction(instruction)
  );

  assign brOffserTimes4 = brOffset << 2;
endmodule // INSTRUCT_FETCH
