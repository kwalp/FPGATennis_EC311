`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 05:01:51 PM
// Design Name: 
// Module Name: newfinalmodule2_
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module newfinalmodule2_(clk, squash, reset, hits, lights_tolight, AN_Out, C_Out);

    input clk, squash, reset;
    input [1:0] hits;
    output [15:0] lights_tolight;
    output [7:0] AN_Out;
    output [6:0] C_Out;
   
    reg [26:0] divby = 27'b001111101011110000100000000;
   
    wire [7:0] scoredisp0, scoredisp1;
    wire [25:0] ball_speed;

   
   
   
    wire [27:0] clkspeed;
    lights2_ LIGHTS(.clock(clktolights), .squash(squash), .reset(reset), .hits(hits), .out(out), .state(lights_tolight), .score0(scoredisp0) , .score1(scoredisp1), .ball_speed(ball_speed));

    clk_divider_ MAINCLK(.clk_in(clk), .rst(reset), .ball_speed(ball_speed), .divided_clk(clktolights));

    SevenLEDDemo_ DISPLAY(.clk(clk), .rst(reset) ,.squash(squash), .p0(scoredisp0) , .p1(scoredisp1) , .AN_Out(AN_Out) , .C_Out(C_Out));

endmodule

