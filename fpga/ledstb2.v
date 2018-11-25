`include "leds_bx.v"

module Top;
  reg [15:0] num = 'h1234;
  reg [1:0] digit = 0;
  wire [3:0] out;
  reg dot = 0;
  wire [7:0] segments;
  wire [3:0] digits;

  bcd c(num, digit, out);
  segmented s(out, dot, segments);
  splitter sss(digit, digits);

  initial
    begin
      $monitor($time, " num = %X, digit = %d, out = %X | dot = %b segments = %b | split %b", num, digit, out, dot, segments ,digits );

      $dumpfile("ledstb.vcd");
      $dumpvars;


      #4 digit = 1;
      #8 digit = 2;
      #2 dot = 1; digit = 3;
      #6 num = 'h66B7; digit = 2;
      #2 $finish;
    end
endmodule // Top
