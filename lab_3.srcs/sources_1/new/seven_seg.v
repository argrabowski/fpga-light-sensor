`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Worcester Polytechnic Institute
// Engineer: 
//  Adam Grabowski
// Create Date: 10/02/2022 07:28:57 PM
// Design Name: ECE 3829 Lab 3
// Module Name: seven_seg
// Project Name: ECE 3829 Lab 3
// Target Devices: Basys 3 Artix-7 Development Board
// Tool Versions: Verilog 2021.1
// Description: 
//  Specifies the inputs and outputs of the seven segment display module
// Dependencies: 
//  None
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//  None
//////////////////////////////////////////////////////////////////////////////////


module seven_seg(
    input clk, // 10 MHz clock
    input reset_n, // active-low reset
    input [3:0] a, // display A value
    input [3:0] b, // display B value
    input [3:0] c, // display C value
    input [3:0] d, // display D value
    output reg [6:0] seg, // seven segment value
    output reg [3:0] an // display anodes
    );
    
    // Parameters
    parameter TERM_COUNT = 8'd255; // display update terminal count
    parameter ZERO = 7'b0000001; // seven segment 0 encoding
    parameter ONE = 7'b1001111; // seven segment 1 encoding
    parameter TWO = 7'b0010010; // seven segment 2 encoding
    parameter THREE = 7'b0000110; // seven segment 3 encoding
    parameter FOUR = 7'b1001100; // seven segment 4 encoding
    parameter FIVE = 7'b0100100; // seven segment 5 encoding
    parameter SIX = 7'b0100000; // seven segment 6 encoding
    parameter SEVEN = 7'b0001111; // seven segment 7 encoding
    parameter EIGHT = 7'b0000000; // seven segment 8 encoding
    parameter NINE = 7'b0000100; // seven segment 9 encoding
    parameter TEN = 7'b0001000; // seven segment 10 encoding
    parameter ELEVEN = 7'b1100000; // seven segment 11 encoding
    parameter TWELVE = 7'b0110001; // seven segment 12 encoding
    parameter THIRTEEN = 7'b1000010; // seven segment 13 encoding
    parameter FOURTEEN = 7'b0110000; // seven segment 14 encoding
    parameter FIFTEEN = 7'b0111000; // seven segment 15 encoding
    
    // Internal signals
    reg [7:0] count; // display update count
    reg [2:0] dis; // selected display
    reg [3:0] sv; // selected value
    wire update_en; // update enable
    
    // Enable display update
    assign update_en = (count == TERM_COUNT) ? 1'b1 : 1'b0;
    
    // 8-bit display update counter
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            count <= 8'd0;
        end else begin
            if (count == TERM_COUNT) begin
                count <= 8'd0;
            end else begin
                count <= count + 8'd1;
            end
        end
    end
    
    // Change display if update enabled
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            dis <= 3'b000;
        end else begin
            if (update_en == 1'b1) begin
                case (dis[2:0])
                    3'b100: dis <= 3'b101;
                    3'b101: dis <= 3'b110;
                    3'b110: dis <= 3'b111;
                    3'b111: dis <= 3'b100;
                    default: dis <= 3'b100;
                endcase
            end
        end
    end
    
    // Mux to select value and update display anodes
    always @ (*) begin
        if (reset_n == 1'b0) begin
            sv = 4'b0000;
            an = 4'b1111;
        end else begin
            case (dis[2:0])
                3'b100: begin
                    sv = a;
                    an = 4'b0111;
                end 3'b101: begin
                    sv = b;
                    an = 4'b1011;
                end 3'b110: begin
                    sv = c;
                    an = 4'b1101;
                end 3'b111: begin
                    sv = d;
                    an = 4'b1110;
                end default: begin
                    sv = 4'b0000;
                    an = 4'b1111;
                end
            endcase
        end
    end
    
    // Decoder to convert selected value to seven segment value
    always @ (*) begin
        if (reset_n == 1'b0) begin
            seg = ZERO;
        end else begin
            case (sv[3:0])
                4'b0000: seg = ZERO;
                4'b0001: seg = ONE;
                4'b0010: seg = TWO;
                4'b0011: seg = THREE;
                4'b0100: seg = FOUR;
                4'b0101: seg = FIVE;
                4'b0110: seg = SIX;
                4'b0111: seg = SEVEN;
                4'b1000: seg = EIGHT;
                4'b1001: seg = NINE;
                4'b1010: seg = TEN;
                4'b1011: seg = ELEVEN;
                4'b1100: seg = TWELVE;
                4'b1101: seg = THIRTEEN;
                4'b1110: seg = FOURTEEN;
                4'b1111: seg = FIFTEEN;
            endcase
        end
    end
    
endmodule
