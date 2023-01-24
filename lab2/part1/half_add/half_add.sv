module half_add
  (input [0:0] a_i
  ,input [0:0] b_i
  ,output [0:0] carry_o
  ,output [0:0] sum_o);

   // Implement a Half-Adder Module (half_add). You must use behavioral verilog.
   // 
   // Your code here:
   logic [1:0] carry;
   always_comb begin
   	carry = a_i + b_i;
   end
   assign sum_o = carry[0];
   assign carry_o = carry[1];
   
endmodule
