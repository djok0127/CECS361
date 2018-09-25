`timescale 1ns / 1ps
//****************************************************************//
//  File name: pulse_gen.v                                        //
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
module pulse_gen(clk, reset, flag, tick);

	input 		 clk, reset;
	input [19:0] flag;
	
	output		 tick;
	
	reg [19:0] count, d;
	

	//////////////////////////////////////////
	// This combinational block adds 1 bit  //
	// to reg d until the flag is set by the//
	// variable tick                        //
	//////////////////////////////////////////
	always @ (*) begin
		if(tick) 	d = 20'b0;
		else	    d = 20'b1 + count;
	end
	//////////////////////////////////////////////
	// this behavioral block sets count to reg d//
	//////////////////////////////////////////////
	always @ (posedge clk or posedge reset) begin
		if(reset)	count <= 20'b0;
		else		count <= d;
	end

    // tick is equal to one only if the count is eqaul to flag
	assign tick = (count ==	flag);
	
endmodule
