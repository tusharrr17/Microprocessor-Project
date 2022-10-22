`include "defines.v"

module mux_32 (in1, in2, sel, out);
  input sel;
  input [31:0] in1, in2;
  output [31:0] out;

  assign out = (sel == 0) ? in1 : in2;
endmodule // mxu

module mux_32_3input (in1, in2, in3, sel, out);
  input [31:0] in1, in2, in3;
  input [1:0] sel;
  output [31:0] out;

  assign out = (sel == 2'd0) ? in1 :
               (sel == 2'd1) ? in2 : in3;
endmodule // mux

module mux_5 (in1, in2, sel, out);
  input sel;
  input [4:0] in1, in2;
  output [4:0] out;

  assign out = (sel == 0) ? in1 : in2;
endmodule // mxu
