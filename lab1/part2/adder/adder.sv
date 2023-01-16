module adder
  #(parameter width_p = 1)
  (input [width_p - 1 : 0] a_i
  ,input [width_p - 1 : 0] b_i
  ,output [width_p : 0] sum_o); // Note, the missing -1 is not an error!

   // Implement a parameterized Adder Module (adder). 
   // 
   // *** For maximum points you should use the full_add module from this lab **
   // 
   // You can also use the three following modules provided:
   // 
   // Two-Input And Gate:
   // 
   // module and2
   //   (input [0:0] a_i
   //   ,input [0:0] b_i
   //   ,output [0:0] c_o);
   //
   // 
   // Two-Input Or Gate:
   // 
   // module or2
   //   (input [0:0] a_i
   //   ,input [0:0] b_i
   //   ,output [0:0] c_o);
   //
   // Inverter:
   // 
   // module inv
   // (input [0:0] a_i
   // ,output [0:0] b_o);
   //
   // For more information see the the provided_modules directory.
   // 
   //
   // Using any behavioral verilog operators will yield zero points
   // for code correctness (but not affect your demonstration grade).
   // 
   // You may use assign, instantiate modules, and declare wires.
   //
   // You should use a for loop to *instantiate* modules. 
   //
   // Your adder module must correctly compute the sum of A and B for any given value of width_p.
   //
   // Your adder module must correctly handle overflow (i.e. the bit at index width_p in sum_o)
   //
   // Your code here:
   wire [width_p - 1:0] carry_w;
   
   half_add adder0 (.a_i(a_i[0]), .b_i(b_i[0]), .carry_o(carry_w[0]), .sum_o(sum_o[0]));
   
   for(genvar i = 1; i < width_p; i++) begin
       full_add adder1 (.a_i(a_i[i]), .b_i(b_i[i]), .carry_i(carry_w[i-1]), .carry_o(carry_w[i]), .sum_o(sum_o[i]));
   end
   assign sum_o[width_p] = carry_w[width_p - 1];
endmodule
