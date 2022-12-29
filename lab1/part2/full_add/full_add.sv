module full_add
  (input [0:0] a_i
  ,input [0:0] b_i
  ,input [0:0] carry_i
  ,output [0:0] carry_o
  ,output [0:0] sum_o);

   // Implement a Full Adder Module (full_add). 
   // 
   // *** You may use any previously created module from this lab. ***
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
   // The Truth Table of the eq2 module is as follows:
   // 
   // For simplicity, A = a_i, B = b_i, Ci = carry_i, Co = carry_o, S = sum_o
   //
   // A | B | Ci | S | Co
   // 0 | 0 | 0  | 0 | 0
   // 0 | 0 | 1  | 1 | 0
   // 0 | 1 | 0  | 1 | 0
   // 0 | 1 | 1  | 0 | 1
   // 1 | 0 | 0  | 1 | 0
   // 1 | 0 | 1  | 0 | 1
   // 1 | 1 | 0  | 0 | 1
   // 1 | 1 | 1  | 1 | 1
   // 
   // Your code here:

endmodule
