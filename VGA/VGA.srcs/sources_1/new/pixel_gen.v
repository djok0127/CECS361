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
module pixel_gen( pixel_x, pixel_y, video_on, reset, clk, btn, rgb);
    input wire [9:0] pixel_x, pixel_y;
    input wire video_on;
    input reset, clk;
    input [1:0] btn;
    output reg [2:0] rgb;
    
    //define the max pixel coordinates
    localparam MAX_X = 640;
    localparam MAX_Y = 480;
        
    //wall parameters
    localparam WALL_X_L = 32;
    localparam WALL_X_R = 35;
    
    //bar parameters
    localparam BAR_X_L = 600;
    localparam BAR_X_R = 603;
        
    //changing bar parameters
    wire [9:0] bar_y_t, bar_y_b;
    
    // size of bar
    localparam BAR_Y_SIZE = 72;
    
    reg [9:0] bar_y_reg, bar_y_next;
    
    localparam BAR_V = 4; 
    
    //variables to define the square ball
    
    localparam BALL_SIZE =8;
    
    wire [9:0]  ball_x_l , ball_x_r;
    wire [9:0] ball_y_t, ball_y_b;
    wire [9:0] ball_x_next , ball_y_next;
    
    reg [9:0] ball_x_reg, ball_y_reg;
    reg [9:0] x_delta_reg, x_delta_next;
    reg [9:0] y_delta_reg, y_delta_next;
    
    wire wall_on, bar_on, ball_on;
    wire [2:0] wall_rgb, bar_rgb, ball_rgb;
        
        
    localparam BALL_V_P = 2;
    localparam BALL_V_N = -2;
    
    // refresh every 60 hz
    wire ref_tick;
    
    assign ref_tick = (pixel_y == 481) && (pixel_x == 0); 
    //------------------------- wall -------------------------
    // create wall on the left side four pixels wide
    assign wall_on = (WALL_X_L <= pixel_x) &&  (pixel_x <= WALL_X_R);
    
    // color wall red
    assign wall_rgb = 3'b001;
    
    //------------------------- bar -------------------------

    // set the bar to green
    assign bar_rgb = 3'b010;
    //assign the values for bar
    assign bar_y_t = bar_y_reg;
    assign bar_y_b = bar_y_t + BAR_Y_SIZE -1;
    assign bar_on = ((BAR_X_L <= pixel_x) && (pixel_x <= BAR_X_R) 
                  && (bar_y_t <= pixel_y) && (pixel_y <= bar_y_b));
    // new bar position
    always @ (*) begin
        bar_y_next = bar_y_reg; // do not move
        if(ref_tick) begin
            if(btn[1] & (bar_y_b < (MAX_Y - 1 - BAR_V)))
                bar_y_next = bar_y_reg + BAR_V;
            else if( btn[0] & (bar_y_t > BAR_V))
                bar_y_next = bar_y_reg - BAR_V;
        end
    end
    //------------------------- ball -------------------------
    // create the ball
    
	assign ball_x_l = ball_x_reg;
    assign ball_y_t = ball_y_reg;
    assign ball_x_r = ball_x_l + BALL_SIZE - 1;
    assign ball_y_b = ball_y_t + BALL_SIZE - 1;
    
    // create square ball
    assign ball_on = ((ball_x_l <= pixel_x) && (pixel_x <= ball_x_r) && 
                      (ball_y_t <= pixel_y) && (pixel_y <= ball_y_b));
    
    // new ball position
    assign ball_x_next = (ref_tick) ? ball_x_reg + x_delta_reg: ball_x_reg;
    assign ball_y_next = (ref_tick) ? ball_y_reg + y_delta_reg: ball_y_reg;
    
    // new ball velocity
    always @ (*) begin
        x_delta_next = x_delta_reg;
        y_delta_next = y_delta_reg;
        if(ball_y_t <1)
            y_delta_next = BALL_V_P;
        else if (ball_y_b > (MAX_Y -1))
            y_delta_next = BALL_V_N;
        else if (ball_x_l <= WALL_X_R)
            x_delta_next = BALL_V_P;
        else if ((BAR_X_L <= ball_x_r) && (ball_x_r <= BAR_X_R) && 
                 (bar_y_t <= ball_y_b) && (ball_y_t <= bar_y_b))
            x_delta_next = BALL_V_N;
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
        end // end of else
    end // end of always
endmodule