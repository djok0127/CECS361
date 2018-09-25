`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:07 09/24/2018 
// Design Name: 
// Module Name:    top_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_module(reset, clk, inc, uphdl, anode, cathode);

    input reset, clk, inc, uphdl;
    output [6:0] cathode;    // Cathodes for Seven-Segment Display
    output [7:0] anode;      // Anodes for Seven-Segment Display
    
    wire  rst_sync, inc_db, inc_p;
    
    wire [15:0] count;
    
    AISO           AISO(.reset      (     reset),     // Intput 
                        .clk        (       clk),     // Intput
                        .reset_sync (  rst_sync)      // Output
                       );
	        //  (clk, reset, D_in, Q_out)
    debounce         Db( .clk       (       clk),     // Input
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
    disp_cont   disp(  .clk         (       clk),    //  Input
                       .reset       (  rst_sync),    //  Input
                       .seg         (     count),    //  Input
                       .a           (     anode),    // Output
                       .cathodes    (   cathode)     // Output
                    );
	
	
	
endmodule
