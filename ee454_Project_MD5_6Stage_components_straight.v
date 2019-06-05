//////////////////////////////
//////////////////////////////
//////////////////////////////
///////////////////////////////


//I_Counter_Stage - Stage 1
`timescale 1 ns / 100 ps
module I_Counter_stage_reg(rstb, clk, en, i, initial_i, end_flag, 
							i_reg, initial_i_reg, end_flag_reg);
    
	input rstb, clk, en;
    input [5:0] i;
	input initial_i, end_flag;
	
	output reg [5:0] i_reg;
    output reg initial_i_reg, end_flag_reg;
	
    always @(posedge clk, negedge rstb) begin
		if (rstb == 1'b0) begin
			i_reg <= 6'b000000;
			initial_i_reg <= 1'b0;
			end_flag_reg <= 1'b0;
		end
		else begin 
			if (en) begin
				i_reg <= i;
				initial_i_reg <= initial_i;
				end_flag_reg <= end_flag;
			end  
		end
	end
endmodule //I counter Stage

//Ti_S_Fetcher_Stage - Stage 2
module T_S_Fetcher_stage_reg(clk, en, rstb, st2_i, st2_initial_i, st2_end_flag, st2_Ti, st2_s, 
								st2_i_reg, st2_initial_i_reg, st2_end_flag_reg, st2_Ti_reg, st2_s_reg);

	input rstb, clk, en;
	input [5:0] st2_i;
	input [4:0] st2_s;
	input [31:0] st2_Ti;
	input st2_initial_i, st2_end_flag;

	output reg [5:0] st2_i_reg;
	output reg [4:0] st2_s_reg;
	output reg [31:0] st2_Ti_reg;
	output reg st2_initial_i_reg, st2_end_flag_reg;
	
    always @(posedge clk, negedge rstb) begin
		if (rstb == 1'b0) begin
			st2_i_reg <= 6'b000000;
			st2_Ti_reg <= 32'h00000000;
			st2_s_reg <= 5'b00000;
			st2_initial_i_reg <= 1'b0;
			st2_end_flag_reg <= 1'b0;
		end
		else begin 
			if (en) begin
				st2_i_reg <= st2_i;
				st2_Ti_reg <= st2_Ti;
				st2_s_reg <= st2_s;
				st2_initial_i_reg <= st2_initial_i;
				st2_end_flag_reg <= st2_end_flag;
			end
		end
	end
endmodule

//Xk_Fetcher_Stage - Stage 3
module Xk_Fetcher_stage_reg(clk, en, rstb, st3_i, st3_initial_i, st3_end_flag, st3_Ti, st3_s, st3_Xk,  
								st3_i_reg, st3_initial_i_reg, st3_end_flag_reg, st3_Ti_reg, st3_s_reg, st3_Xk_reg);

	input rstb, clk, en;
	input [5:0] st3_i;
	input [4:0] st3_s;
	input [31:0] st3_Ti, st3_Xk;
	input st3_initial_i, st3_end_flag;

	output reg [5:0] st3_i_reg;
	output reg [4:0] st3_s_reg;
	output reg [31:0] st3_Ti_reg, st3_Xk_reg;
	output reg st3_initial_i_reg, st3_end_flag_reg;
	
    always @(posedge clk, negedge rstb) begin
		if (rstb == 1'b0) begin
			st3_i_reg <= 6'b000000;
			st3_Ti_reg <= 32'h00000000;
			st3_s_reg <= 5'b00000;
			st3_Xk_reg <= 32'h00000000;
			st3_initial_i_reg <= 1'b0;
			st3_end_flag_reg <= 1'b0;
		end
		else begin 
			if (en) begin
				st3_i_reg <= st3_i;
				st3_Ti_reg <= st3_Ti;
				st3_s_reg <= st3_s;
				st3_Xk_reg <= st3_Xk;
				st3_initial_i_reg <= st3_initial_i;
				st3_end_flag_reg <= st3_end_flag;
			end
		end
	end
endmodule

//Xk_Ti_Adder_Stage - Stage 4
module Xk_Ti_Adder_stage_reg(clk, en, rstb, st4_i, st4_initial_i, st4_end_flag, st4_Xk_plus_Ti, st4_s, 
								st4_i_reg, st4_initial_i_reg, st4_end_flag_reg, st4_Xk_plus_Ti_reg, st4_s_reg);

	input rstb, clk, en;
	input [5:0] st4_i;
	input [4:0] st4_s;
	input [31:0] st4_Xk_plus_Ti;
	input st4_initial_i, st4_end_flag;

	output reg [5:0] st4_i_reg;
	output reg [4:0] st4_s_reg;
	output reg [31:0] st4_Xk_plus_Ti_reg;
	output reg st4_initial_i_reg, st4_end_flag_reg;
	
    always @(posedge clk, negedge rstb) begin
		if (rstb == 1'b0) begin
			st4_i_reg <= 6'b000000;
			st4_Xk_plus_Ti_reg <= 32'h00000000;
			st4_s_reg <= 5'b00000;
			st4_initial_i_reg <= 1'b0;
			st4_end_flag_reg <= 1'b0;
		end
		else begin 
			if (en) begin
				st4_i_reg <= st4_i;
				st4_Xk_plus_Ti_reg <= st4_Xk_plus_Ti;
				st4_s_reg <= st4_s;
				st4_initial_i_reg <= st4_initial_i;
				st4_end_flag_reg <= st4_end_flag;
			end
		end
	end
endmodule

//Core_Calc_stage - Stage 5
module Core_Calc_reg(clk, en, rstb, st5_i, st5_end_flag, st5_Xk_plus_Ti, st5_s, st5_Func_res,
						st5_Btemp, st5_Atemp, st5_Aout, st5_Cout, st5_Dout,
							st5_i_reg, st5_end_flag_reg, st5_Xk_plus_Ti_reg, st5_s_reg, st5_Func_res_reg,
							st5_Btemp_reg, st5_Atemp_reg, st5_Aout_reg, st5_Cout_reg, st5_Dout_reg);

	input rstb, clk, en;
	input [5:0] st5_i;
	input [4:0] st5_s;
	input [31:0] st5_Btemp, st5_Atemp, st5_Aout, st5_Cout, st5_Dout, st5_Xk_plus_Ti, st5_Func_res;
	input st5_end_flag;

	output reg [5:0] st5_i_reg;
	output reg [4:0] st5_s_reg;
	output reg [31:0] st5_Btemp_reg, st5_Atemp_reg, st5_Aout_reg, st5_Cout_reg, st5_Dout_reg, st5_Xk_plus_Ti_reg, st5_Func_res_reg;
	output reg st5_end_flag_reg;
	
    always @(posedge clk, negedge rstb) begin
		if (rstb == 1'b0) begin
			st5_i_reg <= 6'b000000;
			st5_Xk_plus_Ti_reg <= 32'h00000000;
			st5_s_reg <= 5'b00000;
			st5_Btemp_reg <= 32'h00000000;
			st5_Atemp_reg <= 32'h00000000;
			st5_Aout_reg <= 32'h00000000;
			st5_Cout_reg <= 32'h00000000;
			st5_Dout_reg <= 32'h00000000;
			st5_Func_res_reg <= 32'h00000000;
			st5_end_flag_reg <= 1'b0;
		end
		else begin 
			if (en) begin
				st5_i_reg <= st5_i;
				st5_Xk_plus_Ti_reg <= st5_Xk_plus_Ti;
				st5_s_reg <= st5_s;
				st5_Btemp_reg <= st5_Btemp;
				st5_Atemp_reg <= st5_Atemp;
				st5_Aout_reg <= st5_Aout;
				st5_Cout_reg <= st5_Cout;
				st5_Dout_reg <= st5_Dout;
				st5_Func_res_reg <= st5_Func_res;
				st5_end_flag_reg <= st5_end_flag;
			end
		end
	end
endmodule

module Core_Calc_reg_new(clk, en, rstb, st5_i, st5_end_flag, st5_s, st5_Func_res,
							st5_Btemp, st5_Aout, st5_Cout, st5_Dout,
								st5_i_reg, st5_end_flag_reg, st5_s_reg, st5_Func_res_reg,
								st5_Btemp_reg, st5_Aout_reg, st5_Cout_reg, st5_Dout_reg);

	input rstb, clk, en;
	input [5:0] st5_i;
	input [4:0] st5_s;
	input [31:0] st5_Btemp, st5_Aout, st5_Cout, st5_Dout, st5_Func_res;
	input st5_end_flag;

	output reg [5:0] st5_i_reg;
	output reg [4:0] st5_s_reg;
	output reg [31:0] st5_Btemp_reg, st5_Aout_reg, st5_Cout_reg, st5_Dout_reg, st5_Func_res_reg;
	output reg st5_end_flag_reg;
	
    always @(posedge clk, negedge rstb) begin
		if (rstb == 1'b0) begin
			st5_i_reg <= 6'b000000;
			st5_s_reg <= 5'b00000;
			st5_Btemp_reg <= 32'h00000000;
			st5_Aout_reg <= 32'h00000000;
			st5_Cout_reg <= 32'h00000000;
			st5_Dout_reg <= 32'h00000000;
			st5_Func_res_reg <= 32'h00000000;
			st5_end_flag_reg <= 1'b0;
		end
		else begin 
			if (en) begin
				st5_i_reg <= st5_i;
				st5_s_reg <= st5_s;
				st5_Btemp_reg <= st5_Btemp;
				st5_Aout_reg <= st5_Aout;
				st5_Cout_reg <= st5_Cout;
				st5_Dout_reg <= st5_Dout;
				st5_Func_res_reg <= st5_Func_res;
				st5_end_flag_reg <= st5_end_flag;
			end
		end
	end
endmodule

//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////

//I_Counter - I_Counter_stage - 1st Stage
module I_counter (en, clk, rstb, i);
	input en, clk, rstb;
	output reg [5:0] i;
	always @ (posedge clk, negedge rstb) begin 
			if (rstb == 1'b0) begin
					i = 6'b000000;
			end
			else begin
					if (en) begin
						i = i + 1;
					end
			end
	end
endmodule

//I_Comparator - I_Counter_stage - 1st Stage
module I_comparator (curr_i_val, comp_i_val, output_sig);
	input [5:0] curr_i_val, comp_i_val;
	output reg output_sig;
	
	always @ (curr_i_val, comp_i_val) begin
			output_sig = 0;
			if (curr_i_val == comp_i_val)
				output_sig = 1;
	end
endmodule

//T(i) Fetcher - Ti_S_Fetcher_Stage - 2nd stage 
// From Xilinx docs - https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_6/xst.pdf - page 191
module Ti_Fetcher (clk, initial_i, rst, en, curr_i_val, output_Ti_value);
	input clk, rst, en, initial_i;
	input [5:0] curr_i_val;
	reg toggle_flag;
	output reg [31:0] output_Ti_value;
	
	// always @ (posedge clk, negedge rst) begin
	always @ (*) begin
		
		if (rst == 1'b0) begin 
			output_Ti_value = 32'h00000000;
			toggle_flag <= 0;
		end
		
		else begin
			output_Ti_value = 32'h00000000;
			if (initial_i) begin
				toggle_flag = 1;
			end
		
			if(toggle_flag) begin
					case(curr_i_val)
					
						6'b000000: output_Ti_value = 32'hd76AA478; 6'b100000: output_Ti_value = 32'hFFFA3942;
						6'b000001: output_Ti_value = 32'hE8C7B756; 6'b100001: output_Ti_value = 32'h8771F681;
						6'b000010: output_Ti_value = 32'h242070DB; 6'b100010: output_Ti_value = 32'h6D9D6122;
						6'b000011: output_Ti_value = 32'hC1BDCEEE; 6'b100011: output_Ti_value = 32'hFDE5380C;
						6'b000100: output_Ti_value = 32'hF57C0FAF; 6'b100100: output_Ti_value = 32'hA4BEEA44;
						6'b000101: output_Ti_value = 32'h4787C62A; 6'b100101: output_Ti_value = 32'h4BDECFA9;
						6'b000110: output_Ti_value = 32'hA8304613; 6'b100110: output_Ti_value = 32'hF6BB4B60;
						6'b000111: output_Ti_value = 32'hFD469501; 6'b100111: output_Ti_value = 32'hBEBFBC70;
						6'b001000: output_Ti_value = 32'h698098D8; 6'b101000: output_Ti_value = 32'h289B7EC6;
						6'b001001: output_Ti_value = 32'h8B44F7AF; 6'b101001: output_Ti_value = 32'hEAA127FA;
						6'b001010: output_Ti_value = 32'hFFFF5BB1; 6'b101010: output_Ti_value = 32'hD4EF3085;
						6'b001011: output_Ti_value = 32'h895CD7BE; 6'b101011: output_Ti_value = 32'h04881D05;
						6'b001100: output_Ti_value = 32'h6B901122; 6'b101100: output_Ti_value = 32'hD9D4D039;
						6'b001101: output_Ti_value = 32'hFD987193; 6'b101101: output_Ti_value = 32'hE6DB99E5;
						6'b001110: output_Ti_value = 32'hA679438E; 6'b101110: output_Ti_value = 32'h1FA27CF8;
						6'b001111: output_Ti_value = 32'h49B40821; 6'b101111: output_Ti_value = 32'hC4AC5665;
						6'b010000: output_Ti_value = 32'hF61E2562; 6'b110000: output_Ti_value = 32'hF4292244;
						6'b010001: output_Ti_value = 32'hC040B340; 6'b110001: output_Ti_value = 32'h432AFF97;
						6'b010010: output_Ti_value = 32'h265E5A51; 6'b110010: output_Ti_value = 32'hAB9423A7;
						6'b010011: output_Ti_value = 32'hE9B6C7AA; 6'b110011: output_Ti_value = 32'hFC93A039;
						6'b010100: output_Ti_value = 32'hD62F105D; 6'b110100: output_Ti_value = 32'h655B59C3;
						6'b010101: output_Ti_value = 32'h02441453; 6'b110101: output_Ti_value = 32'h8F0CCC92;
						6'b010110: output_Ti_value = 32'hD8A1E681; 6'b110110: output_Ti_value = 32'hFFEFF47D;
						6'b010111: output_Ti_value = 32'hE7D3FBC8; 6'b110111: output_Ti_value = 32'h85845DD1;
						6'b011000: output_Ti_value = 32'h21E1CDE6; 6'b111000: output_Ti_value = 32'h6FA87E4F;
						6'b011001: output_Ti_value = 32'hC33707D6; 6'b111001: output_Ti_value = 32'hFE2CE6E0;
						6'b011010: output_Ti_value = 32'hF4D50D87; 6'b111010: output_Ti_value = 32'hA3014314;
						6'b011011: output_Ti_value = 32'h455A14ED; 6'b111011: output_Ti_value = 32'h4E0811A1;
						6'b011100: output_Ti_value = 32'hA9E3E905; 6'b111100: output_Ti_value = 32'hF7537E82;
						6'b011101: output_Ti_value = 32'hFCEFA3F8; 6'b111101: output_Ti_value = 32'hBD3AF235;
						6'b011110: output_Ti_value = 32'h676F02D9; 6'b111110: output_Ti_value = 32'h2AD7D2BB;
						6'b011111: output_Ti_value = 32'h8D2A4C8A; 6'b111111: output_Ti_value = 32'hEB86D391;
					endcase
			end
		end
	end
	
endmodule


//S Fetcher - Ti_S_Fetcher_Stage - 2nd stage 
// From Xilinx docs - https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_6/xst.pdf - page 191
module S_Fetcher (clk, initial_i, rst, en, curr_i_val, output_s_value);
	input clk, rst, en, initial_i;
	input [5:0] curr_i_val;
	reg toggle_flag;
	output reg [4:0] output_s_value;
	
	always @ (*) begin
	
		if (rst == 1'b0) begin
			output_s_value = 5'd0;
			toggle_flag = 0;
		end
		else begin
		
			output_s_value = 5'd0;
			if(initial_i) begin
				toggle_flag = 1;
			end
		
			if(toggle_flag) begin
					case(curr_i_val)
					
						6'b000000: output_s_value = 5'd7	; 6'b100000: output_s_value = 5'd4;
						6'b000001: output_s_value = 5'd12	; 6'b100001: output_s_value = 5'd11;
						6'b000010: output_s_value = 5'd17	; 6'b100010: output_s_value = 5'd16;
						6'b000011: output_s_value = 5'd22	; 6'b100011: output_s_value = 5'd23;
						6'b000100: output_s_value = 5'd7	; 6'b100100: output_s_value = 5'd4;
						6'b000101: output_s_value = 5'd12	; 6'b100101: output_s_value = 5'd11;
						6'b000110: output_s_value = 5'd17	; 6'b100110: output_s_value = 5'd16;
						6'b000111: output_s_value = 5'd22	; 6'b100111: output_s_value = 5'd23;
						6'b001000: output_s_value = 5'd7	; 6'b101000: output_s_value = 5'd4;
						6'b001001: output_s_value = 5'd12	; 6'b101001: output_s_value = 5'd11;
						6'b001010: output_s_value = 5'd17	; 6'b101010: output_s_value = 5'd16;
						6'b001011: output_s_value = 5'd22	; 6'b101011: output_s_value = 5'd23;
						6'b001100: output_s_value = 5'd7	; 6'b101100: output_s_value = 5'd4;
						6'b001101: output_s_value = 5'd12	; 6'b101101: output_s_value = 5'd11;
						6'b001110: output_s_value = 5'd17	; 6'b101110: output_s_value = 5'd16;
						6'b001111: output_s_value = 5'd22	; 6'b101111: output_s_value = 5'd23;
						6'b010000: output_s_value = 5'd5	; 6'b110000: output_s_value = 5'd6;
						6'b010001: output_s_value = 5'd9	; 6'b110001: output_s_value = 5'd10;
						6'b010010: output_s_value = 5'd14	; 6'b110010: output_s_value = 5'd15;
						6'b010011: output_s_value = 5'd20	; 6'b110011: output_s_value = 5'd21;
						6'b010100: output_s_value = 5'd5	; 6'b110100: output_s_value = 5'd6;
						6'b010101: output_s_value = 5'd9	; 6'b110101: output_s_value = 5'd10;
						6'b010110: output_s_value = 5'd14	; 6'b110110: output_s_value = 5'd15;
						6'b010111: output_s_value = 5'd20	; 6'b110111: output_s_value = 5'd21;
						6'b011000: output_s_value = 5'd5	; 6'b111000: output_s_value = 5'd6;
						6'b011001: output_s_value = 5'd9	; 6'b111001: output_s_value = 5'd10;
						6'b011010: output_s_value = 5'd14	; 6'b111010: output_s_value = 5'd15;
						6'b011011: output_s_value = 5'd20	; 6'b111011: output_s_value = 5'd21;
						6'b011100: output_s_value = 5'd5	; 6'b111100: output_s_value = 5'd6;
						6'b011101: output_s_value = 5'd9	; 6'b111101: output_s_value = 5'd10;
						6'b011110: output_s_value = 5'd14	; 6'b111110: output_s_value = 5'd15;
						6'b011111: output_s_value = 5'd20	; 6'b111111: output_s_value = 5'd21;
					endcase
			end
		end
	end
	
endmodule   


//K Fetcher - Xk_Fetcher_Stage - 3rd stage 
// From Xilinx docs - https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_6/xst.pdf - page 191
module Xk_Fetcher (clk, initial_i, rst, en, curr_i_val, output_Xk_value_wire);
	input clk, en, rst, initial_i;
	input [5:0] curr_i_val;
	reg [31:0] input_X_msg [15:0];
	reg [3:0] output_k_value;
	wire [3:0] output_k_value_wire;
	reg [31:0] output_Xk_value;
	reg toggle_flag;
	output wire [31:0] output_Xk_value_wire;
	
	assign output_k_value_wire = output_k_value;
	assign output_Xk_value_wire = output_Xk_value;
	
	
	always @ (*) begin
		case(curr_i_val)
					
						6'b000000: output_k_value = 4'd0	; 6'b100000: output_k_value = 4'd5;
						6'b000001: output_k_value = 4'd1	; 6'b100001: output_k_value = 4'd8;
						6'b000010: output_k_value = 4'd2	; 6'b100010: output_k_value = 4'd11;
						6'b000011: output_k_value = 4'd3	; 6'b100011: output_k_value = 4'd14;
						6'b000100: output_k_value = 4'd4	; 6'b100100: output_k_value = 4'd1;
						6'b000101: output_k_value = 4'd5	; 6'b100101: output_k_value = 4'd4;
						6'b000110: output_k_value = 4'd6	; 6'b100110: output_k_value = 4'd7;
						6'b000111: output_k_value = 4'd7	; 6'b100111: output_k_value = 4'd10;
						6'b001000: output_k_value = 4'd8	; 6'b101000: output_k_value = 4'd13;
						6'b001001: output_k_value = 4'd9	; 6'b101001: output_k_value = 4'd0;
						6'b001010: output_k_value = 4'd10	; 6'b101010: output_k_value = 4'd3;
						6'b001011: output_k_value = 4'd11	; 6'b101011: output_k_value = 4'd6;
						6'b001100: output_k_value = 4'd12	; 6'b101100: output_k_value = 4'd9;
						6'b001101: output_k_value = 4'd13	; 6'b101101: output_k_value = 4'd12;
						6'b001110: output_k_value = 4'd14	; 6'b101110: output_k_value = 4'd15;
						6'b001111: output_k_value = 4'd15	; 6'b101111: output_k_value = 4'd2;
						6'b010000: output_k_value = 4'd1	; 6'b110000: output_k_value = 4'd0;
						6'b010001: output_k_value = 4'd6	; 6'b110001: output_k_value = 4'd7;
						6'b010010: output_k_value = 4'd11	; 6'b110010: output_k_value = 4'd14;
						6'b010011: output_k_value = 4'd0	; 6'b110011: output_k_value = 4'd5;
						6'b010100: output_k_value = 4'd5	; 6'b110100: output_k_value = 4'd12;
						6'b010101: output_k_value = 4'd10	; 6'b110101: output_k_value = 4'd3;
						6'b010110: output_k_value = 4'd15	; 6'b110110: output_k_value = 4'd10;
						6'b010111: output_k_value = 4'd4	; 6'b110111: output_k_value = 4'd1;
						6'b011000: output_k_value = 4'd9	; 6'b111000: output_k_value = 4'd8;
						6'b011001: output_k_value = 4'd14	; 6'b111001: output_k_value = 4'd15;
						6'b011010: output_k_value = 4'd3	; 6'b111010: output_k_value = 4'd6;
						6'b011011: output_k_value = 4'd8	; 6'b111011: output_k_value = 4'd13;
						6'b011100: output_k_value = 4'd13	; 6'b111100: output_k_value = 4'd4;
						6'b011101: output_k_value = 4'd2	; 6'b111101: output_k_value = 4'd11;
						6'b011110: output_k_value = 4'd7	; 6'b111110: output_k_value = 4'd2;
						6'b011111: output_k_value = 4'd12	; 6'b111111: output_k_value = 4'd9;
		endcase
	end
	
	// Input message - Hello World
	// link : https://www.scribd.com/doc/35954574/MD5-With-Example
	// all values are in little endian
	
	always @ (*) begin
		
		if (rst == 1'b0) begin
			output_Xk_value = 32'h00000000;
			toggle_flag <= 0;
		end
		else begin
			output_Xk_value = 32'h00000000;
			if (initial_i) begin
				toggle_flag = 1;
			end
			if(toggle_flag) begin					
					output_Xk_value = input_X_msg[output_k_value_wire];
			end
		end
	end
	
endmodule

//Xk_Ti_Adder - Xk_Ti_Adder_Stage - 3rd stage
module Xk_Ti_Adder (clk, initial_i, rst, en, input_Xk, input_Ti, output_Xk_plus_Ti);
	
	input clk, en, rst, initial_i;
	input [31:0] input_Xk, input_Ti;
	output wire [31:0] output_Xk_plus_Ti;
	
	assign output_Xk_plus_Ti = input_Ti + input_Xk;
	
endmodule

//combined_Func_calc_shift_adder - Core_Calc_stage
module combined_Func_calc_shift_adder(clk, i_input, A_input, B_input, C_input, D_input, Xk_plus_Ti_input, s_input, input_shifter_base, int_B_output);
	input clk;
	input [5:0] i_input;
	input [31:0] A_input, B_input, C_input, D_input, Xk_plus_Ti_input, input_shifter_base;
	reg [31:0] F_shifted_output, F_output;
	input [4:0] s_input;
	output reg [31:0] int_B_output;
	reg [31:0] shifter_mask, working_B_reg, working_shifted_output, Func_res_output, F_circular_shifted_output, F_shift_lower;
	reg [1:0] func_sel;
	
 	always @ (*) begin
	
		Func_res_output = 32'h00000000;
		F_output = 32'h00000000;
		
		func_sel = 2'b11; 
		if (i_input < 48)
			func_sel = 2'b10;
		if (i_input < 32)
			func_sel = 2'b01;
		if (i_input < 16)
			func_sel = 2'b00;
			
		case (func_sel)
		
			2'b00: Func_res_output = (B_input & C_input) | ((~B_input) & D_input);
			2'b01: Func_res_output = (B_input & D_input) | (C_input & (~D_input));
			2'b10: Func_res_output = B_input ^ C_input ^ D_input;
			2'b11: Func_res_output = C_input ^ (B_input | (~D_input));
		
		endcase
		
		F_output = Func_res_output + A_input + Xk_plus_Ti_input;
		
		// to perform circular shift - as circular shift is not readily available in Verilog
		shifter_mask = ~ (input_shifter_base >> s_input);
		F_shift_lower = F_output & shifter_mask;
		F_shift_lower = F_shift_lower >> (31 - s_input + 1);
		F_shifted_output = F_output << s_input;
		F_circular_shifted_output = F_shifted_output + F_shift_lower;
		
		int_B_output = B_input + F_circular_shifted_output;
	
	end 
	
endmodule
