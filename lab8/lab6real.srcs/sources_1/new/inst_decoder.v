`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2022 01:33:55 PM
// Design Name: 
// Module Name: inst_decoder
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


module inst_decoder(
    input [15:0] instruction,
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
    );
    
    reg padding;
        
    always @(*) begin
    
        opcode = instruction[15:12];
        rs_addr = instruction[11:10];
        rt_addr = instruction[9:8];
        rd_addr = instruction[7:6];
        immediate = instruction[7:0];
        //assign padding = instruction[5:0];
        
        case (opcode)
        // lw
        4'b0000: begin
            RegDst = 1'b0;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b000;
            MemWrite = 1'b0;
            MemToReg = 1'b1;
        end
        // sw
        4'b0001: begin
            RegDst = 1'b0;
            RegWrite = 1'b0;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b000;
            MemWrite = 1'b1;
            MemToReg = 1'b0;
        end
        // add
        4'b0010: begin
            RegDst = 1'b1;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b000;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // addi
        4'b0011: begin
            RegDst = 1'b0;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b000;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // inv
        4'b0100: begin
            RegDst = 1'b1;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b001;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // and
        4'b0101: begin
            RegDst = 1'b1;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b010;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // andi
        4'b0110: begin
            RegDst = 1'b0;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b010;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // or
        4'b0111: begin
            RegDst = 1'b1;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b011;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // ori
        4'b1000: begin
            RegDst = 1'b0;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b1;
            ALUOp = 3'b011;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // sra
        4'b1001: begin
            RegDst = 1'b0;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b100;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // sll
        4'b1010: begin
            RegDst = 1'b0;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b101;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // beq
        4'b1011: begin
            RegDst = 1'b0;
            RegWrite = 1'b0;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b110;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // bne
        4'b1100: begin
            RegDst = 1'b0;
            RegWrite = 1'b0;
            ALUSrc1 = 1'b0;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b111;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        // clr
        4'b1101: begin
            RegDst = 1'b1;
            RegWrite = 1'b1;
            ALUSrc1 = 1'b1;
            ALUSrc2 = 1'b0;
            ALUOp = 3'b010;
            MemWrite = 1'b0;
            MemToReg = 1'b0;
        end
        endcase
    
    end
endmodule

