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
    input  wire D_in;
    output  reg Q_out;
	       wire tick_r;
	
	pulse_gen pg1 (.clk(clk),
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
   always @(*)  begin
       case  ({PS, D_in, tick_r})
           5'b000_0_0 : NS = 3'b000; // use conditional
           5'b000_0_1 : NS = 3'b000;
           5'b000_1_0 : NS = 3'b001;
           5'b000_1_1 : NS = 3'b001;
           5'b001_0_0 : NS = 3'b000;
           5'b001_0_1 : NS = 3'b000;
           5'b001_1_0 : NS = 3'b001;
           5'b001_1_1 : NS = 3'b010;
           5'b010_0_0 : NS = 3'b000; // use conditional
           5'b010_0_1 : NS = 3'b000;
           5'b010_1_0 : NS = 3'b010;
           5'b010_1_1 : NS = 3'b011;
           5'b011_0_0 : NS = 3'b000;
           5'b011_0_1 : NS = 3'b000;
           5'b011_1_0 : NS = 3'b011;
           5'b011_1_1 : NS = 3'b100;
           
           5'b100_0_0 : NS = 3'b101;
           5'b100_0_1 : NS = 3'b101; // use conditional
           5'b100_1_0 : NS = 3'b100;
           5'b100_1_1 : NS = 3'b100;
           5'b101_0_0 : NS = 3'b101;
           5'b101_0_1 : NS = 3'b110;
           5'b101_1_0 : NS = 3'b100;
           5'b101_1_1 : NS = 3'b100;
           5'b110_0_0 : NS = 3'b110;
           5'b110_0_1 : NS = 3'b111; // use conditional
           5'b110_1_0 : NS = 3'b100;
           5'b110_1_1 : NS = 3'b100;
           5'b111_0_0 : NS = 3'b111;
           5'b111_0_1 : NS = 3'b000;
           5'b111_1_0 : NS = 3'b100;
           5'b111_1_1 : NS = 3'b100;
       endcase
   end
   //*****************************************
   // State Register Logic (Sequential Logic)
   //*****************************************
   always @ (posedge clk  or posedge reset) begin
       if (reset == 1'b1)
           PS <= 3'b0; //Got a reset so set state register to all 0's
       else
           PS <= NS;        // Got a posedge so update state register with next state
    end
           
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
