`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:57:51 09/23/2018 
// Design Name: 
// Module Name:    counter 
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
module counter(clk, reset, uphdl, inc, count);
	 
	input 				clk, reset, uphdl, inc;
	output 	[15:0] 	count;
	 
	reg 		[15:0] 	count, ncount;
	 
	always @ (posedge clk or posedge reset) begin
		if (reset)  count <= 16'b0;
		else			count <= ncount;
	end
	
	
	always @ (*) begin
		case ( {inc, uphdl} )
			2'b00: ncount = count;
			2'b01: ncount = count;
			2'b10: ncount = count - 16'b1;
			2'b11: ncount = count + 16'b1;
		endcase
	end
	 


endmodule
