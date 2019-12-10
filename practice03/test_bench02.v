module   tb_mux4to1;
      
 reg    in0;
 reg    in1;
 reg    in2;
 reg    in3;
 reg    [1:0] sel;
 
 
 wire   out1;
 
 wire   out2;
 
 wire   out3;
 
 
 mux4to1_inst     dut_1     ( .out    (   out1      ),
                              .in0    (   in0       ),
                              .in1    (   in1       ),
                              .in2    (   in2       ),
                              .in3    (   in3       ),
                              .sel    (   sel       ));
                                                 
 mux4to1_if       dut_2     ( .out        (     out2                          ),
                              .in         (     {in3, in2, in1, in0}          ),
                              .sel        (     sel                           ));
                      
 mux4to1_case     dut_3     ( .out        (     out3                          ),
                              .in         (     {in3, in2, in1, in0}          ),
                              .sel        (     sel                           )); 
                        
initial begin
  
  $display(" Mux4to1_cond      :     out1");
  $display(" Mux4to1_if        :     out2");
  $display(" Mux4to1_case'     :     out3");
  $display("=========================================================");
  $display("  sel, in0, in1, in2, in3, out1, out2, out3 ");
  $display("========================================================="); 
  #(0)    {sel, in0, in1, in2, in3} = 6'b0000_000;
  #(50)   {sel, in0, in1, in2, in3} = 6'b0000_000; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   {sel, in0, in1, in2, in3} = 6'b0000_001; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   {sel, in0, in1, in2, in3} = 6'b0000_010; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   {sel, in0, in1, in2, in3} = 6'b0000_011; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   {sel, in0, in1, in2, in3} = 6'b0000_100; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   {sel, in0, in1, in2, in3} = 6'b1111_101; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   {sel, in0, in1, in2, in3} = 6'b1110_110; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   {sel, in0, in1, in2, in3} = 6'b1100_111; #(50)  $display("  %b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", sel, in0, in1, in2, in3, out1, out2, out3);
  #(50)   $finish           ;
  
end

endmodule  




