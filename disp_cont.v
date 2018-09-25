/*****************************************************
 * File Name: disp_cont.v
 * Project: Lab08 
 * Designer: Dong Jae Shin (014579836)
 * Email: djok0127@gmail.com
 * Rev. Date:  May 7, 2018
 *
 *
 * Purpose: This module is the top module for
 *          displaying the hex value on to the
 *          LED. This module makes the LED to turn
 *          on one by one that refreshes every 2.08ms
 *          and display the hex value converted on
 *          to the seven segment display.
 * 
 * Notes: The refresh rate is calculated by dividing 1
 *        by the frequency necessary(1/480hz).
 *        480Hz is calculated by multiplying 60Hz with 8,
 *        because there are 8 7-segment displays
 *        in total. Therefore, 480Hz will give
 *        scanned display of 60Hz.
 *****************************************************/
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
    pulse_generator pulse_generator(.clk(clk),			// Input
												.reset(reset),		// Input
												.flag(104_166),	// Input
												.tick(tick)			// Output
												);		
     
    px_controller p_con( .clk(clk),  			// Input
                                 .reset(reset),       // Input
								 .tick(tick),			// Input
                                 .a(a),               // Output
                                 .seg_sel(seg_sel)    // Output
											);
  
    mux_8_1             mux81( .S(seg_sel),         // Input  
                                 .Din({16'b0,seg}),           // Input  
                                 .Dout(hex_wire)      // Output 
                               );
  
    hex_to_7seg      hex_to_seg( .hex(hex_wire),   	// Input
                                 .cathodes(cathodes)  // Output
                               );

endmodule
