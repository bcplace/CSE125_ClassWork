`timescale 1ns/1ps
module testbench();
   localparam width_lp = 4;
   logic [width_lp-1:0] a_i;
   logic [width_lp-1:0] b_i;
   wire  [width_lp-1:0] quot_o;
   wire  [width_lp-1:0] rem_o;

   logic [0:0] error;
   
   // Your testbench should PASS with the good DUT, and FAIL with the
   // "bad" DUT. Use `define GOOD to switch between the two.
   //
   // Write your assertions inside of the DUT modules themselves.
`ifdef GOOD
   divider
     #(.width_p(width_lp))
   dut_good
     (.a_i(a_i)
     ,.b_i(b_i)
     ,.quot_o(quot_o)
     ,.rem_o(rem_o));
`else 
   divider_synth
     #(.width_p(width_lp))
   dut_bad
     (.a_i(a_i)
     ,.b_i(b_i)
     ,.quot_o(quot_o)
     ,.rem_o(rem_o));
`endif

   initial begin
      // Leave this code alone, it generates the waveforms
`ifdef VERILATOR
      $dumpfile("verilator.fst");
`else
      $dumpfile("iverilog.vcd");
`endif
      $dumpvars;

      // Put your testbench code here. Print all of the test cases and
      // their correctness.

      $finish();
   end

   final begin
      $display("Simulation time is %t", $time);
      if(error) begin
	 $display("\033[0;31m    ______                    \033[0m");
	 $display("\033[0;31m   / ____/_____________  _____\033[0m");
	 $display("\033[0;31m  / __/ / ___/ ___/ __ \\/ ___/\033[0m");
	 $display("\033[0;31m / /___/ /  / /  / /_/ / /    \033[0m");
	 $display("\033[0;31m/_____/_/  /_/   \\____/_/     \033[0m");
	 $display();
	 $display("Simulation Failed");

     end else begin
	 $display("\033[0;32m    ____  ___   __________\033[0m");
	 $display("\033[0;32m   / __ \\/   | / ___/ ___/\033[0m");
	 $display("\033[0;32m  / /_/ / /| | \\__ \\\__ \ \033[0m");
	 $display("\033[0;32m / ____/ ___ |___/ /__/ / \033[0m");
	 $display("\033[0;32m/_/   /_/  |_/____/____/  \033[0m");
	 $display();
	 $display("Simulation Succeeded!");
      end
   end

endmodule
