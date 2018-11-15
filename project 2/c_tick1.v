`timescale 1ns / 1ps
//****************************************************************//
//  File name: c_tick1.v                                          //
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


module c_tick1(clk, rst, cout);

    input clk, rst;
    
    output cout;
    
    reg [19:0] count, d;
    
    assign cout = (count == 999_999);
    // if count is equal to 999_999, then cout = 1
    
    always @(*)
        if (cout)   d = 20'b0;
        else        d = count + 20'b1;
    
    always @(posedge clk, posedge rst)
        if (rst)    count <= 20'b0;
        else        count <= d;
    
    
endmodule
