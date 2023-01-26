`timescale 1ns / 1ps
//Testbench for top.sv part 3

module testbench(
);
reg clk, reset, valid;
wire ready_o, done_o;

multiplier multi (.clk_i(clk), .reset_i(reset), .valid_i(valid), .ready_then_o(ready_o), .done_o(done_o), .a_i(), .b_i(), .result_o());

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
valid = 1'b0;
#100
valid = 1'b1;
#100
$finish();
end

endmodule

