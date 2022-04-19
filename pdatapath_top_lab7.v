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
	
	// ALU inteface
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

    wire [1:0] regfile_WriteAddress;//destination register address
    wire [8:0] regfile_WriteData;//result data
    wire [8:0] regfile_ReadData1;//source register1 data
    wire [8:0] regfile_ReadData2;//source register2 data

    wire [8:0] alu_result;
    wire [8:0] Data_Mem_Out;
	wire [7:0] zero_register;
	
	// PC and debouce clock
	wire [7:0] pc;
	wire pb_clk_debounced;

	assign zero_register = 8'b0;	//ZERO constant
	assign alu_result = {alu_ovf, alu_output};
	
	// Assign LEDs
    assign led = alu_output;
	assign ovf_ctrl = alu_ovf;

	// Debounce circuit
    debounce debounce_clk(
        .clk_in(clk),
        .rst_in(rst_general),
        .sig_in(top_pb_clk),
        .sig_debounced_out(pb_clk_debounced)
    );
	
	// 7-Segment display module
	Adaptor_display display(
		.clk(clk), 					// system clock
		.input_value(alu_output),	// 8-bit input [7:0] value to display
		.disp_en(disp_en),			// output [3:0] 7 segment display enable
		.seg7_output(seg7_output)	// output [6:0] 7 segment signals
	);
	
    //Instantiate Your PC Register here
    pcreg pc_register(pb_clk_debounced, rst_general, immediate, take_branch, pc);
    
	//Instantiate Your instruction Memory here
	instr_mem instruction_memory (
        .a(pc),      // input wire [7 : 0] a
        .spo(instruction)  // output wire [15 : 0] spo
        );
	
	//Instantiate Your instruction decoder here
    inst_decoder decoder(instruction, opcode, rs_addr, rt_addr, rd_addr, immediate, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, MemWrite, MemToReg);
	
	//Instantiate Your alu-regfile here
    reg_file REG(rst_general, pb_clk_debounced, rs_addr, rt_addr, regfile_WriteAddress, regfile_WriteData, RegWrite, regfile_ReadData1, regfile_ReadData2);
    assign alu_input1 = ALUSrc1 ? 0 : regfile_ReadData1[7:0];
    assign alu_input2 = ALUSrc2 ? immediate : regfile_ReadData2[7:0];
    alu ALU(alu_input1, alu_input2, ALUOp, alu_output, alu_ovf, take_branch);
    
 	//Instantiate Your data memory here
    dist_mem_gen_0 data_mem (
    .a(alu_output),      // input wire [7 : 0] a
    .d(regfile_ReadData2),      // input wire [8 : 0] d
    .clk(pb_clk_debounced),  // input wire clk
    .we(MemWrite),    // input wire we
    .spo(Data_Mem_Out)  // output wire [8 : 0] spo
    );

    //Mux for regfile_writedata
	assign regfile_WriteData = MemToReg ? Data_Mem_Out : alu_output;
	
	//Mux for RegDST
    assign regfile_WriteAddress = RegDst ? rd_addr : rt_addr;
    
	//Instantiate Your VIO core here
vio_0 your_instance_name (
  .clk(clk),                // input wire clk
  .probe_in0(alu_output),    // input wire [7 : 0] probe_in0
  .probe_in1(alu_ovf),    // input wire [0 : 0] probe_in1
  .probe_in2(take_branch),    // input wire [0 : 0] probe_in2
  .probe_in3(regfile_ReadData1),    // input wire [7 : 0] probe_in3
  .probe_in4(regfile_ReadData2),    // input wire [7 : 0] probe_in4
  .probe_in5(alu_input1),    // input wire [7 : 0] probe_in5
  .probe_in6(alu_input2),    // input wire [7 : 0] probe_in6
  .probe_in7(regfile_WriteData),    // input wire [8 : 0] probe_in7
  .probe_in8(Data_Mem_Out),    // input wire [8 : 0] probe_in8
  .probe_in9(opcode),    // input wire [3 : 0] probe_in9
  .probe_in10(rs_addr),  // input wire [1 : 0] probe_in10
  .probe_in11(rt_addr),  // input wire [1 : 0] probe_in11
  .probe_in12(rd_addr),  // input wire [1 : 0] probe_in12
  .probe_in13(immediate),  // input wire [7 : 0] probe_in13
  .probe_in14(RegDst),  // input wire [0 : 0] probe_in14
  .probe_in15(RegWrite),  // input wire [0 : 0] probe_in15
  .probe_in16(ALUSrc1),  // input wire [0 : 0] probe_in16
  .probe_in17(ALUSrc2),  // input wire [0 : 0] probe_in17
  .probe_in18(ALUOp),  // input wire [2 : 0] probe_in18
  .probe_in19(MemWrite),  // input wire [0 : 0] probe_in19
  .probe_in20(MemToReg),  // input wire [0 : 0] probe_in20
  .probe_in21(pc),  // input wire [7 : 0] probe_in21
  .probe_in22(instruction)  // input wire [15 : 0] probe_in22
);
	
	
endmodule