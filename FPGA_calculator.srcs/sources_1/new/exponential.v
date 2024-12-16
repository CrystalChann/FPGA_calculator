`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 12:29:45
// Design Name: 
// Module Name: exponential
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


module exponential(
    input signed [9:0] num1,
    input clk,
    output reg signed [19:0] expo_result
    );
    
localparam E_FIXED = 271828; // e * 10^5

powering_function power(
    .num1 (E_FIXED),
    .num2 (num1),
    .clk (clk),
    .result (result)
    );    
    
     always @(posedge clk) begin
        if (num1 == 0) begin
            expo_result = 10000;
        end
        else begin
            expo_result = result; 
        end
    end

endmodule
