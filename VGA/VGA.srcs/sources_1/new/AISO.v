`timescale 1ns / 1ps
//****************************************************************//
//  File name: AISO.v                                             //
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
module AISO(reset, clk, reset_sync);

	input 		clk, reset;
	output     	reset_sync;
	reg 			Q1, Q2;
	
	////////////////////////////////////////////////////////
	// This Behavioral block creates a synchronous reset  //
	////////////////////////////////////////////////////////
	always @ (posedge reset or posedge clk) begin
	   if(reset)
	       {Q1, Q2} <= 2'b0;
	   else
	       {Q1, Q2} <= {1'b1, Q1};
	end
    
    // vivado uses negative logic for the reset. 
	assign reset_sync = ~Q2;
	
endmodule
