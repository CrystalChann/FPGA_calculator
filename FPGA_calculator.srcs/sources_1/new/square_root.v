`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 14:49:00
// Design Name: 
// Module Name: square_root
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


module square_root(
    input wire [9:0] num1,     // Input number (0 to 999)
    output reg [9:0] sqrt
    );

    reg [9:0] x;              // Working variable for the input
    reg [9:0] remainder;   // Remainder
    reg [9:0] b;              // Current approximation
    integer i;              

    always @(*) begin
        // Init
        sqrt = 0;

        if (num1 <= 0) begin
            sqrt = 0;
        end
        else begin
            x = num1;
            remainder = 0;
            b = 0;    // Current approximation
            i = 9;

            // Digit recurrence
            while (i >= 0) begin
            // Shift the remainder left by 2 bits, add the next bit of x
                remainder = (remainder << 2) | (x[i] ? 2'b01 : 2'b00); // Add the next bit from x
                b = (b << 1) | 1'b1; // Shift b left and add 1

            // if b * b <= r
                if (b * b <= remainder) begin
                    remainder = remainder - (b * b);
                end else begin
                    b = b - 1; //  b - 1 if b * b > r
                end
                i = i - 1;
            end
            sqrt = b;
        end
    end

endmodule
