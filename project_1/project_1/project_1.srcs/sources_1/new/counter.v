`timescale 1ns / 1ps
//****************************************************************//
//  File name: counter.v                                          //
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
module counter(clk, reset, uphdl, inc, count);
	 
	input 				clk, reset, uphdl, inc;
	output 	[15:0] 	count;
	 
	reg 		[15:0] 	count, ncount;
	
	/////////////////////////////////////////////
	// This behavioral block copies ncount to  //
	// count for every clock tick              //
	/////////////////////////////////////////////
	always @ (posedge clk or posedge reset) begin
		if (reset)  count <= 16'b0;
		else	    count <= ncount;
	end
	
	///////////////////////////////////////////
	// This combinational block( 4 to 1 mux) //
	// determines the ncount according to the//
	// two inputs( inc, uphdl ).             //
	///////////////////////////////////////////
	always @ (*) begin
		case ( {inc, uphdl} )
			2'b00: ncount = count;
			2'b01: ncount = count;
			2'b10: ncount = count - 16'b1;
			2'b11: ncount = count + 16'b1;
		endcase
	end
	 


endmodule
