`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2022 01:02:57 PM
// Design Name: 
// Module Name: reg_file
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

module reg_file(
    input rst,
    input clk,
    input wr_en,
    input[1:0] rd0_addr,
    input[1:0] rd1_addr,
    input[1:0] wr_addr,
    input[8:0] wr_data,
    output reg[8:0] rd0_data,
    output reg[8:0] rd1_data
    );
    reg [8:0] file [3:0];
    integer i;
    always @(posedge rst, negedge clk) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1)
                file[wr_addr] <= 0;
        end else if (wr_en) begin
            file[wr_addr] <= wr_data;
        end
        rd0_data <= file[rd0_addr];
        rd1_data <= file[rd1_addr]; 
    end
        
endmodule
