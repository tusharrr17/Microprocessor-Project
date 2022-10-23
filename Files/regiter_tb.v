// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module register_tb();
 reg sel;
  reg[31:0] in2;
  reg[31:0] in1;
  wire[31:0] out;

  mux_32 adderInput (
   .sel(sel),
    .in2(in2),
    .in1(in1),
    .out(out),
  );

 initial begin
    clk = 1'b0;
    forever #1 clk=~clk;
 end

 initial begin
    rst= 1'b1;
    #10
    rst = 1'b0;
 end

 initial begin
   $monitor("time=%3d, in1=%d , out=%d",$time,regIn,regOut);

    in1= 32'd40;
   	in2= 32'd50;
    
   sel = 1'b0;
   #20
   sel 1'b1;
   #20
   sel 1'b0;
   #20 1'b1;
   #60
   $finish;
 end

endmodule