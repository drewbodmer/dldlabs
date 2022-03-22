`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2022 01:27:27 PM
// Design Name: 
// Module Name: alu_regfile_tb
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


module alu_regfile_tb;
    reg rst;
    reg clk;
    reg wr_en;
    reg[1:0] rd0_addr;
    reg[1:0] rd1_addr;
    reg[1:0] wr_addr;
    reg[8:0] wr_data;
    reg signed[7:0] instr_i;
    reg ALUsrc1;
    reg ALUsrc2;
    reg[2:0] ALUop;
    wire [8:0] rd0_data;
    wire [8:0] rd1_data;
    wire signed[7:0] result;
    wire ovf;
    wire take_branch;

    alu_regfile aluregf(rst, clk, wr_en, rd0_addr, rd1_addr, wr_addr, wr_data, instr_i, ALUsrc1, ALUsrc2, ALUop, rd0_data, rd1_data, result, ovf, take_branch);
    
    initial begin
        rst <= 1;
        #5 rst <= 0;
    end
    
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end
    
    
        
    initial begin
    wr_en = 0;
    rd0_addr = 0;
    rd1_addr = 0;
    wr_addr = 0;
    wr_data = 0;
    instr_i = 0;
    ALUsrc1 = 0;
    ALUsrc2 = 0;
    ALUop = 0;
    $monitor("time: %d rst=%b clk=%b, wr_en=%b rd0_addr=%b rd1_addr=%b wr_addr=%b wr_data=%d instr_i=%d ALUsrc1=%b ALUsrc2=%b ALUop=%b rd0_data=%d rd1_data=%d result=%d ovf=%b branch=%b", $time, rst, clk, wr_en, rd0_addr, rd1_addr, wr_addr, wr_data, instr_i, ALUsrc1, ALUsrc2, ALUop, rd0_data, rd1_data, result, ovf, take_branch);
    // writing and reading from regfile
    #10 wr_en = 1; wr_addr = 0; rd1_addr = 1;
    #10 wr_en = 1; wr_addr = 0; wr_data = 8'b00011011; // write to 0
    #10 wr_addr = 1; wr_data = 1; // write to 1
    #10 wr_en = 0; 
    
    // mux configurations
    #10 ALUsrc1 = 1; // add 0 to 0
    #10 ALUsrc1 = 0; instr_i = 1; 
    #10 ALUsrc2 = 1; // add 1 to the saved number
    #10 ALUsrc2 = 0; instr_i = 0; wr_en = 1; wr_addr = 1; wr_data = 4;
    #10 wr_addr = 0; wr_data = 4;
    #10 wr_en = 0; ALUop = 1;
    // ALU outputs
    #5 instr_i = 123; ALUsrc2 = 1; ALUop = 0;
    #5 instr_i = 126; 
    #5 instr_i = 4; ALUop = 6;
    #10 $finish;
    end
endmodule
