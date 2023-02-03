`timescale 1ns/1ps
module testb();

nonsynth_clock_gen
     #(.cycle_time_p(10))
   cg
     (.clk_o(clk_i));

   nonsynth_reset_gen
     #(.num_clocks_p(1)
       ,.reset_cycles_lo_p(1)
       ,.reset_cycles_hi_p(10))
   rg
     (.clk_i(clk_i)
      ,.async_reset_o(reset_i));
      
   logic up, down, left, right, b, a, start, clk_i, reset_i;
   wire cheat_code;
   wire up_debounce;
   
   konami
   #()
   dut (.clk_i(clk_i), .reset_i(reset_i), .up_i(up), .down_i(down), .left_i(left), .right_i(right), .b_i(b), .a_i(a), .start_i(start), .cheat_code_unlocked_o(cheat_code));
   
   debouncer
   test
   (.clk_i(clk_i), .btn_i(up), .debounced_o(up_debounce));
   
   initial
   begin
   `ifdef VERILATOR
      $dumpfile("verilator.fst");
`else
      $dumpfile("iverilog.vcd");
`endif
      $dumpvars;
   end
   
   initial
   begin
   #120
   up = 1'b0;
   down = 1'b0;
   left = 1'b0;
   right = 1'b0;
   b = 1'b0;
   a = 1'b0;
   start = 1'b0;
   #50
   start = 1'b1;
   #50
   start = 1'b0;
   up = 1'b1;
   #20
   up = 1'b0;
   down = 1'b1;
   #20
   down = 1'b0;
   left = 1'b1;
   #10
   left = 1'b0;
   right = 1'b1;
   #10
   right = 1'b0;
   left = 1'b1;
   #10
   left = 1'b0;
   right = 1'b1;
   #10
   right = 1'b0;
   b = 1'b1;
   #10
   b = 1'b0;
   a = 1'b1;
   #10
   a = 1'b0;
   start = 1'b1;
   #10
   start = 1'b0;
   #20
   $finish();
   end
   
endmodule
