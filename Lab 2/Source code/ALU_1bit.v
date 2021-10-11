module ALU_1bit( result, carryOut, set, a, b, invertA, invertB, operation, carryIn, less); 
  
	output wire	result;
	output wire 	carryOut;
	output wire	set;
  
	input wire 	a;
	input wire	b;
  	input wire	invertA;
  	input wire	invertB;
  	input wire[1:0] operation;
  	input wire 	carryIn;
  	input wire 	less;
  /*your code here*/ 
	wire		aa, bb;
	reg		re;
	reg		co;

	assign	aa = (invertA == 1'b0)? a : ~a;
	assign  bb = (invertB == 1'b0)? b : ~b;

	always @(*) begin
		if (operation == 2'b00) begin
			re = aa & bb;
			co = 1'b0;
		end
		if (operation == 2'b01) begin
			re = aa | bb;
			co = 1'b0;
		end
		if (operation == 2'b10) begin
			co = (aa & bb) | ((aa ^ bb) & carryIn);
			re = carryIn ^ aa ^ bb;
		end
		if(operation == 2'b11) begin
			co = (aa & bb) | ((aa ^ bb) & carryIn);
			re = less;
		end
	end

	assign	result = re;
	assign	carryOut = co;
	assign	set = (operation == 2'b11)? carryIn ^ aa ^ bb : 1'b0;
			
endmodule