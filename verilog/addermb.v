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


module clockdata(input wire clk,
                 input wire data,
                 output wire q,
                 output wire not_q);

  reg stored = 0;

  assign q = stored;
  assign not_q = !stored;

  always @(posedge clk) begin
    stored <= data;
  end

  // wire t1, t2, t3, t4;

  // nand(t1, data, t2);
  // nand(t2, t1, clock, t4);
  // nand(t3, clock, t4);
  // nand(t4, t1, t3);
  // nand(not_q, t2, q);
  // nand(q, not_q, t3);
endmodule

module memory4(input wire clk,
               input wire [3:0] data,
               output wire [3:0] out,
               output wire [3:0] negout);

  clockdata c1(clk, data[0], out[0], negout[0]);
  clockdata c2(clk, data[1], out[1], negout[1]);
  clockdata c3(clk, data[2], out[2], negout[2]);
  clockdata c4(clk, data[3], out[3], negout[3]);

endmodule

// The counter should increase on a positive clock edge whenever en (enable) is set, and reset to 0 whenever rst (reset) is set:

module counter(input wire clk,
               input wire en,
               input wire rst,
               output reg [3:0] count);

  wire [3:0] store;
  wire [3:0] negstore;
  wire [3:0] data;
  wire [3:0] next_data;
  wire zero = 0;
  wire one = 1;
  wire [3:0] multizero = 0;
  wire ignore_clk;

  memory4 mem(clk, data, store, negstore);
  adder4 aa(store, multizero, one, next_data, ignore_clk);

  always @(posedge clk) begin

   // data <= 

  end

endmodule