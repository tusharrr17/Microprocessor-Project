// Code your TESTBENCH here
// or browse Examples
`timescale 1ns/1ps

module REGISTER_TB();
 reg selector;
  reg[31:0] input2;
  reg[31:0] input1;
  wire[31:0] outputfinal;

  mux_32 adderInput (
   .selector(selector),
    .input2(input2),
    .input1(input1),
    .outputfinal(outputfinal),
  );

 initial begin
    clk = 1'b0;
    forever #1 clk=~clk;
 end

 initial begin
    reset= 1'b1;
    #10
    reset = 1'b0;
 end

 initial begin
   $monitor("time=%3d, input1=%d , outputfinal=%d",$time,register_inputvalue,register_outputvalue);

    input1= 32'd40;
   	input2= 32'd50;
    
   selector = 1'b0;
   #20
   selector 1'b1;
   #20
   selector 1'b0;
   #20 1'b1;
   #60
   $finish;
 end

endmodule