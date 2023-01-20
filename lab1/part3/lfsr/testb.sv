`timescale 1ns / 1ps
//Testbench for top.sv part 3

module testbench(
);
reg clk, reset;
reg [3:1] button;
wire [5:1] led;

top toplevel (.clk_12mhz_i(clk), .reset_n_async_unsafe_i(reset), .button_async_unsafe_i(button), .led_o(led));

nonsynth_clock_gen
     #(.cycle_time_p(10))
   cg
     (.clk_o(clk));
     
   initial begin
`ifdef VERILATOR
      $dumpfile("verilator.fst");
`else
      $dumpfile("iverilog.vcd");
`endif
      $dumpvars;
   end
     
initial
begin
reset = 1'b1;
button = 3'b000;
#1000
reset = 1'b0;
#100000
reset = 1'b1;

$finish();
end

endmodule
