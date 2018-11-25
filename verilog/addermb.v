module half_adder(input wire  x,
                  input wire  y,
                  output wire s,
                  output wire c_out);
  xor(s, x, y);
  and(c_out, x, y);
endmodule

module adder(input wire x,
             input wire y,
             input wire c_in,
             output wire s,
             output wire c_out);
  wire s_0;
  wire c_0;
  wire c_1;
  half_adder add1(x, y, s_0, c_0);
  half_adder add2(s_0, c_in, s, c_1);
  or(c_out, c_0, c_1);
endmodule

module adder4(input wire [3:0] x,
              input wire y_0,
              input wire y_1,
              input wire y_2,
              input wire y_3,
              input wire c_in,
              output wire s_0,
              output wire s_1,
              output wire s_2,
              output wire s_3,
              output wire c_out);
  wire c_0;
  wire c_1;
  wire c_2;
  adder a_0(x[0:0], y_0, c_in, s_0, c_0);
  adder a_1(x[1:1], y_1, c_0,  s_1, c_1);
  adder a_2(x[2:2], y_2, c_1,  s_2, c_2);
  adder a_3(x[3:3], y_3, c_2,  s_3, c_out);
endmodule
