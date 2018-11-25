
module bcd(input wire [15:0] num,
           input wire [2:0] digit,
           output wire [3:0] out);

  wire [15:0] temp;

  assign temp = num >> ((3-digit) * 4);
  
  assign out = temp & 15;

endmodule

module segmented(input wire [3:0] digit,
                 input wire dot,
                 output wire [7:0] out);


wire [7:0] patterns [0:15];
assign patterns[ 0] = 8'b11000000;
assign patterns[ 1] = 8'b11111001;
assign patterns[ 2] = 8'b10100100;
assign patterns[ 3] = 8'b10110000;
assign patterns[ 4] = 8'b10011001;
assign patterns[ 5] = 8'b10010010;
assign patterns[ 6] = 8'b10000010;
assign patterns[ 7] = 8'b11111000;
assign patterns[ 8] = 8'b10000000;
assign patterns[ 9] = 8'b10010000;

assign patterns[10] = 8'b00001000;
assign patterns[11] = 8'b01100000;
assign patterns[12] = 8'b00110001;
assign patterns[13] = 8'b01000010;
assign patterns[14] = 8'b00110000;
assign patterns[15] = 8'b00111000;

assign out[6:0] = patterns[digit];
assign out[7] = ~dot;

endmodule

module top(input wire  CLK,
//           output wire LED,
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

wire [2:0] sdigit = 3;
wire usedot = 1;
   
wire [15:0] source;

assign source = clk_counter[15:0];//n-1:n-16];

    //bcd bb(source, sdigit, ledout);
    assign ledout = clk_counter[3:0];//clk_counter[25:22];
    segmented seg(ledout, usedot, leds);

  always @(posedge CLK) begin
    clk_counter <= clk_counter + 1;
  end

endmodule
