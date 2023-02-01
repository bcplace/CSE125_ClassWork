module ram_1r1w_sync
  #(parameter [31:0] width_p = 8
    ,parameter [31:0] depth_p = 128
    ,parameter  filename_p = "memory_init_file.hex")
   (input [0:0] clk_i
    ,input [0:0] reset_i

    ,input [0:0] wr_valid_i
    ,input [width_p-1:0] wr_data_i
    ,input [$clog2(depth_p) - 1 : 0] wr_addr_i

    ,input [$clog2(depth_p) - 1 : 0] rd_addr_i
    ,output [width_p-1:0] rd_data_o
    );

endmodule
