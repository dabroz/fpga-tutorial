`include "leds_bx.v"

module Top;
  reg [15:0] num = 1234;
  reg [2:0] digit = 0;
  wire [3:0] out;
  reg dot = 0;
  wire [7:0] segments;

  bcd c(num, digit, out);
  segmented s(out, dot, segments);

  initial
    begin
      $monitor($time, " num = %d, digit = %d, out = %d | dot = %b segments = %b", num, digit, out, dot, segments  );

      $dumpfile("ledstb.vcd");
      $dumpvars;


      #4 digit = 1;
      #8 digit = 2;
      #2 dot = 1; digit = 3;
      #6 num = 6677; digit = 2;
      #2 $finish;
    end
endmodule // Top
