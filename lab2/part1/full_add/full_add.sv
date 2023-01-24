module full_add
  (input [0:0] a_i
  ,input [0:0] b_i
  ,input [0:0] carry_i
  ,output [0:0] carry_o
  ,output [0:0] sum_o);

   // Implement a Full Adder Module (full_add). You must use behavioral verilog.
   // 
   // Your code here:
   logic [1:0] carry;
   always_comb begin
   	carry = a_i + b_i + carry_i;
   end
   assign carry_o = carry[1];
   assign sum_o = carry[0];
endmodule
