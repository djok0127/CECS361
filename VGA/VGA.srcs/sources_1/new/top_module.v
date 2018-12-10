`timescale 1ns / 1ps
/****************************** C E C S  3 6 1 ******************************
 * 
 * File Name:  vga_sync
 *
 * Created by       Dong Jae Shin 11/14/2018
 * Copyright © 2018 Dong Jae Shin. All rights reserved.
 *
 * purpose: top_module of the VGA project.
 *          Puts together the vga sync module and the color module.
 *          
 *
 * In submitting this file for class work at CSULB
 * I am confirming that this is my work and the work
 * of no one else. In submitting this code I acknowledge that
 * plagiarism in student project work is subject to dismissal
 * from the class.
 *         
 ****************************************************************************/
module top_module(clk, reset, btn_down, btn_up, rgb, h_sync, v_sync, video_on);
    
    // initialized inputs
    input        clk, reset, btn_down, btn_up;
    
    // initialize wires
    output       video_on;

    wire [9:0] v_count, h_count;    
    wire [2:0] rgb_next;
    wire tick, rst_sync;
    
    // initialize outputs
    output h_sync, v_sync;
    output reg [2:0] rgb;
    
    // Asynchronous In Synchronous Out
    AISO reset_sync(.reset(reset),
                    .clk(clk),
                    .reset_sync(rst_sync)
                    );
                    
    // call the vga_sync module 
    vga_sync vs(.clk(clk),          // input
                .reset(rst_sync),      // input
                .h_sync(h_sync),    // output
                .v_sync(v_sync),    // output
                .video_on(video_on),// output
                .v_count(v_count),  // output
                .h_count(h_count),   // output
                .tick(tick)         // output
                );
    
    // call the pixel gen module
    pixel_gen pg(.pixel_x(h_count),     // input 
                 .pixel_y(v_count),     // input
                 .btn_up(btn_up),       // input
                 .btn_down(btn_down),   // input
                 .video_on(video_on),   // input
                 .reset(rst_sync),      // input
                 .clk(clk),             // input
                 .rgb(rgb_next)         // output
                 );
     
    always @(posedge clk or posedge reset) begin
        if(tick) rgb <= rgb_next;
        else if(reset) rgb <= 2'b0;
    end
endmodule