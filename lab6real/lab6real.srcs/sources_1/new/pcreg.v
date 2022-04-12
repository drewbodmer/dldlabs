`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2022 01:55:28 PM
// Design Name: 
// Module Name: pcreg
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


module pcreg(input pb_clk_debounced, input right_pb_rst_general, input[7:0] imm, input take_branch, output reg [7:0] pc);
    //reg[7:0] pcinternal;
    always @(posedge pb_clk_debounced, posedge right_pb_rst_general) begin
        if (right_pb_rst_general)
            pc = 8'b00000000;
        else if (take_branch)
            pc = pc + imm;
        else
            pc = pc + 1;
    end
    
endmodule
