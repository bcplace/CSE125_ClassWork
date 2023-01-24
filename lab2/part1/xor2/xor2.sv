module xor2
  (input [0:0] a_i
  ,input [0:0] b_i
  ,output [0:0] c_o);

   // Implement a Two-Input Exclusive OR Module (xor2). You must use behavioral verilog.
   // 
   // Your code here:
   logic c;
   always_comb begin
        c = a_i ^ b_i;
   end
   assign c_o = c;
endmodule
