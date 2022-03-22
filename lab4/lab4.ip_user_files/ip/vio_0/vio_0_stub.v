// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Tue Mar  1 13:51:16 2022
// Host        : WFXA4BB6DB89955 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub c:/Users/bodmer.d/lab4/lab4.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2020.1" *)
module vio_0(clk, probe_in0, probe_in1, probe_in2, probe_in3, 
  probe_in4, probe_in5, probe_in6, probe_out0, probe_out1, probe_out2, probe_out3, probe_out4, 
  probe_out5, probe_out6, probe_out7, probe_out8)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[7:0],probe_in1[0:0],probe_in2[0:0],probe_in3[8:0],probe_in4[8:0],probe_in5[7:0],probe_in6[7:0],probe_out0[7:0],probe_out1[2:0],probe_out2[0:0],probe_out3[0:0],probe_out4[0:0],probe_out5[1:0],probe_out6[1:0],probe_out7[1:0],probe_out8[8:0]" */;
  input clk;
  input [7:0]probe_in0;
  input [0:0]probe_in1;
  input [0:0]probe_in2;
  input [8:0]probe_in3;
  input [8:0]probe_in4;
  input [7:0]probe_in5;
  input [7:0]probe_in6;
  output [7:0]probe_out0;
  output [2:0]probe_out1;
  output [0:0]probe_out2;
  output [0:0]probe_out3;
  output [0:0]probe_out4;
  output [1:0]probe_out5;
  output [1:0]probe_out6;
  output [1:0]probe_out7;
  output [8:0]probe_out8;
endmodule
