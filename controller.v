// ----------------------------------------------------------------------
// 	A Verilog module for controlling MD5 Core
// ------------------------------------------------------------------------
module controller(Clk, Reset, complete);

input Clk, Reset;
output complete;

reg [9:0] counter;
reg [4:0] state;
reg [255:0] value;
reg [31:0] A_out,B_out,C_out,D_out;
wire [511:0] out;
wire [31:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
wire [31:0] A,B,C,D;
reg Rst_out;
reg [127:0] hash_out;
reg [9:0] Addr;
wire [255:0] R_in;
wire Done;
reg completed;

localparam
Get = 5'b00001,
Start = 5'b00010,
Wait = 5'b00100,
Next = 5'b01000,
Finished = 5'b10000;

always @(posedge Clk, posedge Reset) 

  begin
    if (Reset)
       begin
		state <= Get;
		counter <= 10'b0000000000;
		Addr <= 10'b0000000000;
		A_out <= 32'h67452301;
		B_out <= 32'hefcdab89;
		C_out <= 32'h98badcfe;
		D_out <= 32'h10325476;
		hash_out <= 128'd0;
		Rst_out <= 1;
		completed <= 0;
       end
    else
       begin
         case (state)
	        Get	: 
	          begin
		        value <= R_in;
				state <= Start;
	          end
	        Start	:
	          begin
				state <= Wait;
		        counter <= counter + 1;
				Rst_out <= 0;
 	          end
	        Wait	:
	          begin
				Rst_out<=1;
				if (Done)
					state <= Next;
	          end
			Next	:
	          begin  
				Addr <= counter;
				if(counter==10'b1111111111)
					begin
						state <= Finished;
						completed <= 1;
					end
				else
					state <= Get;
				hash_out <= {A,B,C,D};
	          end
			 Finished:
				begin
					state <= Finished;
				end
      endcase
    end 
  end
  
// assign out = {value, 192'h800000000000000000000000, 64'h00000100};
assign out = counter==10'd0 ? {64'h0000000000000100, 192'h800000000000000000000000, value}:{64'h0000000000000180, 64'h8000000000000000, hash_out, value};

assign c0 = out[31:0];
assign c1 = out[63:32];
assign c2 = out[95:64];
assign c3 = out[127:96];
assign c4 = out[159:128];
assign c5 = out[191:160];
assign c6 = out[223:192];
assign c7 = out[255:224];
assign c8 = out[287:256];
assign c9 = out[319:288];
assign c10 = out[351:320];
assign c11 = out[383:352];
assign c12 = out[415:384];
assign c13 = out[447:416];
assign c14 = out[479:448];
assign c15 = out[511:480];
assign complete = completed;

MD5_6Stage UUT(.CLK(Clk), .RSTB(Rst_out), .A_input(A_out), .B_input(B_out), .C_input(C_out), .D_input(D_out),
					.msg_x0(c0), .msg_x1(c1), .msg_x2(c2), .msg_x3(c3), .msg_x4(c4), .msg_x5(c5), .msg_x6(c6), .msg_x7(c7),
					.msg_x8(c8), .msg_x9(c9), .msg_x10(c10), .msg_x11(c11), .msg_x12(c12), .msg_x13(c13), .msg_x14(c14), .msg_x15(c15),
						.A_output(A), .B_output(B), .C_output(C), .D_output(D), .EOC_flag(Done));
						
rom r(Clk, Addr, R_in); 

endmodule