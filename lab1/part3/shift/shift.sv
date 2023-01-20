module shift
  #(parameter depth_p = 5
   ,parameter [depth_p-1:0] reset_val_p = 0)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] data_i
   ,output [depth_p-1:0] data_o);

   // Implement a parameterized, 1-bit shift register. 
   //
   // 
   // For full credit you must use the following modules provided:
   // 
   // 
   // D-Type Flip Flop
   // 
   // module dff
   //  #(parameter [0:0] reset_val_p = 1'b0)
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
   // A shift register is an array of registers, connected
   // in series. On each cycle, the shift register ingests a new value (data_i),
   // and moves the previous values forward by 1 index.
   //
   // Example:
   //
   //   Positive Edge Cycle 0 (i.e. the first cycle reset_i is set to 0):
   //     data_i = 1'b1, data_o = 5'b00000
   // 
   //   Positive Edge Cycle 1: 
   //     data_i = 1'b0, data_o = 5'b00001
   // 
   //   Positive Edge Cycle 2: 
   //     data_i = 1'b1, data_o = 5'b00010
   //   Positive Edge Cycle 3: 
   //     data_i = 1'b0, data_o = 5'b00101
   //
   //   And so on... 
   //
   // Your shift register should reset to reset_val_p when reset_i is high.
   // 
   // Your code here:

   dff
   #(reset_val_p[0])
   flipf
   (.clk_i(clk_i), .reset_i(reset_i), .d_i(data_i), .q_o(data_o[0]));
   for (genvar i = 1; i < depth_p; i++) begin 
   	dff
   	#(reset_val_p[i])
   	flop
   	(.clk_i(clk_i), .reset_i(reset_i), .d_i(data_o[i-1]), .q_o(data_o[i]));
   end
endmodule
