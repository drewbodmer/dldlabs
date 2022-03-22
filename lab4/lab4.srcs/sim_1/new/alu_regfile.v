`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2022 01:31:35 PM
// Design Name: 
// Module Name: alu_regfile
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
module alu_regfile(
    input rst,
    input clk,
    input wr_en,
    input[1:0] rd0_addr,
    input[1:0] rd1_addr,
    input[1:0] wr_addr,
    input[8:0] wr_data,
    input signed[7:0] instr_i,
    input ALUsrc1,
    input ALUsrc2,
    input[2:0] ALUop,
    output [8:0] rd0_data,
    output [8:0] rd1_data,
    output signed[7:0] result,
    output ovf,
    output take_branch
);
wire[7:0] input1;
wire[7:0] input2;

    reg_file rf(rst, clk, wr_en, rd0_addr, rd1_addr, wr_addr, wr_data, rd0_data, rd1_data);
    mux21 mux1(ALUsrc1, rd0_data[7:0], 8'b0, input1);
    mux21 m2(ALUsrc2, rd1_data[7:0], instr_i, input2);
    eightbit_palu alu(input1, input2, ALUop, result, ovf, take_branch);

endmodule
