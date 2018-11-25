
module bcd(input wire [15:0] num,
           input wire [2:0] digit,
           output wire [3:0] out);

  wire [15:0] temp;

  assign temp = (digit == 0) ? (num / 1000) : (
    (digit == 1) ? (num / 100) : (
      (digit == 2) ? (num / 10) : num 
    )
  );
  
  assign out = temp % 10;

endmodule

module segmented(input wire [3:0] digit,
                 input wire dot,
                 output wire [7:0] out);


wire [7:0] patterns [0:9];
assign patterns[0] = 8'b00111111;
assign patterns[1] = 8'b00000110;
assign patterns[2] = 8'b01011011;
assign patterns[3] = 8'b01001111;
assign patterns[4] = 8'b01100110;
assign patterns[5] = 8'b01101101;
assign patterns[6] = 8'b01111101;
assign patterns[7] = 8'b00000111;
assign patterns[8] = 8'b01111111;
assign patterns[9] = 8'b01101111;

assign out[6:0] = ~patterns[digit];
assign out[7] = ~dot;

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

assign PIN_2 = 1;
assign PIN_4 = 1;
assign PIN_11 = 1;
assign PIN_24 = 1;

reg [7:0] leds;

assign  PIN_8 = leds[0];
assign  PIN_1 = leds[1];
assign PIN_22 = leds[2];
assign PIN_20 = leds[3];
assign PIN_19 = leds[4];
assign  PIN_6 = leds[5];
assign PIN_23 = leds[6];
assign PIN_21 = leds[7];

wire [3:0] digits;

assign digits[0] = PIN_11;
assign digits[1] = PIN_4;
assign digits[2] = PIN_2;
assign digits[3] = PIN_24;

wire [3:0] ledout;

   
    bcd bb(clk_counter[25:10], 3, ledout);
    segmented seg(ledout, 0, leds);

  always @(posedge CLK) begin
    clk_counter <= clk_counter + 1;
  end

endmodule
