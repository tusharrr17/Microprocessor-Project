`include "defines.v"

module mux_32 (input1, input2, selector, outputfinal);
  input selector;
  input [31:0] input1, input2;
  output [31:0] outputfinal;

  assign outputfinal = (selector == 0) ? input1 : input2;
endmodule // mxu

module mux_32_3input (input1, input2, in3, selector, outputfinal);
  input [31:0] input1, input2, in3;
  input [1:0] selector;
  output [31:0] outputfinal;

  assign outputfinal = (selector == 2'd0) ? input1 :
               (selector == 2'd1) ? input2 : in3;
endmodule // mux

module mux_5 (input1, input2, selector, outputfinal);
  input selector;
  input [4:0] input1, input2;
  output [4:0] outputfinal;

  assign outputfinal = (selector == 0) ? input1 : input2;
endmodule // mxu
