`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2024 14:49:29
// Design Name: 
// Module Name: myDisplayer
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


module myDisplayer(
    input clock_100Mhz,
    input reset,
    input lButton,
    input rButton,

    output reg[3:0] anode,
    output reg [6:0] pattern

    );
    
    wire leftPress;
    wire rightPress;

    //instances de mes boutons

    buttonHandler left(.clk(clock_100Mhz),.rst(reset),.button_in(lButton),.button_pressed(leftPress));
    buttonHandler right(.clk(clock_100Mhz),.rst(reset),.button_in(rButton),.button_pressed(rightPress));
    reg [3:0] displayPosition; //goes from 0 to 8 STRICTLY
    

    //refreshCounter pour un affichage LCD
    reg [19:0] refresh_counter;


    wire [1:0] LED_activating_counter; 
    
    //patterns de test
    wire [6:0] patterns [0:11];
    assign patterns[0] = 7'b0000001;
    assign patterns[1] = 7'b1001111;
    assign patterns[2] = 7'b0010010;
    assign patterns[3] = 7'b0000110;
    assign patterns[4] = 7'b1001100;
    assign patterns[5] = 7'b0100100;
    assign patterns[6] = 7'b0100000;
    assign patterns[7] = 7'b0001111;
    assign patterns[8] = 7'b0000000;
    assign patterns[9] = 7'b0000100;
    assign patterns[10] = 7'b0110000;
    assign patterns[11] = 7'b1111110;



    //controls the display of the buttons
    always @(posedge clock_100Mhz or posedge reset) begin
        if(reset) begin
            displayPosition <= 4'd0;
        end else begin
            //pressRight
             if (rightPress && displayPosition < 8 ) begin
                displayPosition <= displayPosition +1;
             end
             
             //pressLeft
             if (leftPress && displayPosition > 0) begin
                displayPosition <= displayPosition -1;
             end
        end
    end


    //makes the counter work for a 2.6 ms period
    always @(posedge clock_100Mhz or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];


    always @(*) begin
        case(LED_activating_counter)
        2'b00: begin
            anode = 4'b0111; 
            pattern = patterns[0+displayPosition];
        end

        2'b01: begin
            anode = 4'b1011;
            pattern =  patterns[1+displayPosition];
        end

        2'b10: begin
            anode = 4'b1101;
            pattern = patterns[2+displayPosition];
        end

        2'b11: begin
            anode = 4'b1110;
            pattern = patterns[3+displayPosition];
        end

        endcase

    end




endmodule
