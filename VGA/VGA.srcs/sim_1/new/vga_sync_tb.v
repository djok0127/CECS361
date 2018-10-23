`timescale 1ns / 1ps
/****************************** C E C S  3 6 1 ******************************
 * 
 * File Name:  vga_sync_tb
 *
 * Created by       Dong Jae Shin 10/9/2018
 * Copyright © 2018 Dong Jae Shin. All rights reserved.
 *
 * purpose: vga_sync_tb verifies all the signals for the inputs and outputs
 *          meet the requirements.
 *          
 *
 * In submitting this file for class work at CSULB
 * I am confirming that this is my work and the work
 * of no one else. In submitting this code I acknowledge that
 * plagiarism in student project work is subject to dismissal
 * from the class.
 *         
 ****************************************************************************/
module vga_sync_tb;
    
    // inputs to the DUT
    reg        clk,      reset;
    
    // outputs from the DUT
    wire       video_on, h_sync, v_sync;
    wire [9:0] h_count,  v_count;
    
    // calls the module to be tested
    vga_sync vs(.clk        (clk),
                .reset      (reset), 
                .h_sync     (h_sync), 
                .v_sync     (v_sync), 
                .video_on   (video_on), 
                .h_count    (h_count), 
                .v_count    (v_count)
                );
    
    initial begin
        // start the test bench by setting the clock to 0
        // reset to 1
        clk = 0;
        reset = 1;
        
        // change the timeformat to milliseconds
        $timeformat(-3,2,"ms", 10);
        
        // wait for 20ns and set the reset to 0
        #20 reset = 0;
        // loop the cloop forever and not it every 2 ns
        forever 
            #2 clk = !clk;   
    end
endmodule
