`include "adder.v"

module Top;
  reg x_0, x_1, x_2, x_3;
  reg y_0, y_1, y_2, y_3;
  reg c_in;
  wire s_0, s_1, s_2, s_3;
  wire c_out;

  adder4 a(x_0, x_1, x_2, x_3, y_0, y_1, y_2, y_3, c_in, s_0, s_1, s_2, s_3, c_out);

  initial
    begin
      $monitor($time, " x = %b%b%b%b, y = %b%b%b%b, c_in = %b, s = %b%b%b%b, c_out = %b",
               x_0, x_1, x_2, x_3, y_0, y_1, y_2, y_3, c_in, s_0, s_1, s_2, s_3, c_out);
      $dumpfile("adder_tb3.vcd");
      $dumpvars;

      x_0 = 0; x_1 = 0; x_2 = 0; x_3 = 0; y_0 = 0; y_1 = 0; y_2 = 0; y_3 = 0; c_in = 0;
      #5 x_0 = 0; x_1 = 0; x_2 = 0; x_3 = 1; y_0 = 0; y_1 = 0; y_2 = 1; y_3 = 0; c_in = 0;
      #5 x_0 = 0; x_1 = 1; x_2 = 0; x_3 = 1; y_0 = 0; y_1 = 1; y_2 = 0; y_3 = 1; c_in = 1;
      #5 x_0 = 1; x_1 = 1; x_2 = 1; x_3 = 1; y_0 = 0; y_1 = 0; y_2 = 0; y_3 = 0; c_in = 1;
      #5 $finish;
    end
endmodule // Top
