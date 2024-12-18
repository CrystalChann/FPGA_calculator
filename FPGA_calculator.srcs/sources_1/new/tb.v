`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2024 22:44:28
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
        
        
        #50 key = 16'h22;
    
        //5 then press enter
        #50 key = 16'h25;
        //#50 key = 16'h26;
        //#50 key = 16'h1E;
        //#100 key = 16'h5A;
        #50 key = 16'h5A;
        
        // operation
        #50 key = 16'h1C;
        
        #50 key = 16'h22;
       
        
        
        //press +
        //#100 key = 16'h1C;
        //#100 key = 16'h5A;
        
        //press 7 + enter
        #50 key = 16'h3D;
        #50 key = 16'h5A;
        
        
        
       
        
    
    end
    
    
    
endmodule
