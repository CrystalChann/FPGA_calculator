`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.12.2024 23:54:11
// Design Name: 
// Module Name: main_cal
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


module main_cal(
    input clk,
    input [15:0] keycode,     // Input from keyboard
    output reg [31:0] result // Result output
    );
    
    // States
    localparam S1 = 3'd0;  // Check num1 sign
    localparam S2 = 3'd1;  // Input num1
    localparam S3 = 3'd2;  // Choose operator
    localparam S4 = 3'd3;  // Check num2 sign
    localparam S5 = 3'd4;  // Input num2
    localparam CALC = 3'd5; // Calculate result

    reg [2:0] state = S1;
    reg [9:0] num1 = 0;
    reg [9:0] num2 = 0;
    reg num1_negative = 0;
    reg num2_negative = 0;
    reg [7:0] operator = 0;
    reg [3:0] digit_count = 0;
    
    reg signed [9:0] signed_num1;
    reg signed [9:0] signed_num2;

    // Getting the number of 0-9 from the keycode of keyboard
    function [7:0] get_number;
        input [15:0] keycode;
        begin
            case(keycode)
                16'h16: get_number = 8'd1;
                16'h1E: get_number = 8'd2;
                16'h26: get_number = 8'd3;
                16'h25: get_number = 8'd4;
                16'h2E: get_number = 8'd5;
                16'h36: get_number = 8'd6;
                16'h3D: get_number = 8'd7;
                16'h3E: get_number = 8'd8;
                16'h46: get_number = 8'd9;
                16'h45: get_number = 8'd0;
                default: get_number = 8'hFF;
            endcase
        end
    endfunction

    // Check if keycode is a *valid number*
    function is_number;
        input [15:0] keycode;
        begin
            is_number = (keycode == 16'h16 || keycode == 16'h1E || 
                        keycode == 16'h26 || keycode == 16'h25 || 
                        keycode == 16'h2E || keycode == 16'h36 || 
                        keycode == 16'h3D || keycode == 16'h3E || 
                        keycode == 16'h46 || keycode == 16'h45);
        end
    endfunction

    // Check if keycode is a *valid operator*
    // Waiting to re-direct the operation after implementing the algorithm of operators
    function is_operator;
        input [15:0] keycode;
        begin
            is_operator = (keycode == 16'h1C || keycode == 16'h4E || 
                          keycode == 16'h3A || keycode == 16'h4A || 
                          keycode == 16'h2D || keycode == 16'h21 || 
                          keycode == 16'h1B || keycode == 16'h2C || 
                          keycode == 16'h4B || keycode == 16'h24 || keycode == 16'h4D);
        end
    endfunction
    
    function single_input;
        input [15:0] keycode;
        begin
            single_input = (keycode == 16'h2D || keycode == 16'h21 || 
                          keycode == 16'h1B || keycode == 16'h2C || 
                          keycode == 16'h4B || keycode == 16'h24);
        end
    endfunction

    // Main state machine
    always @(posedge clk) begin
            case (state)
                S1: begin // Check num1 sign
                    if (keycode == 16'h5A) begin // Enter key = num1 positive
                        num1_negative <= 0;
                        state <= S2;
                        digit_count <= 0;
                    end
                    else if (keycode == 16'h4E) begin // Minus key = num1 negative
                        num1_negative <= 1;
                        state <= S2;
                        digit_count <= 0;
                    end
                end

                S2: begin // Input num1
                    if (is_number(keycode) && digit_count < 3) begin
                        num1 <= (num1 * 10) + get_number(keycode); // num1 *10 for higher digit input
                        digit_count <= digit_count + 1;
                        if (digit_count == 2)
                            state <= S3;
                    end
                    else if (keycode == 16'h5A) // Enter key = end entering, for single digit or double digit
                        state <= S3;
                end

                S3: begin // Choose operator
                    if (is_operator(keycode)) begin
                        operator <= keycode; // assign operators
                        if (single_input(keycode)) begin
                            state <= CALC;
                        end
                        else begin
                            state <= S4;
                        end
                    end
                end

                S4: begin // Check num2 sign
                    if (keycode == 16'h5A) begin // Enter key = num2 positive
                        num2_negative <= 0;
                        state <= S5;
                        digit_count <= 0;
                        num2 <= 0;
                    end
                    else if (keycode == 16'h4E) begin // - key = num2 negative
                        num2_negative <= 1;
                        state <= S5;
                        digit_count <= 0;
                        num2 <= 0;
                    end
                end

                S5: begin // Input num2
                    if (is_number(keycode) && digit_count < 3) begin
                        num2 <= (num2 * 10) + get_number(keycode);
                        digit_count <= digit_count + 1;
                        if (digit_count == 2)
                            state <= CALC;
                    end
                    else if (keycode == 16'h5A) // Enter key
                        state <= CALC;
                end

                CALC: begin
                    // Assign the number with the signed part
                    signed_num1 = num1_negative ? -num1 : num1;
                    signed_num2 = num2_negative ? -num2 : num2;
                    
                    case (operator)
                        16'h1C: result <= signed_num1 + signed_num2; //  Addition
                        16'h4E: result <= signed_num1 - signed_num2; // Subtraction 
                    endcase
                    
                    // Show result with 7 segement LED
                    // Reset state machine after finish calculation
                    state <= S1;
                    num1 <= 0;
                    num2 <= 0;
                    num1_negative <= 0;
                    num2_negative <= 0;
                    operator <= 0;
                    digit_count <= 0;
                end
            endcase
    end

endmodule
