`include "addermb.v"

module Top;
  reg not_s;
  reg not_r;
  wire q;
  wire not_q;

  twonand a(not_s, not_r, q, not_q);

  initial
    begin
      $monitor($time, " not_s = %b not_r = %b q = %b not_q = %b", not_s, not_r, q, not_q);
      $dumpfile("twonand.vcd");
      $dumpvars;

      not_s = 1; not_r = 1;
      #5 not_s = 1; not_r = 0;
      #5 not_s = 1; not_r = 1;
      #5 not_s = 0; not_r = 1;
      #5 not_s = 1; not_r = 1;
      #5 not_s = 0; not_r = 0;
      #5 not_s = 1; not_r = 1;
      #5 $finish;
    end
endmodule // Top
