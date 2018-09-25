`timescale 1ns / 1ps
//****************************************************************//
//  File name: pos_edge_detect.v                                  //
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
module pos_edge_detect(D_in, clk, reset, inc_p);
	input 	D_in, clk, reset;
	output 	inc_p;
	reg Q1, Q2;
	
	///////////////////////////////////////////////
	// This behavioral block detects the positive//
	// edge of the input.                        //
	///////////////////////////////////////////////
	always @ (posedge reset or posedge clk) begin
       if(reset)
           {Q1, Q2} <= 2'b0;
       else
           {Q1, Q2} <= {D_in, Q1};
    end
            
	assign inc_p = (Q1 & ~Q2);
endmodule
