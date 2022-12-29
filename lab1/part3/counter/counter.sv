module counter
  #(parameter width_p = 4)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] up_i
   ,input [0:0] down_i
   ,output [width_p-1:0] count_o);

   // Implement a parameterized up/down counter
   //
   // *** You may use any previously created module from this lab. (Hint: adder) ***
   // 
   // For full credit you must use the following modules provided:
   // 
   // 
   // D-Type Flip Flop
   // 
   // module dff
   //   (input [0:0] clk_i
   //    ,input [0:0] reset_i // positive-polarity, synchronous reset
   //    ,input [0:0] d_i
   //    ,output [0:0] q_o);
   // 
   //
   // For more information see the the provided_modules directory.
   //
   // Using any behavioral verilog operators will yield zero points
   // for code correctness (but not affect your demonstration grade).
   // You may use assign, instantiate modules, and declare wires.
   //
   //
   // count_o must reset to '0 at the positive edge of clk_i when reset_i is 1
   //
   // count_o must have the following behavior at the positive edge of clk_i when reset_i is 0:
   // 
   // * Maintain the same value when up_i and down_i are both 1 or both 0.
   // 
   // * Increment by 1 when up_i is 1 and down_i is 0
   //
   // * Decrement by 1 when down_i is 1 and up_i is 0 
   //
   // * Use two's complement: -1 == '1 (Remember: decrementing by 1 is the same as adding negative 1)
   //
   // If the counter value overflows, return to 0. If the counter value underflows, return to the maximum value.
   //
   // (In other words you don't need to handle over/underflow conditions).
   // 
   // Your code here:
       
endmodule
