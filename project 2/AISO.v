`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:23:00 09/23/2018 
// Design Name: 
// Module Name:    AISO 
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
module AISO(reset, clk, reset_sync);
	input 		clk, reset;
	output     	reset_sync;
	reg 			Q1, Q2;
	
	always @ (posedge reset or posedge clk) begin
	   if(reset)
	       {Q1, Q2} <= 2'b0;
	   else
	       {Q1, Q2} <= {1'b1, Q1};
	end
			
	assign reset_sync = Q2; // vivado uses negative logic for the reset.
	
endmodule
