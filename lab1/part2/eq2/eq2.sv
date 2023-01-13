module eq2
  (input [0:0] a_i
  ,input [0:0] b_i
  ,output [0:0] c_o);

   // Implement a Two-Input Equality Module (eq2). For full credit you
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
   // The Truth Table of the eq2 module is as follows:
   // 
   // For simplicity, A = a_i, B = b_i,, C = c_o
   //
   // A | B | C
   // 0 | 0 | 1
   // 0 | 1 | 0
   // 1 | 0 | 0
   // 0 | 1 | 1
   // 
   // Your code here:
   wire A_B;
   wire _AB;
   wire _A;
   wire _B;
   wire xor_out;
   inv inverter0 (.a_i(a_i), .b_o(_A));
   inv inverter1 (.a_i(b_i), .b_o(_B));
   and2 andgate0 (.a_i(_A), .b_i(b_i), .c_o(_AB));
   and2 andgate1 (.a_i(a_i), .b_i(_B), .c_o(A_B));
   or2 orgate0 (.a_i(_AB), .b_i(A_B), .c_o(xor_out));
   inv inverter2 (.a_i(xor_out), .b_o(c_o));

endmodule
