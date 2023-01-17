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
   
      wire [0:0] enable;
      wire [width_p - 1:0] d_w;
      wire overflow;
      wire clk_enable;
      
      xor2 
      xor2_inst1
      (.a_i(up_i), 
      .b_i(down_i),
      .c_o(enable)
      );
      
      and2 
      #()
      and0
      (.a_i(clk_i), .b_i(enable), .c_o(clk_enable));
      
      genvar i;
      for (i = 0; i < width_p; i++) begin
      dff 
      #()
      dff_inst
      (.clk_i(clk_i),
      .reset_i(reset_i),
      .d_i(d_w[i]),
      .q_o(count_o[i])
      );
      end
      
      wire enableandup;
      wire enableanddown;
      wire [width_p - 1: 0] change_w;
      
      for (i = width_p - 1; i > 0; i--) begin
      and2
      #()
      and_inst
      (.a_i(enable), .b_i(down_i), .c_o(change_w[i]));
      end
      
      mux2
      #()
      mux2_inst
      (.a_i(1'b0), .b_i(1'b1), .select_i(enable), .c_o(change_w[0]));
      
      adder
	#(.width_p(width_p))
	adder0
	(.a_i(count_o), 
	.b_i(change_w), 
	.sum_o({overflow, d_w}));
      
   /*always @* begin
	if(enableandup)
		adder
		#(.width_p(width_p))
		adder0
		(.a_i(count_o), 
		.b_i({{width_p - 1{1'b0}},1'b1}), 
		.sum_o({overflow, d_w}));
	end
      
      else begin
              adder
		#(.width_p(width_p))
		adder0
		(.a_i(count_o), 
		.b_i({{width_p - 1{1'b0}},1'b1}), 
		.sum_o({overflow, d_w}));
	  end
   end*/
endmodule
