module kpyd2ssd
  (input [7:0] kpyd_i
  ,output [7:0] ssd_o);

   // Your code here
   logic [4:0] read_addr;
   
   always_comb begin
       case(kpyd_i)
           8'b10001000 : read_addr = 5'b00001;
           8'b10000100 : read_addr = 5'b00010;
           8'b10000010 : read_addr = 5'b00011;
           8'b10000001 : read_addr = 5'b00100;
           8'b01001000 : read_addr = 5'b00101;
           8'b01000100 : read_addr = 5'b00110;
           8'b01000010 : read_addr = 5'b00111;
           8'b01000001 : read_addr = 5'b01000;
           8'b00101000 : read_addr = 5'b01001;
           8'b00100100 : read_addr = 5'b01010;
           8'b00100010 : read_addr = 5'b01011;
           8'b00100001 : read_addr = 5'b01100;
           8'b00011000 : read_addr = 5'b01101;
           8'b00010100 : read_addr = 5'b01110;
           8'b00010010 : read_addr = 5'b01111;
           8'b00010001 : read_addr = 5'b10000;
           default : read_addr = 5'b00000;
        endcase
    end

   ram_1w1r_async
   #(.width_p(8), .depth_p(17), .filename_p("memory_init_file.hex"))
   ROM
   (.clk_i(1'b0)
   , .reset_i(1'b0)
   , .wr_valid_i(1'b0)
   , .wr_data_i(8'd0)
   , .wr_addr_i(5'd0)
   , .rd_addr_i(read_addr)
   , .rd_data_o(ssd_o));
endmodule
