module half_add
  (input [0:0] a_i
  ,input [0:0] b_i
  ,output [0:0] carry_o
  ,output [0:0] sum_o);

   // Implement a Half-Adder Module (half_add). For full credit you
   // must use the three following modules provided:
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
   // Using any behavioral verilog operators will yield zero points
   // for code correctness (but not affect your demonstration grade).
   // You may use assign, instantiate modules, and declare wires.
   //
   // The Truth Table of the half_add module is as follows:
   // 
   // For simplicity, A = a_i, B = b_i, C = carry_o, S = sum_o
   //
   // A | B | S | C
   // 0 | 0 | 0 | 0
   // 0 | 1 | 1 | 0
   // 1 | 0 | 1 | 0
   // 1 | 1 | 0 | 1
   // 
   // Your code here:
   //XOR GATE
   wire A_B;
   wire _AB;
   wire _A;
   wire _B;
   inv inverter0 (.a_i(a_i), .b_o(_A));
   inv inverter1 (.a_i(b_i), .b_o(_B));
   and2 andgate0 (.a_i(_A), .b_i(b_i), .c_o(_AB));
   and2 andgate1 (.a_i(a_i), .b_i(_B), .c_o(A_B));
   or2 orgate0 (.a_i(_AB), .b_i(A_B), .c_o(sum_o));
   //
   and2 carry (.a_i(a_i), .b_i(b_i), .c_o(carry_o));
   

endmodule
