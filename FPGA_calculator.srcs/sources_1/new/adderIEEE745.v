module adderIEEE754(
    input [31:0] A, 
    input [31:0] B,  
    output reg [31:0] C 
);

   
   //Signals for A
    wire signA = A[31];
    wire [7:0] expA = A[30:23];
    wire [23:0] mantA = {1'b1, A[22:0]}; 

    //Signals for B
    wire signB = B[31];
    wire [7:0] expB = B[30:23];
    wire [23:0] mantB = {1'b1, B[22:0]};

    reg [23:0] alignedMantA,alignedMantB; 
    reg [24:0] resultMant; 
    reg [7:0] resultExp;
    reg resultSign;

    always @(*) begin
        
       if (A[30:0] == 31'b0 || B[30:0] == 31'b0) begin
            C = (A[30:0] == 31'b0 && B[30:0] == 31'b0) ? 32'b0 : (A[30:0] == 31'b0 ? B : A);
        end else begin
            
            if(expA>expB) begin   
                alignedMantA = mantA;
                alignedMantB = mantB >> expA-expB;
                resultExp = expA;
                resultSign = signA;
            end else begin
                alignedMantB = mantB;
                alignedMantA = mantA >> expB-expA;
                resultExp = expB;
                resultSign = signB;
            end


            if(signA == signB) begin
                //same sign, we add mantissas
                resultMant = alignedMantA + alignedMantB;
                resultSign = signA;
            end else begin
                //oposite sign we substract mantissa
                if(alignedMantA>=alignedMantB) begin
                    resultMant = alignedMantA - alignedMantB;
                    resultSign = signA;
                end else begin
                    resultMant = alignedMantB - alignedMantA;
                    resultSign = signB;
                end
            end
            
            if(resultMant[24] == 1) begin
                resultMant = resultMant >> 1;
                resultExp = resultExp + 1;
            end else begin
                while (resultMant[23] == 0 && resultExp > 0) begin
                    resultMant = resultMant << 1;
                    resultExp = resultExp - 1;
                end
            end

         if (resultExp >= 255) begin
      
            C = {resultSign, 8'hFF, 23'b0};
        end else if (resultExp == 0 && resultMant[23] == 0) begin
            
            C = {resultSign, 8'b0, 23'b0};
        end else begin
            
            C = {resultSign, resultExp, resultMant[22:0]};
        end

       end         

    end

endmodule