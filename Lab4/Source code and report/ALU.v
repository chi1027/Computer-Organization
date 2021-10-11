module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input signed[32-1:0]  aluSrc1;
input signed[32-1:0]  aluSrc2;
input	 [4-1:0] ALU_operation_i;

output	signed[32-1:0] result;
output		 zero;
output			 overflow;

//Internal Signals
wire			 zero;
wire			 overflow;
reg	signed[32-1:0] result;

//Main function
assign zero = (result == 0) ? 0 : 1;
always @(ALU_operation_i, aluSrc1, aluSrc2) begin
	case (ALU_operation_i)
		0: result <= aluSrc1 & aluSrc2;
		1: result <= aluSrc1 | aluSrc2;
		2: result <= aluSrc1 + aluSrc2;
		6: result <= aluSrc1 - aluSrc2;
		7: result <= aluSrc1 < aluSrc2 ? 1 : 0;
		9: result <= aluSrc1 < 0 ? 1 : 0;
		12: result <= ~(aluSrc1 | aluSrc2);
		default: result <= 0;
	endcase
end


endmodule
