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
    wire [11:0] color;
    reg [11:0] sw;
    

 top_module top_module(.clk(clk),
                       .reset(reset), 
                       .SW(sw), 
                       .color(color), 
                       .h_sync(h_sync), 
                       .v_sync(v_sync));
                       
   initial begin
   // start the test bench by setting the clock to 0
   // reset to 1
   clk = 0;
   reset = 1;
   sw = 12'b0;
   
   // change the timeformat to milliseconds
   $timeformat(-3,2,"ms", 10);
   
   // wait for 20ns and set the reset to 0
   #20 reset = 0;
   // loop the cloop forever and not it every 2 ns
   forever begin 
        
       #2 clk = !clk;
       #2 sw = sw + 12'b1;
   end   
end
endmodule
