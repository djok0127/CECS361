/************************************************************
 * File Name: px_controller.v
 * Project: Lab05
 * Designer: Dong Jae Shin (014579836)
 * Email: djok0127@gmail.com
 * Rev. Date:  Mar. 12, 2018
 *
 *
 * Purpose: This module takes divided clock input
 *          (480Hz) and cycles through each anodes
 *          to be turned on, one at a time.
 *
 * Notes: This module is using the moore state
 *        machine to cycle through each anodes,
 *        which means that the output is only
 *        dependent on the present state.
 ************************************************************/
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
            if(tick == 1'b1)
                PS = NS;        // Got a posedge so update state register with next state
            else
                PS = PS;
            
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
