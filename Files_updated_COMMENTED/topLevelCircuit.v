`include "defines.v"

module PROCESSOR (input CLOCK_50, input reset, input forward_EN);
	wire clock = CLOCK_50;
	wire [`MAX_LENGTH-1:0] PC_IF, PC_ID, PC_EXE, PC_MEM;
	wire [`MAX_LENGTH-1:0] inst_IF, inst_ID;
	wire [`MAX_LENGTH-1:0] reg1_ID, reg2_ID, ST_value_EXE, ST_value_EXE2MEM, ST_value_MEM;
	wire [`MAX_LENGTH-1:0] val1_ID, val1_EXE;
	wire [`MAX_LENGTH-1:0] val2_ID, val2_EXE;
	wire [`MAX_LENGTH-1:0] ALURes_EXE, ALURes_MEM, ALURes_WB;
	wire [`MAX_LENGTH-1:0] dataMem_out_MEM, dataMem_out_WB;
	wire [`MAX_LENGTH-1:0] WB_result;
	wire [`REG_LENGTH-1:0] destination_execute, destination_Memory, destination_WriteBack; // dest_ID = instruction[25:21] thus nothing declared
	wire [`REG_LENGTH-1:0] source1_ID, src2_regFile_ID, src2_forw_ID, src2_forw_EXE, src1_forw_EXE;
	wire [`FUNC_SIZE-1:0] EXE_CMD_ID, EXE_CMD_EXE;
	wire [`FORWARDING_LENGTH-1:0] value1_select, value2_select, ST_val_sel;
	wire [1:0] branch_comm;
	wire Br_Taken_ID, IF_Flush, Br_Taken_EXE;
	wire MEM_R_EN_ID, Memory_R_enable_execute, MEM_R_EN_MEM, MEM_R_EN_WB;
	wire MEM_W_EN_ID, MEM_W_EN_EXE, MEM_W_EN_MEM;
	wire WB_EN_ID, WriteBack_enable_execute, WriteBack_Enable_Memory, WriteBack_Enable_WriteBack;
	wire hazard_detected, is_imm, store_branch_not_equal;

	REGISTER_FILE REGISTER_FILE(
		// INPUTS
		.clk(clock),
		.reset(reset),
		.source1(source1_ID),
		.source2(src2_regFile_ID),
		.destination_source(destination_WriteBack),
		.writing_value(WB_result),
		.write_enabled(WriteBack_Enable_WriteBack),
		// OUTPUTS
		.registerval1(reg1_ID),
		.registerval2(reg2_ID)
	);

	DETECT_HAZARD hazard (
		// INPUTS
		.forward_EN(forward_EN),
		.is_imm(is_imm),
		.store_branch_not_equal(store_branch_not_equal),
		.source1_ID(source1_ID),
		.source2_ID(src2_regFile_ID),
		.destination_execute(destination_execute),
		.destination_Memory(destination_Memory),
		.WriteBack_enable_execute(WriteBack_enable_execute),
		.WriteBack_Enable_Memory(WriteBack_Enable_Memory),
		.Memory_R_enable_execute(Memory_R_enable_execute),
		// OUTPUTS
		.branch_comm(branch_comm),
		.hazard_detected(hazard_detected)
	);

	FORWARD_EXECUTE forwrding_EXE (
		.source1_Execute(src1_forw_EXE),
		.source2_Execute(src2_forw_EXE),
		.Store_source_Execute(destination_execute),
		.destination_Memory(destination_Memory),
		.destination_WriteBack(destination_WriteBack),
		.WriteBack_Enable_Memory(WriteBack_Enable_Memory),
		.WriteBack_Enable_WriteBack(WriteBack_Enable_WriteBack),
		.value1_select(value1_select),
		.value2_select(value2_select),
		.ST_val_sel(ST_val_sel)
	);

    // PIPELINE STAGES ARE DEFINED BELOW : 
	// STAGE 1
	INSTRUCT_FETCH INSTRUCT_FETCH (
		// INPUTS
		.clk(clock),
		.reset(reset),
		.freeze(hazard_detected),
		.brTaken(Br_Taken_ID),
		.brOffset(val2_ID),
		// OUTPUTS
		.instruction(inst_IF),
		.programrun_counter(PC_IF)
	);

	// STAGE 2
	INSTRUCT_DECODE INSTRUCT_DECODE (
		// INPUTS
		.clk(clock),
		.reset(reset),
		.hazard_detected_in(hazard_detected),
		.instruction(inst_ID),
		.registerval1(reg1_ID),
		.registerval2(reg2_ID),
		// OUTPUTS
		.source1(source1_ID),
		.src2_reg_file(src2_regFile_ID),
		.src2_forw(src2_forw_ID),
		.valuein1(val1_ID),
		.valuein2(val2_ID),
		.brTaken(Br_Taken_ID),
		.EXE_CMD(EXE_CMD_ID),
		.memory_read_enabled(MEM_R_EN_ID),
		.memory_write_enabled(MEM_W_EN_ID),
		.writeback_enabled(WB_EN_ID),
		.is_imm_out(is_imm),
		.ST_or_BNE_out(store_branch_not_equal),
		.branch_comm(branch_comm)
	);

	// STAGE 3
	EXECUTE_STAGE EXECUTE_STAGE (
		// INPUTS
		.clk(clock),
		.EXE_CMD(EXE_CMD_EXE),
		.value1_select(value1_select),
		.value2_select(value2_select),
		.ST_val_sel(ST_val_sel),
		.valuein1(val1_EXE),
		.valuein2(val2_EXE),
		.ALU_res_MEM(ALURes_MEM),
		.result_WB(WB_result),
		.ST_value_in(ST_value_EXE),
		// OUTPUTS
		.ALUResult(ALURes_EXE),
		.ST_value_out(ST_value_EXE2MEM)
	);

	// STAGE 4
	MEMORY_stage MEMORY_stage (
		// INPUTS
		.clk(clock),
		.reset(reset),
		.memory_read_enabled(MEM_R_EN_MEM),
		.memory_write_enabled(MEM_W_EN_MEM),
		.ALU_res(ALURes_MEM),
		.ST_value(ST_value_MEM),
		// OUTPUTS
		.dataMem_out(dataMem_out_MEM)
	);

	// STAGE 5
	WRITEBACK_STAGE WRITEBACK_STAGE (
		// INPUTS
		.memory_read_enabled(MEM_R_EN_WB),
		.currmemory_data(dataMem_out_WB),
		.alu_result(ALURes_WB),
		// OUTPUTS
		.WB_res(WB_result)
	);

    
	// PIPELINE REGISTERS ARE DEFINED BELOW :

	IF_REG_ID IF2IDReg (
		// INPUTS
		.clk(clock),
		.reset(reset),
		.flush(IF_Flush),
		.freeze(hazard_detected),
		.program_counter_input(PC_IF),
		.instructionIn(inst_IF),
		// OUTPUTS
		.programrun_counter(PC_ID),
		.instruction(inst_ID)
	);

	ID_REG_EXE ID2EXEReg (
		.clk(clock),
		.reset(reset),
		// INPUTS
		.destination_inputval(inst_ID[25:21]),
		.src1_in(source1_ID),
		.src2_in(src2_forw_ID),
		.register2_inputval(reg2_ID),
		.value1_inputval(val1_ID),
		.value2_inputval(val2_ID),
		.program_counter_input(PC_ID),
		.EXE_CMD_IN(EXE_CMD_ID),
		.memory_read_enabled_inputvalue(MEM_R_EN_ID),
		.memory_write_enabled_inputvalue(MEM_W_EN_ID),
		.writeback_enabled_inputvalue(WB_EN_ID),
		.brTaken_in(Br_Taken_ID),
		// OUTPUTS
		.src1_out(src1_forw_EXE),
		.src2_out(src2_forw_EXE),
		.destination_source(destination_execute),
		.ST_value(ST_value_EXE),
		.valuein1(val1_EXE),
		.valuein2(val2_EXE),
		.programrun_counter(PC_EXE),
		.EXE_CMD(EXE_CMD_EXE),
		.memory_read_enabled(Memory_R_enable_execute),
		.memory_write_enabled(MEM_W_EN_EXE),
		.writeback_enabled(WriteBack_enable_execute),
		.brTaken_out(Br_Taken_EXE)
	);

	EXE_REG_MEM EXE2MEMReg (
		.clk(clock),
		.reset(reset),
		// INPUTS
		.writeback_enabled_inputvalue(WriteBack_enable_execute),
		.memory_read_enabled_inputvalue(Memory_R_enable_execute),
		.memory_write_enabled_inputvalue(MEM_W_EN_EXE),
		.program_counter_input(PC_EXE),
		.alu_mod_result_input(ALURes_EXE),
		.storevalue_input(ST_value_EXE2MEM),
		.destination_inputval(destination_execute),
		// OUTPUTS
		.writeback_enabled(WriteBack_Enable_Memory),
		.memory_read_enabled(MEM_R_EN_MEM),
		.memory_write_enabled(MEM_W_EN_MEM),
		.programrun_counter(PC_MEM),
		.alu_unit_result(ALURes_MEM),
		.STVal(ST_value_MEM),
		.destination_source(destination_Memory)
	);

	MEM_REG_WB MEM_REG_WB(
		.clk(clock),
		.reset(reset),
		// INPUTS
		.writeback_enabled_inputvalue(WriteBack_Enable_Memory),
		.memory_read_enabled_inputvalue(MEM_R_EN_MEM),
		.alu_mod_result_input(ALURes_MEM),
		.memReadValIn(dataMem_out_MEM),
		.destination_inputval(destination_Memory),
		// OUTPUTS
		.writeback_enabled(WriteBack_Enable_WriteBack),
		.memory_read_enabled(MEM_R_EN_WB),
		.alu_unit_result(ALURes_WB),
		.memReadVal(dataMem_out_WB),
		.destination_source(destination_WriteBack)
	);

	assign IF_Flush = Br_Taken_ID; //FLUSH IS ASSIGNED WHEN REQUIRED BY THE BRANCH TAKEN

endmodule
