`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:33:29 09/23/2018 
// Design Name: 
// Module Name:    pulse_generator 
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
module pulse_generator(clk, reset, flag, tick);

	input 		 clk, reset;
	input [19:0] flag;
	
	output		 tick;
	
	reg [19:0] count, d;
	

	
	always @ (*) begin
		if(tick) 	d = 20'b0;
		else	    d = 20'b1 + count;
	end
	
	always @ (posedge clk or posedge reset) begin
		if(reset)	count <= 20'b0;
		else		count <= d;
	end

	assign tick = (count ==	flag);
	
endmodule
