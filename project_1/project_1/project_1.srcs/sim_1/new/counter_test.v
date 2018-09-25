`timescale 1ns / 1ps
//****************************************************************//
//  File name: counter_test.v                                     //
//                                                                //
//  Created by      Dong Jae Shin on 9/24/2018     .              //
//  Copyright � 2018 Dong Jae Shin. All rights reserved.          //
//                                                                //
//                                                                //
//  In submitting this file for class work at CSULB               //
//  I am confirming that this is my work and the work             //
//  of no one else. In submitting this code I acknowledge that    //
//  plagiarism in student project work is subject to dismissal.   // 
//  from the class                                                //
//****************************************************************//



module counter_test(); // Testbench has no inputs, outputs
    
    // variable instantiation
    reg clk, rst, UPHDNL, inc;
    wire [15:0] count;
    
    counter count_test(.clk     (   clk),   // Input
                       .reset   (   rst),   // Input
                       .uphdl   (UPHDNL),   // Input
                       .inc     (   inc),   // Input
                       .count   ( count)    // Outut
                      );
    always
        #5 clk = ~clk; // change clock from 0 to 1, 1 to 0 every 5ns
    
    initial begin      // sequential block
    
        $timeformat(-9, 1, " ns", 6);
        clk = 0; rst = 0; UPHDNL = 0; inc = 0;
    
    /////////////////
    // apply reset //
    /////////////////
        
        @(negedge clk)
            rst = 1;
        @(negedge clk)
            rst = 0;
        
    //////////////////////////////
    // apply inputs, wait 10 ns //
    //////////////////////////////
                   
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

