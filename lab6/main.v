`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2022 05:59:37 PM
// Design Name: 
// Module Name: main
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


module reg_file(rst, clk, ReadAddr1, ReadAddr2, WriteAddr, WriteData, RegWrite, ReadData1, ReadData2);
    input rst, clk, RegWrite;
    input [1:0] ReadAddr1, ReadAddr2, WriteAddr;
    input [8:0] WriteData;
    output [8:0] ReadData1, ReadData2;
    
    reg [8:0] REG_FILE[0:3]; 
    
    assign ReadData1 = REG_FILE[ReadAddr1];
    assign ReadData2 = REG_FILE[ReadAddr2];
    
    always@(posedge clk)
        begin
            if(rst) begin
                REG_FILE[0] <= 0;
                REG_FILE[1] <= 0;
                REG_FILE[2] <= 0;
                REG_FILE[3] <= 0;
            end
            else if(RegWrite) begin
                REG_FILE[WriteAddr] <= WriteData;
            end
        end

endmodule

/////////////////////////////////////////////////////
module alu(input1, input2, op, alu_out, ovf, take_branch);
    input [7:0] input1, input2;
    input [2:0] op;
    output reg [7:0] alu_out;
    output reg ovf, take_branch;
    
    wire [7:0] sum;
    assign sum = input1 + input2;
    
    always@(*) begin 
        case(op)
            0:      begin alu_out <= sum; ovf <= (~input1[7]&~input2[7]&sum[7])|(input1[7]&input2[7]&~sum[7]); take_branch <= 0; end
            1:      begin alu_out <= ~input2; ovf <= 0; take_branch <= 0; end
            2:      begin alu_out <= input1 & input2; ovf <= 0; take_branch <= 0; end
            3:      begin alu_out <= input1 | input2; ovf <= 0; take_branch <= 0; end
            4:      begin alu_out <= {input1[7], input1[7:1]}; ovf <= 0; take_branch <= 0; end
            5:      begin alu_out <= input1 << input2; ovf <= 0; take_branch <= 0; end
            6:      begin alu_out <= 0; ovf <= 0; take_branch <= (input1 == input2); end
            7:      begin alu_out <= 0; ovf <= 0; take_branch <= (input1 != input2); end
            default:begin alu_out <= 0; ovf <= 0; take_branch <= 0; end   
        endcase
    
    end

endmodule