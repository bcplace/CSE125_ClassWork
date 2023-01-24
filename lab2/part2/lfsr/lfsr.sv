module lfsr
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,output [4:0] data_o);

   // Implement a 5-bit Many-to-One Linear Feedback Shift Register
   //
   // *** You may use any previously created module from this lab ***
   //
   // Your solution must include behavioral verilog written in this file.
   // 
   // Your LFSR should reset to 5'b00001 at the positive edge of clk_i when reset_i is high
   // 
   // Your code here:
   logic data_n;
   wire [4:0] out;
   shift
   #(5, 5'b00001) 
   shifter (.clk_i(clk_i), .reset_i(reset_i), .data_i(data_n), .data_o(out));
   always_comb begin
   	data_n = out[1] ^ out[4];
   end
   assign data_o = out;

endmodule
