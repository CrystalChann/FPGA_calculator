`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  
// Engineer: 
// 
// Create Date: 12/10/2024 02:04:01 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

//a PS/2 keyboard to FPGA system. It reads input from a PS/2 keyboard, 
//converts the keycodes to ASCII, and transmits them to cal.

//Clock divider for 50MHz clock
//PS/2 receiver interface
//Keycode to ASCII conversion
//main calculator stage control

module top(
    input         clk,
    input         PS2Data,
    input         PS2Clk,
    input         btnL,
    input         reset,
    input         btnR,
    output        tx,
    output        [6:0]seg,
    output        [3:0]an
);
//    wire        tready;
    wire        ready;
//    wire        tstart;
    reg         start=0;
    reg         CLK50MHZ=0;
    reg         CLK100MHZ=0;
//    wire [31:0] tbuf;
    reg  [15:0] keycodev=0;
    wire [15:0] keycode;
//    wire [ 7:0] tbus;
    reg  [ 2:0] bcount=0;
    wire        flag;
    reg         cn=0;
    
    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    always @(posedge CLK50MHZ)begin
        CLK100MHZ<=~CLK100MHZ;
    end
    
    PS2Receiver uut (
        .clk(CLK50MHZ),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keycode),
        .oflag(flag)
    );
    
    
    always@(keycode)
        if (keycode[7:0] == 8'hf0) begin
            cn <= 1'b0;
            bcount <= 3'd0;
        end else if (keycode[15:8] == 8'hf0) begin
            cn <= keycode != keycodev;
            bcount <= 3'd5;
        end else begin
            cn <= keycode[7:0] != keycodev[7:0] || keycodev[15:8] == 8'hf0;
            bcount <= 3'd2;
        end
    
    always@(posedge clk)
        if (flag == 1'b1 && cn == 1'b1) begin
            start <= 1'b1;
            keycodev <= keycode;
        end else
            start <= 1'b0;
            
    bin2ascii #(
        .NBYTES(2)
    ) conv (
        .I(keycodev),
        .O(keydecoded)
    );
    
    main_cal main_cal (
        .clk (clk),
        .keycode (keydecoded),
        .result (result),
        .done (done)
    );

    myDisplayer displayer (
        .clock_100Mhz(CLK100MHZ), 
        .reset(0),                
        .btnL(btnL),       
        .btnR(btnR),        
        .done(done),            
        .an(an),            
        .seg(seg)         
    );
endmodule
