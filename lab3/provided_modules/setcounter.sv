module setcounter
  #(parameter width_p = 4)
  (input clk_i,
  input set_i,
  input up_i,
  input [width_p - 1 : 0] Din_i,
  input down_i,
  input reset_i,
  output [width_p - 1 : 0]counter_o);
  
  logic [width_p - 1 : 0] counter_val = '0;
  
  always_ff @(posedge clk_i) begin
      if(set_i) begin
          counter_val <= Din_i;
      end else if(down_i & ~set_i & ~up_i) begin
          counter_val <= counter_val - 1;
      end else if(up_i & ~down_i & ~set_i) begin
          counter_val <= counter_val + 1;
      end
  end
  
  assign counter_o = counter_val;
endmodule
