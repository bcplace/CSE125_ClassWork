module lfsr
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,output [4:0] data_o);

   // Implement a 5-bit Many-to-One Linear Feedback Shift Register
   //
   // https://www.eetimes.com/tutorial-linear-feedback-shift-registers-lfsrs-part-1/
   //
   // *** You may use any previously created module from this lab. (Hint: xor2) ***
   // 
   // Using any behavioral verilog operators will yield zero points
   // for code correctness (but not affect your demonstration grade).
   // You may use assign, instantiate modules, and declare wires.
   //
   //
   // A linear feedback shift register (LFSR)  is an array of registers, connected
   // in series. On each cycle, the LFSR bits represent a new pseudorandom value.
   // 
   // The values repeat after 2^bits - 1 cycles, because zero is never shown.
   //
   // Your LFSR should reset to 5'b00001 at the positive edge of clk_i when reset_i is high /////tap 1 and 4
   // 
   // Your code here:
   wire tap;
   dff
   #(1'b1)
   flip
   (.clk_i(clk_i), .reset_i(reset_i), .d_i(tap), .q_o(data_o[0]));
   for (genvar i = 1; i < 5; i++) begin
   	dff
   	#(1'b0)
   	flop
   	(.clk_i(clk_i), .reset_i(reset_i), .d_i(data_o[i-1]), .q_o(data_o[i]));
   end

   xor2
   xorgate
   (.a_i(data_o[1]), .b_i(data_o[4]), .c_o(tap));

endmodule
