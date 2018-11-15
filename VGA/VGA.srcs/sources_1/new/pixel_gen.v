`timescale 1ns / 1ps
/****************************** C E C S  3 6 1 ******************************
 * 
 * File Name:  pixel_gen
 *
 * Created by       Dong Jae Shin 11/14/2018
 * Copyright © 2018 Dong Jae Shin. All rights reserved.
 *
 * purpose: To create the static objects from the vga sync signals.
 *          
 * In submitting this file for class work at CSULB
 * I am confirming that this is my work and the work
 * of no one else. In submitting this code I acknowledge that
 * plagiarism in student project work is subject to dismissal
 * from the class.
 *         
 ****************************************************************************/
module pixel_gen( pixel_x, pixel_y, video_on, rgb);
   input wire [9:0] pixel_x, pixel_y;
   input wire video_on;
   output reg [2:0] rgb;
    
   wire wall_on, bar_on, ball_on;
   wire [2:0] bar_rgb, wall_rgb, ball_rgb;
   // create wall on the left side four pixels wide
   assign wall_on = (32 <= pixel_x) &&  (pixel_x <= 35);
    
   // color wall red
   assign wall_rgb = 3'b001;
    
   // create bar on the right side
   assign bar_on = (600 <= pixel_x) && (pixel_x <= 603) && 
   (480/2 - 72/2 <= pixel_y) && (pixel_y <= 480/2 - 72/2 + 72 -1);
              
   // set the bar to green
   assign bar_rgb = 3'b010;
    
   // create the ball
   //ball size is 8 pixels, 4 pixels radius
   localparam BALL_SIZE = 8;
    
   // create square ball
   assign ball_on = (550 <= pixel_x) && (pixel_x <= 550 + BALL_SIZE) && 
   (480/2 <= pixel_y) && (pixel_y <= 480/2 + BALL_SIZE);
    
   //set the ball color to blue
   assign ball_rgb = 3'b100;              
     
   always @ (*) begin
        // set the rgb to blank when the video is not on
        if(~video_on) rgb = 3'b000;
        else begin
            if(bar_on) rgb = bar_rgb;
            else if(ball_on) rgb = ball_rgb;
            else if(wall_on) rgb = wall_rgb;
            // set rgb to 0 to show black
            else rgb = 3'b000;
        end
    end
endmodule