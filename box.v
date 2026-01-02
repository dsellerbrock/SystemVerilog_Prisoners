module box(
           input clk,
           input rst_n,
           input [31:0] key,
           input [7:0] data_i,
           output [7:0] data_o
          )

always @(posedge clk) begin
    if(rst_n) begin
        data_o <= 8'h00;
    end
    else begin
        if(key == 32'hDEADBEEF) begin
            data_o <= data_i;
        end
    end
end
endmodule
