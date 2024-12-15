`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 01:28:06
// Design Name: 
// Module Name: powering
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


module powering_function (
    input signed [9:0] num1,
    input signed [9:0] num2,
    output reg signed [19:0] result
);

    reg signed [19:0] temp_result; // Temporary result for multiplication
    reg signed [19:0] current_base; // Current base value
    reg signed [19:0] temp_num1;

    always @(*) begin
        // Initialize result
        result = 0;
        temp_result = 1;
        current_base = num1;
        temp_num1 = 0;

        if (num2 == 0) begin
            result = 1; // x^0 = 1
        end else if (num1 == 0) begin
            result = 0; // 0^x  = 0
        end else begin
                for (integer i = 0; i < num2; i = i + 1) begin
                    temp_result = 0; // Reset temp_result for each multiplication
                    for (integer j = 0; j < current_base; j = j + 1) begin
                        temp_result = temp_result + num1; // Add base to itself
                    end
                    temp_num1 = temp_result; // Update base to the result of multiplication
                end
                result = temp_num1; // Final result
        end
    end

endmodule
