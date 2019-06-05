`timescale 1 ns / 100 ps

module controller_tb ;
  
localparam CLK_PERIOD = 20;
reg Clk_tb, Rstb_tb;

controller UUT(Clk_tb, Rstb_tb);

initial
  begin  : CLK_GENERATOR
    Clk_tb = 0;
    forever
       begin
	      #(CLK_PERIOD/2) Clk_tb = ~Clk_tb;
       end 
  end

initial
  begin  : RESET_GENERATOR
    Rstb_tb = 1;
    #(2 * CLK_PERIOD) Rstb_tb = 0;
  end
  

endmodule
