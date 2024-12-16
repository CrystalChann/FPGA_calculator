`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 01:16:24
// Design Name: 
// Module Name: divider
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


module divider (
    input signed [9:0] num1,  
    input signed [9:0] num2,   
    input clk,
    output reg signed [9:0] quotient, // 10-bit signed quotient
    output reg signed [9:0] remainder // 10-bit signed remainder
);

    reg signed [19:0] temp_num1; // Temp num1 for processing (wider to hold shifts)
    reg signed [19:0] temp_num2;   // Temp num2 for processing
    reg signed [19:0] temp_quotient; 
    integer i;

    always @(posedge clk) begin
        // Init
        quotient = 0;
        remainder = 0;
        temp_num1 = num1;
        temp_num2 = num2;

        if (num2 == 0) begin
            quotient = 10'sd0;
            remainder = num1;
        end else begin
            // Start division process
            for (i = 19; i >= 0; i = i - 1) begin
                // Shift left the remainder and bring down the next bit
                remainder = {remainder[8:0], temp_num1[i]}; // Shift left and add next bit
                temp_quotient = {temp_quotient[8:0], 1'b0}; // Shift left the quotient

                if (remainder >= temp_num2) begin
                    remainder = remainder - temp_num2; // Subtract divisor from remainder
                    temp_quotient[0] = 1; // Set the least significant bit of the quotient
                end
            end

            quotient = temp_quotient[9:0];
        end
    end

endmodule