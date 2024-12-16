`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 01:57:43
// Design Name: 
// Module Name: cosine
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


module cosine(
    input signed [9:0] angle, // In degree for now
    input clk,
    output reg signed [9:0] cosine 
);

    reg signed [19:0] x; 
    reg signed [19:0] term;
    reg signed [19:0] x_squared = 0;
    reg signed [19:0] factorial = 1;
    
    integer i;
    integer j;
    integer k;
    
    // pi (scaled by 10^8) (not very sure)
    localparam PI = 314159265; // Represents pi in fixed-point format

    always @(posedge clk) begin
        // Init
        cosine = 0;
        x = angle; 
        
        if (x > 360) begin
           x = x % 360; 
        end
        
        x = (angle * PI) / 180; // Convert degrees to radians

        // Taylor series
        term = 1;
        cosine = cosine + term;

        // Calculate the cosine series terms
        for (i = 1; i < 5; i = i + 1) begin
            // term = -term * (x^2) / ((2*i) * (2*i - 1))
            //  x^2 using repeated addition
                x_squared = x * x; // x * x

            // factorial (2*i)!
            for (k = 1; k <= 2 * i + 1; k = k + 1) begin
                factorial = factorial * k;
            end

            term = -term * x_squared / factorial; // Simulate the sine term
            cosine = cosine + term;
        end
    end
endmodule
