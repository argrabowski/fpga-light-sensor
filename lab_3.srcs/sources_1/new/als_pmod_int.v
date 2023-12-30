`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Worcester Polytechnic Institute
// Engineer: 
//  Adam Grabowski
// Create Date: 10/02/2022 07:28:26 PM
// Design Name: ECE 3829 Lab 3
// Module Name: als_pmod_int
// Project Name: ECE 3829 Lab 3
// Target Devices: Basys 3 Artix-7 Development Board
// Tool Versions: Verilog 2021.1
// Description: 
//  Specifies the inputs and outputs of the ALS PMOD interface and control module
// Dependencies: 
//  None
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//  None
//////////////////////////////////////////////////////////////////////////////////


module als_pmod_int
    #(parameter SAMPLE_RATE = 10000000)( // 1 sec sample rate
    input clk, // 10 MHz clock
    input reset_n, // active-low reset
    input sdo, // ALS PMOD sdo
    output reg sclk, // ALS PMOD sclk
    output cs_n, // ALS PMOD cs_n
    output reg [7:0] value // display value
    );
    
    // Parameters
    localparam TERM_COUNT_SCLK = 4'd9; // sclk terminal count
    localparam RISE_EDGE = 4'd0; // rising edge set count
    localparam FALL_EDGE = 4'd5; // falling edge set count
    localparam TERM_COUNT_CS = 5'd19; // cs_n terminal count
    localparam LOW_COUNT_CS = 5'd15; // cs_n set low count
    localparam S_IDLE = 2'b00; // idle state encoding
    localparam S_WAIT = 2'b01; // wait state encoding
    localparam S_READ = 2'b10; // read state encoding
    localparam S_DONE = 2'b11; // done state encoding
    
    // Internal signals
    reg [31:0] count_1sec; // 1 sec count
    reg [3:0] count_sclk; // sclk count
    wire rising_edge; // rising edge enable
    wire falling_edge; // falling edge enable
    reg [4:0] count_cs; // chip select count
    reg [1:0] current_state = S_IDLE; // current state
    reg [7:0] data; // read data
    
    // 1 sec sample rate counter
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            count_1sec <= 32'd0;
        end else begin
            if (current_state == S_IDLE) begin
                count_1sec <= 32'd0;
            end else begin
                count_1sec <= count_1sec + 32'd1;
            end
        end
    end
    
    // Rising and falling edge enable assigns
    assign rising_edge = {count_sclk == RISE_EDGE} ? 1'b1 : 1'b0;
    assign falling_edge = {count_sclk == FALL_EDGE} ? 1'b1 : 1'b0;
    
    // 4-bit sclk counter
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            count_sclk <= 4'd0;
        end else begin
            if (count_sclk == TERM_COUNT_SCLK) begin
                count_sclk <= 4'd0;
            end else begin
                count_sclk <= count_sclk + 4'd1;
            end
        end
    end
    
    // Set sclk on rising and falling edges
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            sclk <= 1'b0;
        end else begin
            if (rising_edge == 1'b1) begin
                sclk <= 1'b1;
            end else if (falling_edge == 1'b1) begin
                sclk <= 1'b0;
            end
        end
    end
    
    // Active-low chip select assign
    assign cs_n = (count_cs > LOW_COUNT_CS) ? 1'b1 : 1'b0;
    
    // 5-bit chip select counter
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            count_cs <= 5'd0;
        end else begin
            if (falling_edge == 1'b1) begin
                if (count_cs == TERM_COUNT_CS) begin
                    count_cs <= 5'd0;
                end else begin
                    count_cs <= count_cs + 5'd1;
                end
            end
        end
    end
    
    // Read data on rising edge when chip select low
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            data <= 8'd0;
        end else begin
            if (cs_n == 1'b0 && rising_edge == 1'b1 && count_cs > 5'd3 && count_cs < 5'd12) begin
                data[7:0] <= {data[6:0], sdo};
            end
        end
    end
    
    // State machine with 4 states: idle, wait, read, and done
    always @ (posedge clk) begin
        if (reset_n == 1'b0) begin
            current_state <= S_IDLE;
        end else begin
            if (falling_edge == 1'b1) begin
                case (current_state[1:0])
                    S_IDLE: begin
                        current_state <= S_WAIT;
                    end S_WAIT: begin
                        if (count_1sec >= SAMPLE_RATE && count_cs == TERM_COUNT_CS) begin
                            current_state <= S_READ;
                        end
                    end S_READ: begin
                        if (count_cs == LOW_COUNT_CS) begin
                            current_state <= S_DONE;
                        end
                    end S_DONE: begin
                        value[7:0] <= data[7:0];
                        current_state <= S_IDLE;
                    end
                endcase
            end
        end
    end
    
endmodule
