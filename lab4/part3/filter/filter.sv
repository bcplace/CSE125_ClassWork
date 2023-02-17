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
logic [width_p - 1:0] data;
logic valid_o_l;


shift_24
#()
shifter
(.clk_i(clk_i), .reset_i(reset_i), .en(valid_i & ready_o), .data_i(data_i), .data_o(shift_o));

assign ready_o = ~valid_o | ready_i;

always_comb begin
    data = (shift_o[0] >> 3) + (shift_o[1] >> 2) + (shift_o[2] >> 1) + 
    (shift_o[3] << 1) + (shift_o[4] >> 1) + (shift_o[5] >> 2) + (shift_o[6] >> 3);
end


always_ff @(posedge clk_i) begin
    if(reset_i) begin
        valid_o_l <= '0;
    end else if(ready_o) begin
        valid_o_l <= ready_o & valid_i;
    end
end
assign valid_o = valid_o_l;
assign data_o = data;

endmodule

