module tb_bnb ;
  
reg		d	;
reg		clk	;

wire		q1	;
wire		q2	;

initial		         clk = 1'b0	;
always	   #(100)	 clk = ~clk	;  
  
 
block     dut_1  (.q    ( q1  ),
                  .d    ( d   ),
                  .clk  ( clk ));
               
               
nonblock  dut_2  (.q    ( q2  ),
                  .d    ( d   ),
                  .clk  ( clk ));
                  

initial begin
  
	$display("block: q1");
	$display("nonblock: q2");
	$display("==========================================================================");
	$display("	clk	d	q1	q2	");
	$display("==========================================================================");
	#(0)	{d} = 1'b_0;
	#(50)	{d} = 1'b_0;	#(50)	$display("	%b\t%b\t%b\t%b\t", clk, d, q1, q2);
	#(50)	{d} = 1'b_1;	#(50)	$display("	%b\t%b\t%b\t%b\t", clk, d, q1, q2);
	#(50)	{d} = 1'b_1;	#(50)	$display("	%b\t%b\t%b\t%b\t", clk, d, q1, q2);
	#(50)	{d} = 1'b_0;	#(50)	$display("	%b\t%b\t%b\t%b\t", clk, d, q1, q2);
	#(50)	{d} = 1'b_0;	#(50)	$display("	%b\t%b\t%b\t%b\t", clk, d, q1, q2);
	#(50)	{d} = 1'b_0;	#(50)	$display("	%b\t%b\t%b\t%b\t", clk, d, q1, q2);
	#(50)	{d} = 1'b_1;	#(50)	$display("	%b\t%b\t%b\t%b\t", clk, d, q1, q2);
	$finish;

	end
endmodule  