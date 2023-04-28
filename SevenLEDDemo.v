`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2023 06:05:25 PM
// Design Name: 
// Module Name: SevenLEDDemo
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


module SevenLEDDemo(clk,rst,p0,p1,AN_Out,C_Out);

input clk,rst;
input [1:0] p0;
input [1:0] p1;
output [7:0] AN_Out;
output [6:0] C_Out;

reg [7:0] AN_In;
reg [55:0] C_In;

parameter ONE = 7'b0000110, TWO= 7'b1011011, THREE=7'b1001111,P=7'b1110011, ZERO=7'b0111111;

SevenSegmentLED_ SevenSegmentLED(.clk(clk),.rst(rst),.AN_In(AN_In),.C_In(C_In),.AN_Out(AN_Out),.C_Out(C_Out));

always @ (posedge clk or posedge rst)
begin
    if(rst)
    begin
        AN_In <= 8'h0;
        C_In <= 56'h0;
    end
    else
    begin
        AN_In <= 8'b00111110;
        if (p0==2'b00 && p1==2'b00)
       
        C_In<= {7'd0,7'd0,ZERO,7'd0,7'd0,ZERO,7'd0,7'd0};
        else if (p0==2'b00 && p1==2'b01)
        C_In<= {7'd0,7'd0,ZERO,7'd0,7'd0,ONE,7'd0,7'd0};
       
        else if (p0==2'b00 && p1==2'b10)
        C_In<= {7'd0,7'd0,ZERO,7'd0,7'd0,TWO,7'd0,7'd0};
         else if (p0==2'b00 && p1==2'b11)
        C_In<= {7'd0,7'd0,ZERO,P,TWO,THREE,7'd0,7'd0};
         else if (p0==2'b01 && p1==2'b00)
        C_In<= {7'd0,7'd0,ONE,7'd0,7'd0,ZERO,7'd0,7'd0};
        else if (p0==2'b01 && p1==2'b01)
        C_In<= {7'd0,7'd0,ONE,7'd0,7'd0,ONE,7'd0,7'd0};
        else if (p0==2'b01 && p1==2'b10)
        C_In<= {7'd0,7'd0,ONE,7'd0,7'd0,TWO,7'd0,7'd0};
        else if (p0==2'b01 && p1==2'b11)
        C_In<= {7'd0,7'd0,ONE,P,TWO,THREE,7'd0,7'd0};
        else if (p0==2'b10 && p1==2'b00)
        C_In<= {7'd0,7'd0,TWO,7'd0,7'd0,ZERO,7'd0,7'd0};
        else if (p0==2'b10 && p1==2'b01)
        C_In<= {7'd0,7'd0,TWO,7'd0,7'd0,ONE,7'd0,7'd0};
        else if (p0==2'b10 && p1==2'b10)
        C_In<= {7'd0,7'd0,TWO,7'd0,7'd0,TWO,7'd0,7'd0};
        else if (p0==2'b10 && p1==2'b11)
        C_In<= {7'd0,7'd0,TWO,P,TWO,THREE,7'd0,7'd0};
        else if (p0==2'b11 && p1==2'b00)
        C_In<= {7'd0,7'd0,THREE,P,ONE,ZERO,7'd0,7'd0};
        else if (p0==2'b11 && p1==2'b01)
        C_In<= {7'd0,7'd0,THREE,P,ONE,ONE,7'd0,7'd0};
        else if (p0==2'b11 && p1==2'b10)
        C_In<= {7'd0,7'd0,THREE,P,ONE,TWO,7'd0,7'd0};
      end
      end
     
     
       
       
        //case (p0)
       
       //2'b00:  C_In <= (p0==2'b00 && p1==2'b00)? {7'd0,7'd0,ZERO,7'd0,ZERO,7'd0,7'd0,7'd0}: {7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};
       //2'b00:  C_In <= (p0==2'b00 && p1==2'b01)? {7'd0,7'd0,ZERO,7'd0,ONE,7'd0,7'd0,7'd0}: {7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};
       //2'b01:  C_In <= (p0==2'b01 && p1==2'b00)? {7'd0,7'd0,ONE,7'd0,ZERO,7'd0,7'd0,7'd0}: {7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};
       //2'b01:  C_In <= (p0==2'b01 && p1==2'b01)? {7'd0,7'd0,ONE,7'd0,ONE,7'd0,7'd0,7'd0}: {7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};
       //2'b10:  C_In <= (p0==2'b10 && p1==2'b00)? {7'd0,7'd0,TWO,7'd0,ZERO,7'd0,7'd0,7'd0}: {7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};
        // 2'b10:  C_In <= (p0==2'b10 && p1==2'b10)? {7'd0,7'd0,TWO,7'd0,TWO,7'd0,7'd0,7'd0}: {7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};
       //2'b01:  C_In <= {ONE,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};
       //2'b10:  C_In <= {TWO,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0,7'd0};

//endcase




endmodule
