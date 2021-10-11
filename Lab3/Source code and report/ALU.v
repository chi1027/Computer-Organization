module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input [32-1:0] aluSrc1;
input	[32-1:0] aluSrc2;
input	 [4-1:0] ALU_operation_i;

output	[32-1:0] result;
output	zero;
output	overflow;

//Internal Signals
wire	zero;
wire	overflow;
wire	[32-1:0] result;

reg   [32-1:0] result_o;

//Main function
/*your code here*/
assign zero = (result == 0);
always @ (ALU_operation_i, aluSrc1, aluSrc2) begin
    case (ALU_operation_i)
        4'b0000: result_o <= $signed(aluSrc1) & $signed(aluSrc2);
        4'b0001: result_o <= $signed(aluSrc1) | $signed(aluSrc2);
        4'b0010: result_o <= $signed(aluSrc1) + $signed(aluSrc2);
        4'b0110: result_o <= $signed(aluSrc1) - $signed(aluSrc2);
        4'b0111: result_o <= ($signed(aluSrc1) < $signed(aluSrc2)) ? 1 : 0;
	    4'b1100: result_o <= ~($signed(aluSrc1) | $signed(aluSrc2));
        default: result_o <= 0;
    endcase
end

assign overflow = ((ALU_operation_i == 4'b0010 && aluSrc1[31] == 1 && aluSrc2[31] == 1 && result[31] == 0) || (ALU_operation_i == 4'b0010 && aluSrc1[31] == 0 && aluSrc2[31] == 0 && result[31] == 1) ||  (ALU_operation_i == 4'b0110 && aluSrc1[31] == 0 && aluSrc2[31] == 1 && result[31] == 1) ||  (ALU_operation_i == 4'b0110 && aluSrc1[31] == 1 && aluSrc2[31] == 0 && result[31] == 0))? 1 : 0;
assign result = result_o;

endmodule
