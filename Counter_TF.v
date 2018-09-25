`timescale 1ns / 1ps
//****************************************************************//
//  File name: Counter_TF.v                                       //
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



module Counter_TF();
    reg clk, rst, UPHDNL, inc;
    
    wire [15:0] count;
    
    Counter c1 (.clk(clk), .rst(rst), .UPHDNL(UPHDNL), .inc(inc), .count(count));
    
    always
        #5 clk = ~clk;
    
    initial begin
        $timeformat(-9, 1, " ns", 6);
        clk = 0; rst = 0; UPHDNL = 0; inc = 0;
    
        @(negedge clk)
            rst = 1;
        @(negedge clk)
            rst = 0;
        
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b1xx;
        
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
        
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b011;
        
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
        
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b001;
        
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
        
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b011;
        
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
        
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b001;
        
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
        
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b001;
        
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
            
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b010;
            
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
            
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b001;
            
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
            
        @(negedge clk)
            {rst, UPHDNL, inc} = 3'b1xx;
            
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
          
         @(negedge clk)
            {rst, UPHDNL, inc} = 3'b011;
            
        @(posedge clk)
            #1 $display("t = %t count = %h", $time, count);
        $finish;
    end
endmodule

