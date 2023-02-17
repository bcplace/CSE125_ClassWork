module elastic_pipe
 #(parameter [31:0] width_p = 10
  ) 
  (input [0:0] clk_i
  ,input [0:0] reset_i

  ,input [width_p - 1:0] data_i
  ,input [0:0] valid_i
  ,output [0:0] ready_o 

  ,output [0:0] valid_o 
  ,output [width_p - 1:0] data_o 
  ,input [0:0] yumi_i
  );
  
   logic ready_l;
   logic valid_o_l;
   logic data_en;
   
   
   logic [width_p - 1 : 0] q_l;
   
   always_ff @(posedge clk_i) begin
       if(reset_i) begin
          q_l <= '0;
       end else if(data_en) begin
          q_l <= data_i;
       end
   end 
   
  always_comb begin 
      ready_l = ~valid_o_l | yumi_i;
      data_en = ready_l & valid_i;
  end
   
   always_ff @(posedge clk_i) begin
       if(reset_i) begin
           valid_o_l <= 1'b0;
       end else if(ready_l) begin
           valid_o_l <= ready_l & valid_i;// | ~yumi_i & ~ready_l;
       end
   end
   
   assign data_o = q_l;
   assign ready_o = ready_l;
   assign valid_o = valid_o_l;
   
endmodule

