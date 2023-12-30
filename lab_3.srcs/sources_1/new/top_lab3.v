`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Worcester Polytechnic Institute
// Engineer: 
//  Adam Grabowski
// Create Date: 10/02/2022 07:24:45 PM
// Design Name: ECE 3829 Lab 3
// Module Name: top_lab3
// Project Name: ECE 3829 Lab 3
// Target Devices: Basys 3 Artix-7 Development Board
// Tool Versions: Verilog 2021.1
// Description: 
//  Specifies the inputs and outputs of the top module
// Dependencies: 
//  None
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//  None
//////////////////////////////////////////////////////////////////////////////////


module top_lab3(
    input clk, // 100 MHz clock
    input btnC, // active-high reset
    input JA3, // ALS sdo pin
    output JA1, // ALS cs_n pin
    output JA4, // ALS sclk pin
    output [6:0] seg, // seven segment value
    output [3:0] an // display anodes
    );
    
    // Parameters
    parameter [3:0] wpi_id_a = 4'b1000; // display A value
    parameter [3:0] wpi_id_b = 4'b0110; // display B value
    
    // Internal signals
    wire clk_10MHz; // 10 MHz clock
    wire reset_n; // active-low reset
    wire [7:0] sensor_val; // sensor value
    
    // Instantiate clock generation module
    clock_gen clock_geni(
    .clk_100MHz(clk),
    .reset(btnC),
    .clk_10MHz(clk_10MHz),
    .reset_n(reset_n));
    
    // Instantiate ALS PMOD interface and control module
    als_pmod_int als_pmod_inti(
    .clk(clk_10MHz),
    .reset_n(reset_n),
    .sdo(JA3),
    .sclk(JA4),
    .cs_n(JA1),
    .value(sensor_val));
    
    // Instantiate seven segment display module
    seven_seg seven_segi(
    .clk(clk_10MHz),
    .reset_n(reset_n),
    .a(wpi_id_a),
    .b(wpi_id_b),
    .c(sensor_val[7:4]),
    .d(sensor_val[3:0]),
    .seg(seg),
    .an(an));
    
endmodule
