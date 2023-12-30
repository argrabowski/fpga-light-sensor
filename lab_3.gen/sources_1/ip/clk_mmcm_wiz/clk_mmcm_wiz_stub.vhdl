-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Sun Oct  2 19:34:55 2022
-- Host        : DESKTOP-0FOP0U3 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/Adam/Desktop/ECE 3829/Lab
--               3/lab_3/lab_3.gen/sources_1/ip/clk_mmcm_wiz/clk_mmcm_wiz_stub.vhdl}
-- Design      : clk_mmcm_wiz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_mmcm_wiz is
  Port ( 
    clk_10MHz : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_mmcm_wiz;

architecture stub of clk_mmcm_wiz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_10MHz,reset,locked,clk_in1";
begin
end;
