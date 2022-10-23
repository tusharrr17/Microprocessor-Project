`include "defines.v"

module adder_module (input1, input2, outputfinal);
  input [`MAX_LENGTH-1:0] input1, input2;
  output [`MAX_LENGTH-1:0] outputfinal;

  assign outputfinal = input1 + input2; // adds the given inputs and stores it in outputfinal
endmodule 
