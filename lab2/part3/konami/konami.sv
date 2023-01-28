module konami
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] up_i
   ,input [0:0] down_i
   ,input [0:0] left_i
   ,input [0:0] right_i
   ,input [0:0] b_i
   ,input [0:0] a_i
   ,input [0:0] start_i
   ,output [0:0] cheat_code_unlocked_o);

   // Implement a state machine to recognize the Konami Code.
   // 
   //    https://en.wikipedia.org/wiki/Konami_Code
   //
   // The sequence is: UP UP DOWN DOWN LEFT RIGHT LEFT RIGHT B A START
   //
   // The solution must:
   // 
   //  * Use behavioral verilog, written in this file
   // 
   //  * Go to the intitial state when reset_i is one
   //
   //  * Go back to the initial state on the next input to the machine.
   //
   //  * Set cheat_code_unlocked_o to 1 when the sequence is recognized
   //
   //  * Buttons may be asserted at the same time, but in the correct
   //  sequence, only one button is pressed at a time. (I.e. don't
   //  interpet UP and DOWN at the same time as an UP and then a
   //  DOWN. It is invalid.)
   //
   //  * Recognize any string with the correct sequence, for example
   //  DOWN UP UP UP DOWN DOWN LEFT RIGHT LEFT RIGHT B A START should
   //  assert cheat_code_unlocked_o
   // 
   // Your code here: 
   wire [4:0] inputs;
   logic [4:0] edges;
   logic [10:0] reg_o [4:0];
   enum logic [2:0] = {3'b001, 3'b010, 3'b100} state, next_state;
   
   assign inputs = {up_i, down_i, left_i, right_i, b_i};
   for(genvar i = 0; i < 5; i++) begin
       edgedetector
       edged
       (.clk_i(clk_i), .btn_i(inputs[i]), .edge_o(edges[i]));
   end
   
   for(genvar i = 0; i < 5; i++) begin
       shift
       #(11)
       inputreg
       (.clk_i(clk_i), .reset_i(1'b0), .data_i(edges[i]), .data_o(reg_o[i]));
   end
   
   always_comb begin
       
   
   
   always_ff (@posedge clk_i) begin
       if(reset_i) begin
           state <= Init;
       end else begin
           state <= next_state;
       end
   end
   
   assign cheat_code_unlocked_o = 1'b0;
endmodule

