`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2022 01:05:31 PM
// Design Name: 
// Module Name: pdatapath_tb
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


module pdatapath_tb;
    reg [15:0] instruction;
    wire [3:0] opcode;
    wire [1:0] rs_addr, rt_addr, rd_addr;
    wire [7:0] immediate;
    wire [2:0] ALUOp;
    wire RegDst, RegWrite, ALUSrc1, ALUSrc2, MemWrite, MemToReg;
    
    inst_decoder decoder(instruction, opcode, rs_addr, rt_addr, rd_addr, immediate, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, MemWrite, MemToReg);
    
    initial begin
        instruction = {4'b1101, {12{1'b0}}};
        #5 instruction = {16{1'b0}};
    end
    
    initial begin
        $monitor("%d instruction=%b opcode=%b RegDst=%b RegWrite=%b ALUSrc1=%b ALUSrc2=%b ALUOp=%b MemWrite=%b MemToReg=%b", 
        $time, instruction, opcode, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, MemWrite, MemToReg);
        #10 instruction = {4'b0000, {12{1'b0}}};
        #10 instruction = {4'b0001, {12{1'b0}}};
        #10 instruction = {4'b0010, {12{1'b0}}};
        #10 instruction = {4'b0011, {12{1'b0}}};
        #10 instruction = {4'b0100, {12{1'b0}}};
        #10 instruction = {4'b0101, {12{1'b0}}};
        #10 instruction = {4'b0110, {12{1'b0}}};
        #10 instruction = {4'b0111, {12{1'b0}}};
        #10 instruction = {4'b1000, {12{1'b0}}};
        #10 instruction = {4'b1001, {12{1'b0}}};
        #10 instruction = {4'b1010, {12{1'b0}}};
        #10 instruction = {4'b1011, {12{1'b0}}};
        #10 instruction = {4'b1100, {12{1'b0}}};
        #10 instruction = {4'b1101, {12{1'b0}}};
        #10 $finish;
    end
endmodule
