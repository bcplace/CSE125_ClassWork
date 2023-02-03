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
   /* verilator lint_off UNUSEDSIGNAL */

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
   wire [6:0] inputs;
   logic [10:0] reg_o [6:0];
   //logic [10:0] shift0, shift1, shift2, shift3, shift4, shift5, shift6; 
   logic match_l;
   logic sum_o;
   enum logic [1:0] {Init = 2'b01, check = 2'b10} state, next_state;
   logic reg_enable;
   
   assign reg_enable = |inputs | reset_i;
   assign inputs = {up_i, down_i, left_i, right_i, b_i, a_i, start_i};
   
   for(genvar i = 0; i < 7; i++) begin
       shift
       #(11)
       inputreg
       (.clk_i(clk_i&reg_enable), .reset_i(reset_i), .data_i(inputs[i]), .data_o(reg_o[i]));
   end
   
   
   always_comb begin
      match_l = 1'b0;
      sum_o = 1'b0;
      case(state)
           Init : begin
                  if(inputs[0]) begin
                      next_state = check;
                  end else begin
                      next_state = Init;
                  end
                  end
           check : begin
                       sum_o = reg_o[6][10]&reg_o[6][9]&reg_o[5][8]&reg_o[5][7]&reg_o[4][6]&reg_o[4][4]&reg_o[3][5]&reg_o[3][3]&reg_o[2][2]&reg_o[1][1]&reg_o[0][0];
                       if(sum_o) begin
                           match_l = 1'b1;
                           next_state = Init;
                       end else begin
                           next_state = Init;
                       end
                   end
           default : begin
                         next_state = Init;
                     end
       endcase
   end
   
   always_ff @(posedge clk_i) begin
       if(reset_i) begin
           state <= Init;
       end else begin
           state <= next_state;
       end
   end
   
   assign cheat_code_unlocked_o = match_l;
endmodule

