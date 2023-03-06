// Do not modify this file!
`timescale 1ns/1ps
`ifndef WIDTH
`define WIDTH 4
`endif
module testbench();
   localparam width_lp = `WIDTH;
   localparam iterations_lp = 64;

   wire [0:0] up_i;
   wire [0:0]  clk_i;
   wire [0:0]  reset_i;
   logic reset_done = 1'b0;
   wire error_o;
   int itervar;
   logic [width_lp - 1:0] graycode_correct;
   wire [width_lp - 1:0] gray_o;
   logic [width_lp - 1:0] binary_i;
   //logic [width_lp - 1:0] binary_decode;
   
   assign error_o = (graycode_correct != gray_o);
   assign up_i = 1'b1;
   
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

   graycounter
     #(.width_p(width_lp))
   dut
     (.clk_i(clk_i)
     // Hint: there is a bug in one of the modules regarding reset.
     ,.reset_i(reset_i)
     ,.up_i(up_i)
     ,.gray_o(gray_o));

   initial begin
`ifdef VERILATOR
      $dumpfile("verilator.fst");
`else
      $dumpfile("iverilog.vcd");
`endif
      $dumpvars;
      
      graycode_correct = '0;
      binary_i = '0;
      
      @(negedge reset_i);
      
      reset_done = 1'b1;
      
      for(itervar = 0; itervar < iterations_lp; itervar++) begin
          @(posedge clk_i);
          if(~up_i) begin
          //Do nothing
          end else if(!reset_i & up_i) begin
             binary_i += 1;
             graycode_correct = ((binary_i >> 1) ^ binary_i);
          end
          $display("Graycode is %b", graycode_correct);
      end
      $finish();
   end
   
   always @(negedge clk_i) begin 
        if(reset_done & !reset_i & error_o) begin
             $error("\033[0;31mError!\033[0m: gray_o should be %b, got %b", graycode_correct, gray_o);
             $finish(); 
        end
   end

   final begin
      $display("Simulation time is %t", $time);
      if(error_o) begin
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