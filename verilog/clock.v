`include "addermb.v"

module Top;
  reg clock;
  reg data;
  wire q;
  wire not_q;

  clockdata a(clock, data, q, not_q);

  initial
    begin
      $monitor($time, " clock = %b data = %b q = %b not_q = %b", clock, data, q, not_q);
      $dumpfile("clock.vcd");
      $dumpvars;

      clock = 1; data = 1;
      #5 clock = 1; data = 0;
      #5 clock = 1; data = 1;
      #5 clock = 0; data = 1;
      #5 clock = 1; data = 1;
      #5 clock = 0; data = 0;
      #5 clock = 1; data = 0;
      #5 clock = 1; data = 1;
      #5 $finish;
    end
endmodule // Top
