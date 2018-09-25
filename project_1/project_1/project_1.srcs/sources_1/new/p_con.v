//****************************************************************//
//  File name: px_controller.v                                    //
//                                                                //
//  Created by       Dong Jae Shin on 9/24/2018     .             //
//  Copyright © 2018 Dong Jae Shin. All rights reserved.          //
//                                                                //
//                                                                //
//  In submitting this file for class work at CSULB               //
//  I am confirming that this is my work and the work             //
//  of no one else. In submitting this code I acknowledge that    //
//  plagiarism in student project work is subject to dismissal.   // 
//  from the class                                                //
//****************************************************************//
`timescale 1ns / 1ps
module px_controller(clk, reset, tick, a, seg_sel);
    input        clk, reset,tick;
    output [7:0] a;
    output [2:0] seg_sel;
     
    reg [2:0] seg_sel;
    reg [7:0] a;
    
    
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
    always @(PS)
        case  (PS)
            3'b000 : NS = 3'b001;
            3'b001 : NS = 3'b010;
            3'b010 : NS = 3'b011;
            3'b011 : NS = 3'b100;
            3'b100 : NS = 3'b101;
            3'b101 : NS = 3'b110;
            3'b110 : NS = 3'b111;
            3'b111 : NS = 3'b000;
            default: NS = 3'b000;
    endcase

    //*****************************************
    // State Register Logic (Sequential Logic)
    //*****************************************
    always @ (posedge clk  or posedge reset)
        if (reset == 1'b1)
            PS = 3'b0; //Got a reset so set state register to all 0's
        else
            if(tick == 1'b1)    // changes to the next anode on every 60 hz for each anode(480hz)
                PS = NS;        // Got a posedge so update state register with next state
            else
                PS = PS;        // if it is before 60 hz, do not update the state
            
    //******************************************************
    // Output Combinational Logic
    // (Outputs will only chnage when present state changes)
    //******************************************************
    always @(PS)
      case  (PS)
           3'b000 : {seg_sel, a} = 11'b000_11111110;  // selecting the anode 0
           3'b001 : {seg_sel, a} = 11'b001_11111101;  // selecting the anode 1
           3'b010 : {seg_sel, a} = 11'b010_11111011;  // selecting the anode 2
           3'b011 : {seg_sel, a} = 11'b011_11110111;  // selecting the anode 3
           3'b100 : {seg_sel, a} = 11'b100_11101111;  // selecting the anode 4
           3'b101 : {seg_sel, a} = 11'b101_11011111;  // selecting the anode 5
           3'b110 : {seg_sel, a} = 11'b110_10111111;  // selecting the anode 6
           3'b111 : {seg_sel, a} = 11'b111_01111111;  // selecting the anode 7
           default: {seg_sel, a} = 11'b000_00000000;  // selecting the anode 0
       endcase

endmodule
