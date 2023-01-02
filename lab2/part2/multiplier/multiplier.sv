module multiplier
  #(parameter width_p = 4)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] valid_i
   ,output [0:0] ready_then_o
   ,input [width_p - 1 : 0] a_i
   ,input [width_p - 1 : 0] b_i
   ,output [0:0] done_o
   ,output [(2*width_p) - 1 : 0] result_o);

   // Implement a parameterized accumulating (iteratve) multiplier.
   //
   // *** The solution may use any previously created module from this lab ***
   //
   // The module must implement the following behavior: 
   // 
   // * When reset_i is 1, reset the internal state of the module. All
   // other input signals should be ignored.
   //
   // * The module must set ready_then_o to 1 when it can accept an
   // input, and 0 when it cannot. It should not be set to 1 while the
   // module is still computing a result.
   //
   // * When ready_then_o is 1, valid_i will be set to 1 on some
   // subsequent clock cycle. (This is a ready-then-valid interface)
   //
   // * When valid_i is 1, a_i and b_i contain the two values to be
   // multiplied.
   //
   // * When the multiplier is finished it should set done_o to 1 for
   // one cycle and the product of a_i and b_i should be on result_o.
   //
   // Any solution that uses the behavioral verilog multiplication
   // operator will not get full points.
   //
   // For maximum modularity/reuse points, the correct solution must
   // use your up/down counter.
   //
   // Your code here:
   //
       
endmodule
