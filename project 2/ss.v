/************************************************
 * File Name: hex_to_7seg.v
 * Project: Lab08 
 * Designer: Steven Cagle (014055026)
 * Email: Steven.Cagle@csulb.student.edu
 * Rev. Date:  May 7, 2018
 *
 *
 * Purpose: 
 *      This module inputs a hexidecimal digit over a 4-bit input
 *      wire, since storing a hex digit requires 4-bits (2^4=16),
 *      and outputs a binary number in which every bit represents
 *      a cathode (pixel) on a 7-segment display.
 *
 * Notes: 
 ************************************************/
`timescale 1ns / 1ps
module hex_to_7seg(hex, cathodes);
    input      [3:0] hex;      // Binary form of hex digit
    output reg [6:0] cathodes; // 7-segment pixels to turn on/off

    always @(*)
	 begin
        case (hex)
            4'b0000: cathodes = 7'b000_0001; // 0000 -> 0
            4'b0001: cathodes = 7'b100_1111; // 0001 -> 1
            4'b0010: cathodes = 7'b001_0010; // 0010 -> 2
            4'b0011: cathodes = 7'b000_0110; // 0011 -> 3
            4'b0100: cathodes = 7'b100_1100; // 0000 -> 4
            4'b0101: cathodes = 7'b010_0100; // 0101 -> 5
            4'b0110: cathodes = 7'b010_0000; // 0110 -> 6
            4'b0111: cathodes = 7'b000_1111; // 0111 -> 7
            4'b1000: cathodes = 7'b000_0000; // 0100 -> 8
            4'b1001: cathodes = 7'b000_0100; // 0101 -> 9
                                                      
		    4'b1010: cathodes = 7'b000_1000; // 1010 -> A
            4'b1011: cathodes = 7'b110_0000; // 1011 -> B
            4'b1100: cathodes = 7'b011_0001; // 1100 -> C
            4'b1101: cathodes = 7'b100_0010; // 1101 -> D
            4'b1110: cathodes = 7'b011_0000; // 1110 -> E
            4'b1111: cathodes = 7'b011_1000; // 1111 -> F

            default: cathodes = 7'b000_0001; // default
        endcase
    end
endmodule
