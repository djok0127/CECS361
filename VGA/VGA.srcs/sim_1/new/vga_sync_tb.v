`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2018 01:15:20 AM
// Design Name: 
// Module Name: vga_sync_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_sync_tb;
    
    // inputs to the DUT
    reg        clk,      reset;
    
    // outputs from the DUT
    wire       video_on, h_sync, v_sync;
    wire [9:0] h_count,  v_count;
    
    vga_sync vs(.clk        (clk),
                .reset      (reset), 
                .h_sync     (h_sync), 
                .v_sync     (v_sync), 
                .video_on   (video_on), 
                .h_count    (h_count), 
                .v_count    (v_count)
                );
    
    initial begin
        clk = 0;
        reset = 0;
        
        $timeformat(3,1,"ks",12);
        
        #20 reset = 1;
        #20 reset = 0;
        forever 
            #2 clk = !clk;   
    end
endmodule
