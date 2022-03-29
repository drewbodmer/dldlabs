`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Majid Sabbagh (sabbagh.m@husky.neu.edu)
// 
// Create Date: 08/17/2014 02:18:36 PM
// Design Name: 
// Module Name: eightbit_alu_top
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
module pdatapath_top(
		input wire clk,				// General clock input
		input wire top_pb_clk,		// PBN1 clock input
        input wire rst_general,		// PBN0 clock reset for memory blocks
		output [7:0] led,			// add-on board led[5:0], + LD0, LD1
		output wire ovf_ctrl,    	// LD3 for overflow
		output [3:0] disp_en,		// 7-Segment display enable
		output [6:0] seg7_output	// 7-segment display output
    );
    
    wire [7:0] alu_input1, alu_input2;
    wire [7:0] alu_output;
    wire [2:0] ALUOp;
    wire       alu_ovf;
    wire       take_branch;
    
    wire [15:0] instruction;
    //insturction fields
    wire [3:0] opcode;
    wire [1:0] rs_addr;
    wire [1:0] rt_addr;
    wire [1:0] rd_addr;
    wire [7:0] immediate;
    //control signals
    wire RegDst;
    wire RegWrite;
    wire ALUSrc1;
    wire ALUSrc2;
    wire MemWrite;
    wire MemToReg;

    wire [1:0] regfile_WriteAddress; //destination register address
    wire [8:0] regfile_WriteData;	//result data
    wire [8:0] regfile_ReadData1;	//source register1 data
    wire [8:0] regfile_ReadData2;	//source register2 data

    wire [8:0] alu_result;
    wire [8:0] Data_Mem_Out;
	reg [7:0] zero_register = 0;	//ZERO constant

    wire pb_clk_debounced;

	assign alu_result = {alu_ovf, alu_output};
	
	// Assign LEDs
    assign led = alu_output;
	assign ovf_ctrl = alu_ovf;

    //Instantiate Your instruction decoder here
    
        
	//Instantiate Your alu-regfile here
    reg_file REG(rst_general, pb_clk_debounced, rs_addr, rt_addr, regfile_WriteAddress, regfile_WriteData, RegWrite, regfile_ReadData1, regfile_ReadData2);
    assign alu_input1 = ALUSrc1 ? 0 : regfile_ReadData1[7:0];
    assign alu_input2 = ALUSrc2 ? immediate : regfile_ReadData2[7:0];
    alu ALU(alu_input1, alu_input2, ALUOp, alu_output, alu_ovf, take_branch);
    

endmodule

//****************** End Top Module *********************************
