module mux2
  (input [0:0] a_i
  ,input [0:0] b_i
  ,input [0:0] select_i
  ,output [0:0] c_o);

   // Implement a Two-Input Multiplexer (mux2). You must use behavioral verilog.
   // 
   // Your code here:
   logic c;
   always_comb begin
   	c = (~select_i & a_i)|(select_i & b_i);
   end
   assign c_o = c;
endmodule
