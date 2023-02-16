module shift_24(
input clk_i,
input reset_i,
input en,
input [23:0] data_i,
output [23:0] data_o [6:0]);

logic [23:0] mem [6:0];


always_ff @(posedge clk_i) begin
    if(reset_i) begin
        for(int i = 0; i < 7; i++) begin
            mem[i] <= 24'd0;
        end
    end else if(en) begin
        mem[0] <= data_i;
        for(int i = 1; i < 7; i++) begin
             mem[i] <= mem[i-1];
        end
     end
end

assign data_o = mem;


endmodule
