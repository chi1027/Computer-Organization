module Decoder( instr_op_i, funct_i, RegWrite_o, ALUOp_o, ALUSrc_o, RegDst_o, Branch_o, Branch_type, Jump_o, MemRead_o, MemWrite_o, MemtoReg_o);
     
//I/O ports
input	[6-1:0]		instr_op_i;
input	[6-1:0]		funct_i;
output			RegWrite_o;
output	[3-1:0]		ALUOp_o;
output			ALUSrc_o;
output	[2-1:0]		RegDst_o;
//new
output			Branch_o;
output			Branch_type;
output	[2-1:0]		Jump_o;
output			MemRead_o;
output			MemWrite_o;
output	[2-1:0]		MemtoReg_o;
 
//Internal Signals
wire	[3-1:0]		ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire	[2-1:0]		RegDst_o;

//new
wire			Branch_o;
wire			Branch_type;
wire	[2-1:0]		Jump_o;
wire			MemRead_o;
wire			MemWrite_o;
wire	[2-1:0]		MemtoReg_o;


//Main function
assign RegWrite_o = (instr_op_i == 6'b000000) ? 1'b1 : // R type #notice jr cant write
		    (instr_op_i == 6'b001000) ? 1'b1 : // addi
		    (instr_op_i == 6'b000011) ? 1'b1 : // jal
		    (instr_op_i == 6'b101100) ? 1'b1 :	1'b0; // lw

assign ALUOp_o = (instr_op_i == 6'b000000) ? 3'b010 : // R type
		 (instr_op_i == 6'b001000) ? 3'b100 : // addi
		 (instr_op_i == 6'b101100) ? 3'b000 : // lw
 		 (instr_op_i == 6'b101101) ? 3'b000 : // sw
 		 (instr_op_i == 6'b001010) ? 3'b001 : // beq
 		 (instr_op_i == 6'b001011) ? 3'b110 : // bne
		 (instr_op_i == 6'b001110) ? 3'b011 : // blt
		 (instr_op_i == 6'b001100) ? 3'b110 : // bnez
		 (instr_op_i == 6'b001101) ? 3'b111 : 3'b101; // bgez / lui

assign ALUSrc_o = (instr_op_i == 6'b101100) ? 1'b1 : // lw
			(instr_op_i == 6'b101101) ? 1'b1 : // sw
		  	(instr_op_i == 6'b000000) ? 1'b0 : // R type
		  	(instr_op_i == 6'b001010) ? 1'b0 : // beq
		  	(instr_op_i == 6'b001011) ? 1'b0 : // bne
		  	(instr_op_i == 6'b001110) ? 1'b0 : // blt
		  	(instr_op_i == 6'b001100) ? 1'b0 : // bnez
		 	(instr_op_i == 6'b001101) ? 1'b0 : // bgez
		  	(instr_op_i == 6'b001000) ? 1'b1 : 1'b1; // addi

assign RegDst_o = (instr_op_i == 6'b000000) ? 2'b01 : // R type
		  (instr_op_i == 6'b000011) ? 2'b10 : 2'b00; // jal

assign Branch_o = (instr_op_i == 6'b001010 || instr_op_i == 6'b001011 || instr_op_i == 6'b001110 || instr_op_i == 6'b001100 || instr_op_i == 6'b001101) ? 1'b1 : 1'b0; // beg and bne and blt and bnez and bgez

assign Branch_type = (instr_op_i == 6'b001010 || instr_op_i == 6'b001101) ? 1'b0 : // beg and bgez
		     (instr_op_i == 6'b001011 || instr_op_i == 6'b001110 || instr_op_i == 6'b001100) ? 1'b1 : 1'b0; // bne and blt and bnez

assign Jump_o = (instr_op_i == 6'b000010 || instr_op_i == 6'b000011 ) ? 2'b01 : // jump and jal
		(instr_op_i == 6'b000000 && funct_i == 6'b001000) ? 2'b10 :  2'b00;// jr #jr need rd = 0 

assign MemRead_o = (instr_op_i == 6'b101100) ? 1'b1 : 1'b0; // lw

assign MemWrite_o = (instr_op_i == 6'b101101) ? 1'b1 : 1'b0; // sw

assign MemtoReg_o = (instr_op_i == 6'b101100) ? 2'b01 : // lw
		    (instr_op_i == 6'b000011) ? 2'b10 : 2'b00; // jal

endmodule
   