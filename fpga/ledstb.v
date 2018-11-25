`include "leds_bx.v"

module Top;
  reg [15:0] num = 1234;
  reg [2:0] digit = 0;
  wire [3:0] out;

  bcd c(num, digit, out);

  initial
    begin
      $monitor($time, " num = %d, digit = %d, out = %d", num, digit, out);

      $dumpfile("ledstb.vcd");
      $dumpvars;


      #4 digit = 1;
      #8 digit = 2;
      #2 digit = 3;
      #6 num = 6677; digit = 2;
      #2 $finish;
    end
endmodule // Top
