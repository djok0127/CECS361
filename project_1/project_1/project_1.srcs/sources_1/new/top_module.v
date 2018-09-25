`timescale 1ns / 1ps
//****************************************************************//
//  File name: top_module.v                                       //
//                                                                //
//  Created by       Dong Jae Shin on 9/24/2018     .             //
//  Copyright © 2018 Dong Jae Shin. All rights reserved.          //
//                                                                //
//                                                                //
//  In submitting this file for class work at CSULB               //
//  I am confirming that this is my work and the work             //
//  of no one else. In submitting this code I acknowledge that    //
//  plagiarism in student project work is subject to dismissal.   // 
//  from the class                                                //
//****************************************************************//
module top_module(reset, clk, inc, uphdl, anode, cathode);

    input reset, clk, inc, uphdl;           // Input delcaration
    output [6:0] cathode;                   // Cathodes for Seven-Segment Display
    output [7:0] anode;                     // Anodes for Seven-Segment Display
    
    wire  rst_sync, inc_db, inc_p;          // Wire declaration
    wire [15:0] count;
    
    AISO           AISO(.reset      (     reset),    // Intput 
                        .clk        (       clk),    // Intput
                        .reset_sync (  rst_sync)     // Output
                       );
                       
    debounce         Db(.clk       (       clk),     // Input
                        .reset     (  rst_sync),     // Input
                        .D_in      (       inc),     // Input
                        .Q_out     (    inc_db)      // Output
                        );
                       
	pos_edge_detect PED(.D_in       (    inc_db),    // Input
	                    .clk        (       clk),    // Input
	                    .reset      (  rst_sync),    // Input
	                    .inc_p      (     inc_p)     // Output
	                    );
	                    
	counter     counter(.clk        (       clk),    // Input
                        .reset      (  rst_sync),    // Input
                        .uphdl      (     uphdl),    // Input
                        .inc        (     inc_p),    // Input
                        .count      (     count)     // Output
                        );
                        
    disp_cont     disp(.clk         (       clk),    //  Input
                       .reset       (  rst_sync),    //  Input
                       .seg         (     count),    //  Input
                       .a           (     anode),    // Output
                       .cathodes    (   cathode)     // Output
                    );
	
endmodule
