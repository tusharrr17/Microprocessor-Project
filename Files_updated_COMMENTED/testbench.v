`timescale 1ns/1ns

module TESTBENCH ();
  reg clk,reset, forwarding_EN;
  PROCESSOR top_module (clk, reset, forwarding_EN);

  initial begin
    clk=1;
    repeat(5000) #50 clk=~clk ;
  end

  initial begin
    reset = 1;
    forwarding_EN = 1;
    #100
    reset = 0;
  end
endmodule // test
