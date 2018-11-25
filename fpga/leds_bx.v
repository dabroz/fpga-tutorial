
// Adapted from the official example:
//  https://github.com/tinyfpga/TinyFPGA-BX/blob/master/apio_template/top.v

//    top: 11, 8, 6, 4, 2, 1
// bottom: 19, 20, 21, 22, 23, 24

module top(input wire  CLK,
           output wire LED,
    output USBPU , // USB pull-up resistor
    output PIN_1,
    output PIN_2,
    output PIN_4,
    output PIN_6,
    output PIN_8,
    output PIN_11,
    output PIN_19,
    output PIN_20,
    output PIN_21,
    output PIN_22,
    output PIN_23,
    output PIN_24,
    );



  parameter n = 26;
  reg [n-1:0] clk_counter = 0;

    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

/*

11 4  2  24
A  B  C  D
A  B  C  D


  ___a_8____
 |          |
 f          b
 6          1
 |          |
 |__g_23____|
 |          |
 e          c
 19        22
 |          |  . h
 |____20d___| 21

*/


//assign PIN_1 = 0;
assign PIN_2 = 1;
assign PIN_4 = 1;
//assign PIN_6 = 0;
//assign PIN_8 = 0;
assign PIN_11 = 1;
// assign PIN_19 = 0;
// assign PIN_20 = 0;
// assign PIN_21 = 0;
// assign PIN_22 = 0;
// assign PIN_23 = 0;
assign PIN_24 = 1;

wire [7:0] leds;


assign leds[0] = PIN_8;
assign leds[1] = PIN_1;
assign leds[2] = PIN_22;
assign leds[3] = PIN_20;
assign leds[4] = PIN_19;
assign leds[5] = PIN_6;
assign leds[6] = PIN_23;
assign leds[7] = PIN_21;



  always @(posedge CLK) begin
    clk_counter <= clk_counter + 1;
  end

  // SOS pattern
  //wire[31:0] blink_pattern = 32'b101010001110111011100010101;
  //wire[31:0] blink_pattern = 32'b101010101010101010101010101;
    wire[31:0] blink_pattern = 32'b111111111100000000010101010;

/*
Digit Display gfedcba abcdefg a b c d e f g
0 0 0x3F  0x7E  on  on  on  on  on  on  off
1 1 0x06  0x30  off on  on  off off off off
2 2 0x5B  0x6D  on  on  off on  on  off on
3 3 0x4F  0x79  on  on  on  on  off off on
4 4 0x66  0x33  off on  on  off off on  on
5 5 0x6D  0x5B  on  off on  on  off on  on
6 6 0x7D  0x5F  on  off on  on  on  on  on
7 7 0x07  0x70  on  on  on  off off off off
8 8 0x7F  0x7F  on  on  on  on  on  on  on
9 9 0x6F  0x7B  on  on  on  on  off on  on
*/

  assign leds = 8'b01010101;

  assign LED = blink_pattern[clk_counter[n-1:n-5]];
endmodule
