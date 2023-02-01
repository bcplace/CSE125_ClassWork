module debouncer
(input clk_i,
input btn_i,
output debounced_o);

wire connect1_w, connect2_w;

dff
#()
ff1
(.clk_i(clk_i)
,.reset_i(1'b0)
,.d_i(btn_i)
,.q_o(connect1_w));

dff
#()
ff2
(.clk_i(clk_i)
,.reset_i(1'b0)
,.d_i(connect1_w)
,.q_o(connect2_w));

assign debounced_o = connect1_w & ~connect2_w;
endmodule
