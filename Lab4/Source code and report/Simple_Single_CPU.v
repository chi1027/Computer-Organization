module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [32-1:0] add_pc;
wire [32-1:0] pc_inst;
wire [32-1:0] instr_o;
wire [5-1:0] Write_reg;
wire [2-1:0] RegDst; //changed
wire RegWrite;
wire [3-1:0] ALUOp;
wire ALUSrc;
wire [32-1:0] Write_Data;
wire [32-1:0] rs_data;
wire [32-1:0] rt_data;
wire [4-1:0] ALUCtrl;
wire [2-1:0] FURslt;
wire [32-1:0] sign_instr;
wire [32-1:0] zero_instr;
wire [32-1:0] Src_ALU_Shifter;
wire zero;
wire [32-1:0] result_ALU;
wire [32-1:0] result_Shifter;
wire overflow;
wire [5-1:0] ShamtSrc;
//new
wire		Branch;
wire		Branch_t;
wire	[2-1:0]	Jump;
wire		MemRead;
wire		MemWrite;
wire	[2-1:0]	MemtoReg;
wire 	[32-1:0] data_left_2, branch_pc, after_branch_pc, pc, final_write_data;
wire 	[32-1:0] Mem_data;

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	.rst_n(rst_n),     
	.pc_in_i(pc),   
	.pc_out_o(pc_inst) 
	    );
	
Adder Adder1(
        .src1_i(pc_inst),     
	.src2_i(32'd4),
	.sum_o(add_pc)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_inst),  
	.instr_o(instr_o)    
	    );

Mux3to1 #(.size(5)) Mux_Write_Reg( //changed
        .data0_i(instr_o[20:16]),
        .data1_i(instr_o[15:11]),
	.data2_i(5'd31), //for jal
        .select_i(RegDst),
        .data_o(Write_reg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	.rst_n(rst_n),     
        .RSaddr_i(instr_o[25:21]),  
        .RTaddr_i(instr_o[20:16]),  
        .RDaddr_i(Write_reg), 
        .RDdata_i(final_write_data), 
        .RegWrite_i(RegWrite),
        .RSdata_o(rs_data),  
        .RTdata_o(rt_data)   
        );
	
Decoder Decoder( //changed
        .instr_op_i(instr_o[32-1:26]), 
	.funct_i(instr_o[6-1:0]),
	.RegWrite_o(RegWrite), 
	.ALUOp_o(ALUOp),   
	.ALUSrc_o(ALUSrc),   
	.RegDst_o(RegDst),
	.Branch_o(Branch),
	.Branch_type(Branch_t),
	.Jump_o(Jump),
	.MemRead_o(MemRead),
	.MemWrite_o(MemWrite),
	.MemtoReg_o(MemtoReg)   
		);

ALU_Ctrl AC(
        .funct_i(instr_o[6-1:0]),   
        .ALUOp_i(ALUOp),   
        .ALU_operation_o(ALUCtrl),
	.FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(instr_o[15:0]),
        .data_o(sign_instr)
        );

Zero_Filled ZF(
        .data_i(instr_o[15:0]),
        .data_o(zero_instr)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(rt_data),
        .data1_i(sign_instr),
        .select_i(ALUSrc),
        .data_o(Src_ALU_Shifter)
        );	

Mux2to1 #(.size(5)) Shamt_Src(
        .data0_i(instr_o[10:6]),
        .data1_i(rs_data[5-1:0]),
        .select_i(ALUCtrl[1]),
        .data_o(ShamtSrc)
        );	

ALU ALU(
	.aluSrc1(rs_data),
	.aluSrc2(Src_ALU_Shifter),
	.ALU_operation_i(ALUCtrl),
	.result(result_ALU),
	.zero(zero),
	.overflow(overflow)
	);

		
Shifter shifter( 
		.result(result_Shifter), 
		.leftRight(ALUCtrl[0]),
		.shamt(ShamtSrc),
		.sftSrc(Src_ALU_Shifter) 
		);
//new

Data_Memory DM( 
		.clk_i(clk_i),
        	.addr_i(result_ALU),
        	.data_i(rt_data),
        	.MemRead_i(MemRead),
        	.MemWrite_i(MemWrite),
        	.data_o(Mem_data)
		);

Shifter Left_two( 
		.result(data_left_2), 
		.leftRight(1'b0),
		.shamt(5'd2),
		.sftSrc(sign_instr) 
		);


Adder Adder2( 
        .src1_i(add_pc),
        .src2_i(data_left_2),
        .sum_o(branch_pc)
        );


Mux2to1 #(.size(32)) PC_after_branch(
        .data0_i(add_pc),
        .data1_i(branch_pc),
        .select_i(Branch & (Branch_t == zero)),
        .data_o(after_branch_pc)
        );	

Mux3to1 #(.size(32)) PC_final(
        .data0_i(after_branch_pc),
        .data1_i({add_pc[31:28], instr_o[25:0], 2'b00}),
	.data2_i(rs_data),
        .select_i(Jump),
        .data_o(pc)
        );	

Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(result_ALU),
        .data1_i(result_Shifter),
	.data2_i(zero_instr),
        .select_i(FURslt),
        .data_o(Write_Data)
        );

Mux3to1 #(.size(32)) after_jal(
        .data0_i(Write_Data),
	.data1_i(Mem_data),
        .data2_i(add_pc),
        .select_i(MemtoReg),
        .data_o(final_write_data)
        );		

endmodule



