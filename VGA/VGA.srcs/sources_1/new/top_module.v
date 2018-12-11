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
module top_module(clk, reset, btn, rgb, h_sync, v_sync);
    
    // initialized inputs
    input       clk, reset;
    input [1:0] btn;
        
    // initialize wires
    wire       video_on;

    wire [9:0] v_count, h_count;    
    wire [2:0] rgb_next;
    wire       rst_sync;
    
    // initialize outputs
    output h_sync, v_sync;
    output [2:0] rgb;
    
    // Asynchronous In Synchronous Out
    AISO reset_sync(.reset(reset),
                    .clk(clk),
                    .reset_sync(rst_sync)
                    );
                    
    // call the vga_sync module 
    vga_sync vs(.clk(clk),              // input
                .reset(rst_sync),       // input
                .h_sync(h_sync),        // output
                .v_sync(v_sync),        // output
                .video_on(video_on),    // output
                .v_count(v_count),      // output
                .h_count(h_count)      // output
                );
    
    // call the pixel gen module
    pixel_gen pg(.pixel_x(h_count),     // input 
                 .pixel_y(v_count),     // input
                 .video_on(video_on),   // input
                 .reset(rst_sync),      // input
                 .clk(clk),             // input
                 .btn(btn),             // input
                 .rgb(rgb)              // output
                 );
endmodule