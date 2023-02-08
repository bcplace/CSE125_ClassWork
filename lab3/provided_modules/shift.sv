module shift
  #(parameter depth_p = 5
   ,parameter [depth_p-1:0] reset_val_p = 0)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [0:0] data_i
   ,output [depth_p-1:0] data_o);

   // Implement a parameterized, 1-bit shift register. You must use behavioral verilog.
   //
   // A shift register is an array of registers, connected
   // in series. On each cycle, the shift register ingests a new value (data_i),
   // and moves the previous values forward by 1 index.
   //
   // Example:
   //
   //   Positive Edge Cycle 0 (i.e. the first cycle reset_i is set to 0):
   //     data_i = 1'b1, data_o = 5'b00000
   // 
   //   Positive Edge Cycle 1: 
   //     data_i = 1'b0, data_o = 5'b00001
   // 
   //   Positive Edge Cycle 2: 
   //     data_i = 1'b1, data_o = 5'b00010
   //   Positive Edge Cycle 3: 
   //     data_i = 1'b0, data_o = 5'b00101
   //
   //   And so on... 
   //
   // Your shift register should reset to reset_val_p when reset_i is high.
   // 
   // Your code here:
   logic [depth_p - 1:0] data_c;
   logic [depth_p - 1:0] data_n;
   always_ff @(posedge clk_i) begin
	if(reset_i) begin
		data_c <= reset_val_p;
	end else begin
		data_c <= data_n;
	end
   end
   
   always_comb begin
   	data_n = {data_c[depth_p - 2:0], data_i};
   end
   assign data_o = data_c;

endmodule
