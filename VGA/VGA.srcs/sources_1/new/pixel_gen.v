`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2018 11:12:53 PM
// Design Name: 
// Module Name: pixel_gen
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


module pixel_gen( pixel_x, pixel_y, video_on, rgb);
    input wire [9:0] pixel_x, pixel_y;
    input wire video_on;
    output reg [2:0] rgb;
    
    wire wall_on, bar_on, wall_rgb, bar_rgb, ball_on, ball_rgb;
    
    // create wall on the left side four pixels wide
    assign wall_on = (32 <= pixel_x) &&  (pixel_x <= 35);
    
    // color wall blue
    assign wall_rgb = 3'b001;
    
    // create bar on the right side
    assign bar_on = (600 <= pixel_x) && (pixel_x <= 603)
              && (480/2 - 72/2)   && (pixel_y <= 480/2 - 72/2 + 72 -1);
              
    // set the bar to green
    assign bar_rgb = 3'b010;
    
    // create the ball
    //ball size is 8 pixels, 4 pixels radius
    localparam BALL_SIZE = 8;
    
    // create square ball
    assign ball_on = (550 <= pixel_x) && (pixel_x <= 550 + BALL_SIZE)
                  && (480/2 <= pixel_y) && (pixel_y <= 480/2 +BALL_SIZE);
    
    //set the ball color to red
    assign ball_rgb = 3'b100;              
     
     
    always @ (*) begin
        if(video_on) begin
            if(wall_on) rgb = wall_rgb;
            else if(bar_on) rgb = bar_rgb;
            else if(ball_on) rgb = ball_rgb;
            else rgb = 3'b110; //yellow background
        end else
            rgb = 3'b000; // blank back ground
    end
    
endmodule
