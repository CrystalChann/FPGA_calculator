`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 01:10:52
// Design Name: 
// Module Name: multiplier
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

module multiplier (
    input signed [9:0] num1,
    input signed [9:0] num2,
    output reg signed [19:0] product
);

    integer i;

    always @(*) begin
        product = 0;
        for (i = 0; i < 4; i = i + 1) begin
            if (num2[i]) begin
                product = product + (num1 << i); 
            end
        end
    end

endmodule
