`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:53 09/23/2018 
// Design Name: 
// Module Name:    d_ff 
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
module d_ff(D, Q, reset, clk);
	 
	input D, reset, clk;
	output reg Q;
	
	always @ (posedge clk or posedge reset) begin
	   if(reset)
	       Q <= 1'b0;
	   else
	       Q <= D;
	end

endmodule
