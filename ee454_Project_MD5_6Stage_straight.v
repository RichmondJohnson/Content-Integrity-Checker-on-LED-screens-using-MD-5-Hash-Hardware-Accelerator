`timescale 1 ns / 100 ps

module MD5_6Stage (CLK, RSTB, A_input, B_input, C_input, D_input,
					msg_x0, msg_x1, msg_x2, msg_x3, msg_x4, msg_x5, msg_x6, msg_x7,
					msg_x8, msg_x9, msg_x10, msg_x11, msg_x12, msg_x13, msg_x14, msg_x15,
						A_output, B_output, C_output, D_output, EOC_flag);

input CLK,RSTB;
input [31:0] A_input, B_input, C_input, D_input;
input [31:0] msg_x0, msg_x1, msg_x2, msg_x3, msg_x4, msg_x5, msg_x6, msg_x7;
input [31:0] msg_x8, msg_x9, msg_x10, msg_x11, msg_x12, msg_x13, msg_x14, msg_x15;
output reg [31:0] A_output, B_output, C_output, D_output;
output reg EOC_flag;

reg [31:0] X_input [15:0];

always @ (negedge RSTB) begin

	Xk_Fetcher_inst.input_X_msg[0] = msg_x0;
	Xk_Fetcher_inst.input_X_msg[1] = msg_x1;
	Xk_Fetcher_inst.input_X_msg[2] = msg_x2;
	Xk_Fetcher_inst.input_X_msg[3] = msg_x3;
	Xk_Fetcher_inst.input_X_msg[4] = msg_x4;
	Xk_Fetcher_inst.input_X_msg[5] = msg_x5;
	Xk_Fetcher_inst.input_X_msg[6] = msg_x6;
	Xk_Fetcher_inst.input_X_msg[7] = msg_x7;
	Xk_Fetcher_inst.input_X_msg[8] = msg_x8;
	Xk_Fetcher_inst.input_X_msg[9] = msg_x9;
	Xk_Fetcher_inst.input_X_msg[10] = msg_x10;
	Xk_Fetcher_inst.input_X_msg[11] = msg_x11;
	Xk_Fetcher_inst.input_X_msg[12] = msg_x12;
	Xk_Fetcher_inst.input_X_msg[13] = msg_x13;
	Xk_Fetcher_inst.input_X_msg[14] = msg_x14;
	Xk_Fetcher_inst.input_X_msg[15] = msg_x15;

end

// reg [31:0] X_input [15:0]
//////////       STAGE SIGNALS       ///////////

// I_counter_Stage
wire initial_i, end_flag;
wire [5:0] i;

// Ti_S_Fetcher_Stage
wire [5:0] st2_i;
wire st2_initial_i, st2_end_flag;
wire [31:0] st2_Ti;
wire [4:0] st2_s;

//Xk_Fetcher_Stage
wire [5:0] st3_i;
wire st3_initial_i, st3_end_flag;
wire [31:0] st3_Ti, st3_Xk;
wire [4:0] st3_s;
wire [3:0] st3_k;

//Xk_Ti_Adder_Stage
wire [5:0] st4_i;
wire st4_initial_i, st4_end_flag;
wire [31:0] st4_Xk_plus_Ti, st4_Ti, st4_Xk;
wire [4:0] st4_s;

//Core_Calc_Stage
wire [31:0] st5_B_mux_output, st5_A_mux_output, st5_C_mux_output, st5_D_mux_output, st5_Func_res, st5_Xk_plus_Ti, st5_temp_B_out;
wire [5:0] st5_i;
wire st5_end_flag, st5_sel, st5_initial_i;
wire [4:0] st5_s;
reg st5_toggle_value, st5_toggle_flag;
wire st5_start_of_calc;

//Final_Stage
wire [31:0] st6_B_Temp_out, st6_A_out, st6_C_out, st6_D_out, st6_Func_res, st6_Xk_plus_Ti;
wire [5:0] st6_i;
wire st6_end_flag;
wire st6_final_regwrite_en;
wire [4:0] st6_s;
wire [31:0] st6_B_end_of_round;

///////////////////////////////////////////////


//---------------------------------------------------------------------------//

//////////       STAGE LOGIC        ///////////

// I_counter_Stage
	
I_counter I_Counter_inst(.en(1'b1), .clk(CLK), .rstb(RSTB), 
							.i(i));
							
I_comparator I_comparator_inst_initial_i(.curr_i_val(i), .comp_i_val(6'b000000), 
											.output_sig(initial_i));
											
I_comparator I_comparator_inst_end_flag(.curr_i_val(i), .comp_i_val(6'b111111), 
											.output_sig(end_flag));
											
I_Counter_stage_reg I_Counter_stage_reg_inst(.rstb(RSTB), .clk(CLK), .en(1'b1), .i(i), .initial_i(initial_i), .end_flag(end_flag), 
												.i_reg(st2_i), .initial_i_reg(st2_initial_i), .end_flag_reg(st2_end_flag));


//------------------------------------------------

// Ti_S_Fetcher_Stage

Ti_Fetcher Ti_Fetcher_inst(.clk(CLK), .initial_i(st2_initial_i), .rst(RST), .en(1'b1), .curr_i_val(st2_i), 
								.output_Ti_value(st2_Ti));
								
S_Fetcher S_Fetcher_inst(.clk(CLK), .initial_i(st2_initial_i), .rst(RST), .en(1'b1), .curr_i_val(st2_i), 
							.output_s_value(st2_s));
							
T_S_Fetcher_stage_reg T_S_Fetcher_stage_reg_inst(.clk(CLK), .en(1'b1), .rstb(RSTB), .st2_i(st2_i), .st2_initial_i(st2_initial_i), .st2_end_flag(st2_end_flag), .st2_Ti(st2_Ti), .st2_s(st2_s), 
													.st2_i_reg(st3_i), .st2_initial_i_reg(st3_initial_i), .st2_end_flag_reg(st3_end_flag), .st2_Ti_reg(st3_Ti), .st2_s_reg(st3_s));

//------------------------------------------------

// Xk_Fetcher_Stage

Xk_Fetcher Xk_Fetcher_inst(.clk(CLK), .initial_i(st3_initial_i), .rst(RST), .en(1'b1), .curr_i_val(st3_i),
							.output_Xk_value_wire(st3_Xk));

Xk_Fetcher_stage_reg Xk_Fetcher_stage_reg_inst(.clk(CLK), .en(1'b1), .rstb(RSTB), .st3_i(st3_i), .st3_initial_i(st3_initial_i), .st3_end_flag(st3_end_flag), .st3_Ti(st3_Ti), .st3_s(st3_s), .st3_Xk(st3_Xk),  
												.st3_i_reg(st4_i), .st3_initial_i_reg(st4_initial_i), .st3_end_flag_reg(st4_end_flag), .st3_Ti_reg(st4_Ti), .st3_s_reg(st4_s), .st3_Xk_reg(st4_Xk));									
								
//------------------------------------------------

// Xk_Ti_Adder_Stage

Xk_Ti_Adder Xk_Ti_Adder_inst(.clk(CLK), .initial_i(st4_initial_i), .rst(RST), .en(1'b1), .input_Xk(st4_Xk), .input_Ti(st4_Ti), 
								.output_Xk_plus_Ti(st4_Xk_plus_Ti));
								
Xk_Ti_Adder_stage_reg Xk_Ti_Adder_stage_reg_inst(.clk(CLK), .en(1'b1), .rstb(RSTB), .st4_i(st4_i), .st4_initial_i(st4_initial_i), .st4_end_flag(st4_end_flag), .st4_Xk_plus_Ti(st4_Xk_plus_Ti), .st4_s(st4_s), 
													.st4_i_reg(st5_i), .st4_initial_i_reg(st5_initial_i), .st4_end_flag_reg(st5_end_flag), .st4_Xk_plus_Ti_reg(st5_Xk_plus_Ti), .st4_s_reg(st5_s));
					
//------------------------------------------------

// Core_Calc_Stage

assign st5_sel = ~st5_initial_i;

assign st5_A_mux_output = (st5_sel) ? st6_A_out : A_input;
assign st5_B_mux_output = (st5_sel) ? st6_B_Temp_out : B_input;
assign st5_C_mux_output = (st5_sel) ? st6_C_out : C_input;
assign st5_D_mux_output = (st5_sel) ? st6_D_out : D_input;
										
combined_Func_calc_shift_adder combined_Func_calc_shift_adder_inst(.clk(CLK), .i_input(st5_i), .A_input(st5_A_mux_output), .B_input(st5_B_mux_output), .C_input(st5_C_mux_output), .D_input(st5_D_mux_output), 
																	.Xk_plus_Ti_input(st5_Xk_plus_Ti), .s_input(st5_s), .input_shifter_base(32'hFFFFFFFF), 
																		.int_B_output(st5_temp_B_out));
																		
Core_Calc_reg_new Core_Calc_reg_new_inst(.clk(CLK), .en(1'b1), .rstb(RSTB), .st5_i(st5_i), .st5_end_flag(st5_end_flag), .st5_s(st5_s), .st5_Func_res(st5_Func_res),
											.st5_Btemp(st5_temp_B_out), .st5_Aout(st5_D_mux_output), .st5_Cout(st5_B_mux_output), .st5_Dout(st5_C_mux_output),
												.st5_i_reg(st6_i), .st5_end_flag_reg(st6_end_flag), .st5_s_reg(st6_s), .st5_Func_res_reg(st6_Func_res),
												.st5_Btemp_reg(st6_B_Temp_out), .st5_Aout_reg(st6_A_out), .st5_Cout_reg(st6_C_out), .st5_Dout_reg(st6_D_out));									
									
//------------------------------------------------

// Final_Stage									
assign st6_final_regwrite_en = st6_end_flag;
								
always @ (*) begin

	if (RSTB == 1'b0) begin

		A_output = 32'd0000000;
		B_output = 32'd0000000;
		C_output = 32'd0000000;
		D_output = 32'd0000000;
		EOC_flag = 1'b0;
		
	end
	
	else begin
	
		if (st6_final_regwrite_en) begin
		
			A_output = A_input + st6_A_out;
			B_output = B_input + st6_B_Temp_out;
			C_output = C_input + st6_C_out;
			D_output = D_input + st6_D_out;
			EOC_flag = 1'b1;
	
	end
	
	end
end
								
endmodule
