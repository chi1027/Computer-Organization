module Shifter( result, leftRight, shamt, sftSrc  );
    
 	output wire[31:0]	result;
 	input wire		leftRight;
 	input wire[4:0]		shamt;
 	input wire[31:0]	sftSrc ;
  
  /*your code here*/ 
	reg[31:0]	re;

	always @(*) begin
		if (leftRight == 1'b1) begin
			re = sftSrc << shamt;
		end
		if (leftRight == 1'b0) begin
			re = sftSrc >> shamt;
		end
	end

	assign result = re;
	
	
endmodule