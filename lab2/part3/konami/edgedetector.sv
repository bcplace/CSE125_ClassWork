module edgedetector(
    input clk_i,
    input btn_i,
    output edge_o);

wire temp_w;

dff
#()
edge1
(.clk_i(clk_i), .reset_i(1'b0), .d_i(btn_i), .q_o(temp_w));

assign edge_o = btn_i & ~temp_w;
endmodule
