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
    inst_decoder decoder(instruction, opcode, rs_addr, rt_addr, rd_addr, immediate, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, MemWrite, MemToReg);
        
	//Instantiate Your alu-regfile here
    reg_file REG(rst_general, pb_clk_debounced, rs_addr, rt_addr, regfile_WriteAddress, regfile_WriteData, RegWrite, regfile_ReadData1, regfile_ReadData2);
    assign alu_input1 = ALUSrc1 ? 0 : regfile_ReadData1[7:0];
    assign alu_input2 = ALUSrc2 ? immediate : regfile_ReadData2[7:0];
    alu ALU(alu_input1, alu_input2, ALUOp, alu_output, alu_ovf, take_branch);
    
    // DATA MEM
    dist_mem_gen_0 data_mem (
    .a(alu_output),      // input wire [7 : 0] a
    .d(regfile_ReadData2),      // input wire [8 : 0] d
    .clk(clk),  // input wire clk
    .we(MemWrite),    // input wire we
    .spo(Data_Mem_Out)  // output wire [8 : 0] spo
    );
    
    // VIO
    vio_0 VIO (
  .clk(clk),                  // input wire clk
  .probe_in0(regfile_WriteData),      // input wire [8 : 0] probe_in0
  .probe_in1(regfile_ReadData1),      // input wire [7 : 0] probe_in1
  .probe_in2(regfile_ReadData2),      // input wire [7 : 0] probe_in2
  .probe_in3(alu_input1),      // input wire [7 : 0] probe_in3
  .probe_in4(alu_input2),      // input wire [7 : 0] probe_in4
  .probe_in5(take_branch),      // input wire [0 : 0] probe_in5
  .probe_in6(alu_ovf),      // input wire [0 : 0] probe_in6
  .probe_in7(opcode),      // input wire [3 : 0] probe_in7
  .probe_in8(alu_output),      // input wire [7 : 0] probe_in8
  .probe_in9(Data_Mem_Out),      // input wire [8 : 0] probe_in9
  .probe_out0(RegWrite),    // output wire [0 : 0] probe_out0
  .probe_out1(RegDst),    // output wire [0 : 0] probe_out1
  .probe_out2(immediate),    // output wire [7 : 0] probe_out2
  .probe_out3(ALUSrc1),    // output wire [0 : 0] probe_out3
  .probe_out4(ALUSrc2),    // output wire [0 : 0] probe_out4
  .probe_out5(ALUOp),    // output wire [2 : 0] probe_out5
  .probe_out6(MemWrite),    // output wire [0 : 0] probe_out6
  .probe_out7(opcode),    // output wire [3 : 0] probe_out7
  .probe_out8(MemToReg),    // output wire [0 : 0] probe_out8
  .probe_out9(rs_addr),    // output wire [1 : 0] probe_out9
  .probe_out10(rt_addr),  // output wire [1 : 0] probe_out10
  .probe_out11(rd_addr)  // output wire [1 : 0] probe_out11
);
    

endmodule

//****************** End Top Module *********************************
