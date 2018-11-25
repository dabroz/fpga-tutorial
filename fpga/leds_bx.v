
// Adapted from the 0icial example:
//  https://github.com/tinyfpga/TinyFPGA-BX/blob/master/apio_template/top.v

//    top: 11, 8, 6, 4, 2, 1
// bottom: 19, 20, 21, 22, 23, 24


module bcd(input wire [15:0] num,
           input wire [2:0] digit,
           output wire [3:0] out);

  wire [15:0] temp;

  assign temp = num & 15;
  
  assign out = temp[3:0];

endmodule

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
    output PIN_24
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

reg [7:0] leds;

assign PIN_8 = leds[0] ;
assign PIN_1 = leds[1] ;
assign PIN_22 = leds[2] ;
assign PIN_20 = leds[3] ;
assign PIN_19 = leds[4] ;
assign PIN_6 = leds[5] ;
assign PIN_23 = leds[6] ;
assign PIN_21 = leds[7] ;

wire [3:0] digits;

assign digits[0] = PIN_11;
assign digits[1] = PIN_4;
assign digits[2] = PIN_2;
assign digits[3] = PIN_24;


// task display;
//  input wire [3:0] digit;
// // output wire [7:0] leds;
// begin
//  leds[7:4] = digit;
//  leds[3:0] = digit;
// end
// endtask

wire [7:0] patterns [0:9];
assign patterns[0] = 8'b00111111;  // b11111100;
assign patterns[1] = 8'b00000110;  // b01100000;
assign patterns[2] = 8'b01011011;  // b11011010;
assign patterns[3] = 8'b01001111;  // b11110010;
assign patterns[4] = 8'b01100110;  // b01100110;
assign patterns[5] = 8'b01101101;  // b10110110;
assign patterns[6] = 8'b01111101;  // b10111110;
assign patterns[7] = 8'b00000111;  // b11100000;
assign patterns[8] = 8'b01111111;  // b11111110;
assign patterns[9] = 8'b01101111;  // b11110110;


  always @(posedge CLK) begin
    clk_counter <= clk_counter + 1;
    //display(clk_counter[25:22]);



   leds = ~patterns[clk_counter[25:22]];
  end

  // SOS pattern
  //wire[31:0] blink_pattern = 32'b101010001110111011100010101;
  //wire[31:0] blink_pattern = 32'b101010101010101010101010101;
    wire[31:0] blink_pattern = 32'b111111111100000000010101010;

/*
Digit Display   a  b  c  d  e  f  g
0 0 0x3F  0x7E  11111100
1 1 0x06  0x30  01100000
2 2 0x5B  0x6D  11011010
3 3 0x4F  0x79  11110010
4 4 0x66  0x33  01100110
5 5 0x6D  0x5B  10110110
6 6 0x7D  0x5F  10111110
7 7 0x07  0x70  11100000
8 8 0x7F  0x7F  11111110
9 9 0x6F  0x7B  11110110
*/

//  assign leds = 8'b01010101;


  assign LED = blink_pattern[clk_counter[n-1:n-5]];


//  display(patterns[clk_counter[25:22]], leds);

endmodule
