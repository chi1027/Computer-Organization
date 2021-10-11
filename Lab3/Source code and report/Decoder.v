module Decoder( instr_op_i, RegWrite_o, ALUOp_o, ALUSrc_o, RegDst_o);
     
//I/O ports
input	[6-1:0] instr_op_i;

output	RegWrite_o;
output	[3-1:0] ALUOp_o;
output	ALUSrc_o;
output	RegDst_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire	ALUSrc_o;
wire	RegWrite_o;
wire	RegDst_o;

//Main function
/*your code here*/

assign RegDst_o = (instr_op_i == 0)? 1 : 0;
assign ALUSrc_o = (instr_op_i == 0)? 0 : 1;
assign RegWrite_o = 1;
assign ALUOp_o = (instr_op_i == 0)? 3'b010 : 3'b001;


/*always @ ( * ) begin
    RegDst <= (instr_op_i == 0 && funct_i != 0 && funct_i != 2)? 1 : 0;
    ALUSrc <= (instr_op_i == 0)? 0 : 1;
    //RegWrite <= 1;
    ALUOp[2] <= 0;
    ALUOp[1] <= (instr_op_i == 0)? 1 : 0;
    ALUOp[0] <= 0;
end

assign ALUOp_o = ALUOp;
assign ALUSrc_o = ALUSrc;
assign RegWrite_o = 1;
assign RegDst_o = RegDst;
*/
endmodule
   