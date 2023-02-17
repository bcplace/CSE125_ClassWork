module fifo_1r1w
 #(parameter [31:0] width_p = 10
  ,parameter [31:0] depth_p = 20
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
  
  
  logic ready_o_l;
  logic valid_o_l;
  logic [$clog2(depth_p) - 1:0] wr_ptr;
  logic [$clog2(depth_p) - 1:0] rd_ptr;
  wire [31:0] wr_ptr_comp;
  wire [31:0] rd_ptr_comp;
  
  assign wr_ptr_comp[$clog2(depth_p) - 1:0] = wr_ptr;
  assign wr_ptr_comp[31:$clog2(depth_p)] = '0;
  assign rd_ptr_comp[$clog2(depth_p) - 1:0] = rd_ptr;
  assign rd_ptr_comp[31:$clog2(depth_p)] = '0;
  
  always_ff @(posedge clk_i) begin
      if(reset_i) begin
          ready_o_l <= '0;
          valid_o_l <= '0;
          wr_ptr <= '0;
          rd_ptr <= '0;
      end
      if(yumi_i & valid_o) begin // Producer Yumi-Valid Handshake
         valid_o_l <= 1'b0;
         if(rd_ptr_comp >= depth_p - 1)
           rd_ptr <= '0; //at terminal count loop back
         else
           rd_ptr <= rd_ptr + 1;
      end else begin
         if(rd_ptr != wr_ptr) begin //If not empty
             valid_o_l <= 1'b1;
         end
      end
      
      if(ready_o_l & valid_i) begin //Consumer Ready-Valid Handshake
         ready_o_l <= 1'b0; //We won't be ready for more until next clock cycle
         if(wr_ptr_comp == depth_p - 1) begin
           wr_ptr <= '0; //at terminal count loop back
         end else begin
           wr_ptr <= wr_ptr + 1;
         end
      end else begin
          if((rd_ptr != wr_ptr + 1) || ((wr_ptr_comp == depth_p - 1) && (rd_ptr == 0))) begin //if the FIFO isn't full
             ready_o_l <= 1'b1;
          end
      end
  end
  
  assign valid_o = valid_o_l;
  assign ready_o = ready_o_l;
  
ram_1r1w_sync #(.width_p(width_p), .depth_p(depth_p))
  ram_1r1w_sync_inst
   (.clk_i(clk_i)
    ,.reset_i(reset_i)

    ,.wr_valid_i(valid_i & ready_o)
    ,.wr_data_i(data_i)
    ,.wr_addr_i(wr_ptr)

    ,.rd_addr_i(rd_ptr)
    ,.rd_data_o(data_o)
    );

endmodule

