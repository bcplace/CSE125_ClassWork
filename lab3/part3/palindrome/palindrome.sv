module palindrome
  #(parameter [31:0] depth_p = 32'd10)
   (input [0:0] clk_i
   ,input [0:0] reset_i
   ,input [3:0] symbol_i
   ,input [0:0] valid_i
   ,output [0:0] overflow_o // Not required, but provided for debugging
   ,output [0:0] palindrome_o);

   // Your code here:
   
     enum logic [7:0] {Init = 8'h01, Begin = 8'h02, Process = 8'h04, 
     Match = 8'h08, Wait_Match = 8'h10, Wait_Process = 8'h20, No_Match = 8'h40, Success = 8'h80} state, next_state;
     
     logic [$clog2(2*depth_p) - 1 : 0] read_counter;
     logic [$clog2(2*depth_p) - 1 : 0] write_counter;
     logic set, down;
     logic write_up, match, read_up;
     logic [$clog2(2*depth_p) - 1 : 0] Din;
     logic [3:0] write_data;
     logic [3:0] read_data;
     
       setcounter
       #($clog2(depth_p*2))
       count
       (.clk_i(clk_i)
       , .set_i(set)
       , .up_i(read_up)
       , .down_i(down)
       , .reset_i(reset_i)
       , .Din_i(Din)
       , .counter_o(read_counter));
       
       counter
       #($clog2(depth_p*2))
       upcounter
       (.clk_i(clk_i)
       , .reset_i(reset_i)
       , .up_i(write_up)
       , .down_i(1'b0)
       , .counter_o(write_counter));
       
       ram_1w1r_async
       #(.width_p(4), .depth_p(2*depth_p), .filename_p("Init.hex"))
       FIFO
       (.clk_i(clk_i)
       , .reset_i(reset_i)
       , .wr_valid_i(valid_i)
       , .wr_data_i(symbol_i)
       , .wr_addr_i(write_buf)
       , .rd_addr_i(read_counter)
       , .rd_data_o(read_data));
       
       logic [$clog2(2*depth_p) - 1 : 0] write_buf;
       always_ff @(posedge clk_i) begin
           write_buf <= write_counter;
       end
       
       always_comb begin
           case(state)
               Init : begin
                          if(valid_i) begin
                              next_state = Begin;
                          end else begin
                              next_state = Init;
                          end
                       end
               Begin : begin
                          write_up = 1'b1;
                          if(valid_i)
                          next_state = Process;
                          else begin
                          write_up = 1'b0;
                          next_state = Begin;
                          end
                       end 
               Process : begin
                             write_up = 1'b0;
                             read_up = 1'b0;
                             if((read_data == symbol_i) && valid_i) begin
                                 next_state = Match;
                             end else if((read_data == symbol_i) && ~valid_i) begin
                                 next_state = Wait_Match;
                             
                             end else begin
                                 write_up = 1'b1;
                                 read_up = 1'b1;
                                 if(~valid_i & ~(read_data == symbol_i)) begin
                                     next_state = Wait_Process;
                                 end else if(valid_i & ~(read_data == symbol_i)) begin
                                     next_state = Process;
                                 end
                             end
                         end
               Wait_Process : begin
                                 write_up = 1'b0;
                                 read_up = 1'b0;
                                 if(valid_i) begin
                                     next_state = Process;
                                  end else begin
                                     next_state = Wait_Process;
                                  end
                              end            
               Match : begin
                           if(~valid_i) begin
                               next_state = Wait_Match;
                           end else begin
                               write_up = 1'b1;
                               down = 1'b1;
                           end
                       end//If ~valid go to Wait_match else increment write and write and decrement read. Check that they are equal if not equal set match to 0 and transition to No_Match. If equal transistion to match if valid&Match if ~valid&match transition to Wait_match.
               //Wait_Match : //If valid&Match go to Match
               //No_Match : //Set Read = write - 1 upon valid data transition to process
               //Sucess : 
               default : begin
                            next_state = Init;
                            set = 1'b0;
                            down = 1'b0;
                            read_up = 1'b0;
                            write_up = 1'b0;
                         end
           endcase
       end
       
       
       always_ff @(posedge clk_i) begin
           if(reset_i) begin
               state <= Init;
           end else begin
               state <= next_state;
           end
       end 
       
       
       
endmodule

