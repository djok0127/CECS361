`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2018 07:13:39 PM
// Design Name: 
// Module Name: top_module_tb
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


module top_module_tb;

    // inputs to the DUT
    reg        clk,      reset;
    
    // outputs from the DUT
    wire       video_on, h_sync, v_sync;
    wire [2:0] rgb;

    top_module tm(.clk(clk), 
                  .reset(reset), 
                  .rgb(rgb), 
                  .h_sync(h_sync), 
                  .v_sync(v_sync)
                  );
initial begin
   // start the test bench by setting the clock to 0
   // reset to 1
   clk = 0;
   reset = 1;
   
   #50 // wait for 50 ns
   reset = 0;
   
   
   //ToDo: does he want the tick as an output to use that signal to check others?
   
end
endmodule
