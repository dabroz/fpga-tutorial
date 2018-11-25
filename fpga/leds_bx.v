
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

  __________
 |          |
 |          |
 |          |
 |          |
 |__________|
 |          |
 |          |
 19        22
 |          |  .
 |____20____| 21

*/


assign PIN_1 = 1;
assign PIN_2 = 1;
assign PIN_4 = 1;
assign PIN_6 = 1;
assign PIN_8 = 1;
assign PIN_11 = 1;
assign PIN_19 = 0;
assign PIN_20 = 0;
assign PIN_21 = 0;
assign PIN_22 = 0;
assign PIN_23 = 0;
assign PIN_24 = 1;

  always @(posedge CLK) begin
    clk_counter <= clk_counter + 1;
  end

  // SOS pattern
  //wire[31:0] blink_pattern = 32'b101010001110111011100010101;
  //wire[31:0] blink_pattern = 32'b101010101010101010101010101;
    wire[31:0] blink_pattern = 32'b111111111100000000010101010;

  assign LED = blink_pattern[clk_counter[n-1:n-5]];
endmodule
