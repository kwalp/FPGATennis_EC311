`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 12:29:53 AM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
	input clk_in,
	input rst,
	//input [7:0] divby,
	input [27:0] divby,
	output reg divided_clk
    );
	 
//used to be 'paramater toggle_value'
parameter toggle_value =  27'b001111101011110000100000000;	
//parameter toggle_value = 2'b10; 
reg[26:0] cnt;
reg[26:0] new_toggle_value;
//(2)
//reg[10:0] hits;

always@(posedge clk_in or posedge rst)
begin
	if (rst==1) begin
		cnt <= 0;
		divided_clk <= 0;
		new_toggle_value <= toggle_value;
		//hits <= 1'b0;
		
	end
	else begin
	    //toggle_value <= toggle_value * (1 - divby/5'd20);
	    //new_toggle_value = toggle_value - (toggle_value * (divby/10));
	    //if(divby==1'b1) begin
	       //(1)
	       //new_toggle_value = new_toggle_value - 20'b00110100001001000000;
	       //cnt <= 1'b0;
	       //(2)
	       //hits = hits + 1'b1;
	       //new_toggle_value = new_toggle_value / hits;
	       //end
		//if (cnt==new_toggle_value) begin
		if (cnt==divby) begin
			cnt <= 0;
			divided_clk <= ~divided_clk;
		end
		else begin
			cnt <= cnt +1;
			divided_clk <= divided_clk;		
		end
	end

end
			 
endmodule
