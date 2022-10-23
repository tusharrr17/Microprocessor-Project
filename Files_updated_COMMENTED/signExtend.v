`include "defines.v"

module SIGNED_EXTENSION (in, outputfinal);
  input [15:0] in;
  output [`MAX_LENGTH-1:0] outputfinal;

  assign outputfinal = (in[15] == 1) ? {16'b1111111111111111, in} : {16'b0000000000000000, in};
endmodule // SIGNED_EXTENSION
