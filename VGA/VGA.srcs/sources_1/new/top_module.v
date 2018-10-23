`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2018 03:25:41 PM
// Design Name: 
// Module Name: top_module
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
module top_module(clk, reset, sw, color, h_sync, v_sync);
    
    input        clk, reset;
    input [11:0] sw;
    wire       video_on;
    wire [9:0] v_count, h_count;    
    output h_sync, v_sync;
    output [11:0] color;
     
    vga_sync vs(.clk(clk), 
                .reset(reset), 
                .h_sync(h_sync), 
                .v_sync(v_sync),
                .video_on(video_on), 
                .v_count(v_count),
                .h_count(h_count)
                );
                
	//assign the color of the screen based on switch inputs
    assign color = (video_on) ? sw : 12'b0;
                
endmodule
