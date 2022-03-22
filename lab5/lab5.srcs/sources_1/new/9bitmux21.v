`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 03:09:55 PM
// Design Name: 
// Module Name: 9bitmux21
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


module bitmux21(input c0, input[8:0] a, input[8:0] b, output[8:0] y); 
 assign y = c0 ? b : a; 
endmodule
