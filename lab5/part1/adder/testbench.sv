`timescale 1ns/1ps
module testbench();
   localparam width_lp = 4;
   logic [width_lp-1:0] a_i;
   logic [width_lp-1:0] b_i;
   logic [width_lp-1:0] c_i;
   wire  [width_lp  :0] sum_o;

   logic [0:0] error;
   
   wire [width_lp:0] correct_sum_o;

   logic [width_lp:0] itervar_a;
   logic [width_lp:0] itervar_b;
   logic [width_lp:0] itervar_c;
   
   assign correct_sum_o = (a_i + b_i + c_i);
   assign error = (sum_o !== correct_sum_o);
   
   //`define GOOD;
   
   // Your testbench should PASS with the good DUT, and FAIL with the
   // "bad" DUT. Use `define GOOD to switch between the two.
   //
   // Write your assertions inside of the DUT modules themselves.
`ifdef GOOD
   adder
     #(.width_p(width_lp))
   dut_good
     (.a_i(a_i)
     ,.b_i(b_i)
     ,.c_i(c_i)
     ,.sum_o(sum_o));
`else 
   adder_synth
     #(.width_p(width_lp))
   dut_bad
     (.a_i(a_i)
     ,.b_i(b_i)
     ,.c_i(c_i)
     ,.sum_o(sum_o));
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
      $display("Begin Test:");
      $display();
      
      for(itervar_a = '0; itervar_a < (1 << width_lp); itervar_a++) begin
	 for(itervar_b = '0; itervar_b < (1 << width_lp); itervar_b++) begin
	    for(itervar_c = '0; itervar_c < (1 << width_lp); itervar_c++) begin
		    a_i = itervar_a[width_lp-1:0];
		    b_i = itervar_b[width_lp-1:0];
		    c_i = itervar_c[width_lp-1:0];
		    $display("  a_i = %b, b_i = %b, c_i = %b", a_i, b_i, c_i);
		    #10;
		    if(error) begin
		       $display("\033[0;31mError!\033[0m: sum_o should be %b, got %b (a_i is %b, b_i is %b, c_i is %b)",
			      correct_sum_o, sum_o, a_i, b_i, c_i);
		       //$finish();
		    end
            end
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
