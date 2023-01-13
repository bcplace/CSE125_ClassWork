module mux2
  (input [0:0] a_i
  ,input [0:0] b_i
  ,input [0:0] select_i
  ,output [0:0] c_o);

   // Implement a Two-Input Multiplexer (mux2). For full credit you
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
   // The Truth Table of the mux is as follows:
   // 
   // For simplicity, A = a_i, B = b_i, S = select_i, C = c_o
   //
   // A | B | S | C
   // 0 | 0 | 0 | 0
   // 0 | 0 | 1 | 0
   // 0 | 1 | 0 | 0
   // 0 | 1 | 1 | 1
   // 1 | 0 | 0 | 1
   // 1 | 0 | 1 | 0
   // 1 | 0 | 0 | 1
   // 1 | 1 | 1 | 1
   // 
   // Your code here:
   wire select_not;
   wire and0out, and1out;
   inv select_inv (.a_i(select_i), .b_o(select_not));
   and2 and0 (.a_i(a_i), .b_i(select_not), .c_o(and0out));
   and2 and1 (.a_i(b_i), .b_i(select_i), .c_o(and1out));
   or2 or0 (.a_i(and1out), .b_i(and0out), .c_o(c_o));
   //assign c_o = (~select_i & a_i) | (select_i & b_i);
endmodule
