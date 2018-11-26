module traffic(input wire  clk,
               input wire  go,
               output reg red,
               output reg yellow,
               output reg green);

  parameter s_red = 0;
  parameter s_red_yellow = 1;
  parameter s_green = 2;
  parameter s_yellow = 3;

  reg [2:0] state = s_red;
  reg [2:0] last_state = s_red;
  reg [2:0] delayer;

  wire testred;
  
  always @(posedge clk) begin
    if (last_state == s_red) begin
      if (go) begin
        state = s_red_yellow;
        delayer = 3;
      end
    end
    if (last_state == s_red_yellow) begin     
      delayer = delayer - 1;
      if (delayer == 0) begin
        state = s_green;
      end 
    end
    if (last_state == s_green) begin
      if (!go) begin
        state = s_yellow;
        delayer = 3;
      end
    end
    if (last_state == s_yellow) begin
      delayer = delayer - 1;
      if (delayer == 0) begin
        state = s_red;
      end 
    end

    red = ((state == s_red) || (state == s_red_yellow));
    yellow = ((state == s_red_yellow) || (state == s_yellow));
    green = (state == s_green);

    last_state = state;
  end

endmodule
