`define CSE_X25_MAX(x,y) (((x)>(y)) ? (x) : (y))

`ifdef XCELIUM // Bare default parameters are incompatible as of 20.09.012
               // = "inv" causes type inference mismatch as of 20.09.012
`define CSE_X25_INV_PARAM(param) param = -1
`elsif YOSYS // Bare default parameters are incompatible as of 0.9
`define CSE_X25_INV_PARAM(param) param = "inv"
`else // VIVADO, DC, VERILATOR, GENUS
`define CSE_X25_INV_PARAM(param) param
`endif

`define CSE_X25_SAFE_CLOG2(x) ( ((x)==1) ? 1 : $clog2((x)))

module cse_x25_nonsynth_axilite_mem
//  import cse_x25_axi_pkg::*;
 #(parameter axi_id_width_p = 1
  ,parameter axi_addr_width_p = 32
  ,parameter axi_data_width_p = 32
  ,parameter axi_len_width_p  = 4
  ,parameter mem_els_p = 1024)
  (input clk_i
  ,input reset_i
  
  ,input [axi_addr_width_p-1:0] axi_awaddr_i
  ,input axi_awvalid_i
  ,output axi_awready_o

  ,input [axi_data_width_p-1:0] axi_wdata_i
  ,input axi_wlast_i
  ,input axi_wvalid_i
  ,output axi_wready_o

  ,output [1:0] axi_bresp_o
  ,output axi_bvalid_o
  ,input axi_bready_i

  ,input [axi_addr_width_p-1:0] axi_araddr_i
  ,input axi_arvalid_i
  ,output axi_arready_o
  
  ,output [axi_data_width_p-1:0] axi_rdata_o
  ,output [1:0] axi_rresp_o
  ,output axi_rlast_o
  ,output axi_rvalid_o
  ,input axi_rready_i
  );

  typedef enum logic [1:0]
  {
    e_axi_burst_fixed     = 2'b00
    ,e_axi_burst_incr     = 2'b01
    ,e_axi_burst_wrap     = 2'b10
    ,e_axi_burst_reserved = 2'b11
  } axi_burst_type_e;

  // AXI defines burst lengths of 1-16 for bursts not incr
  //   and 1-256 for bursts that are incr
  typedef enum logic [3:0]
  {
    e_axi_len_1   = 4'b0000
    ,e_axi_len_2  = 4'b0001
    ,e_axi_len_3  = 4'b0010
    ,e_axi_len_4  = 4'b0011
    ,e_axi_len_5  = 4'b0100
    ,e_axi_len_6  = 4'b0101
    ,e_axi_len_7  = 4'b0110
    ,e_axi_len_8  = 4'b0111
    ,e_axi_len_9  = 4'b1000
    ,e_axi_len_10 = 4'b1001
    ,e_axi_len_11 = 4'b1010
    ,e_axi_len_12 = 4'b1011
    ,e_axi_len_13 = 4'b1100
    ,e_axi_len_14 = 4'b1101
    ,e_axi_len_15 = 4'b1110
    ,e_axi_len_16 = 4'b1111
  } axi_len_e;

   cse_x25_nonsynth_axi_mem
     #(.axi_id_width_p                  (axi_id_width_p)
      ,.axi_addr_width_p                (axi_addr_width_p)
      ,.axi_data_width_p                (axi_data_width_p)
      ,.axi_len_width_p                 (axi_len_width_p)
      ,.mem_els_p                       (mem_els_p))
   mem_i
     (.clk_i                            (clk_i)
     ,.reset_i                          (reset_i)

     ,.axi_awid_i                       ('0)
     ,.axi_awaddr_i                     (axi_awaddr_i[axi_addr_width_p-1:0])
     ,.axi_awlen_i                      (e_axi_len_1)
     ,.axi_awburst_i                    (e_axi_burst_fixed)
     ,.axi_awvalid_i                    (axi_awvalid_i)
     ,.axi_awready_o                    (axi_awready_o)

     ,.axi_wdata_i                      (axi_wdata_i[axi_data_width_p-1:0])
     ,.axi_wstrb_i                      (4'b1111)
     ,.axi_wlast_i                      (axi_wlast_i)
     ,.axi_wvalid_i                     (axi_wvalid_i)
     ,.axi_wready_o                     (axi_wready_o)

     ,.axi_bid_o                        ()
     ,.axi_bresp_o                      (axi_bresp_o[1:0])
     ,.axi_bvalid_o                     (axi_bvalid_o)
     ,.axi_bready_i                     (axi_bready_i)

     ,.axi_arid_i                       ('0)
     ,.axi_araddr_i                     (axi_araddr_i[axi_addr_width_p-1:0])
     ,.axi_arlen_i                      (e_axi_len_1)
     ,.axi_arburst_i                    (e_axi_burst_fixed)
     ,.axi_arvalid_i                    (axi_arvalid_i)
     ,.axi_arready_o                    (axi_arready_o)

     ,.axi_rid_o                        ()
     ,.axi_rdata_o                      (axi_rdata_o[axi_data_width_p-1:0])
     ,.axi_rresp_o                      (axi_rresp_o[1:0])
     ,.axi_rlast_o                      (axi_rlast_o)
     ,.axi_rvalid_o                     (axi_rvalid_o)
     ,.axi_rready_i                     (axi_rready_i)
     );
endmodule

module cse_x25_nonsynth_axi_mem
//  import cse_x25_axi_pkg::*;
  #(parameter `CSE_X25_INV_PARAM(axi_id_width_p)
    , parameter `CSE_X25_INV_PARAM(axi_addr_width_p)
    , parameter `CSE_X25_INV_PARAM(axi_data_width_p)
    , parameter `CSE_X25_INV_PARAM(axi_len_width_p)
    , parameter `CSE_X25_INV_PARAM(mem_els_p)
    , parameter init_data_p = 32'hdead_beef // 32 bits

    , parameter lg_mem_els_lp=`CSE_X25_SAFE_CLOG2(mem_els_p)
    , parameter axi_strb_width_lp=(axi_data_width_p>>3)
  )
  ( 
    input clk_i
    , input reset_i
  
    , input [axi_id_width_p-1:0] axi_awid_i
    , input [axi_addr_width_p-1:0] axi_awaddr_i
    , input [axi_len_width_p-1:0] axi_awlen_i
    , input [1:0] axi_awburst_i
    , input axi_awvalid_i
    , output logic axi_awready_o

    , input [axi_data_width_p-1:0] axi_wdata_i
    , input [axi_strb_width_lp-1:0] axi_wstrb_i
    , input axi_wlast_i
    , input axi_wvalid_i
    , output logic axi_wready_o

    , output logic [axi_id_width_p-1:0] axi_bid_o
    , output logic [1:0] axi_bresp_o
    , output logic axi_bvalid_o
    , input axi_bready_i

    , input [axi_id_width_p-1:0] axi_arid_i
    , input [axi_addr_width_p-1:0] axi_araddr_i
    , input [axi_len_width_p-1:0] axi_arlen_i
    , input [1:0] axi_arburst_i
    , input axi_arvalid_i
    , output logic axi_arready_o
  
    , output logic [axi_id_width_p-1:0] axi_rid_o
    , output logic [axi_data_width_p-1:0] axi_rdata_o
    , output logic [1:0] axi_rresp_o
    , output logic axi_rlast_o
    , output logic axi_rvalid_o
    , input axi_rready_i
  );

  typedef enum logic [1:0]
  {
    e_axi_burst_fixed     = 2'b00
    ,e_axi_burst_incr     = 2'b01
    ,e_axi_burst_wrap     = 2'b10
    ,e_axi_burst_reserved = 2'b11
  } axi_burst_type_e;

  // AXI defines burst lengths of 1-16 for bursts not incr
  //   and 1-256 for bursts that are incr
  typedef enum logic [3:0]
  {
    e_axi_len_1   = 4'b0000
    ,e_axi_len_2  = 4'b0001
    ,e_axi_len_3  = 4'b0010
    ,e_axi_len_4  = 4'b0011
    ,e_axi_len_5  = 4'b0100
    ,e_axi_len_6  = 4'b0101
    ,e_axi_len_7  = 4'b0110
    ,e_axi_len_8  = 4'b0111
    ,e_axi_len_9  = 4'b1000
    ,e_axi_len_10 = 4'b1001
    ,e_axi_len_11 = 4'b1010
    ,e_axi_len_12 = 4'b1011
    ,e_axi_len_13 = 4'b1100
    ,e_axi_len_14 = 4'b1101
    ,e_axi_len_15 = 4'b1110
    ,e_axi_len_16 = 4'b1111
  } axi_len_e;

  logic [axi_data_width_p-1:0] ram [mem_els_p-1:0];

  // write channel
  //
  typedef enum logic [1:0] {
    WR_RESET,
    WR_WAIT_ADDR,
    WR_WAIT_DATA,
    WR_RESP
  } wr_state_e;

  wr_state_e wr_state_r, wr_state_n;
  logic [axi_id_width_p-1:0] awid_r, awid_n;
  logic [axi_addr_width_p-1:0] awaddr_lo, awaddr_r, awaddr_n;
  logic [axi_len_width_p-1:0] wr_burst_r, wr_burst_n;
  logic [1:0] awburst_r, awburst_n;
  logic [axi_len_width_p-1:0] awlen_r, awlen_n;

  logic [lg_mem_els_lp-1:0] wr_ram_idx;
  assign wr_ram_idx = awaddr_lo[$clog2(axi_data_width_p>>3)+:lg_mem_els_lp];

  wire [axi_addr_width_p-1:0] awaddr_bytes_in_burst = (axi_data_width_p>>3) * (awlen_r+1);
  wire [axi_addr_width_p-1:0] awaddr_wrap_boundary = (awaddr_r/awaddr_bytes_in_burst)*awaddr_bytes_in_burst;
  wire [axi_addr_width_p-1:0] awaddr_wrap_upper = awaddr_wrap_boundary + awaddr_bytes_in_burst;
  wire [axi_addr_width_p-1:0] awaddr_incr = (awaddr_r+(wr_burst_r<<$clog2(axi_data_width_p>>3)));
  wire [axi_addr_width_p-1:0] awaddr_wrap =
    (awaddr_incr == awaddr_wrap_upper)
    ? awaddr_wrap_boundary
    : (awaddr_incr > awaddr_wrap_upper)
      ? awaddr_r + ((wr_burst_r-awlen_r)<<$clog2(axi_data_width_p>>3))
      : awaddr_incr;

  always_comb begin

    axi_awready_o = 1'b0;
    awaddr_lo = '0;

    axi_wready_o = 1'b0;
    
    axi_bid_o = awid_r;
    axi_bresp_o = '0;
    axi_bvalid_o = 1'b0;

    awaddr_n = awaddr_r;
    awid_n = awid_r;
    awlen_n = awlen_r;
    wr_burst_n = wr_burst_r;
    awburst_n = awburst_r;

    case (wr_state_r)
      WR_RESET: begin
        axi_awready_o = 1'b0;

        wr_state_n = WR_WAIT_ADDR;
      end

      WR_WAIT_ADDR: begin
        axi_awready_o = 1'b1;
        awid_n = axi_awvalid_i 
          ? axi_awid_i
          : awid_r;
        awaddr_n = axi_awvalid_i
          ? axi_awaddr_i
          : awaddr_r;
        awburst_n = axi_awvalid_i
          ? axi_awburst_i
          : awburst_r;
        awlen_n = axi_awvalid_i
          ? axi_awlen_i
          : awlen_r;

        wr_burst_n = axi_awvalid_i
          ? '0
          : wr_burst_r;

        wr_state_n = axi_awvalid_i
          ? WR_WAIT_DATA
          : WR_WAIT_ADDR;
      end
      
      WR_WAIT_DATA: begin
        axi_wready_o = 1'b1;

        wr_burst_n = axi_wvalid_i
          ? wr_burst_r + 1
          : wr_burst_r;

        awaddr_lo =
          (awburst_r == e_axi_burst_incr)
          ? awaddr_incr
          : (awburst_r == e_axi_burst_wrap)
            ? awaddr_wrap
            : awaddr_r;
    
        wr_state_n = ((wr_burst_r == awlen_r) & axi_wvalid_i)
          ? WR_RESP
          : WR_WAIT_DATA;
      end

      WR_RESP: begin
        axi_bvalid_o = 1'b1;
        wr_state_n = axi_bready_i
          ? WR_WAIT_ADDR
          : WR_RESP;
      end
    endcase
  end

  // read channel
  //
  typedef enum logic [1:0] {
    RD_RESET
    ,RD_WAIT_ADDR
    ,RD_SEND_DATA
  } rd_state_e;

  rd_state_e rd_state_r, rd_state_n;
  logic [axi_id_width_p-1:0] arid_r, arid_n;
  logic [axi_addr_width_p-1:0] araddr_lo, araddr_r, araddr_n;
  logic [axi_len_width_p-1:0] rd_burst_r, rd_burst_n;
  logic [1:0] arburst_r, arburst_n;
  logic [axi_len_width_p-1:0] arlen_r, arlen_n;

  logic [lg_mem_els_lp-1:0] rd_ram_idx;
  assign rd_ram_idx = araddr_lo[$clog2(axi_data_width_p>>3)+:lg_mem_els_lp];

  // uninitialized data
  //
  logic [axi_data_width_p-1:0] uninit_data;
  assign uninit_data = {(`CSE_X25_MAX(1, axi_data_width_p/32)){init_data_p}};

  for (genvar i = 0; i < axi_data_width_p; i++) begin
    assign axi_rdata_o[i] = (ram[rd_ram_idx][i] === 1'bx)
      ? uninit_data[i]
      : ram[rd_ram_idx][i];
  end

  // https://developer.arm.com/documentation/ihi0022/c/Addressing-Options/Burst-address
  wire [axi_addr_width_p-1:0] araddr_bytes_in_burst = (axi_data_width_p>>3) * (arlen_r+1);
  wire [axi_addr_width_p-1:0] araddr_wrap_boundary = (araddr_r/araddr_bytes_in_burst)*araddr_bytes_in_burst;
  wire [axi_addr_width_p-1:0] araddr_wrap_upper = araddr_wrap_boundary + araddr_bytes_in_burst;
  wire [axi_addr_width_p-1:0] araddr_incr = (araddr_r+(rd_burst_r<<$clog2(axi_data_width_p>>3)));
  wire [axi_addr_width_p-1:0] araddr_wrap =
    (araddr_incr == araddr_wrap_upper)
    ? araddr_wrap_boundary
    : (araddr_incr > araddr_wrap_upper)
      ? araddr_r + ((rd_burst_r-arlen_r)<<$clog2(axi_data_width_p>>3))
      : araddr_incr;

  always_comb begin

    axi_rvalid_o = 1'b0;
    axi_rlast_o = 1'b0;
    axi_rid_o = arid_r;
    axi_rresp_o = '0;
    axi_arready_o = 1'b0;
    araddr_lo = '0;

    rd_state_n = rd_state_r;
    arid_n = arid_r;
    araddr_n = araddr_r;
    arburst_n = arburst_r;
    arlen_n = arlen_r;
    rd_burst_n = rd_burst_r;
    rd_state_n = rd_state_r;

    case (rd_state_r)
      RD_RESET: begin
        axi_arready_o = 1'b0;

        rd_state_n = RD_WAIT_ADDR;
      end

      RD_WAIT_ADDR: begin
        axi_arready_o = 1'b1;

        arid_n = axi_arvalid_i
          ? axi_arid_i
          : arid_r;
        araddr_n = axi_arvalid_i
          ? axi_araddr_i
          : araddr_r;
        arburst_n = axi_arvalid_i
          ? axi_arburst_i
          : arburst_r;
        arlen_n = axi_arvalid_i
          ? axi_arlen_i
          : arlen_r;
    
        rd_burst_n = axi_arvalid_i
          ? '0
          : rd_burst_r;
        
        rd_state_n = axi_arvalid_i
          ? RD_SEND_DATA
          : RD_WAIT_ADDR;
      end

      RD_SEND_DATA: begin
        axi_rvalid_o = 1'b1;

        axi_rlast_o = (rd_burst_r == arlen_r);

        rd_burst_n = axi_rready_i
          ? rd_burst_r + 1
          : rd_burst_r;
    
        araddr_lo =
          (arburst_r == e_axi_burst_incr)
          ? araddr_incr
          : (arburst_r == e_axi_burst_wrap)
            ? araddr_wrap
            : araddr_r;

        rd_state_n = ((rd_burst_r == arlen_r) & axi_rready_i)
          ? RD_WAIT_ADDR
          : RD_SEND_DATA;
     
      end
    endcase
  end 

  // sequential logic
  //
  always_ff @ (posedge clk_i) begin
    if (reset_i) begin
      wr_state_r <= WR_RESET;
      awid_r <= '0;
      awaddr_r <= '0;
      awburst_r <= '0;
      awlen_r <= '0;
      wr_burst_r <= '0;

      rd_state_r <= RD_RESET;
      arid_r <= '0;
      araddr_r <= '0;
      arburst_r <= '0;
      arlen_r <= '0;
      rd_burst_r <= '0;
    end
    else begin
      wr_state_r <= wr_state_n;
      awid_r <= awid_n;
      awaddr_r <= awaddr_n;
      awburst_r <= awburst_n;
      awlen_r <= awlen_n;
      wr_burst_r <= wr_burst_n;

      if ((wr_state_r == WR_WAIT_DATA) & axi_wvalid_i) begin
        for (integer i = 0; i < axi_strb_width_lp; i++) begin
          if (axi_wstrb_i[i]) begin
            ram[wr_ram_idx][i*8+:8] <= axi_wdata_i[i*8+:8];
          end
        end
      end

      rd_state_r <= rd_state_n;
      arid_r <= arid_n;
      araddr_r <= araddr_n;
      arburst_r <= arburst_n;
      arlen_r <= arlen_n;
      rd_burst_r <= rd_burst_n;
      
    end
  end
  
endmodule
