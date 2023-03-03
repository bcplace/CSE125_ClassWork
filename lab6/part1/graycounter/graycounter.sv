module graycounter
  #(parameter width_p = 4)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] up_i
   ,output [width_p-1:0] gray_o);
       
    logic [width_p-1:0] counter_l;
    logic [width_p-1:0] gray_l;
    
    always_ff @(posedge clk_i) begin
        if(reset_i) begin
            counter_l <= '0;
        end else if(up_i) begin
            counter_l <= counter_l + 1;
        end
    end
    
    always_comb begin
        gray_l = ((counter_l >> 1) ^ counter_l);
    end
    
    assign gray_o = gray_l;

endmodule
