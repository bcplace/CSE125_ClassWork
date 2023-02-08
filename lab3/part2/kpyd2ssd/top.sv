// Top-level design file for the icebreaker FPGA board
//
// Wi23, Lab 3
module top
  (input [0:0] clk_12mhz_i
  ,input [0:0] reset_n_async_unsafe_i
   // n: Negative Polarity (0 when pressed, 1 otherwise)
   // async: Not synchronized to clock
   // unsafe: Not De-Bounced
  ,input [3:1] button_async_unsafe_i
   // async: Not synchronized to clock
   // unsafe: Not De-Bounced
  ,input [3:0] kpyd_row_i
  ,output [3:0] kpyd_col_o
  ,output [7:0] ssd_o
  ,output [5:1] led_o);

   // These two D Flip Flops form what is known as a Synchronizer. We
   // will learn about these in Week 5, but you can see more here:
   // https://inst.eecs.berkeley.edu/~cs150/sp12/agenda/lec/lec16-synch.pdf
   wire reset_n_sync_r;
   wire reset_sync_r;
   wire reset_r; // Use this as your reset_signal
   dff
     #()
   sync_a
     (.clk_i(clk_12mhz_i)
     ,.reset_i(1'b0)
     ,.d_i(reset_n_async_unsafe_i)
     ,.q_o(reset_n_sync_r));

   inv
     #()
   inv
     (.a_i(reset_n_sync_r)
     ,.b_o(reset_sync_r));

   dff
     #()
   sync_b
     (.clk_i(clk_12mhz_i)
     ,.reset_i(1'b0)
     ,.d_i(reset_sync_r)
     ,.q_o(reset_r));
     
     /*for(genvar i = 1; i < 4; i++) begin
         dff
         #()
         sync_buttons
         (.clk_i(clk_12mhz_i)
         ,.reset_i(1'b0)
         ,.d_i(button_async_unsafe_i[i])
         ,.q_o(button_sync_w[i]));
         
         dff
         #()
         debounce_buttons
         (.clk_i(clk_12mhz_i)
         ,.reset_i(1'b0)
         ,.d_i(button_sync_w[i])
         ,.q_o(buttons[i]));
     end*/
       
  // Your code goes here
  logic [3:0] kpyd2ssd_row_w;
  logic [3:0] shift_o;
  logic [3:0] kpyd2ssd_col_w;
  
  shift
  #(.depth_p(4), .reset_val_p(4'b1110))
  shifter
  (.clk_i(clk_12mhz_i)
  , .reset_i(reset_r)
  , .data_i(shift_o[3])
  , .data_o(shift_o));
  
  always_comb begin
      kpyd2ssd_col_w = shift_o;
      case(kpyd_row_i)
          4'b0111 : kpyd2ssd_row_w = 4'b1000;
          4'b1011 : kpyd2ssd_row_w = 4'b0100;
          4'b1101 : kpyd2ssd_row_w = 4'b0010;
          4'b1110 : kpyd2ssd_row_w = 4'b0001;
          default : kpyd2ssd_row_w = 4'b0000;
      endcase
  end
  assign kpyd_col_o = kpyd2ssd_col_w;
  
  logic [3:0] row_sync;
  logic [3:0] col_sync;
  always_ff @(posedge clk_12mhz_i) begin
       row_sync <= kpyd2ssd_row_w;
       col_sync <= ~kpyd2ssd_col_w;
  end
  
  kpyd2ssd
  #()
  keypad
  (.kpyd_i({row_sync, col_sync})
  , .ssd_o(ssd_o));
 

endmodule
