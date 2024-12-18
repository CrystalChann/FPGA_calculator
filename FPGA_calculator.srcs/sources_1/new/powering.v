`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 01:28:06
// Design Name: 
// Module Name: powering_function
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Module Verilog pour calculer num1 ^ num2
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module powering_function (
    input signed [9:0] num1,       // Base
    input signed [9:0] num2,       // Exposant
    input clk,                     // Horloge
    output reg signed [19:0] result // R¨¦sultat
);

    reg signed [19:0] temp_result; // Stocke le r¨¦sultat temporaire
    integer i;                     // Variable pour boucle

    always @(posedge clk) begin
        // Gestion des cas particuliers
        if (num2 == 0) begin
            result <= 1; // x^0 = 1
        end 
        else if (num1 == 0) begin
            result <= 0; // 0^x = 0
        end 
        else begin
            // Initialisation du r¨¦sultat temporaire
            temp_result = 1;
            
            // Boucle pour calculer num1 ^ num2
            for (i = 0; i < num2; i = i + 1) begin
                temp_result = temp_result * num1;
            end
            
            // Mise ¨¤ jour du r¨¦sultat
            result <= temp_result;
        end
    end

endmodule