`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 22:45:55
// Design Name: 
// Module Name: tb
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



module tb;
     //DUT device under test
     
    reg clk;             
    reg [15:0]key;    
    wire [31:0]result;
     
     
    main_cal uut(
        .clk(clk),
        .keycode(key),
        .result(result)
    );
    
    always begin
        #5 clk = ~clk;  // Horloge avec une période de 10ns
    end
    
    initial begin
        clk = 0;
        
        
        #100 key = 16'h5A;
    
        //5 then press enter
        #100 key = 16'h1E;
        #100 key = 16'h26;
        #100 key = 16'h1E;
        //#100 key = 16'h5A;
        
        //#100 key = 16'h36;
        
        
        //press +
        //#100 key = 16'h1C;
        //#100 key = 16'h5A;
        
        //press 7 + enter
        //#100 key = 16'h3D;
        //#100 key = 16'h5A;
        
        
        
       
        
    
    end
    
    
    
endmodule