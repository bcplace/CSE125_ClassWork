module counter
  #(parameter width_p = 4)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] up_i
   ,input [0:0] down_i
   ,output [width_p-1:0] counter_o);

   // Implement a parameterized up/down counter. You must use behavioral verilog
   //
   // counter_o must reset to '0 at the positive edge of clk_i when reset_i is 1
   //
   // counter_o must have the following behavior at the positive edge of clk_i when reset_i is 0:
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
   logic [width_p - 1:0] counter_valc;
   logic [width_p - 1:0] counter_valn;
   always_ff @(posedge clk_i) begin
   	if(reset_i) begin
   		counter_valc <= '0;
   	end else begin
   		counter_valc <= counter_valn;
   	end
   end
   
   always_comb begin
   	counter_valn = counter_valc;
   	case (up_i ^ down_i)
   		1'b1 : begin
	   		if(up_i) begin 
	   			counter_valn++; 
	   		end else begin
	   			counter_valn--;
	   		end
	   		end
   		default : ;
   	endcase
   end
   assign counter_o = counter_valc;
        	
endmodule


