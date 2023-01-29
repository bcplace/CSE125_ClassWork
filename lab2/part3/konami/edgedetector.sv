module edgedetector(
    input clk_i,
    input btn_i,
    output edge_o);

wire temp_w, out_w;

dff
#()
edge1
(.clk_i(clk_i), .reset_i(1'b0), .d_i(btn_i), .q_o(temp_w));

dff
#()
edge2
(.clk_i(clk_i), .reset_i(1'b0), .d_i(temp_w), .q_o(out_w));

assign edge_o = ~out_w & temp_w;
endmodule
