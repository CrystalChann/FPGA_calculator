`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 14:49:00
// Design Name: Square Root Calculator
// Module Name: square_root
// Project Name: 
// Target Devices: FPGA/ASIC
// Tool Versions: 
// Description: Computes square root of a 10-bit input number using iterative approximation
// 
// Dependencies: None
// 
//////////////////////////////////////////////////////////////////////////////////

module square_root(
    input wire clk,                // Horloge pour l'it¨¦ration
    input wire [9:0] num1,         // Entr¨¦e : nombre sur 10 bits (0 ¨¤ 1023)
    output reg [9:0] sqrt          // Sortie : racine carr¨¦e approch¨¦e
    );

    // Variables internes
    reg [9:0] approx;              // Valeur d'approximation actuelle
    reg [9:0] temp;                // Variable temporaire pour les calculs
    integer i;                     // Compteur pour it¨¦rations

    always @(posedge clk) begin
        // Initialisation de l'approximation
        approx <= num1 >> 1;       // Premi¨¨re approximation : num1 divis¨¦ par 2
        temp <= 0;

        // It¨¦rations pour affiner l'approximation
        for (i = 0; i < 10; i = i + 1) begin
            temp <= (approx + (num1 / approx)) >> 1; // Newton-Raphson
            approx <= temp;
        end

        // R¨¦sultat final
        sqrt <= approx;
    end

endmodule