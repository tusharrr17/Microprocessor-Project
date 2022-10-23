`include "defines.v"

module SIGNED_EXTENSION (in, outputfinal);
  input [15:0] in;
  output [`MAX_LENGTH-1:0] outputfinal;

  if(in[15]==1) assign outputfinal ={16'b1111111111111111, in};
  else assign outputfinal ={16'b0000000000000000, in};
endmodule // SIGNED_EXTENSION
