`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2022 02:44:41 PM
// Design Name: 
// Module Name: inst_decoder_tb
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


module inst_decoder_tb;
    wire [15:0] instruction,
    output reg [3:0] opcode,
    output reg [1:0] rs_addr,
    output reg [1:0] rt_addr,
    output reg [1:0] rd_addr,
    output reg [7:0] immediate,
    //control signals
    output reg RegDst,
    output reg RegWrite,
    output reg ALUSrc1,
    output reg ALUSrc2,
    output reg [2:0] ALUOp,
    output reg MemWrite,
    output reg MemToReg
endmodule
