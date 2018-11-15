`timescale 1ns / 1ps
/****************************** C E C S  3 6 1 ******************************
 * 
 * File Name:  vga_sync
 *
 * Created by       Dong Jae Shin 10/9/2018
 * Copyright © 2018 Dong Jae Shin. All rights reserved.
 *
 * purpose: To create the signals of the horizontal and vertical
 *          sync, video on signal depnding on the counts
 *          of the horizontal pixel and the vertical pixel.
 *
 * In submitting this file for class work at CSULB
 * I am confirming that this is my work and the work
 * of no one else. In submitting this code I acknowledge that
 * plagiarism in student project work is subject to dismissal
 * from the class.
 *         
 ****************************************************************************/


module vga_sync(clk, reset, h_sync, v_sync, video_on, v_count, h_count, tick );
    
    // initialization of input
	input 		      clk, reset;
	
    // initialization of output
	output reg           video_on;
    output reg [9:0]  v_count, h_count;	
    output wire       h_sync, v_sync;
    output wire       tick;
    
    // initialization of regs and wires
	reg [1:0] count, d;
	

	wire h_end, v_end;
	
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

    // make 25 Mhz tick
    assign tick = (count == 3);
    
    // check when the counter for horizontal and vertical ends
    assign h_end = (h_count == 799);
    assign v_end = (v_count == 524);
    
    // assgin h sync and v sync
    // h and v sync are low active, which is why it is notted.
    assign h_sync = ~(h_count >= 656 && h_count <= 751);
    assign v_sync = ~(v_count >= 490 && v_count <= 491);
    
    // assert video_on when v count is less than 480 and h count is less than 640
    always @(*) video_on = ((v_count < 480) && (h_count < 640));
    
	///////////////////////////////////////////////////////////
	// This combinational block adds 1 bit                   //
	// to reg h and v count next until the flag is set by the//
	// variable h and v count next                           //
	///////////////////////////////////////////////////////////
    // behavioral block for v count and h count
    always @(posedge clk or posedge reset) begin
        if(reset) h_count <= 10'b0; else
        if(tick)begin
            if(h_end) h_count <= 10'b0;
            else h_count <= h_count + 10'b1;
        end
    end
    
    always @(posedge clk or posedge reset)begin
        if(reset) v_count <= 10'b0; else
        if( tick ) begin 
            if(h_end) begin
                if(v_end) v_count <= 10'b0;
                else      v_count <= v_count + 10'b1;
            end
        end
    end

    

endmodule
