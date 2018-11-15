`timescale 1ns / 1ps
/****************************** C E C S  3 6 1 ******************************
 * 
 * File Name:  top_module_tb.v
 *
 * Created by       Dong Jae Shin 11/14/2018
 * Copyright © 2018 Dong Jae Shin. All rights reserved.
 *
 * purpose: top_module test bench of the VGA project.
 *          this verilog module checks the requirments for the project
 *          using the self checking test bench
 *
 * In submitting this file for class work at CSULB
 * I am confirming that this is my work and the work
 * of no one else. In submitting this code I acknowledge that
 * plagiarism in student project work is subject to dismissal
 * from the class.
 *         
 ****************************************************************************/
module top_module_tb;

    // inputs to the DUT
    reg        clk,      reset;
    
    // outputs from the DUT
    wire       video_on, h_sync, v_sync;
    wire [2:0] rgb;
    
    //reg tick;
    
    // calls DUT
    top_module tm(.clk(clk), 
                  .reset(reset), 
                  .rgb(rgb), 
                  .h_sync(h_sync), 
                  .v_sync(v_sync),
                  .video_on(video_on)
                  );
                  
//   tick = tm.pg.tick;               
initial begin
   // start the test bench by setting the clock to 0
   clk = 0;
   // reset to 1
   reset = 1;
   
   #50 // wait for 50 ns
   reset = 0;

 end
 
 reg [1:0] clk_25;
 
 // creates 25Mhz clk pulse
 always @(posedge clk or posedge reset) begin
    if( reset ) clk_25 <= 2'b0;
    else begin
        if(clk_25 == 3) clk_25 <= 2'b0;
        else clk_25 = clk_25 + 2'b01;
    end
 end
 
 initial begin
    // start indicator
    $display("==============================start==============================");
    // loops forever
    forever begin
        #2 clk = !clk;
       
        // check for the clock pulse
        if(!(clk_25 == tm.vs.count))
           $display("Error: clk and counter does not match clk_25 = %d count = %d ", clk_25, tm.vs.count);
       
        /////////////////////////////////////////////
        // checks or requirements in the vga module//
        /////////////////////////////////////////////   
       
        // checks if h sync is off when it is supposed to be on
        if(!(tm.vs.h_count >= 656 && tm.vs.h_count <= 751))
           if(!h_sync) $display("Error: h_sync off x = %d h_sync = &d", tm.vs.h_count, h_sync);
           
        // checks if the h_sync is on when it is not supposed to be on
        else if (tm.vs.h_count >=656 && tm.vs.h_count <= 751)
            if(h_sync) $display("Error: h_sync on x = %d h_sync = &d", tm.vs.h_count, h_sync);
               
        // checks if v sync is off when it is supposed to be on
        if(!(tm.vs.v_count >= 490 && tm.vs.v_count <= 491))
            if(!v_sync) $display("Error: v_sync off x = %d y = %d v_sync = &d", tm.vs.h_count, tm.vs.v_count, v_sync);
         
        // checks if the h_sync is on when it is not supposed to be on
        else if (tm.vs.v_count >= 490 && tm.vs.v_count <= 491)
            if(v_sync) $display("Error: v_sync on x = %d y = %d v_sync = &d", tm.vs.h_count, tm.vs.v_count, v_sync);
        
        // video on is on when it is not supposed to be on
        if(!((tm.vs.v_count < 480) && (tm.vs.h_count < 640)))
            if(video_on) $display("Error: video_on on  x = %d y = %d",tm.vs.h_count, tm.vs.v_count);
        
        // video off is on when it is not supposed to be on
        if((tm.vs.v_count < 480) && (tm.vs.h_count < 640))
            if(!video_on) $display("Error: video_on off  x = %d y = %d",tm.vs.h_count, tm.vs.v_count);
            
        /////////////////////////////////////////////
        // checks or requirements in the vga module//
        /////////////////////////////////////////////
        
        // check if wall has right color
        if(32 <= tm.pg.pixel_x && tm.pg.pixel_x <= 35)
            if(rgb != tm.pg.wall_rgb)
                $display("Error: Wrong color wall on x = %d y = %d rgb = %d",tm.vs.h_count, tm.vs.v_count, rgb);
        
        // check if the bar has the right color
        else if(600 <= tm.pg.pixel_x && 
                tm.pg.pixel_x <= 603 && 
                480/2 - 72/2  <= tm.pg.pixel_y && 
                tm.pg.pixel_y <= 480/2 - 72/2 + 72 -1)
            if(rgb != tm.pg.bar_rgb) 
                $display("Error: Wrong color bar on x = %d y = %d rgb = %d",tm.vs.h_count, tm.vs.v_count, rgb);
        
        // check if the ball has the right color    
        else if((550 <= tm.pg.pixel_x) && 
                (tm.pg.pixel_x <= 550 + 8) &&
                (480/2 <= tm.pg.pixel_y) && 
                (tm.pg.pixel_y <= 480/2 + 8))
            if(rgb != tm.pg.ball_rgb)
                $display("Error: Wrong color ball on x = %d y = %d rgb = %d", tm.vs.h_count, tm.vs.v_count, rgb);
                
    end // end of forever
    
end // end of initial
    

endmodule
