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
  
  logic [$clog2(depth_p) - 1 : 0] wr_ptr = '0;
  logic [$clog2(depth_p) - 1 : 0] rd_ptr = '0;
  
  logic ready_o_l, valid_o_l = '0;
  logic [width_p - 1:0] data_o_l;
  logic [width_p - 1:0] data_i_l;
  logic Full_FIFO, Empty_FIFO;
  logic [$clog2(depth_p) - 1 : 0] next_wr_ptr = '0;
  logic [$clog2(depth_p) - 1 : 0] next_rd_ptr = '0;
  
  always_ff @(posedge clk_i) begin
      if(wr_ptr == rd_ptr) begin
          Empty_FIFO <= 1'b1;
      end else begin
          Empty_FIFO <= 1'b0;
      end
      if(valid_i & ready_o_l) begin
          data_i_l <= data_i;
          next_wr_ptr <= wr_ptr + 1;
      end
      if(Full_FIFO) begin
          ready_o_l <= 1'b0;
      end else begin
          ready_o_l <= 1'b1;
      end
      if(rd_ptr - wr_ptr == 1) begin
          Full_FIFO <= 1'b1;
      end else begin
          Full_FIFO <= 1'b0;
      end
      if(rd_ptr != wr_ptr) begin
          valid_o_l <= 1'b1;
      end else begin
          valid_o_l <= 1'b0;
      end
      if(yumi_i) begin
          next_rd_ptr <= rd_ptr + 1;
      end
      wr_ptr <= next_wr_ptr;
      rd_ptr <= next_rd_ptr;
  end
  
  
  assign data_o = data_o_l;
  assign valid_o = valid_o_l;
  assign ready_o = ready_o_l;
  
  ram_1r1w_sync
  #(.width_p(width_p), .depth_p(depth_p))
  FIFO
  (.clk_i(clk_i), .reset_i(reset_i), 
  .wr_valid_i(valid_i), .wr_data_i(data_i_l), .wr_addr_i(wr_ptr),
  .rd_addr_i(rd_ptr), .rd_data_o(data_o_l));

endmodule

