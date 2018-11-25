
module bcd(input wire [15:0] num,
           input wire [1:0] digit,
           output wire [3:0] out);

  wire [15:0] temp;

  assign temp = num >> ((3-digit) * 4);
  
  assign out = temp & 15;

endmodule

module segmented(input wire [3:0] digit,
                 input wire dot,
                 output wire [7:0] out);


wire [6:0] patterns [0:15];
assign patterns[ 0] = 7'b1000000;
assign patterns[ 1] = 7'b1111001;
assign patterns[ 2] = 7'b0100100;
assign patterns[ 3] = 7'b0110000;
assign patterns[ 4] = 7'b0011001;
assign patterns[ 5] = 7'b0010010;
assign patterns[ 6] = 7'b0000010;
assign patterns[ 7] = 7'b1111000;
assign patterns[ 8] = 7'b0000000;
assign patterns[ 9] = 7'b0010000;

assign patterns[10] = 7'b0001000;
assign patterns[11] = 7'b0000011;
assign patterns[12] = 7'b1000110;
assign patterns[13] = 7'b0100001;
assign patterns[14] = 7'b0000110;
assign patterns[15] = 7'b0001110;

assign out[6:0] = patterns[digit];
assign out[7] = ~dot;

endmodule

module splitter(input wire [1:0] sdigit, 
                output wire [3:0] digits);

assign digits[0] = sdigit == 3;
assign digits[1] = sdigit == 2;
assign digits[2] = sdigit == 1;
assign digits[3] = sdigit == 0;

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



  parameter n = 34;
  reg [n-1:0] clk_counter = 0;

    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

// assign PIN_2 = 1;
// assign PIN_4 = 1;
// assign PIN_11 = 1;
// assign PIN_24 = 1;

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

assign PIN_11 = digits[3];
assign  PIN_4 = digits[2];
assign  PIN_2 = digits[1];
assign PIN_24 = digits[0];

wire [3:0] ledout;

wire [1:0] sdigit;
wire usedot = 1;
   
wire [15:0] source;

// 27.26.25.24    23.22.21.20   19.18.17.16   15.14.13.12

assign sdigit = clk_counter[1:0];
assign source = clk_counter[33:18];
//assign source2 = clk_counter[27:20];


    bcd bb(source, sdigit, ledout);
    //assign ledout = clk_counter[27:24];//clk_counter[25:22];
    segmented seg(ledout, usedot, leds);

    splitter ss(sdigit, digits);

  always @(posedge CLK) begin
    clk_counter <= clk_counter + 1;
// leds = source2;
  end

endmodule
