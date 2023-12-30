// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Sun Oct  2 19:34:55 2022
// Host        : DESKTOP-0FOP0U3 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Adam/Desktop/ECE 3829/Lab
//               3/lab_3/lab_3.gen/sources_1/ip/clk_mmcm_wiz/clk_mmcm_wiz_stub.v}
// Design      : clk_mmcm_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_mmcm_wiz(clk_10MHz, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_10MHz,reset,locked,clk_in1" */;
  output clk_10MHz;
  input reset;
  output locked;
  input clk_in1;
endmodule
