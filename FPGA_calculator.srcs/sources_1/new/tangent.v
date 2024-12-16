`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 12:16:51
// Design Name: 
// Module Name: tangent
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


module tangent(
    input signed [9:0] angle, // In degree for now
    output reg signed [9:0] tangent 
    );

sine sine_function(
    .angle (angle),
    .sine (sine)
    );    
    
cosine cosine_function(
    .angle (angle),
    .cosine (cosine)
    );
 
divider divide (
    .num1 (sine),  
    .num2 (cosine),   
    .quotient (quotient), 
    .remainder (remainder)
);

  always @(*) begin
        if (cosine != 0) begin
            tangent = quotient; // Assign the quotient to the tangent output
        end else begin
            tangent = 32767; // Indicate overflow or undefined value (e.g., tan(pi/2)
        end
    end

endmodule
