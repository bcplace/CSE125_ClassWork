module ram_1r1w_sync
/* verilator lint_off UNUSEDSIGNAL */
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
logic [width_p - 1 : 0] mem [depth_p - 1 : 0];
logic [$clog2(depth_p) - 1 : 0] read_addr_l;

initial begin
    $readmemh(filename_p, mem, 0);
    /*`ifdef VERILATOR
           $dumpfile("verilator.vcd");
    `else
           $dumpfile("iverilog.vcd");
    `endif
    for(int i = 0; i < depth_p; i++) $dumpvars(0, mem[i]);*/
end

always_ff @(posedge clk_i) begin
    read_addr_l <= rd_addr_i;
end
assign rd_data_o = mem[read_addr_l];

always_ff @(posedge clk_i) begin
    if(wr_valid_i) begin
        mem[wr_addr_i] <= wr_data_i;
    end
end
/* verilator lint_on UNUSEDSIGNAL */
endmodule
