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
module top_module(clk, reset, SW, color, h_sync, v_sync);
    
    // initialized inputs
    input        clk, reset;
    input [11:0] SW;
    
    // initialize wires
    wire       video_on; // if it is output wire the testbench shows
                                // if it is wire it gets high impedance
    wire [9:0] v_count, h_count;    
    
    // initialize outputs
    output h_sync, v_sync;
    output wire [11:0] color;
    
    // call the vga_sync module 
    vga_sync vs(.clk(clk),          // input
                .reset(reset),      // input
                .h_sync(h_sync),    // output
                .v_sync(v_sync),    // output
                .video_on(video_on),// output
                .v_count(v_count),  // output
                .h_count(h_count)   // output
                );
          
	// assign the color of the screen based on switch inputs
    assign color = (video_on) ? SW : 12'b0;
                
endmodule
