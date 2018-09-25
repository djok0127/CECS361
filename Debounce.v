`timescale 1ns / 1ps
//****************************************************************//
//  File name: Debounce.v                                             //
//                                                                //
//  Created by       Sunny Pham on 9/24/2018     .                //
//  Copyright © 2018 Sunny Pham. All rights reserved.             //
//                                                                //
//                                                                //
//  In submitting this file for class work at CSULB               //
//  I am confirming that this is my work and the work             //
//  of no one else. In submitting this code I acknowledge that    //
//  plagiarism in student project work is subject to dismissal.   // 
//  from the class                                                //
//****************************************************************//

// This Debounce in particular is taken from Pong Chu's example.
module Debounce( clk, rst, sw, db);

	input  wire	  clk, rst;
	input  wire   sw;
	
	output reg	  db;
	
	reg     [2:0] present_state, next_state;

	//State Declaration
	localparam [2:0]
				    zero    = 3'b000,
					wait1_1 = 3'b001,
					wait1_2 = 3'b010,
					wait1_3 = 3'b011,
					one     = 3'b100,
					wait0_1 = 3'b101,
					wait0_2 = 3'b110,
					wait0_3 = 3'b111;
					
	// number of counter bits
	localparam N = 19;
	
	// signal declaration
	reg  [N-1:0] q_reg;
	wire [N-1:0] q_next;
	wire         tick;
	reg          n_tick;
	reg  [2:0]   state_reg, state_next;
	
	// counter to generate 10 ms tick
	c_tick1 ct_1 (clk, rst, tick);
	
	// debouncing FSM
	// state register
	always @(posedge clk, posedge rst)
		if(rst)
			state_reg <= zero;
		else 
			state_reg <= state_next;
		
	// next state logic and output logic
	always @(*)
	begin 
		state_next = state_reg;						// default state
		db = 1'b0;										// default output of 0
		n_tick = tick;
		case (state_reg)
			zero    : if(sw)
							state_next = wait1_1;
			wait1_1 : if(~sw)
							state_next = zero;
						 else
							if (tick)
								state_next = wait1_2;
			wait1_2 : if(~sw)
							state_next = zero;
						 else
							if(tick)
								state_next = wait1_3;
			wait1_3 : if(~sw)
							state_next = zero;
						 else
							if(tick)
								state_next = one;
			one     : begin
							db = 1'b1;
							if(~sw)
								state_next = wait0_1;
						 end
			wait0_1 : begin
							db = 1'b1;
							if(sw)
								state_next = one;
							else
								if(tick)
									state_next = wait0_2;
						 end
			wait0_2 : begin
							db = 1'b1;
							if(sw)
								state_next = one;
							else
								if(tick)
									state_next = wait0_3;
						 end
			wait0_3 : begin
							db = 1'b1;
							if(sw)
								state_next = one;
							else
								if(tick)
									state_next = zero;
						 end
			default : state_next = zero;
		endcase
	end
			
endmodule
