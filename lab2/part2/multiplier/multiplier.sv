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
   enum logic [2:0] {Init = 3'b001,
   		     comp = 3'b010,
   		     valid = 3'b100}
   		     states, next_state;
   
   logic [(2*width_p) : 0] carry;
   logic [(2*width_p) - 1 : 0] product = '0;
   wire [width_p  : 0] counter;
   logic end_comp;
   logic [width_p - 1 : 0] reg_a;
   logic [width_p - 1 : 0] reg_b;
   wire reset_counter;
   logic [(2*width_p) : 0] buffer_o;
   
   adder
   #(2*width_p)
   add (.a_i(product), .b_i({{width_p{1'b0}}, reg_a}), .sum_o(carry));
   
   counter
   #(width_p + 1) 
   count (.clk_i(clk_i), .reset_i(reset_i|reset_counter), .up_i(1'b1), .down_i(1'b0), .counter_o(counter));
   
   always_ff @(posedge clk_i) begin
       case(states)
       comp : buffer_o <= carry;
       default : buffer_o <= '0;
       endcase
   end
   
   always_ff @(posedge clk_i) begin
       if(valid_i) begin
           reg_a <= a_i;
           reg_b <= b_i;
       end
   end
   
   always_comb begin : next_state_logic
   	case(states) 
   	    Init : begin 
   	           if(~valid_i) begin
   	               next_state = Init;
   	           end else begin
   	               next_state = comp;
   	           end
   	           end
   	           
   	    comp : if(counter != reg_b + 1) begin
   	               product = buffer_o[(2*width_p) - 1 : 0];
   	               next_state = comp;
   	           end else begin
   	               end_comp = 1'b1;
   	               next_state = valid;
   	           end
   	           
   	   valid : begin
   	           next_state = Init;
   	           end_comp = 1'b0;
   	           end
   	   default : next_state = Init;
   	endcase
   end
   
   always_ff @(posedge clk_i) begin
   	if(reset_i) begin
   	    states <= Init;
   	end else begin
   	    states <= next_state;
   	end
   end
   
   
   assign ready_then_o = states[0];
   assign done_o = states[1] & end_comp;
   assign result_o = product;
   assign reset_counter = states[0] & valid_i;
               
       
endmodule
