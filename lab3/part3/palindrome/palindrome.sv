module palindrome
  #(parameter [31:0] depth_p = 32'd10)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [3:0] symbol_i
   ,input [0:0] valid_i
   ,output [0:0] overflow_o // Not required, but provided for debugging
   ,output [0:0] palindrome_o);

   // Implement a state machine to recognize any arbitrary palindrome
   // up to depth_p in length that starts from the first symbol. In
   // other words, you must recognize the sequence ABA, ABBA, and
   // BABBAB, but not BABBA.
   //
   // On sequences like BABBAB overflow_o should be set to 1 twice,
   // once on the 3-character palindrome, and again on the 6 character
   // palindrome.
   //
   //    https://en.wikipedia.org/wiki/Palindrome
   //
   // This assignment is inspired by push down automata. You are not
   // required to understand push down automata beyond the fact that
   // they are a state machine with a stack and used to understand
   // human language: https://en.wikipedia.org/wiki/Pushdown_automaton
   //
   // The solution must:
   // 
   //  * Go to an initial state when reset_i is one (this does not
   //  necessarily mean a state machine!)
   //
   //  * Accept symbol_i as a new symbol when valid_i is 1.
   //
   //  * Set palindrome_o to 1 when any valid palindrome is recognized
   //
   //  * Optional: Set overflow_o when the module can no longer
   //  recongize a palindrome.
   //
   // Your code here:
   
endmodule

