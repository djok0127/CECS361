//****************************************************************//
//  File name: mux_8_1      .v                                    //
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
module mux_8_1(S, Din, Dout);
    input       [2:0] S;     // 3-bit Select
    input      [31:0] Din;   // 8 x 4-bit data inputs (16 bits)
    output reg  [3:0] Dout;  // 4-bit data output
    
    //////////////////////////////////////////////////////////////////
    // This combinational block changes the output depending on the //  
    // 3 bit select and outputs 4 bit data output                   //
    //////////////////////////////////////////////////////////////////
    always @(*)
        case (S)
            3'b000:  Dout = Din[3 : 0];  // D0
            3'b001:  Dout = Din[7 : 4];  // D1
            3'b010:  Dout = Din[11: 8];  // D2
            3'b011:  Dout = Din[15:12];  // D3
            3'b100:  Dout = Din[19:16];  // D4
            3'b101:  Dout = Din[23:20];  // D5
            3'b110:  Dout = Din[27:24];  // D6
            3'b111:  Dout = Din[31:28];  // D7
            default: Dout = Din[3:0];    // D0
        endcase
endmodule
