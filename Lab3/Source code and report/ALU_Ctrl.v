module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o, choose_v_o );

//I/O ports 
input		[6-1:0] funct_i;
input		[3-1:0] ALUOp_i;

output		[4-1:0] ALU_operation_o;  
output		[2-1:0] FURslt_o;
output		choose_v_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;
//wire		leftRight_o;
wire		choose_v_o;

//Main function
/*your code here*/

assign ALU_operation_o = (ALUOp_i[1] == 1 && funct_i == 6'b010011)? 4'b0010 :
		                 (ALUOp_i[1] == 1 && funct_i == 6'b010001)? 4'b0110 :
		                 (ALUOp_i[1] == 1 && funct_i == 6'b010100)? 4'b0000 :
		                 (ALUOp_i[1] == 1 && funct_i == 6'b010110)? 4'b0001 :
		                 (ALUOp_i[1] == 1 && funct_i == 6'b010101)? 4'b1100 :
		                 (ALUOp_i[1] == 1 && funct_i == 6'b110000)? 4'b0111 :
			             (ALUOp_i[1] == 1 && funct_i == 6'b000100)? 4'b0001 : // 0 left 1 right SRLV
			             (ALUOp_i[1] == 1 && funct_i == 6'b000000)? 4'b0000 : // SLL
			             (ALUOp_i[1] == 1 && funct_i == 6'b000010)? 4'b0001 : // SRL
			             (ALUOp_i[1] == 1 && funct_i == 6'b000110)? 4'b0000 : // SLLV
		                 (ALUOp_i[1] == 0)? 4'b0010: 4'b0000;

assign FURslt_o = (ALUOp_i[1] == 1 && funct_i[4] == 0)? 2'b01 : 2'b00;


assign choose_v_o = (ALUOp_i[1] == 1 && funct_i[2] == 1)? 1 :0;
    //FURslt[0] <= ((~funct_i[4]) & ALUOp_i[1]);
    //leftRight <= ((~funct_i[4]) & ALUOp_i[1] & ((funct_i[1] & (~funct_i[2])) || ((~funct_i[1]) & funct_i[2])));
    //choose_v <= ((~funct_i[4]) & funct_i[2]);


//always @ ( * ) begin
    //ALU_operation[3] <= (ALUOp_i[1] & funct_i[4] & funct_i[2] & (~funct_i[1]) & funct_i[0]);
    //ALU_operation[2] <= (ALUOp_i[1] & funct_i[4] & (((~funct_i[3]) & (~funct_i[2]) & (~funct_i[1])) | (funct_i[2] & (~funct_i[1]) & funct_i[0])));
    //ALU_operation[1] <= ((~ALUOp_i[1]) | (funct_i[4] & (~funct_i[3]) & (~funct_i[2])));
    //ALU_operation[0] <= (ALUOp_i[1] & funct_i[4] & (funct_i[5] | (funct_i[1] & (~funct_i[0]))));
    //FURslt[1] <= 0;
    //FURslt[0] <= ((~funct_i[4]) & ALUOp_i[1]);
    //leftRight <= ((~funct_i[4]) & ALUOp_i[1] & ((funct_i[1] & (~funct_i[2])) || ((~funct_i[1]) & funct_i[2])));
    //choose_v <= ((~funct_i[4]) & funct_i[2]);
//end
/*
always @ ( * ) begin
    FURslt[1] <= 0;
    FURslt[0] <= ((~funct_i[4]) & ALUOp_i[1]);
    leftRight <= ((~funct_i[4]) & ALUOp_i[1] & ((funct_i[1] & (~funct_i[2])) || ((~funct_i[1]) & funct_i[2])));
    choose_v <= ((~funct_i[4]) & funct_i[2]);
    if(ALUOp_i[1] == 0) begin
	ALU_operation <= 2;
    end else begin
        case(funct_i)
	    19: ALU_operation <= 2;
	    17: ALU_operation <= 6;
	    20: ALU_operation <= 0;
	    22: ALU_operation <= 1;
	    48: ALU_operation <= 7;
	    21: ALU_operation <= 12;
	    default: ALU_operation <= 0;
	endcase
    end
end
    //ALU_operation[3] <= (ALUOp_i[1] & funct_i[4] & funct_i[2] & (~funct_i[1]) & funct_i[0]);
    //ALU_operation[2] <= (ALUOp_i[1] & funct_i[4] & (((~funct_i[3]) & (~funct_i[2]) & (~funct_i[1])) | (funct_i[2] & (~funct_i[1]) & funct_i[0])));
    //ALU_operation[1] <= ((~ALUOp_i[1]) | (funct_i[4] & (~funct_i[3]) & (~funct_i[2])));
    //ALU_operation[0] <= (ALUOp_i[1] & funct_i[4] & (funct_i[5] | (funct_i[1] & (~funct_i[0]))));
    //FURslt[1] <= 0;
    //FURslt[0] <= ((~funct_i[4]) & ALUOp_i[1]);
    //leftRight <= ((~funct_i[4]) & ALUOp_i[1] & ((funct_i[1] & (~funct_i[2])) || ((~funct_i[1]) & funct_i[2])));
    //choose_v <= ((~funct_i[4]) & funct_i[2]);
//end

assign ALU_operation_o = ALU_operation;
assign FURslt_o = FURslt;
assign leftRight_o = leftRight;
assign choose_v_o = choose_v;
*/
endmodule     
