`include "addermb.v"

module Top;
  reg clock;
  reg [3:0] data;
  wire [3:0] q;
  wire [3:0] not_q;

  memory4 a(clock, data, q, not_q);

  initial
    begin
      $monitor($time, " clock = %b data = %b q = %b not_q = %b", clock, data, q, not_q);
      $dumpfile("clock.vcd");
      $dumpvars;

      clock = 0; data = 0;
      #50 clock = 1; data = 0;
      #50 clock = 0; data = 7;
      #50 clock = 1; data = 7;
      #50 clock = 0; data = 1;
      #50 clock = 1; data = 3;
      #50 clock = 0; data = 0;
      #50 clock = 1; data = 0;
      #50 $finish;
    end
endmodule // Top
