module subtractorIEEE754(
// A-B
    input [31:0] A,  // Entrï¿½e nombre flottant IEEE 754
    input [31:0] B,  // Entrï¿½e nombre flottant IEEE 754
    output wire [31:0] C // Sortie nombre flottant IEEE 754
);
    wire [31:0] mB = {~B[31], B[30:0]};
    adderIEEE754 adder(.A(A),.B(mB),.C(C));

endmodule