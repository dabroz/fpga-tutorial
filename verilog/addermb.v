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
              input wire [3:0] y,
              input wire c_in,
              output wire [3:0] s,
              output wire c_out);
  // wire c_0;
  // wire c_1;
  // wire c_2;
  // adder a_0(x[0:0], y[0:0], c_in, s[0:0], c_0);
  // adder a_1(x[1:1], y[1:1], c_0,  s[1:1], c_1);
  // adder a_2(x[2:2], y[2:2], c_1,  s[2:2], c_2);
  // adder a_3(x[3:3], y[3:3], c_2,  s[3:3], c_out);
  wire [4:0] full = x + y + c_in;
  assign s = full[3:0];
  assign c_out = full[4:4];
endmodule


module twonand(input wire not_s,
               input wire not_r,
               output wire q,
               output wire not_q);

  nand(q, not_s, not_q);
  nand(not_q, q, not_r);
endmodule
