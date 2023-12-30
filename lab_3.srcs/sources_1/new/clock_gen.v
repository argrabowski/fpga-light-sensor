`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Worcester Polytechnic Institute
// Engineer: 
//  Adam Grabowski
// Create Date: 10/02/2022 07:26:11 PM
// Design Name: ECE 3829 Lab 3
// Module Name: clock_gen
// Project Name: ECE 3829 Lab 3
// Target Devices: Basys 3 Artix-7 Development Board
// Tool Versions: Verilog 2021.1
// Description: 
//  Specifies the inputs and outputs of the clock generation module
// Dependencies: 
//  None
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//  None
//////////////////////////////////////////////////////////////////////////////////


module clock_gen(
    input clk_100MHz, // 100 MHz clock
    input reset, // active-high reset
    output clk_10MHz, // 10 MHz clock
    output reg reset_n // active-low reset
    );
    
    // Internal signals
    reg reset_n_d; // active-low reset delayed 1 clock cycle
    wire reset_n_dd; // active-low reset delayed 2 clock cycles
    
    // Instantiate MMCM clock module
    clk_mmcm_wiz clk_mmcm_wizi(
    .clk_in1(clk_100MHz),
    .reset(reset),
    .clk_10MHz(clk_10MHz),
    .locked(reset_n_dd));
    
    // 2 consecutive flip flops syncronize active-low reset
    always @ (posedge clk_100MHz) begin
        reset_n_d <= reset_n_dd;
        reset_n <= reset_n_d;
    end
    
endmodule
