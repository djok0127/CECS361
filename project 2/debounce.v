`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:36 09/23/2018 
// Design Name: 
// Module Name:    debounce 
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
module debounce(clk, reset, D_in, Q_out);
	
    input       clk, reset;
    input wire D_in;
    output reg 	Q_out;
	wire tick_r;
	
	pulse_generator pg1 (.clk(clk),
						 .reset(reset),
						 .flag(999_999),	// generate 10 ms clock pulse
						 .tick(tick_r));
	
    
   //***********************
   // State register and
   // Next_state Variables
   //***********************
   reg [2:0] PS;
   reg [2:0] NS;
    
   //************************************************************************
   // Next State Combinational Logic
   // (Next State values can change anytime but will only be "clocked" below)
   //************************************************************************
   always @(PS or D_in or tick_r)
       case  (PS)
           3'b000 : if(D_in & tick_r == 1) NS = 3'b000; else NS = 3'b000; // use conditional
           3'b001 : if(D_in & tick_r == 1) NS = 3'b010; else NS = 3'b000;
           3'b010 : if(D_in & tick_r == 1) NS = 3'b011; else NS = 3'b000;
           3'b011 : if(D_in & tick_r == 1) NS = 3'b100; else NS = 3'b000;
           3'b100 : if(D_in & tick_r == 1) NS = 3'b101; else NS = 3'b100;
           3'b101 : if(D_in & tick_r == 1) NS = 3'b110; else NS = 3'b100;
           3'b110 : if(D_in & tick_r == 1) NS = 3'b111; else NS = 3'b100;
           3'b111 : if(D_in & tick_r == 1) NS = 3'b000; else NS = 3'b100;
   endcase
   //*****************************************
   // State Register Logic (Sequential Logic)
   //*****************************************
   always @ (posedge clk  or posedge reset)
       if (reset == 1'b1)
           PS <= 3'b0; //Got a reset so set state register to all 0's
       else
           PS <= NS;        // Got a posedge so update state register with next state

           
   //******************************************************
   // Output Combinational Logic
   // (Outputs will only chnage when present state changes)
   //******************************************************
   always @(PS)
     case  (PS)
          3'b000 : Q_out = 1'b0;
		  3'b001 : Q_out = 1'b0;
		  3'b010 : Q_out = 1'b0;
		  3'b011 : Q_out = 1'b0;
		  3'b100 : Q_out = 1'b1;
		  3'b101 : Q_out = 1'b1;
		  3'b110 : Q_out = 1'b1;
		  3'b111 : Q_out = 1'b1;
		  default: Q_out = 1'b0;
      endcase

endmodule
