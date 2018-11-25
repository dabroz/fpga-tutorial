`include "adder.v"

module Top;
  reg x;
  reg y;
  reg c_in;
  wire s;
  wire c_out;

  adder a(x, y, c_in, s, c_out);

  initial
    begin
      $monitor($time, " x = %b, y = %b, c_in = %b, s = %b, c_out = %b",
               x, y, c_in, s, c_out);
      $dumpfile("adder_tb2.vcd");
      $dumpvars;

      x = 0; y = 0; c_in = 0;
      #5 x = 1; y = 0; c_in = 1;
      #5 x = 0; y = 1; c_in = 0;
      #5 x = 1; y = 1; c_in = 1;
      #5 $finish;
    end
endmodule // Top
