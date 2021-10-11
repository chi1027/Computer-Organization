module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [31:0] pcnow, pcnext;
wire [31:0] instr;
wire [4:0]  reg_to_write, which_shf;
wire [31:0] r_data1, r_data2;
wire [31:0] aludata2;
wire [31:0] alu_result;
wire [31:0] shift_result;
wire [31:0] zero_filled_result;
wire [31:0] result;
wire [31:0] sign_ex_data;
wire        zero, overflow;
wire        regdst, alusrc, regwrite, leftright, choose_v;
wire [1:0]  furslt;
wire [2:0]  aluop;
wire [3:0]  aluctrl;

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	.rst_n(rst_n),     
	.pc_in_i(pcnext),   
	.pc_out_o(pcnow) 
	);
	
Adder Adder1(
        .src1_i(pcnow),     
	.src2_i(32'd4),
	.sum_o(pcnext)    
	);
	
Instr_Memory IM(
        .pc_addr_i(pcnow),  
	.instr_o(instr)
	);

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(regdst),
        .data_o(reg_to_write)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	.rst_n(rst_n),     
        .RSaddr_i(instr[25:21]),  
        .RTaddr_i(instr[20:16]),  
        .RDaddr_i(reg_to_write),  
        .RDdata_i(result), 
        .RegWrite_i(regwrite),
        .RSdata_o(r_data1),  
        .RTdata_o(r_data2)   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	.RegWrite_o(regwrite), 
	.ALUOp_o(aluop),   
	.ALUSrc_o(alusrc),   
	.RegDst_o(regdst)   
		);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(aluop), 
        .ALU_operation_o(aluctrl),
	.FURslt_o(furslt),
	.choose_v_o(choose_v)
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(sign_ex_data)
        );

Zero_Filled ZF(
        .data_i(instr[15:0]),
        .data_o(zero_filled_result)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(r_data2),
        .data1_i(sign_ex_data),
        .select_i(alusrc),
        .data_o(aludata2)
        );	
		
ALU ALU(
	.aluSrc1(r_data1),
	.aluSrc2(aludata2),
	.ALU_operation_i(aluctrl),
	.result(alu_result),
	.zero(zero),
	.overflow(overflow)
	);

Mux2to1 #(.size(5)) for_shifter(
		.data0_i(instr[10:6]),
		.data1_i(r_data1[4:0]),
		.select_i(choose_v),
		.data_o(which_shf)
		);

		
Shifter shifter( 
	.result(shift_result), 
	.leftRight(aluctrl[0]),
	.shamt(which_shf),
	.sftSrc(aludata2)
	);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(alu_result),
        .data1_i(shift_result),
	.data2_i(zero_filled_result),
        .select_i(furslt),
        .data_o(result)
        );			

endmodule



