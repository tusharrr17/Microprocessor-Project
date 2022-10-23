`include "defines.v"

module IFStage (clk, rst, brTaken, brOffset, freeze, PC, instruction);
  input clk, rst, brTaken, freeze;
  input [`WORD_LEN-1:0] brOffset;
  output [`WORD_LEN-1:0] PC, instruction;

  wire [`WORD_LEN-1:0] adderIn1, adder4Out,adderoffOut, brOffserTimes4,adderOut;


  adder add4 (
    .in1(32'd4),
    .in2(PC),
    .out(adder4Out)
  );

  adder addoff(
    .in1(brOffserTimes4),
    .in2(PC),
    .out(adderoffOut)
  );

  mux_32 adderInput (
    .in1(adder4Out),
    .in2(adderoffOut),
    .sel(brTaken),
    .out(adderOut)
  );
  register PCReg (
    .clk(clk),
    .rst(rst),
    .writeEn(~freeze),
    .regIn(adderOut),
    .regOut(PC)
  );

  instructionMem instructions (
    .rst(rst),
    .addr(PC),
    .instruction(instruction)
  );

  assign brOffserTimes4 = brOffset << 2;
endmodule // IFStage
