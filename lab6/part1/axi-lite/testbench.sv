`timescale 1ns/1ps
module testbench();
   localparam width_lp = 8;
   parameter  axi_addr_width_p = 32;
   parameter  axi_data_width_p = 32;

   wire [0:0] clk_i;
   wire [0:0] reset_i;

   logic [width_lp-1:0] a_i;
   logic [width_lp-1:0] b_i;
   logic [(width_lp * 2) - 1:0] prod_o;

   logic [0:0]                  error;

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

   logic [axi_addr_width_p-1:0] axi_awaddr_i;
   logic                        axi_awvalid_i;
   wire                         axi_awready_o;

   logic [axi_data_width_p-1:0] axi_wdata_i;
   logic                        axi_wvalid_i;
   wire                         axi_wready_o;

   wire [1:0]                   axi_bresp_o;
   wire                         axi_bvalid_o;
   logic                        axi_bready_i;

   logic [axi_addr_width_p-1:0] axi_araddr_i;
   logic                        axi_arvalid_i;
   wire                         axi_arready_o;
   
   wire [axi_data_width_p-1:0]  axi_rdata_o;
   wire [1:0]                   axi_rresp_o;
   wire                         axi_rvalid_o;
   logic                        axi_rready_i;

   
   // Your testbench should PASS with the good DUT, and FAIL with the
   // "bad" DUT. Use `define GOOD to switch between the two.
   //
   // Write your assertions inside of the DUT modules themselves.
   cse_x25_nonsynth_axilite_mem
     #()
   dut_good
     (.clk_i                            (clk_i)
     ,.reset_i                          (reset_i)

     ,.axi_awaddr_i                     (axi_awaddr_i)
     ,.axi_awvalid_i                    (axi_awvalid_i)
     ,.axi_awready_o                    (axi_awready_o)

     ,.axi_wdata_i                      (axi_wdata_i)
     ,.axi_wvalid_i                     (axi_wvalid_i)
     ,.axi_wready_o                     (axi_wready_o)

     ,.axi_bresp_o                      (axi_bresp_o)
     ,.axi_bvalid_o                     (axi_bvalid_o)
     ,.axi_bready_i                     (axi_bready_i)

     ,.axi_araddr_i                     (axi_araddr_i)
     ,.axi_arvalid_i                    (axi_arvalid_i)
     ,.axi_arready_o                    (axi_arready_o)

     ,.axi_rdata_o                      (axi_rdata_o)
     ,.axi_rresp_o                      (axi_rresp_o)
     ,.axi_rvalid_o                     (axi_rvalid_o)
     ,.axi_rready_i                     (axi_rready_i)
     );

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
