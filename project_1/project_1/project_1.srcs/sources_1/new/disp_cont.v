//****************************************************************//
//  File name: disp_cont.v                                        //
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
`timescale 1ns / 1ps
module disp_cont(
    input clk,
    input reset,
    input  [15:0] seg,
    output  [7:0] a,
    output  [6:0] cathodes
    );
     
    //******************
    // wire declaration.
    //******************
    wire       clk_wire_1;
    wire [2:0] seg_sel;
    wire [3:0] hex_wire;
    wire 		tick;
	 

	
    //******************************************************************
    // initialization of the modules and putting them together into one.
    //****************************************************************** 
    pulse_gen pulse_generator(.clk(clk),			// Input
							  .reset(reset),		// Input
							  .flag(104_166),	    // Input
							  .tick(tick)			// Output
							 );		
     
    px_controller       p_con(.clk(clk),  			// Input
                              .reset(reset),        // Input
							  .tick(tick),			// Input
                              .a(a),                // Output
                              .seg_sel(seg_sel)     // Output
							 );
  
    mux_8_1             mux81(.S(seg_sel),          // Input  
                              .Din({16'b0,seg}),    // Input  
                              .Dout(hex_wire)       // Output 
                             );
  
    hex_to_7seg    hex_to_seg( .hex(hex_wire),   	// Input
                               .cathodes(cathodes)  // Output
                             );

endmodule
