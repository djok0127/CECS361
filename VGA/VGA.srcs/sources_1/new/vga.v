`timescale 1ns / 1ps
/****************************** C E C S  3 6 1 ******************************
 * 
 * File Name:  vga_sync
 *
 * Created by       Dong Jae Shin 10/9/2018
 * Copyright � 2018 Dong Jae Shin. All rights reserved.
 *
 * In submitting this file for class work at CSULB
 * I am confirming that this is my work and the work
 * of no one else. In submitting this code I acknowledge that
 * plagiarism in student project work is subject to dismissal
 * from the class.
 *         
 ****************************************************************************/


module vga_sync(clk, reset, h_sync, v_sync, video_on, h_count, v_count);

	input 		 clk, reset;
	output video_on;
    output reg [9:0] v_count, h_count;	
    output wire h_sync, v_sync;

	reg [2:0] count, d;
	reg [9:0] dv, dh;
 	reg h_video_on, v_video_on;
	wire tick, h_end, v_end;
	
   	//////////////////////////////////////////
	// This combinational block adds 1 bit  //
	// to reg d until the flag is set by the//
	// variable tick                        //
	//////////////////////////////////////////
	always @ (*) begin
		if(tick) 	d = 2'b0;
		else	    d = 2'b1 + count;
	end

	// this behavioral block sets count to reg d
	always @ (posedge clk or posedge reset) begin
		if(reset)	count <= 2'b0;
		else		count <= d;
	end

	//////////////////////////////////////////////////
	// This combinational block adds 1 bit          //
	// to reg dh and dv until the flag is set by the//
	// variable dh and dv                           //
	//////////////////////////////////////////////////
	always @ (*) begin
	   if(tick) begin
	       if(h_end) h_count = 10'b0;
	       else      dh = h_count + 10'b1;
	       if(v_end) v_count = 10'b0;
	       else      
	           if(h_end)
	               dv = v_count + 10'b1;
	   end
	end
 
    // behavioral blcok for v count and h count
    always @ (posedge clk or posedge reset) begin
        if(reset)begin
            v_count <= 10'b0;
            h_count <= 10'b0;
            dh <= 10'b0;
            dv <= 10'b0;
        end else begin
            v_count <= dv;
            h_count <= dh;
        end
    end

    // make 25 Mhz tick
    assign tick = (count == 4);
    
    // check when the counter for horizontal and vertical ends
    assign h_end = (h_count == 799);
    assign v_end = (v_count == 524);
    
    // assgin h sync and v sync
    assign h_sync = ~(h_count >= 656 & h_count <= 751);
    assign v_sync = ~(v_count >= 489 & v_count <= 491);
    
    // assert video_on when v count is less than 480 and h count is less than 640
    assign video_on = ((v_count < 480) & (h_count < 640));
endmodule
