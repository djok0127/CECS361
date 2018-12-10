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
module pixel_gen( pixel_x, pixel_y, btn_up, btn_down, video_on, reset, clk, rgb);
    input wire [9:0] pixel_x, pixel_y;
    input wire video_on;
    input reset, clk, btn_up, btn_down;
    output reg [2:0] rgb;
    
    wire wall_on, bar_on, ball_on;
    wire [2:0] bar_rgb, wall_rgb, ball_rgb;
    wire bar_top, bar_bot, bar_left, bar_right, bar_y_top;
    
    wire [9:0] ball_x_next, ball_y_next;
    reg [9:0] x_delta_reg, x_delta_next, y_delta_reg, y_delta_next,
              bar_y_next, bar_y_reg, ball_x_reg, ball_y_reg;     
    
    // refresh every 60 hz
    wire ref_tick = (pixel_y == 481) && (pixel_x==0);
    
    //------------------------- wall -------------------------
    // create wall on the left side four pixels wide
    assign wall_on = (32 <= pixel_x) &&  (pixel_x <= 35);
    
    // color wall red
    assign wall_rgb = 3'b001;
    
    //------------------------- bar -------------------------

    // set the bar to green
    assign bar_rgb = 3'b010;
    assign bar_top = bar_y_reg ;
    assign bar_bot =  bar_top + 72 -1;
    assign bar_left = 600;
    assign bar_right = 603;
    
    // create bar on the right side
    assign bar_on = (bar_left <= pixel_x) && (pixel_x <= bar_right) && 
                    (bar_top <= pixel_y) && (pixel_y <= bar_bot);
    
    // new bar position
    always @ (*) begin
        bar_y_next = bar_y_reg; // do not move
        if(ref_tick)
            if (btn_down & (bar_bot < (480 - 1 -4)))
                bar_y_next = bar_y_reg + 4; // move down
            else if (btn_up & (bar_top > 4))
                bar_y_next = bar_y_reg - 4; // move up
    end // end of always
    
    //------------------------- ball -------------------------
    // create the ball
    //ball size is 8 pixels, 4 pixels radius
    localparam BALL_SIZE = 8;
    
    assign ball_left = ball_x_reg;
    assign ball_right = ball_left - BALL_SIZE - 1;
    assign ball_top = ball_y_reg;
    assign ball_bot = ball_top - BALL_SIZE - 1;
    
    // create square ball
    assign ball_on = (ball_left <= pixel_x) && (pixel_x <= ball_right) && 
                     (ball_top <= pixel_y) && (pixel_y <= ball_bot);
    
    // new ball position
    assign ball_x_next = (ref_tick) ? ball_x_reg + x_delta_reg: ball_x_reg;
    assign ball_y_next = (ref_tick) ? ball_y_reg + y_delta_reg: ball_y_reg;
    
    // new ball velocity
    always @ (*) begin
        x_delta_next = x_delta_reg;
        y_delta_next = y_delta_reg;
        // reach top
        if(ball_bot < 0) y_delta_next = 2;
        // reach bottom
        else if(ball_bot > (480 - 1)) y_delta_next = -2;
        // reach wall
        else if(ball_left <= 603) x_delta_next = 2;
        // bounce back
        else if((600 <= ball_right) && (ball_right <= 603) &&
                (bar_top <= ball_bot) && (ball_top <= bar_bot))
                x_delta_next = -2;
    end // end of always
    
    
    //set the ball color to blue
    assign ball_rgb = 3'b100;              
    
    // procedural block, assigning reg to next reg
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            bar_y_reg <= 0;
            ball_x_reg <= 0;
            ball_y_reg <= 0;
            x_delta_reg <= 10'h004;
            y_delta_reg <= 10'h004;
        end // end of if
        else begin
            bar_y_reg <= bar_y_next;
            ball_x_reg <= ball_x_next;
            ball_y_reg <= ball_y_next;
            x_delta_reg <= x_delta_next;
            y_delta_reg <= y_delta_next;
        end // end of else
    end  // end of always
    
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