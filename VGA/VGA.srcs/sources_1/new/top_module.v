`timescale 1ns / 1ps
/****************************** C E C S  3 6 1 ******************************
 * 
 * File Name:  vga_sync
 *
 * Created by       Dong Jae Shin 10/23/2018
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
module top_module(clk, reset, rgb, h_sync, v_sync);
    
    // initialized inputs
    input        clk, reset;
    
    // initialize wires
    wire       video_on; // if it is output wire the testbench shows
                                // if it is wire it gets high impedance
    wire [9:0] v_count, h_count;    
    reg [2:0] rgb_r;
    wire [2:0] rgb_next;
    wire tick;
    
    // initialize outputs
    output h_sync, v_sync;
    output wire [2:0] rgb;
    
    
    
    // call the vga_sync module 
    vga_sync vs(.clk(clk),          // input
                .reset(reset),      // input
                .h_sync(h_sync),    // output
                .v_sync(v_sync),    // output
                .video_on(video_on),// output
                .v_count(v_count),  // output
                .h_count(h_count),   // output
                .tick(tick)         // output
                );
    
    // call the pixel gen module
    pixel_gen pg(.pixel_x(h_count), 
                 .pixel_y(v_count), 
                 .video_on(video_on), 
                 .rgb(rgb_next)
                 );
     
    always @(posedge clk or posedge reset) begin
        if(tick) rgb_r <= rgb_next;
        else if(reset) rgb_r <= 2'b0;
    end
    
    assign rgb = rgb_r;
endmodule
