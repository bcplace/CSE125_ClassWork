module filter
  #(parameter width_p = 24) // Don't worry, we won't change this.
  (input [0:0] clk_i
  ,input [0:0] reset_i

  ,input [width_p - 1:0] data_i
  ,input [0:0] valid_i
  ,output [0:0] ready_o 

  ,output [0:0] valid_o 
  ,output [width_p - 1:0] data_o 
  ,input [0:0] ready_i
  );

wire [23:0]shift_o[6:0];
logic [23:0] data;

initial begin
#130
data = 24'd10;
#10
data = 24'hB;
#10
data = 24'hC;
#10
data = 24'hD;
#10
data = 24'hE;
#10
data = 24'hF;
#10
data = 24'h9;
end


shift_24
#()
shifter
(.clk_i(clk_i), .reset_i(reset_i), .en(1'b1), .data_i(data), .data_o());
endmodule

