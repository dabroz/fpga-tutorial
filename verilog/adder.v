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
