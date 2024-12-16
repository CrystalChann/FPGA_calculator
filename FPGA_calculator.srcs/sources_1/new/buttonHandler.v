module buttonHandler (
    input wire clk,
    input wire rst,
    input wire button_in,
    output reg button_pressed
);

    localparam COUNTER_MAX = 1000000;

    reg [19:0] debounce_counter = 0;
    reg button_state = 0;
    reg button_state_prev = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            debounce_counter <= 0;
            button_state <= 0;
            button_state_prev <= 0;
            button_pressed <= 0;
        end else begin
            
            if (button_in == button_state) begin
                debounce_counter <= 0;
            end else begin
                debounce_counter <= debounce_counter + 1;
                if (debounce_counter >= COUNTER_MAX) begin
                    debounce_counter <= 0;
                    button_state <= button_in;
                end
            end

            
            button_pressed <= (button_state && ~button_state_prev);

            button_state_prev <= button_state;
        end
    end
endmodule