`include "addermb.v"

module Top;
  reg [3:0] x;
  reg [3:0] y;
  reg c_in;
  wire [3:0] s;
  wire c_out;

  adder4 a(x, y, c_in, s, c_out);

  initial
    begin
      $monitor($time, " x = %b, y = %b, c_in = %b, s = %b, c_out = %b",
               x, y, c_in, s, c_out);
      $dumpfile("adder_tb3.vcd");
      $dumpvars;

      x = 0; y = 0; c_in = 0;
      #5 x = 1; y = 2; c_in = 0;
      #5 x = 5; y = 5; c_in = 1;
      #5 x = 15; y = 0; c_in = 1;
      #5 $finish;
    end
endmodule // Top
