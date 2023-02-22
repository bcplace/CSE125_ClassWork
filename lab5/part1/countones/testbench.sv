`timescale 1ns/1ps
module testbench();
   localparam width_lp = 8;
   logic [width_lp-1:0] binary_i;
   wire  [$clog2(width_lp):0] count_o;

   logic [0:0] error;
   logic [$clog2(width_lp):0] correct_count_o;
   logic [width_lp:0] binary_test_i;
   
   assign error = (count_o !== correct_count_o);
   assign correct_count_o = $countones(binary_i);
   
   
   // Your testbench should PASS with the good DUT, and FAIL with the
   // "bad" DUT. Use `define GOOD to switch between the two.
   //
   // Write your assertions inside of the DUT modules themselves.
   
   //`define GOOD;
`ifdef GOOD
   countones
     #(.width_p(width_lp))
   dut_good
     (.binary_i(binary_i)
     ,.count_o(count_o));
`else 
   countones_synth
     #(.width_p(width_lp))
   dut_bad
     (.binary_i(binary_i)
     ,.count_o(count_o));
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
      for(binary_test_i = '0; binary_test_i < (1 << width_lp); binary_test_i++) begin
           binary_i = binary_test_i[width_lp - 1:0];
           $display("binary_i = %b", binary_i);
           #10;
	    if(error) begin
	       $display("\033[0;31mError!\033[0m: count_o should be %b, got %b (binary_i is %b)",
		      correct_count_o, count_o, binary_i);
	    end
      end
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
