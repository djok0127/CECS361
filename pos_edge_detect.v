`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:43:41 09/23/2018 
// Design Name: 
// Module Name:    pos_edge_detect 
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
module pos_edge_detect(D_in, clk, reset, inc_p);
	input 	D_in, clk, reset;
	output 	inc_p;
	reg Q1, Q2;
	
	always @ (posedge reset or posedge clk) begin
       if(reset)
           {Q1, Q2} <= 2'b0;
       else
           {Q1, Q2} <= {D_in, Q1};
    end
            
	assign inc_p = (Q1 & ~Q2);
endmodule
