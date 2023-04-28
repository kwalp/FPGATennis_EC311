`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 05:51:52 PM
// Design Name: 
// Module Name: lights2
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

module lights2(
    input clock, reset,
    input squash, 
    input [1:0] hits, //[1]: player 1 hit, [0]: player 0 hit
    output reg [4:0] out, //[4]: sucessful hit, [3,2]: player 1,0 early hit, [1,0]: player 1,0 miss
    output reg [15:0] state,
    output reg [2:0] score0,
    output reg [2:0] score1,
    output reg [27:0] clkspeed
    );
    
    reg fwd; // 0: side 0 --> 1, 1: side 1 --> 0
    reg server; // server has to switch apparently :(
    reg [1:0] er0;
    reg [1:0] er1;
    parameter toggle_value =  27'b001111101011110000100000000;
    parameter subtractby = 20'b10110100001001000000;	
    //reg [27:0] clkspeed;
    
    
    
    initial
    begin
        state <= 1'b1;
        fwd <= 1'b0;
        server <= 1'b0;
        out <= 1'b0;
        er0 <= 1'b0;
        er1 <= 1'b0;
        score0 <= 1'b0;
        score1 <= 1'b0;
        clkspeed <= toggle_value;
    end 
    
    always@(posedge clock or posedge reset) begin
    
            if(reset==1'b1) begin
                    state <= 1'b1;
                    fwd <= 1'b0;
                    server <= 1'b0;
                    out <= 1'b0;
                    er0 <= 1'b0;
                    er1 <= 1'b0;
                    score0 <= 1'b0;
                    score1 <= 1'b0;
                    clkspeed <= toggle_value;
            end
            //----------------------------------------------------------------------------------PLAYER 0 EARLY
            else if(er0==2'b11) begin 
                    er0 <= 2'b00;
                    er1 <= 2'b00;
                    if(squash==1'b1) begin
                        state <= 16'b0000000000000001;
                        fwd <= 1'b0;
                        score1 = score1 + 1'b1;
                        clkspeed <= toggle_value;
                        //er0 <= 1'b0;
                        //er1 <= 1'b0;
                    end 
                    
                    else if(squash==1'b0) begin
                        state <= 16'b1000000000000000;
                        fwd <= 1'b1;
                        score1 = score1 + 1'b1;
                        clkspeed <= toggle_value;
                        //er0 <= 1'b0;
                        //er1 <= 1'b0;
                    end 
            end
            //-----------------------------------------------------------------------------------PLAYER 1 EARLY
            else if(er1==2'b11) begin 
                    er0 <= 2'b00;
                    er1 <= 2'b00;
                    state <= 16'b0000000000000001;
                    clkspeed <= toggle_value;
                    fwd <= 1'b0;
                    score0 = score0 + 1'b1;
                    
            end 
            //-----------------------------------------------------------------------------------PLAYER 0 WIN
            else if(score0==2'b11 & state!==16'b0000000000000000) begin 
//UNCOMMENT         
                    state <= 16'b0000000000000000;
                    //score0 <= 2'b00;
                    //score1 <= 2'b00;
                    er0 <= 2'b00;
                    er1 <= 2'b00;
                    clkspeed <= toggle_value;
                    
            end 
            //-----------------------------------------------------------------------------------PLAYER 1 WIN
            else if(score1==2'b11 & state!==16'b1111111111111111) begin 
//UNCOMMENT         
                    state <= 16'b1111111111111111;
                    //score0 <= 2'b00;
                    //score1 <= 2'b00;
                    er0 <= 2'b00;
                    er1 <= 2'b00;
                    clkspeed <= toggle_value;
            end 
            //-----------------------------------------------------------------------------------REST OF SM
            else begin 
                    //-----------------------------------------------------------------------state 0 under this
                    if(state==16'b0000000000000001) begin
                            if(fwd==1'b1) begin
                                if(hits[0]==1'b1) begin//they hit sucessfully
                                        fwd <= 1'b0;
                                        state <= state * 2'b10;
                                        out[4] <= 1'b1;
                                        //clkspeed <= clkspeed - subtractby;
                                        clkspeed <= clkspeed / 2'b10;
                                        if(squash==1'b1)begin
                                            score0 = score0 + 2'b01;
                                        end 
                                end
                                
                                else if(hits[0]==1'b0) begin//they miss
 //THIS IS WHERE I CHANGED AT 3:30
                                        score1 = score1 + 1'b1;
                                            if(squash==1'b0)begin
                                                if(server==1'b0)begin
                                                    state <= 16'b0000000000000001;
                                                    fwd <= 1'b0;
                                                    server<=1'b1;
                                                    clkspeed <= toggle_value;
                                                end
                                                
                                                else if(server==1'b1)begin
                                                    state <= 16'b1000000000000000;
                                                    fwd <= 1'b1;
                                                    server<=1'b1;
                                                    clkspeed <= toggle_value;
                                                end
                                            end
                                            else if(squash==1'b1)begin
                                                state <= 16'b1000000000000000;
                                                fwd <= 1'b1;
                                                server<=1'b1;
                                                clkspeed <= toggle_value;
                                            end
//I changed up until here                                
                                
                                end
                                end
                            else if(fwd==1'b0) begin
                                if(hits[0]==1'b1)
                                    state<=state*2'b10;
                            end
                    
                    end
                    //--------------------------------------------------------------------state 16 under this
                    else if(state==16'b1000000000000000) begin
                            if(squash==1'b1) begin //////////squash
                                
                                    state <= state / 2'b10;
                                    fwd <= 1'b1;
                            end
                            
                            else if(squash==1'b0) begin/////not squash
                                if(fwd==1'b0) begin
                                        if(hits[1]==1'b1) begin//hit!
                                            fwd <= 1'b1;
                                            state <= state / 2'b10;
                                            out[4] <= 1'b1;
                                            //clkspeed <= clkspeed - subtractby;
                                            clkspeed <= clkspeed / 2'b10;
                                        end
                                        
                                        else if(hits[1]==1'b0) begin//miss
                                            score0 = score0 + 1'b1;
                                            if(server==1'b0)begin
                                                state <= 16'b0000000000000001;
                                                fwd <= 1'b0;
                                                server<=1'b1;
                                                clkspeed <= toggle_value;
                                            end
                                            
                                            else if(server==1'b1)begin
                                                state <= 16'b1000000000000000;
                                                fwd <= 1'b1;
                                                server<=1'b1;
                                                clkspeed <= toggle_value;
                                            end
                                        end
                                        end 
                                 else if(fwd==1'b1)begin
                                        if(hits[1]==1'b1)begin
                                            state <= state / 2'b10;
                                            //clkspeed <= clkspeed - subtractby;
                                            clkspeed <= clkspeed / 2'b10;
                                            
                                        end
                                 end
                            
                            end
                    
                    end 
                    
//UNCOMMENT         //---------------------------------------------------------------WON state under this
                    
                    else if(state==16'b0000000000000000)begin
                        if(squash==1'b0)begin
                            if(hits[0]==1'b1 | hits[1]==1'b1)begin // | hits[1]==1'b1
                                    state <= 16'b1000000000000000;//person 0 won, person 1 serves
                                    fwd <= 1'b1;
                                    score0 <= 1'b0;
                                    score1 <= 1'b0;
                                    clkspeed <= toggle_value;
                            end
                        end 
                        else if(squash==1'b1)begin
                            if(hits[0]==1'b1 | hits[1]==1'b1)begin // | hits[1]==1'b1
                                    state <= 16'b0000000000000001;//person 0 won, person 1 serves
                                    fwd <= 1'b0;
                                    score0 <= 1'b0;
                                    score1 <= 1'b0;
                                    clkspeed <= toggle_value;
                            end 
                        end
                            //else begin
                            //        state <= state;
                            //end
                               
                                    
                    end
                    else if(state==16'b1111111111111111) begin
                            if(hits[0]==1'b1 | hits[1]==1'b1)begin //  | hits[1]==1'b1
                                    state <= 16'b0000000000000001;//person 1 won, person 0 serves
                                    fwd <= 1'b0;
                                    score0 <= 1'b0;
                                    score1 <= 1'b0;
                                    clkspeed <= toggle_value;
                            end
                            //else begin
                            //        state <= state;
                            //end
                            
                    end
                    //--------------------------------------------all other states
                    else begin
                    
                           if(fwd==1'b0)
		                          state <= state * 2'b10;
	                       else if(fwd==1'b1)
		                          state <= state / 2'b10;
		                          
		                   if(hits[0] == 1'b1)
	                               er0 = er0 + 1'b1;
	                       if(hits[1] == 1'b1)
	                               er1 = er1 + 1'b1;
                    
                    end
            end
    
    end
    
endmodule